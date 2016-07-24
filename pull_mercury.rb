require './lib/results_processor'
require 'celluloid'

class PullMercury

  include Celluloid

  @@item_filter_hash = { :ListingType => ["Auction", "AuctionWithBIN"] }
  @@years_needed = ["1931", "1932", "1933", "1934", "1935", "1936", "1938", "1939"];
  @@skip_words = ["Scratched", "Scratches", "Spot Removed", "Cleaning", "Cleaned", "Altered Color", "Damage",
    "1939 D", "1939-P", "1938-S", "1938 S", "1938 D", "1938-D", "1935-P", "1939-D"]
  @@coin_type = "Mercury"
  @@aspect_filters = [ {:Certification => "NGC"}, {:Certification => "PCGS"}, {:Grade => "MS 66"}]

  def do_pull(app_id, page_number = 1)
    ebay_utils = EbayUtils.new
    response = ebay_utils.do_ebay_query(app_id, "Mercury Dime", @@aspect_filters, @@item_filter_hash, page_number)
    results_processor = ResultsProcessor.new
    filtered_results = results_processor.filter_results(@@coin_type, response, @@years_needed, @@skip_words, 100)
    # puts filtered_results
    filtered_results
  end

end
