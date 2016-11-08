require './lib/results_processor'
require 'celluloid'

class PullKennedy

  include Celluloid

  @@item_filter_hash = { :ListingType => ["Auction", "AuctionWithBIN"] }
  @@years_needed = ["1968", "1971", "1974", "1978", "1981", "1982", "1984"];
  @@skip_words = ["1971-D", "1974-D", "1974 D", "1984 P", "1981S", "1981 P",
    "1971 D", "1981 P", "1981-P", "1982-D", "1982 D"];
  @@coin_type = "Kennedy"
  @@aspect_filters = [ {:Certification => "NGC"}, {:Certification => "PCGS"}, {:Grade => "MS 66"}]

  def do_pull(app_id, page_number = 1)
    ebay_utils = EbayUtils.new
    response = ebay_utils.do_ebay_query(app_id, "Kennedy Half Dollar", @@aspect_filters, @@item_filter_hash, page_number)
    results_processor = ResultsProcessor.new
    filtered_results = results_processor.filter_results(@@coin_type, response, @@years_needed, @@skip_words, 50)
    #puts filtered_results
    filtered_results
  end

end
