#!/usr/bin/env bash
set -euo pipefail
root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$root"
for file in SKILL.md manifest.yaml agents/openai.yaml fixtures/success.md fixtures/failure.md fixtures/success-input.md fixtures/failure-input.md fixtures/forward-success.md fixtures/forward-failure.md fixtures/additional-input.md fixtures/forward-additional.md fixtures/additional-failure-input.md fixtures/forward-additional-failure.md README.md README.en.md LICENSE icon-512.png assets/promo-1600x900.png assets/promo-layout.svg; do
  test -f "$file" || { echo "missing: $file" >&2; exit 1; }
done
python3 - <<'PY'
from pathlib import Path
import struct, re
def size(path):
    raw = Path(path).read_bytes()
    assert raw[:8] == b'\x89PNG\r\n\x1a\n', f'{path} is not PNG'
    return struct.unpack('>II', raw[16:24])
skill = Path('SKILL.md').read_text()
manifest = Path('manifest.yaml').read_text()
agent = Path('agents/openai.yaml').read_text()
success = Path('fixtures/success.md').read_text()
layout = Path('assets/promo-layout.svg').read_text()
assert 'name: shop-promo-brief-cn' in skill.split('---', 2)[1]
assert 'name: shop-promo-brief-cn' in manifest and 'slug: shop-promo-brief-cn' in manifest
assert 'icon: icon-512.png' in manifest
assert 'allow_implicit_invocation: true' in agent
short = next(x.split(': ', 1)[1].strip('"') for x in agent.splitlines() if 'short_description:' in x)
assert 25 <= len(short) <= 64
for metadata in (agent, manifest):
    for field in ('display_name', 'short_description', 'default_prompt', 'icon_small', 'icon_large'):
        found = re.search(r'^  ' + field + r': "([^"\n]+)"$', metadata, re.M)
        assert found, f'interface field must be quoted: {field}'
        value = found.group(1)
        if field == 'default_prompt':
            assert '$shop-promo-brief-cn' in value
        elif field.startswith('icon_'):
            target = Path(value).resolve()
            assert target.is_relative_to(Path.cwd()) and target.is_file(), 'icon must exist inside Skill directory'
assert size('icon-512.png') == (512, 512)
assert size('assets/promo-1600x900.png') == (1600, 900)
assert '2026-10-12 至 2026-10-18' in success
assert '重构' in Path('fixtures/success-input.md').read_text()
assert '不是原始用户提交' in Path('fixtures/success-input.md').read_text()
assert success == Path('fixtures/forward-success.md').read_text()
assert Path('fixtures/failure.md').read_text() == Path('fixtures/forward-failure.md').read_text()
assert '内部截止日期' in skill and '每一条新增截止日' in skill
confirmed = success.split('## 已确认信息')[1].split('## 活动主张')[0]
for unconfirmed_day in ('10 月 10 日', '10 月 11 日'):
    assert unconfirmed_day not in confirmed, 'suggested deadline became confirmed fact'
execution = success.split('## 执行待办')[1].split('## 边界与风险')[0]
for line in execution.splitlines():
    if '10 月 10 日' in line or '10 月 11 日' in line:
        assert '建议' in line and '待商家确认' in line, 'deadline must be suggested and awaiting merchant confirmation'
additional = Path('fixtures/forward-additional.md').read_text()
for provided in ('A5 横线笔记本', '75 本', '满 2 本减 5 元', '不与优惠券叠加', '2026-11-01 至 2026-11-03'):
    assert provided in additional, f'additional delivery lost confirmed fact: {provided}'
partial_failure = Path('fixtures/forward-additional-failure.md').read_text()
missing_rows = re.findall(r'^\| (.*?) \|', partial_failure, re.M)
assert missing_rows == ['缺项', '---', '活动日期'], 'partial failure must list only the actual missing date'
for unconfirmed in ('00:00', '23:59', '库存售完即止', '两色可选', '两色 SKU'):
    assert unconfirmed not in success, f'unconfirmed fixture claim: {unconfirmed}'
for required_copy in ('店铺活动执行简报', '活动文案与执行清单', '确认资料，快速协作上线'):
    assert required_copy in layout, f'missing promo copy: {required_copy}'
print('self-test passed: interface, confirmed dates, explicitly suggested deadlines, actual missing fields, and PNG dimensions verified')
print('NOTE: reconstructed and new offline inputs are labeled; fixture checks do not claim a blind business evaluation.')
PY
