require './lib/results_processor'
require 'celluloid'

class PullBuffalo

  include Celluloid

  @@item_filter_hash = { :ListingType => ["Auction", "AuctionWithBIN"] }
  @@years_needed = ["1920", "1921", "1922", "1923", "1924", "1925, 1926", "1927", "1929", "1931", "1932", "1933", "1934", "1935", "1936"]
  @@skip_words = ["Scratched", "Scratches", "Spot Removed", "Cleaning", "Cleaned", "Altered Color", "Damage"]
  @@coin_type = "Buffalo"
  @@aspect_filters = [ {:Certification => "NGC"}, {:Certification => "PCGS"}]

  def do_pull(app_id, page_number = 1)
    ebay_utils = EbayUtils.new
    response = ebay_utils.do_ebay_query(app_id, "Buffalo Nickel", @@aspect_filters, @@item_filter_hash, page_number)
    results_processor = ResultsProcessor.new
    filtered_results = results_processor.filter_results(@@coin_type, response, @@years_needed, @@skip_words, 250)
    filtered_results
  end




end
