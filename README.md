# App name
---

## App / Project Info

### URLs
Live site / staging urls etc...

### Customer Contact
Some Customer <some.customer@epigenesys.co.uk>

### Description
Customer X needed to solve problem Y and we created this app to A, B, C...

## Development

### Significant Features / Technology
Mention anything significant outside of the standard stack...

### Getting Started
Clone the project, then:
* `cp config/database_sample.yml config/database.yml` and change credentials as appropriate.
* `bundle install`
* `yarn install`
* `rails db:setup`
* `rails s`
* `bin/webpack-dev-server` for live reloading.

### Testing
* Run specs with `rspec`
* Run Jest tests with `yarn test`
* Run static analysis with `brakeman`
* **Run all of the above with `rake`**

### CI
TODO: Fail if RSpec / Jest tests fail or if Brakeman finds a "medium" issue.

### Style Guide
A style guide is maintained for reference at `/style_guide`.

### Deployment
*QA -> Demo -> Production* using the `epi-deploy` gem.
