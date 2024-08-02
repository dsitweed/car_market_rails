# README

## Settings version:

- rbenv: rbenv 1.2.0-72-g5d78e47

- Ruby version: ruby 3.2.2 (2023-03-30 revision e51014f9c0) [x86_64-linux]

- Rails version: Rails 7.0.8.4

- System dependencies

- Configuration

- Database creation

- Database initialization

- How to run the test suite

- Services (job queues, cache servers, search engines, etc.)

- Deployment instructions

## Command line logs

```bash
rails new car_market

rails db:drop db:reset db:create

rails generate model User email:string:index name:string password_digest:string remember_digest:string role:integer activation_digest:string activated:boolean activated_at:datetime reset_digest:string reset_sent_at:datetime

```

## Dependencies gem
