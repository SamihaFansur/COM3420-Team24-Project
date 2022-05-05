# Extenuating Circumstances Form
## App / Project Info

### Getting Started
Clone the project, then:
* `cp config/database_sample.yml config/database.yml` and change credentials as appropriate.
* `bundle install`
* `yarn install`
* `rails db:setup`
* `bin/webpack-dev-server` for live reloading.
* `rails s`

### URLs
If hosting locally, go to `http://localhost:3000/`

### Style Guide
A style guide is maintained for reference at `/style_guide`.

### Following fields are for customers - QA testers please ignore!
### Testing
* QA testers please note that our tests are slightly outdated as of 05/05/2022
* Run specs with `rspec`
* Run Jest tests with `yarn test`
* Run static analysis with `brakeman`
* **Run all of the above with `rake`**

### Customer Contact
Some Customer <some.customer@epigenesys.co.uk>

### Description
Customer X needed to solve problem Y and we created this app to A, B, C...

## Development

### Significant Features / Technology
Mention anything significant outside of the standard stack...

### Deployment
*QA -> Demo -> Production* using the `epi-deploy` gem.
