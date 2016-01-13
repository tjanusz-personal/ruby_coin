
require "ebay_utils"

## execute all specs using
## rspec . --format documentation

RSpec.describe EbayUtils do

  subject(:ebay_utils) { EbayUtils.new }

  describe "#build_certification_aspect_url" do
      it "handles single Certification values correctly" do
        cert_values = [ {:Certification => "NGC"}]
        actual_string = ebay_utils.build_certification_aspect_url(cert_values)
        expected_string = "&aspectFilter(0).aspectName=Certification&aspectFilter(0).aspectValueName=NGC"
        expect(actual_string).to eql(expected_string)
      end

      it "handles multiple Certification values correctly" do
        cert_values = [ {:Certification => "NGC"}, {:Certification => "PCGS"}]
        actual_string = ebay_utils.build_certification_aspect_url(cert_values)
        expected_string = "&aspectFilter(0).aspectName=Certification&aspectFilter(0).aspectValueName=NGC"
        expected_string += "&aspectFilter(1).aspectName=Certification&aspectFilter(1).aspectValueName=PCGS"
        expect(actual_string).to eql(expected_string)
      end
  end

  describe "#build_item_filter_url" do
    it "handles a single item filter object with a single filter value" do
      item_filters = { "ListingType" => ["Auction"] }
      actual_string = ebay_utils.build_item_filter_url(item_filters)
      expected_string = "&itemFilter(0).name=ListingType&itemFilter(0).value(0)=Auction"
      expect(actual_string).to eql(expected_string)
    end

    it "handles a single item filter object with a multiple filter values" do
      item_filters = { "ListingType" => ["Auction", "AuctionWithBIN"] }
      actual_string = ebay_utils.build_item_filter_url(item_filters)
      expected_string = "&itemFilter(0).name=ListingType&itemFilter(0).value(0)=Auction"
      expected_string += "&itemFilter(0).value(1)=AuctionWithBIN"
      expect(actual_string).to eql(expected_string)
    end
  end

  describe "#build_url_parameters" do
    it "adds the keyword, aspects, item filters and defaults the sortOrder" do
      item_filters = { "ListingType" => ["Auction"] }
      cert_values = [ {:Certification =>"NGC" }]
      keywords = "Indian Cent"
      url_params = ebay_utils.build_url_parameters("Indian Cent", cert_values, item_filters, "EndTimeSoonest")
      expected_string = "&keywords=Indian Cent&sortOrder=EndTimeSoonest"
      expected_string += "&aspectFilter(0).aspectName=Certification&aspectFilter(0).aspectValueName=NGC"
      expected_string += "&itemFilter(0).name=ListingType&itemFilter(0).value(0)=Auction"
      expect(url_params).to eql(expected_string)
    end

    it "always adds keyword and sortOrder" do
      url_params = ebay_utils.build_url_parameters("Indian Cent", [], {}, "EndTimeSoonest")
      expected_string = "&keywords=Indian Cent&sortOrder=EndTimeSoonest"
      expect(url_params).to eql(expected_string)
    end
  end

  describe "#build_base_request_url" do
    it "returns proper request url" do
      actual_url = ebay_utils.build_base_request_url("https://svcs.ebay.com", "findItemsAdvanced", "123")
      expected_url = "https://svcs.ebay.com?OPERATION-NAME=findItemsAdvanced&SERVICE-VERSION=1.9.0&SECURITY-APPNAME=123&RESPONSE-DATA-FORMAT=JSON&REST-PAYLOAD"
      expect(actual_url).to eql(expected_url)
    end
  end

end
