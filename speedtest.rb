#!/opt/local/bin/ruby

require "rubygems"
require "google_drive"

def update_google (data)
   # Logs in.
   # You can also use OAuth. See document of
   # GoogleDrive.login_with_oauth for details.
   session = GoogleDrive.login("email", "password")

   # access the second tab on the spreadsheet
   ws = session.spreadsheet_by_key("key").worksheets[1]

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

# initialize variables
host = ""
ping = ""
download = ""
upload = ""

# collect speedtest statistics
speedtest = `/usr/local/bin/speedtest`

if ($?.exitstatus == 0)
   speedtest_re = /Testing from (.*) \(.*\nSelecting.*\n.*\]: (.*) ms\n.*\nDownload: (.*) Mbits.*\n.*\nUpload: (.*) Mbits/
      m = speedtest_re.match(speedtest)
   if m
      host = m[1]
      ping = m[2]
      download = m[3]
      upload = m[4]
   end
end

output = [
   time.strftime("%Y-%m-%d %H:%M:%S"),
   ping,
   download,
   upload,
   host
]

puts output.join(",")

# push the new row to the google spreadsheet
update_google output

