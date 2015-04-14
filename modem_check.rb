#!/opt/local/bin/ruby

# The purpose of this script is to perform a health-check of the cable modem and connection.
# This is specifically intended to be used with the Motorola SB6120 cable modem
# It will collect all of the downstream & upstream signal-to-noise and power level data
# as well as the most recent log timestamp and entry.
# It also perfoms a ping test (currently 100 poings to www.comcast.net) to determine average and max ping time as well as packet loss
# all of the data is printed in a comma-seperated format for use in a spreadsheet to analyze patterns
# the output is in the following format:
#timestamp,% packet loss,avg ping time(ms),max ping time(ms),down channel 1 snr,down channel 2 snr,down channel 3 snr,   down channel 4 snr,down channel 1 power,down channel 2 power,down channel 3 power,down channel 4 power,up channel 1     power,up channel 2 power,up channel 3 power,log timestamp,log message

# The script is intended to be run on cron (I run it every 5 minutes)
# here is an example crontab entry:
# */5 * * * *       $HOME/Documents/git/modem_check/modem_check.rb >> $HOME/Documents/git/modem_check/modem_log.txt 2>&1

# nokogiri is our scraping/parsing library
# you will need to install it with "gem install nokogiri"
require 'nokogiri'

# open-uri is part of the standard library and allows you to
# download a webpage
require 'open-uri'

require "rubygems"
require "google_drive"

def update_google (data)
   # Logs in.
   # You can also use OAuth. See document of
   # GoogleDrive.login_with_oauth for details.
   session = GoogleDrive.login("email", "password")

   ws = session.spreadsheet_by_key("key").worksheets[0]

   new_row = ws.num_rows + 1
   data.each_with_index do |val, index|
      #puts "========= 'inserting #{val} to index #{index+1}"
      ws[new_row, index + 1] = val
   end

   ws.save()
   ws.reload()
end

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
ping_server = "google.com"

# Here we load the URLs into Nokogiri for parsing downloading the page in
# the process
logs_data = Nokogiri::HTML(open(logs_url))
signal_data = Nokogiri::HTML(open(signal_url))

# Here we create indexes of the <TD> elements we need to access for the various pieces of information
# down channel: 1-4
# down snr: 11-14
# down power level: 22-25
# up channel: 27-29
# up power level: 43-45
downstream_index = [11, 12, 13, 14, 22, 23, 24, 25]
upstream_index = [43, 44, 45]

# iterate through each of the indexes to retreive the appropriate information, only prsing out numbers
downstream_index.each { |index|
   downstream.push(signal_data.css("td")[index].text.gsub(/[^\d-]/,''))
}
upstream_index.each { |index|
   upstream.push(signal_data.css("td")[index].text.gsub(/[^\d-]/,''))
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

output = [
   time.strftime("%Y-%m-%d %H:%M:%S"),
   packet_loss,
   avgms,
   maxms,
]
output.concat(downstream)
output.concat(upstream)
output.push(timestamp).push(message.split(";")[0])


# output eveything as a comma-delimited line for future analysis
#puts time.strftime("%Y-%m-%d %H:%M:%S") + "," + packet_loss + "," + avgms + "," + maxms + "," + downstream.join(",") + "," + upstream.join(",") + "," + timestamp + "," + message.split(";")[0]
puts output.join(",")

# push the new row to the google spreadsheet
update_google output

