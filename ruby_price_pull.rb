
require './lib/numis_screen_scraper'
require './lib/fmv_excel_writer'

puts "Start to scrape price information from NUMIS"

# These are all MS61-MS70 pages
coin_parse_types = { Jefferson: "jefnkl", Kennedy: "kenhlv", Mercury: "mrcdim", Liberty: "libnkl", Buffalo: "bufnkl"}
page_name_template = "http://www.numismedia.com/cgi-bin/coinpricesfmv.cgi?script=%{coin_type}&searchtype=any&searchtext=fmv&search2=any"
## Kennedy MS61-MS70
## http://www.numismedia.com/cgi-bin/coinpricesfmv.cgi?script=kenhlv&searchtype=any&searchtext=fmv&search2=any
## Kennedy G-MS60
## http://www.numismedia.com/cgi-bin/coinpricesfmv.cgi?script=kenhlv&searchtype=any&searchtext=fmv&search=any
## Kennedy G-MS70
## http://www.numismedia.com/cgi-bin/coinpricesfmv.cgi?script=kenhlv&searchtype=any&searchtext=fmv&searchfull=any

coin_results = {}
all_futures = {}

coin_parse_types.keys.each do |key|
  page_to_parse = page_name_template % { :coin_type => coin_parse_types[key] }
  scraper = NumisScreenScraper.new
  all_futures[key] = scraper.future.parse_numis_page(page_to_parse)
end

# get results from all futures
all_futures.keys.each do |key|
  coin_results[key] = all_futures[key].value
end

fmv_excel_writer = FmvExcelWriter.new
fmv_excel_writer.build_excel_file("CurrentFMVValues.xlsx", coin_results)
# TODO: figure out how to deal with Indians since this HTML page is different than all the others!
# Indian Cents MS61-MS70
# page_name = 'http://www.numismedia.com/cgi-bin/coinpricesfmv.cgi?script=indcnt&searchtype=any&searchtext=fmv&search2=any'
# price_hash = parser.parse_numis_page(page_name)
# puts price_hash

puts "DONE"
