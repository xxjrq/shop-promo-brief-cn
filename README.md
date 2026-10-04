# 店铺活动执行简报

把商家已确认的商品、库存、折扣、日期和目标，整理成一份可供运营、设计、库存与客服直接协作的活动简报。结果包含活动主张、页面/海报文案和执行待办；资料不全时会明确列出缺项，不猜价格或库存，也不承诺转化率。

![店铺活动执行简报推广图](assets/promo-1600x900.png)

## 输入与结果

输入：商品与规格、可售库存、优惠规则、活动起止日期、活动目标；可选提供品牌语气、渠道与限制条件。

结果：一份单次活动的 Markdown 简报，含已确认信息、活动主张、主副标题/卖点/规则提示、按角色划分的执行待办和风险检查。一次仅处理一个活动，表格最多 100 行；超出时请分批提供。

## 安装

```bash
npx skills add xxjrq/shop-promo-brief-cn
```

## 使用示例

```text
使用 $shop-promo-brief-cn 根据以下已确认信息生成一次活动执行简报。
商品：60L 折叠收纳箱
库存：320 个
优惠：8 折，不与会员券叠加
日期：2026-10-12 至 2026-10-18
目标：提升换季收纳品类下单量
```

完整的可复制交付请见[成功样例](fixtures/success.md)；字段不全时的回复格式见[缺料样例](fixtures/failure.md)。

成功与缺料的[重构输入](fixtures/success-input.md)、[缺料重构请求](fixtures/failure-input.md)都注明了来源，不称为原始用户提交。内部筹备日期没有提供时，执行截止日逐条标为建议、待商家确认；活动日期保持原样。

新增离线测试：[新输入](fixtures/additional-input.md) → [执行结果](fixtures/forward-additional.md)；[仅缺日期输入](fixtures/additional-failure-input.md) → [实际缺项回复](fixtures/forward-additional-failure.md)。

## 边界

仅使用你提供或确认的材料；不会改价、虚构库存、承诺 GMV 或转化率。详情请见 [SKILL.md](SKILL.md)。

## 本地验证

```bash
bash scripts/self-test.sh
```

## 来源与许可证

业务用途曾参考 [marketingskills offers](https://github.com/coreyhaines31/marketingskills/blob/main/skills/offers/SKILL.md)，本仓库的说明、步骤与示例均为原创，未复制其文本或源码。本仓库采用 [MIT License](LICENSE)。
