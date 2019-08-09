![Little Shop of Cards Screenshot](/little_shop_screenshot.png?raw=true "Little Shop of Cards Screenshot")

# Little Shop of Cards

## About

_Little Shop of Cards_ is a fictitious e-commerce site built by [Kyle Cornelissen](https://github.com/kylecornelissen/), [Patrick Duvall](https://github.com/Patrick-Duvall/), [Aurie Gochenour](https://github.com/Myrdden/), and [Alexande Mathieu](https://github.com/alexander-mathieu/) made in 10 days at [Turing School of Software & Design](https://turing.io/). In our shop, users can add baseball cards to their cart, login, and "checkout" to place their orders. Merchant users can fulfill their components of an order, and admins have additional functionality to oversee the smooth operation of the site.

The deployed site can be viewed [here](https://little-shop-of-cards.herokuapp.com/).

Go ahead and make a user account, and see what you can do!

## Schema

![Imgur](https://i.imgur.com/kEcAZdw.png)

## Local Installation

### Requirements

* [Ruby 2.4.1](https://www.ruby-lang.org/en/downloads/) - Ruby Version
* [Rails 5.1.7](https://rubyonrails.org/) - Rails Version

### Clone

```
git clone https://github.com/alexander-mathieu/little_shop_v2.git
cd little_shop_v2
bundle install
```

### Database Setup

```
rails db:{create,migrate,seed}
```

### Exploration

* From the `little_shop_v2` project directory, boot up a server with `rails s`
* Open your browser, and visit `http://localhost:3000/`
* Create a user account if you'd like, and explore the site

## Additional Information

* The full project specs can be viewed [here](https://github.com/turingschool-projects/little_shop_v2/)
* The test suite can be run with `bundle exec rspec`
* Happy shopping!
