require './lib/results_processor'

class PullMercury

  @@item_filter_hash = { :ListingType => ["Auction", "AuctionWithBIN"] }
  @@years_needed = ["1931", "1932", "1933", "1934", "1935", "1936", "1937", "1938", "1939"];
  @@skip_words = ["Scratched", "Damaged", "Scratch", "Damage"]
  @@coin_type = "Mercury"
  @@aspect_filters = [ {:Certification => "NGC"}, {:Certification => "PCGS"}, {:Grade => "MS 66"}]

  def do_pull(app_id)
    ebay_utils = EbayUtils.new
    response = ebay_utils.do_ebay_query(app_id, "Mercury Dime", @@aspect_filters, @@item_filter_hash)
    search_res = response.response["searchResult"]
    results_processor = ResultsProcessor.new
    filtered_results = results_processor.filter_results(@@coin_type, search_res, @@years_needed, @@skip_words, 100)
    puts filtered_results
    filtered_results
  end

end
