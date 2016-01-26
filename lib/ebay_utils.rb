
require 'Rebay'
require 'CGI'

class EbayUtils

  def build_certification_aspect_url(aspect_array)
    aspect_string = ""
    counter = 0
    aspect_array.each do |eachItem|
      aspect_string << "&"
      aspect_string << "aspectFilter(#{counter}).aspectName=#{eachItem.keys.first}"
      aspect_string << "&aspectFilter(#{counter}).aspectValueName=#{eachItem.values.first}"
      counter += 1
    end
    aspect_string
  end

  def build_item_filter_url(item_filter_hash)
    item_filter_string = ""
    item_counter = 0

    item_filter_hash.each do |filter_name, filter_values|
      item_filter_string << "&"
      item_filter_string << "itemFilter(#{item_counter}).name=#{filter_name}"
      value_counter = 0
      filter_values.each do |filter_value|
          item_filter_string << "&itemFilter(#{item_counter}).value(#{value_counter})=#{filter_value}"
          value_counter += 1
      end
      item_counter += 1
    end
    item_filter_string
  end

  def build_url_parameters(keyword_string, aspect_array, item_filter_hash, sort_order, page_number)
    param_string = "&keywords=#{keyword_string}&sortOrder=#{sort_order}&paginationInput.pageNumber=#{page_number}"
    param_string << build_certification_aspect_url(aspect_array)
    param_string << build_item_filter_url(item_filter_hash)
    param_string
  end

  def build_base_request_url(base_url, service_name, app_id)
#    base_url = "http://svcs.ebay.com/services/search/FindingService/v1"
    "#{base_url}?OPERATION-NAME=#{service_name}&SERVICE-VERSION=1.9.0&SECURITY-APPNAME=#{app_id}&RESPONSE-DATA-FORMAT=JSON&REST-PAYLOAD"
  end

  def do_ebay_query(app_id, keyword_string, aspect_array, item_filter_hash, page_number, sort_order = 'EndTimeSoonest')
    full_url = build_base_request_url("http://svcs.ebay.com/services/search/FindingService/v1", "findItemsAdvanced", app_id)
    param_url = build_url_parameters(keyword_string, aspect_array, item_filter_hash, sort_order, page_number)
    param_url = URI.escape(param_url)
    full_url += param_url
    response = Rebay::Response.new(JSON.parse(Net::HTTP.get_response(URI.parse(full_url)).body))
    response.trim(:findItemsAdvancedResponse)
    response
  end

end
