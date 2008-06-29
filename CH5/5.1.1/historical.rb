require 'rubygems'
require 'open-uri'
require 'fastercsv'
require 'pp'

def historical_stock_prices(ticker)
  url =  "http://finance.google.com/finance/historical?q=NASDAQ:#{ticker}&output=csv"
  data = open(url).read
  csv = FasterCSV.parse(data, :headers=>true, :converters=>:numeric)
  csv.map { |r| r.to_hash }
end

if __FILE__ == $0 
  pp historical_stock_prices(ARGV.first) 
end 
