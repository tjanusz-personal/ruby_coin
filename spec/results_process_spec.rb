
require "results_processor"

## execute all specs using
## rspec . --format documentation

RSpec.describe ResultsProcessor do
  subject(:processor) { ResultsProcessor.new }
  let(:skip_words) { ["Scratched", "Cleaning", "Cleaned", "Altered Color", "Damage"] }
  let(:years_needed) { ["1901", "1902", "1903"]}
  let(:now) { Time.now }
  let(:selling_status) {  {"currentPrice" => { "__value__" => 50}} }
  let(:listing_info) { {"endTime" => now} }
  let(:ebay_result) { {"sellingStatus" => selling_status,
      "title" => "Indian Cent 1901",
      "viewItemURL" => "http://testURL.com",
      "listingInfo" => listing_info} }

  describe "#should_skip_item?" do
    it "returns true if has year needed but contains skip word in title " do
      expect(processor.should_skip_item?("Indian Cent 1901 MS 64 Cleaned", years_needed, skip_words)).to be_truthy
    end

    it "returns true if year is not needed" do
      expect(processor.should_skip_item?("Indian Cent 1904 MS 64", years_needed, skip_words)).to be_truthy
    end

    it "returns false if item is year needed and contains no skip words" do
      expect(processor.should_skip_item?("Indian Cent 1902 MS 64", years_needed, skip_words)).to be_falsey
    end
  end

  describe "#build_result_item" do

    it "builds a result item from the given ebay result hash" do
      actual_result_hash = processor.build_result_item("Indian", ebay_result)
      expected_hash = {:type => "Indian", :current_price => 50, :view_item_url => "http://testURL.com", :title => "Indian Cent 1901", :end_time => now}
      expect(actual_result_hash).to eql(expected_hash)
    end
  end

  describe "#filter_results" do
    let(:expected_hash) { {:type => "Indian", :current_price => 50, :view_item_url => "http://testURL.com", :title => "Indian Cent 1901", :end_time => now} }

    it "returns array of filtered result hashes" do
      search_res = { "item" => [ebay_result]}
      actual_results = processor.filter_results("Indian", search_res, years_needed, skip_words, 100)
      expect(actual_results).to eql([expected_hash])
    end

    it "filters out items to be skipped due to skip_words or invalid date needed" do
      ebay_result1 = ebay_result
      ebay_result2 = ebay_result.clone  ## clone the same item and just manipulate the title to be bad
      ebay_result2["title"] = "Indian Cent 1901 Cleaned"
      search_res = { "item" => [ebay_result1, ebay_result2] }
      actual_results = processor.filter_results("Indian", search_res, years_needed, skip_words, 100)
      expect(actual_results).to eql([expected_hash])
    end

  end

end
