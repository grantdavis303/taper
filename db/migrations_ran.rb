# Migrations Ran

# List migrations here
rails g model User first_name last_name email phone_number
rails g model Role name
rails g model Account user:references role:references username password_digest last_login

rails g model Drink account:references drink_type ounces:decimal percentage:decimal
rails g controller Drinks

rails db:migrate