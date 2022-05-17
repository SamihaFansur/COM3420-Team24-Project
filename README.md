# Extenuating Circumstances Form
### App / Project Info
Team 24:
An online Extenuating Circumstances system for the University of Sheffield.

### Description
This system aims to replace the current system of paper forms and spreadsheet meetings, to streamline the
process of submitting and handling ECFs.

This project handles creation and submission of ECFs, viewing ECFs, scrutiny panel meetings, decisions for ECFs and more.

### Getting Started
Clone the project, then:
* `cp config/database_sample.yml config/database.yml` and change credentials as appropriate.
* `bundle install`
* `yarn install`
Please note that for the following to work you MUST be connected to the Sheffield VPN, when running locally.
* `rails db:setup`
* `bin/webpack-dev-server` for live reloading.
* `rails s` to start the server.
Log in to the site using your University credentials (again you must be connected to the Sheffield VPN.)

### Setting User Role
After logging in when deploying locally, you may notice that you are only signed in as a guest or student.
To change your role, do
* `rails console`
* `User.all`
Find your user, and note the user's 'id' value.
The role numbers for each role are:
0 - guest,  1 - student,  2 - module leader,  3 - scrutiny panel member,  4 - scrutiny panel chair (admin).
To set the user to one of the above roles, in the rails console do:
* `User.find({id}).update(:role => {role number}])`
e.g., User.find(1).update(:role => 4).
After setting your role, refresh the website and you should have the correct level of access.

### URLs
If hosting locally, go to `http://localhost:3000/`

### Testing
Instructions:
* Run our tests with `rspec spec`

### Deployment
Using the `epi-deploy` gem...
 * `bundle exec epi_deploy release -d demo`
Please note that this may require access to our team's GitLab repository.

### Features
Students:
  ECF creation, with multiple affected units
  Viewing information relevant to extenuating circumstances
  Uploading file evidence to support an ECF
  Listing previously submitted ECFs
  Viewing final decisions made on the ECF
  Recieving email notifications for when an ECF is to be reviewed and when an ECF has been marked as 'complete'

For guidance on using the following staff features, please refer to the 'User Guides' provided by Team 24.
Module Leaders:
  Viewing all ECFs affecting their modules, separated into ongoing and complete
  Seeing the affected units, affected assessments and requested actions of their modules for an ECF
  Seeing whether an ECF includes a 'DEX request'
  Communicating with scrutiny panel via 'module leader notes' - which notify the scrutiny panel via email

Staff:
  Attending meetings
  Searching ECFs by field, department, requested action...
  Importing ECFs into a meeting
  Viewing and appending evidence files to existing ECFs
  Tracking email communications via email pdf upload
  Adding 'note ECFs' to a meeting
  Adding decisions to ECFs, specific to a meeting
  Exporting a meeting's minutes as a .pdf, including all meetings on the agenda, the affected units, any note ECFs and any decisions
  Tracking and viewing all previous meetings and the ECFs and decisions reviewed in them
  Viewing previous sets of decisions for an ECF
  Adding notes to ECF for future panels, and to module leaders

Scrutiny Chair:
  Creation of meetings
  Notification of a meeting sent to all attendees
  User overview and management
  Importing users and details to the system from Sheffield's LDAP database
  Showing all ECFs belonging to a particular user
  Uploading module leader to module assignments in bulk via .csv
  Viewing ECFs marked as confidential
  Private 'scrutiny chair' notes for each ECF
  Creating custom 'outcomes' for use in adding decisions.

### Directory Structure
The majority of our code can be found in app/

For JavaScript (.js), go to app/javascript/packs
For Ruby (.js), go to app/controllers or app/models
For HTML / HAML (.html.haml) go to app/views

### Code Styling standards
Our code has been styled according to general JavaScript, Ruby and HAML standards.
We have also used rubocop to to analyse our code styling.

### Team Contact
Should you have any inquiries about the system, please contact one of the team members:
Ezra Bell (Client Contact): ebell3@sheffield.ac.uk
Ariful Haque: ahaque3@sheffield.ac.uk
Samiha Fansur: sfansur1@sheffield.ac.uk
Jakub Bolcun: jbolcun1@sheffield.ac.uk
Mehar Aziz: maziz3@sheffield.ac.uk
Qinghao Du: qdu3@sheffield.ac.uk
Euan Goodbrand: egoodbrand1@sheffield.ac.uk
Charlie Petch: cpetch1@sheffield.ac.uk


