# Purpose
The purpose of this script is to perform a health-check of the cable modem and connection.

This is specifically intended to be used with the Motorola SB6120 cable modem. It will collect all of the downstream & upstream signal-to-noise and power level data as well as the most recent log timestamp and entry.

It also perfoms a ping test (currently 100 pings to www.comcast.net) to determine average and max ping time as well as packet loss

All of the data is printed in a comma-seperated format for use in a spreadsheet to analyze pattern
the output is in the following format:
`timestamp,% packet loss,avg ping time(ms),max ping time(ms),down channel 1 snr,down channel 1 power,down channel 2 snr,down channel 2 power,down channel 3 snr,down channel 3 power,down channel 4 snr,down channel 4 power,up channel 1 power,up channel 2 power,up channel 3 power,log timestamp,log message`

# Examples
## Crontab entry
The script is intended to be run on cron (I run it every 5 minutes)
`*/5 * * * *       $HOME/Documents/git/modem_check/modem_check.rb >> $HOME/Documents/git/modem_check/modem_log.txt 2>&1`

## Example output
```
2014-08-08 12:30:01,0.0%,28.972,39.697,37,37,37,37,0,-2,-3,-4,40,39,39,Aug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
2014-08-08 12:35:00,0.0%,28.754,36.918,37,37,37,37,0,-2,-3,-4,40,39,39,Aug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
2014-08-08 12:40:00,0.0%,29.387,37.260,36,36,37,37,-5,-5,-5,-5,39,39,39,Aug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
2014-08-08 12:45:00,0.0%,28.989,37.495,36,37,37,37,-4,-4,-4,-5,39,39,39,Aug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
2014-08-08 12:50:00,0.0%,29.003,36.379,37,37,37,36,-0,-2,-4,-5,39,39,39,Aug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
2014-08-08 12:55:01,0.0%,28.925,36.435,37,37,37,36,-0,-2,-3,-5,39,39,39,Aug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
```
