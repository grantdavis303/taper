# Taper

### [Live Deployment](https://taper-4affd5dec44c.herokuapp.com/)

### About

Taper is a web application designed to track a user's alcohol consumption.

### Test the Application

```
[Fork and clone this repository]

cd taper
bundle install
rails db:{drop,create,migrate,seed}
rails s

[Open LocalHost:3000]

Login to the application:
Username: bob_the_test_bot123
Password: Password123!
```

### How It Works

Users first create an account and then login to the application, where they will see three different pages:

* The **Dashboard** Page - A page that lists the total alcoholic units and total drink count consumed for today, the current week, the current year, as well as all-time. Additionally, there is a weekly breakdown section where each week lists the units and drink count consumed from that particular week.

* The **New Drink** Page - A page that allows a user to enter a new drink to track by entering a drink's ounces and alcohol-by-volume (ABV) percentage.

* The **All Drinks** Page - A page that lists all of a user's logged drinks.

### Versions

- Ruby 3.2.2
- Rails 7.1.3.4

### Database Schema

![db_schema](public/db_schema.png)

### Key Features

- [x] A user can successfully create a new account
- [x] A user can login to the application with an account
- [x] A user can create a new drink
- [ ] A user can update an existing drink
- [ ] A user can delete an existing drink

### Tests

* 80 Total Tests (866 / 878 LOC (98.63%) covered), 4 Pending
* 26 Feature Tests (557 / 581 LOC (95.87%) covered), 4 Pending
* 54 Model Tests (248 / 248 LOC (100.0%) covered)

### Resources

No resources used for this project.

### Contributors

* Grant Davis | [GitHub](https://github.com/grantdavis303), [LinkedIn](https://www.linkedin.com/in/grantdavis303/)