require 'date'
require 'optparse'

today = Date.today
options = ARGV.getopts("", "m:#{today.month}", "y:#{today.year}")

if options["m"].to_i >= 1 && options["m"].to_i <= 12
  month = options["m"].to_i
else
  puts "cal: #{options["m"]} is neither a month number (1..12) nor a name"
  return
end

if options["y"].to_i >= 1 && options["y"].to_i <= 9999
  year = options["y"].to_i
else
  puts "cal: year `#{options["y"]}' not in range 1..9999"
  return
end

first_date_day = Date.new(year, month).wday
last_date = Date.new(year, month, -1).day
space = "   "

puts "      #{month}月 #{year}"
puts "日 月 火 水 木 金 土"

case first_date_day
when 1
  print space
when 2
  print space * 2
when 3
  print space * 3
when 4
  print space * 4
when 5
  print space * 5
when 6
  print space * 6
end

def color_reverse(text)
  "\e[30m\e[47m#{text}\e[0m"
end

Range.new(1,last_date).each do |date|
  day = Date.new(year, month, date).wday
  print " " if date <= 9
  if date == today.day && month == today.month && year == today.year
    print color_reverse(date)
  else
    print "#{date}"
  end
  print " "
  puts "" if day == 6
end

puts ""

