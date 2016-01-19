require './lib/ebay_utils'
require './lib/results_processor'
require './pull_buffalo'
require './pull_indian'
require './pull_jefferson'
require './pull_kennedy'
require './pull_liberty'
require './pull_mercury'
require './pull_jefferson_bin'
require './pull_kennedy_bin'
require './lib/excel_writer'

puts "Start load all coins"

app_id = ARGV.first

all_results = []
all_results.push(PullIndian.new.do_pull(app_id))
all_results.push(PullBuffalo.new.do_pull(app_id))
all_results.push(PullJefferson.new.do_pull(app_id))
all_results.push(PullKennedy.new.do_pull(app_id))
all_results.push(PullLiberty.new.do_pull(app_id))
all_results.push(PullMercury.new.do_pull(app_id))
1.upto(5) do |page_number|
  all_results.push(PullJeffersonBIN.new.do_pull(app_id, page_number))
end

1.upto(5) do |page_number|
  all_results.push(PullKennedyBIN.new.do_pull(app_id, page_number))
end

all_results.flatten!
file_name_time = Time.now.strftime("%m-%d-%H")
ExcelWriter.new.build_excel_file("coin_results-#{file_name_time}.xlsx", all_results)

puts "DONE - Processing"
