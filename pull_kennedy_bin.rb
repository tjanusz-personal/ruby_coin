require './lib/results_processor'

class PullKennedyBIN

  @@item_filter_hash = { :ListingType => ["FixedPrice"] }
  @@years_needed = ["1971", "1973", "1974", "1975", "1978", "1980", "1981", "1982", "1983", "1984", "1997", "2008"]
  @@skip_words = ["1971 D", "1971-D", "1973 D", "1973-D", "2008 P", "2008-P", "1980-P", "1971 S", "1978-P", "1974-D"]
  @@coin_type = "Kennedy"
  @@aspect_filters = [ {:Certification => "NGC"}, {:Certification => "PCGS"}, {:Grade => "MS 66"}]

  # todo need to add in paging calls..
  def do_pull(app_id)
    ebay_utils = EbayUtils.new
    response = ebay_utils.do_ebay_query(app_id, "Kennedy Half Dollar", @@aspect_filters, @@item_filter_hash, "PricePlusShippingLowest")
    search_res = response.response["searchResult"]
    results_processor = ResultsProcessor.new
    filtered_results = results_processor.filter_results(@@coin_type, search_res, @@years_needed, @@skip_words, 50)
    puts filtered_results
    filtered_results
  end

end
