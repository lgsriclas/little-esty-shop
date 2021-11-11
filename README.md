# Little Esty Shop

## Background and Description

"Little Esty Shop," is a Mod 2 group project at the Turing School of Software and Design, by Ted Staros, Chaz Simons, Billy Frey, and Lesley Sanders. It is modeled after e-commerce platforms where merchants and admins can manage inventory and fulfill customer invoices.

![Database design](./lib/assets/database_design.png)

## Learning Goals
- Practice designing a normalized database schema and defining model relationships
- Utilize advanced routing techniques including namespacing to organize and group like functionality together.
- Utilize advanced active record techniques to perform complex database queries
- Practice consuming a public API while utilizing POROs as a way to apply OOP principles to organize code

## Project Requirements
- Rails 5.2.x
- PostgreSQL
- Code must be tested via feature tests and model tests, respectively
- Utilize GitHub branching, team code reviews via GitHub comments, and github projects to track progress on user stories
- Include a thorough README to describe the project
- Deploy completed code to Heroku

## Setup

This project requires Ruby 2.7.2.

* Fork this repository
* Clone your fork
* From the command line, install gems and set up your DB:
    * `bundle`
    * `rails csv_load:all`
* Run the test suite with `bundle exec rspec`.
* Run your development server with `rails s` to see the app in action.

## Testing
Our project utilizes the Rails application database to streamline testing. From the command-line, run 'rails csv_load:all' to populate the database. Our project uses RSpec as the testing framework.

## Contributers

1. [Ted Staros](https://github.com/tstaros23)
1. [Chaz Simons](https://github.com/chazsimons)
1. [Billy Frey](https://github.com/bfrey08)
1. [Lesley Sanders](https://github.com/lgsriclas)
