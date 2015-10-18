# time_interval_column
Small gem which enables storing and using time intervals in Rails applications

[enumerize](https://github.com/brainspec/enumerize) is a required dependency.

## Installation

Add these lines to your application's Gemfile:
```ruby
gem 'enumerize'
gem 'time_interval_column', github: 'Bajena/time_interval_column'
```

And then execute:
```bash
$ bundle
```
## Usage

Assuming you want to add 'validity_period' method to your Product model:
1. Add two integer columns to your model:
```ruby
add_column :products, :validity_period_value, default:0, null: true
add_column :products, :validity_period_type, default:0, null: false
```

2. Add following line to your Product model

```ruby
time_interval_column :validity_period<locale>
```
3. You can pass additional options to time_interval_column method
- attr_accessible: true - generate required attr_accessible (required in Rails 3). Default: false

4. Now you can get and set validity_period using ActiveSupport::Duration helpers:

```ruby
product.validity_period = 2.days
product.validity_period # => 2 days
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
