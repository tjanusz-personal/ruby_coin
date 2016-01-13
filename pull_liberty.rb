require './lib/results_processor'

class PullLiberty

  @@item_filter_hash = { :ListingType => ["Auction", "AuctionWithBIN"] }
  @@years_needed = ["1884", "1885", "1887", "1886", "1888", "1892", "1894", "1895", "1898"]
  @@skip_words = ["Scratched", "Damaged", "Scratch", "Damage"]
  @@coin_type = "Liberty"
  @@aspect_filters = [ {:Certification => "NGC"}, {:Certification => "PCGS"}]

  def do_pull(app_id)
    ebay_utils = EbayUtils.new
    response = ebay_utils.do_ebay_query(app_id, "Liberty Nickel", @@aspect_filters, @@item_filter_hash)
    search_res = response.response["searchResult"]
    results_processor = ResultsProcessor.new
    filtered_results = results_processor.filter_results(@@coin_type, search_res, @@years_needed, @@skip_words, 250)
    puts filtered_results
    filtered_results
  end

end
