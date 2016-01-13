
class ResultsProcessor

  def filter_results(coin_type, results, years_needed_array, skip_words_array, max_price)
    result_array = []
    return result_array if results.nil?
    items = results[:item.to_s]
    items.each do |item|
      item_title = item["title"]
      next if should_skip_item?(item_title, years_needed_array, skip_words_array)
      current_price = item["sellingStatus"]["currentPrice"]["__value__"].to_i
      next if current_price > max_price
      result_array.push(build_result_item(coin_type, item))
    end
    result_array
  end

  def build_result_item(coin_type, item)
    result = {}
    result[:type] = coin_type
    result[:current_price] = item["sellingStatus"]["currentPrice"]["__value__"]
    result[:view_item_url] = item["viewItemURL"]
    result[:title] = item["title"]
    result[:end_time] = item["listingInfo"]["endTime"]
    result
  end

  def should_skip_item?(item_title, years_needed_array, skip_words_array)
    skip_words_array.each {|skip_word| return true if item_title.include?(skip_word)}
    years_needed_array.each {|year_needed| return false if item_title.include?(year_needed)}
    true
  end

end
