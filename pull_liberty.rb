require './lib/results_processor'
require 'celluloid'

class PullLiberty

  include Celluloid

  @@item_filter_hash = { :ListingType => ["Auction", "AuctionWithBIN"] }
  @@years_needed = ["1885", "1886"]
  @@skip_words = ["Scratched", "Scratches", "Spot Removed", "Cleaning", "Cleaned", "Altered Color", "Damage",
    "VF", "VG", "FR-", "G-0", "AG03", "G6", "G4", "Fair 2", "Good Details"]
  @@coin_type = "Liberty"
  @@aspect_filters = [ {:Certification => "NGC"}, {:Certification => "PCGS"}]

  def do_pull(app_id, page_number = 1)
    ebay_utils = EbayUtils.new
    response = ebay_utils.do_ebay_query(app_id, "Liberty Nickel", @@aspect_filters, @@item_filter_hash, page_number)
    results_processor = ResultsProcessor.new
    filtered_results = results_processor.filter_results(@@coin_type, response, @@years_needed, @@skip_words, 250)
    # puts filtered_results
    filtered_results
  end

end
