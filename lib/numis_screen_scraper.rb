require 'nokogiri'
require 'open-uri'
require 'celluloid'

class NumisScreenScraper

  include Celluloid

  # doc = File.open(full_file_name) { |f| Nokogiri::HTML(f, nil, 'utf-8') }
  def parse_numis_page(file_url)
    doc = Nokogiri::HTML(open(file_url))
    # this will pull out only the cells (based on MS61-MS70 HTML page)
    tables = doc.css("table font b")
    price_hash = {}
    tables.each_slice(12) do |price_rows|
      # should be array of 12 elements (1st element is always coin date)
      # Need to hack off the non-breaking space encoding before removing spaces
      year = price_rows.first.text.gsub(/\u00a0/, ' ').strip
      year_array = []
      price_rows[1..11].each do |price_row|
        text_value = price_row.text.strip
        next if text_value.include?("CAC")
        year_array << text_value
      end
      price_hash[year] = year_array
    end
    price_hash
  end

end
