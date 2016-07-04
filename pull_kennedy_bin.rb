require './lib/results_processor'
require 'celluloid'

class PullKennedyBIN

  include Celluloid

  @@item_filter_hash = { :ListingType => ["FixedPrice"] }
  @@years_needed = ["1971", "1973", "1974", "1978", "1981", "1982", "1983", "1984", "1997"]
  @@skip_words = ["1971 D", "1971-D", "1974 D", "1974-D", "1973 D", "1973-D", "2008 P", "2008-P", "1980-P",
    "1971 S", "1978-P", "1983-D", "1983 D", "1981-P","1984-P", "1984 P", "1978 P",
    "1974-D", "1997 P", "1980 P", "1978 KENN", "1981S", "1981 P", "1997-P", "1982-D", "1982 D"]
  @@coin_type = "KennedyBIN"
  @@aspect_filters = [ {:Certification => "NGC"}, {:Certification => "PCGS"}, {:Grade => "MS 66"}]

  def do_pull(app_id, page_number)
    ebay_utils = EbayUtils.new
    response = ebay_utils.do_ebay_query(app_id, "Kennedy Half Dollar", @@aspect_filters, @@item_filter_hash, page_number, "PricePlusShippingLowest")
    results_processor = ResultsProcessor.new
    filtered_results = results_processor.filter_results(@@coin_type, response, @@years_needed, @@skip_words, 50)
    # puts filtered_results
    filtered_results
  end

end
