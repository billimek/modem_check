# Purpose
The purpose of this script is to perform a health-check of the cable modem and connection.

This is specifically intended to be used with the Motorola SB6120 cable modem. It will collect all of the downstream & upstream signal-to-noise and power level data as well as the most recent log timestamp and entry.

It also perfoms a ping test (currently 100 pings to www.comcast.net) to determine average and max ping time as well as packet loss

All of the data is printed in a comma-seperated format for use in a spreadsheet to analyze pattern
the output is in the following format:
`timestamp,% packet loss,avg ping time(ms),max ping time(ms),down channel 1,snr,power,down channel 2,snr,power,down channel 3,snr,power,down channel 4,snr,power,up channel 1,power,up channel 2,power,up channel 3,power,log timestamp,log message`

# Examples
## Crontab entry
The script is intended to be run on cron (I run it every 5 minutes)
`*/5 * * * *       $HOME/Documents/git/modem_check/modem_check.rb >> $HOME/Documents/git/modem_check/modem_log.txt 2>&1`

## Example output
```
2014-08-08 10:35:00,0.0%,28.894,28.899,7 (down),37 dB,0 dBmV,10 (down),37 dB,-3 dBmV,12 (down),37 dB,-4 dBmV,15 (down),37 dB,-4 dBmV6 (up),39 dBmV,5 (up),39 dBmV,7 (up),39 dBmVAug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
2014-08-08 10:40:01,0.0%,29.190,43.422,7 (down),37 dB,0 dBmV,10 (down),36 dB,-3 dBmV,12 (down),37 dB,-4 dBmV,15 (down),36 dB,-4 dBmV6 (up),39 dBmV,5 (up),39 dBmV,7 (up),39 dBmVAug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
2014-08-08 10:45:00,0.0%,28.859,35.932,7 (down),37 dB,0 dBmV,10 (down),37 dB,-3 dBmV,12 (down),37 dB,-3 dBmV,15 (down),37 dB,-3 dBmV6 (up),39 dBmV,5 (up),39 dBmV,7 (up),39 dBmVAug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
2014-08-08 10:50:01,0.0%,29.401,41.258,7 (down),37 dB,0 dBmV,10 (down),37 dB,-2 dBmV,12 (down),37 dB,-2 dBmV,15 (down),37 dB,-3 dBmV6 (up),39 dBmV,5 (up),39 dBmV,7 (up),39 dBmVAug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
```
