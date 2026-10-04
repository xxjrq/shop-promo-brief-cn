# Shop Promotion Execution Brief

Turn confirmed products, stock, discounts, dates, and goals into one execution-ready promotion brief for operations, design, inventory, and customer support. It produces a campaign proposition, page/poster copy, and task checklist; missing required facts are listed instead of guessed.

## Input and output

Input confirmed product details, sellable stock, offer rules, campaign dates, and goal. Output is a single-campaign Markdown brief with confirmed facts, campaign message, copy, role-based tasks, and risk checks. It never changes pricing, invents stock, or promises conversion results.

## Install

```bash
npx skills add xxjrq/shop-promo-brief-cn
```

See the [successful fixture](fixtures/success.md) and [missing-information fixture](fixtures/failure.md). Run `bash scripts/self-test.sh` to validate the package.

## Usage

Invoke `$shop-promo-brief-cn` with the confirmed product, stock, offer, activity dates, and goal. Activity dates remain unchanged. Internal preparation deadlines that were not supplied are explicitly suggestions awaiting merchant confirmation.

The [reconstructed input](fixtures/success-input.md) and [reconstructed missing-input request](fixtures/failure-input.md) state their provenance and are not original user submissions. New offline tests: [new input](fixtures/additional-input.md) → [delivery](fixtures/forward-additional.md), and [date-only missing input](fixtures/additional-failure-input.md) → [missing-field response](fixtures/forward-additional-failure.md).
