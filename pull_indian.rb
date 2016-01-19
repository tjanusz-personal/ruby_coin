require './lib/results_processor'
require 'celluloid'

class PullIndian

  include Celluloid

  @@item_filter_hash = { :ListingType => ["Auction", "AuctionWithBIN"] }
  @@years_needed = ["1859", "1864", "1865", "1867", "1874", "1875", "1880", "1881", "1882", "1883", "1884", "1886","1887", "1889", "1891", "1894", "1895", "1896", "1897", "1898", "1899", "1900", "1901", "1902", "1903", "1904", "1905", "1906"]
  @@skip_words = ["Scratched", "Cleaning", "Cleaned", "Altered Color", "Damage"]
  @@coin_type = "Indian"
  @@aspect_filters = [{:Certification => "NGC"}, {:Certification => "PCGS"}]

  def do_pull(app_id, page_number = 1)
    ebay_utils = EbayUtils.new
    response = ebay_utils.do_ebay_query(app_id, "Indian Cent", @@aspect_filters, @@item_filter_hash, page_number)
    results_processor = ResultsProcessor.new
    filtered_results = results_processor.filter_results(@@coin_type, response, @@years_needed, @@skip_words, 200)
    filtered_results
  end

end
