require './lib/results_processor'

class PullJeffersonBIN

  @@item_filter_hash = { :ListingType => ["FixedPrice"] }
  @@years_needed = ["1939", "1952", "1953", "1954", "1955", "1958", "1961", "1964", "1963", "1976", "1978", "1982", "1983",
	"1985", "1991", "1995", "1997", "1998", "2000", "2002", "2003", "2007", "2008", "2009"];
  @@skip_words = ["1952 S", "1952-S", "1953-D", "1953-S", "1958 D", "1958-D", "1952 D", "1952-D", "1982 D", "1982-D", "1985-P", "1978-D",
	"PROOF", "SMS", "1952S", "1939 P", "MS65", "2000-D"];
  @@coin_type = "Jefferson"
  @@aspect_filters = [ {:Certification => "NGC"}, {:Certification => "PCGS"}, {:Grade => "MS 66"}]

  # todo: need to add in paging calls
  def do_pull(app_id)
    ebay_utils = EbayUtils.new
    response = ebay_utils.do_ebay_query(app_id, "Jefferson Nickels", @@aspect_filters, @@item_filter_hash, "PricePlusShippingLowest")
    search_res = response.response["searchResult"]
    results_processor = ResultsProcessor.new
    filtered_results = results_processor.filter_results(@@coin_type, search_res, @@years_needed, @@skip_words, 35)
    puts filtered_results
    filtered_results
  end

end
