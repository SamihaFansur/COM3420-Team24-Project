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

### URLs
If hosting locally, go to `http://localhost:3000/`

### Testing
Please note that our tests are slightly outdated as of 05/05/2022, due to refactoring views, so a high amount of tests may fail.
Instructions:
* Run specs with `rspec`

### Directory Structure
The majority of our code can be found in app/

For JavaScript (.js), go to app/javascript/packs
For Ruby (.js), go to app/controllers or app/models
For HTML / HAML (.html.haml) go to app/views

### Code Styling standards
Our code has been styled according to RuboCop standards.

### Following fields are for clients - QA testers please ignore!
### Customer Contact
Some Customer <some.customer@epigenesys.co.uk>

### Description
Customer X needed to solve problem Y and we created this app to A, B, C...

## Development

### Significant Features / Technology
Mention anything significant outside of the standard stack...

### Deployment
*QA -> Demo -> Production* using the `epi-deploy` gem.
