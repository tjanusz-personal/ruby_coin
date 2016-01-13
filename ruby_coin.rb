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

puts "Start load all coins"

app_id = 'TimothyJ-dd41-4e41-92c4-fdfde088137d'

indian = PullIndian.new.do_pull(app_id)
buffalo = PullBuffalo.new.do_pull(app_id)
jefferson = PullJefferson.new.do_pull(app_id)
kennedy = PullKennedy.new.do_pull(app_id)
liberty = PullLiberty.new.do_pull(app_id)
mercury = PullMercury.new.do_pull(app_id)
jefferson_bin = PullJeffersonBIN.new.do_pull(app_id)
kennedy_bin = PullKennedyBIN.new.do_pull(app_id)

puts "DONE - Processing"
