# Ruby URL shorter

## Getting Started / Instalation

```
bundle install
rake db:migrate
rake db:seed

```

## How it works?

Converts a full URL into an unique combination of 5 characters, numbers and letters,
every URL has an expiration time of 15 days.
After The Shorter is created i use a service, UrlTitleExtractor, that
extracts the title from the page. If for some reason the page is down, job is retried
one more time.

I used HTTparty and Nokogiri to make this magic.


## How to run specs
* bundle exec rspec.