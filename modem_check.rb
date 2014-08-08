#!/opt/local/bin/ruby

# nokogiri is our scraping/parsing library
# you will need to install it with "gem install nokogiri"
require 'nokogiri'

# open-uri is part of the standard library and allows you to
# download a webpage
require 'open-uri'

require 'net/ping'

time = Time.new
url = "http://192.168.100.1/cmLogsData.htm"
packet_loss = ""
avgms = ""
maxms = ""

# Here we load the URL into Nokogiri for parsing downloading the page in
# the process
data = Nokogiri::HTML(open(url))

# We can now target data in the page using css selectors.  The at_css method
# returns the first element that matches the selector.
#puts data.at_css("table").text.strip
#puts data.css("table")[0].text.strip

# The text method returns the text from inside the element.
timestamp = data.css("td")[0].text.strip
message = data.css("td")[3].text.strip

ping_count = 100 
server = "www.comcast.net"
result = `/sbin/ping -q -c #{ping_count} #{server}`
if ($?.exitstatus == 0)
   ping_re = /received, (.*) packet loss\n.*stddev = (.*)\/(.*)\/(.*)\/(.*) ms/
      m = ping_re.match(result)
   if m
      packet_loss = m[1]
      avgms = m[3]
      maxms = m[4]
   end
end

puts time.strftime("%Y-%m-%d %H:%M:%S") + "," + packet_loss + "," + avgms + "," + maxms + "," + timestamp + "," + message.split(";")[0]


