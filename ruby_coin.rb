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
# app_id = 'test_bad_number_to_see'
start_time = Time.now

all_results = []
all_futures = []
all_futures.push(PullIndian.new.future.do_pull(app_id))
all_futures.push(PullBuffalo.new.future.do_pull(app_id))
all_futures.push(PullJefferson.new.future.do_pull(app_id))
1.upto(1) do |page_number|
  all_futures.push(PullKennedy.new.future.do_pull(app_id, page_number))
end

all_futures.push(PullLiberty.new.future.do_pull(app_id))
all_futures.push(PullMercury.new.future.do_pull(app_id))
1.upto(5) do |page_number|
  all_futures.push(PullJeffersonBIN.new.future.do_pull(app_id, page_number))
end

1.upto(5) do |page_number|
  all_futures.push(PullKennedyBIN.new.future.do_pull(app_id, page_number))
end

# get results from all futures
all_futures.each do |each_future|
  all_results << each_future.value
end

all_results.flatten!
file_name_time = Time.now.strftime("%m-%d-%H")
ExcelWriter.new.build_excel_file("coin_results-#{file_name_time}.xlsx", all_results)

total_seconds = Time.now - start_time
puts "DONE - Processing total time: #{total_seconds}"
