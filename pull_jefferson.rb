require './lib/results_processor'
require 'celluloid'

class PullJefferson

  include Celluloid

  @@item_filter_hash = { :ListingType => ["Auction", "AuctionWithBIN"] }
  @@years_needed = ["1953", "1954", "1955", "1958", "1961", "1962", "1963", "1983",
	"1985", "1997", "1998", "2002", "2003", "2009"];
  @@skip_words = ["1952 S", "1952-S", "1953-D", "1953-S", "1958 D", "1958-D", "1952 D", "1952-D", "1982 D", "1982-D", "1985-P", "1978-D",
	"PROOF", "SMS", "1952S", "MS65", "2000-D", "1953 S", "1976-D", "1954-P", "1943-D", "2003-P"];
  @@coin_type = "Jefferson"
  @@aspect_filters = [ {:Certification => "NGC"}, {:Certification => "PCGS"}, {:Grade => "MS 66"}]

  def do_pull(app_id, page_number = 1)
    ebay_utils = EbayUtils.new
    response = ebay_utils.do_ebay_query(app_id, "Jefferson Nickels", @@aspect_filters, @@item_filter_hash, page_number)
    results_processor = ResultsProcessor.new
    filtered_results = results_processor.filter_results(@@coin_type, response, @@years_needed, @@skip_words, 50)
    # puts filtered_results
    filtered_results
  end

end
