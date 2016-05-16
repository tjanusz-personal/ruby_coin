Ruby Coin
==================

The ruby_coin project is a home project I built in ruby to help me find coins for my coin collection. I'm a lazy geek I know it. There are two types of programs in this project:

1. **Ebay REST Finding API**
	- This program performs Ebay searches using the Ebay REST Finding API to query active coin auctions and BIN to query and filter out the coins I already have. The results are collated nto a single spreadsheet in the current directory. 
	- Using this XLSX I can quickly glance to see if anything seems viable. This saves me hours combing through the various queries since I really only need a small subset of year/mint for each coin type (mercury dimes, indian cents, jefferson nickels, liberty nickels, kennedy half dollars).

2. **Current FMV Values**
	- This program uses screen scraping to connect to the Numis FMV web site and pull down the current Fair Market Values of the coins I collect. This will output a XLSX file in the current directory I can use to compare current ASK prices.

Some Notes:

* **Both of these projects use celluloid gem** to perform the HTTP calls concurrently. I've used this module before and it's WAY WAY better/easier than EventMachine which unfortunately I've built a lot of stuff using!

* **I use this project on both my Windows and Linux laptops** so it works cross platform. The only wonkyness is the XLSX files on Ubuntu don't always create link cells correctly.

## Getting Started

There is a single launching script with a bunch of supporting classes.

### Dependencies

* **ruby** - (1.9.2 or greater)
* **Ebay API Key** - (https://go.developer.ebay.com/) 
* **axlsx** - Gem for writing out XLSX documents
* **rebay** - Gem for simpler call to Finding API
* **celluloid** - Gem for actor based concurrency
* **nokogiri** - Gem for parsing HTML documents in screen scraping

### Configuring the Project

* **bundler** - `bundle install` to get all gem dependencies
* **Ebay API Key** - requires signup with Ebay Developer program but you gets tons of free API credits and I've never used them up since I only run this once a day or so.

### Running the Project

* **Ebay REST Finding API** - `ruby ruby_coin.rb 'MyEbayAPIKey'`
* **Current FMV Values** - `ruby ruby_price_pull.rb`


## Testing

- Rspec tests 
	- `rspec . --format documentation`

## TODO

* Remove the hard coded coin list I have in each type and replace to read from google doc
* Add some better RSpec tests for the FMV project
* Fix the FMV project to include Indian pull. This HTML has weird formatting for the Flying Eagle cents!


## Deployment

N/A

## Getting Help

### Documentation

* None
