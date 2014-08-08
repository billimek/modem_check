#!/opt/local/bin/ruby

# The purpose of this script is to perform a health-check of the cable modem and connection.
# This is specifically intended to be used with the Motorola SB6120 cable modem
# It will collect all of the downstream & upstream signal-to-noise and power level data
# as well as the most recent log timestamp and entry.
# It also perfoms a ping test (currently 100 poings to www.comcast.net) to determine average and max ping time as well as packet loss
# all of the data is printed in a comma-seperated format for use in a spreadsheet to analyze patterns
# the output is in the following format:
#timestamp,% packet loss,avg ping time(ms),max ping time(ms),down channel 1,snr,power,down channel 2,snr,power,down channel 3,snr,power,down channel 4,snr,power,up channel 1,power,up channel 2,power,up channel 3,power,log timestamp,log message

# The script is intended to be run on cron (I run it every 5 minutes)
# here is an example crontab entry:
# */5 * * * *       $HOME/Documents/git/modem_check/modem_check.rb >> $HOME/Documents/git/modem_check/modem_log.txt 2>&1

# nokogiri is our scraping/parsing library
# you will need to install it with "gem install nokogiri"
require 'nokogiri'

# open-uri is part of the standard library and allows you to
# download a webpage
require 'open-uri'

# get the current timestamp
time = Time.new

# URLS for Motorola SB6120 logs and signal information
logs_url = "http://192.168.100.1/cmLogsData.htm"
signal_url = "http://192.168.100.1/cmSignalData.htm"

# initialize variables
packet_loss = ""
avgms = ""
maxms = ""
downstream = Array.new
upstream = Array.new
ping_count = 100
ping_server = "www.comcast.net"

# Here we load the URLs into Nokogiri for parsing downloading the page in
# the process
logs_data = Nokogiri::HTML(open(logs_url))
signal_data = Nokogiri::HTML(open(signal_url))

# routine to strip-out nbsp characters from the string
def strip_html(str)
   nbsp = Nokogiri::HTML("&nbsp;").text
   str.gsub(nbsp,'')
   #str.gsub("\n",'')
end

# Here we create indexes of the <TD> elements we need to access for the various pieces of information
# down channel: 1-4
# down snr: 11-14
# down power level: 22-25
# up channel: 27-29
# up power level: 43-45
downstream_index = [1, 11, 22, 2, 12, 23, 3, 13, 24, 4, 14, 25]
upstream_index = [27, 43, 28, 44, 29, 45]

# iterate through each of the indexes to retreive the appropriate information
downstream_index.each { |index|
   #puts "index: #{index} '" + strip_html(signal_data.css("td")[index].text).strip + "'"
   if index.between?(1,4)
      downstream.push(strip_html(signal_data.css("td")[index].text).strip + " (down)")
   else
      downstream.push(strip_html(signal_data.css("td")[index].text).strip)
   end
}
upstream_index.each { |index|
   if index.between?(27,29)
      upstream.push(strip_html(signal_data.css("td")[index].text).strip + " (up)")
   else
      upstream.push(strip_html(signal_data.css("td")[index].text).strip)
   end
}

# Fetch the most recent modem logs timestamp and log message
timestamp = logs_data.css("td")[0].text.strip
message = logs_data.css("td")[3].text.strip

# collect ping statistics
result = `/sbin/ping -q -c #{ping_count} #{ping_server}`
if ($?.exitstatus == 0)
   ping_re = /received, (.*) packet loss\n.*stddev = (.*)\/(.*)\/(.*)\/(.*) ms/
      m = ping_re.match(result)
   if m
      packet_loss = m[1]
      avgms = m[3]
      maxms = m[4]
   end
end

# output eveything as a comma-delimited line for future analysis
puts time.strftime("%Y-%m-%d %H:%M:%S") + "," + packet_loss + "," + avgms + "," + maxms + "," + downstream.join(",") + upstream.join(",") + timestamp + "," + message.split(";")[0]

