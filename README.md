# Extenuating Circumstances Form
## App / Project Info

### Getting Started
Clone the project, then:
* `cp config/database_sample.yml config/database.yml` and change credentials as appropriate.
* `bundle install`
* `yarn install`
Please note that for the following to work you MUST be connected to the Sheffield VPN, when running locally.
* `rails db:setup`
* `bin/webpack-dev-server` for live reloading.
* `rails s`

### URLs
If hosting locally, go to `http://localhost:3000/`

### Testing
Instructions:
* Run specs with `rspec spec`

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
