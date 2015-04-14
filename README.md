# Purpose
The purpose of this script is to perform a health-check of the cable modem and connection.

This is specifically intended to be used with the Motorola SB6120 cable modem. It will collect all of the downstream & upstream signal-to-noise and power level data as well as the most recent log timestamp and entry.

It also perfoms a ping test (currently 100 pings to www.comcast.net) to determine average and max ping time as well as packet loss

All of the data is printed in a comma-seperated format for use in a spreadsheet to analyze pattern
the output is in the following format:
`timestamp,% packet loss,avg ping time(ms),max ping time(ms),down channel 1 snr,down channel 2 snr,down channel 3 snr,   down channel 4 snr,down channel 1 power,down channel 2 power,down channel 3 power,down channel 4 power,up channel 1     power,up channel 2 power,up channel 3 power,log timestamp,log message`

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
2014-08-08 13:05:00,0.0%,41.044,49.974,37,37,37,37,0,-1,-3,-4,41,41,40,Aug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
2014-08-08 13:10:00,0.0%,29.249,36.717,37,37,37,36,0,-1,-2,-4,40,40,40,Aug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
2014-08-08 13:15:01,0.0%,30.449,51.709,36,36,37,35,-6,-5,-4,-7,39,39,39,Aug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
2014-08-08 13:20:00,0.0%,28.852,45.695,36,37,37,36,-3,-4,-4,-6,39,39,39,Aug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
2014-08-08 13:25:01,0.0%,28.945,36.311,37,37,37,36,-3,-4,-5,-6,39,39,39,Aug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
2014-08-08 13:30:00,0.0%,28.930,43.007,37,37,37,37,0,-2,-3,-4,39,39,39,Aug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
2014-08-08 13:35:01,0.0%,60.078,75.222,37,37,37,37,0,-2,-4,-5,39,39,39,Aug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
2014-08-08 13:40:00,0.0%,28.809,36.519,36,36,37,37,-6,-5,-5,-6,39,39,39,Aug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
2014-08-08 13:45:01,0.0%,29.153,36.017,37,37,37,37,0,-2,-4,-5,39,39,39,Aug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
2014-08-08 13:50:00,0.0%,29.113,43.619,37,37,37,36,0,-2,-3,-5,39,39,39,Aug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
2014-08-08 13:55:00,0.0%,28.995,36.334,37,37,37,36,-1,-2,-3,-5,39,39,39,Aug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
2014-08-08 14:00:00,0.0%,29.265,42.161,37,37,37,36,0,-1,-3,-5,40,40,40,Aug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
2014-08-08 14:05:00,0.0%,47.255,61.706,37,37,37,36,0,-1,-3,-5,40,39,40,Aug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
2014-08-08 14:10:01,0.0%,28.672,36.686,37,37,37,36,0,-1,-2,-4,40,40,40,Aug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
2014-08-08 14:15:00,0.0%,29.355,40.786,37,37,37,36,0,-1,-2,-4,41,41,40,Aug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
2014-08-08 14:20:00,8.0%,30.401,38.766,37,37,37,36,0,0,-2,-4,41,41,40,Aug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
2014-08-08 14:25:00,0.0%,29.190,63.943,37,37,37,36,0,-1,-2,-3,41,41,40,Aug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
2014-08-08 14:30:00,0.0%,29.232,38.491,37,37,37,37,1,0,-1,-2,39,41,44,Aug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
2014-08-08 14:35:00,0.0%,39.663,53.770,37,37,37,37,0,-1,-2,-3,39,38,39,Aug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
2014-08-08 14:40:00,0.0%,47.330,54.419,37,37,37,37,1,-1,-2,-3,38,38,40,Aug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
2014-08-08 14:45:01,0.0%,62.275,74.074,37,37,37,37,1,-1,-2,-3,38,38,38,Aug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
2014-08-08 14:50:00,0.0%,43.123,53.103,38,37,37,37,1,-1,-2,-2,38,37,37,Aug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
2014-08-08 14:55:01,0.0%,41.673,48.663,37,37,37,37,1,-1,-2,-2,38,37,37,Aug 07 2014 12:44:11,SYNC Timing Synchronization failure - Loss of Sync
```

## Sample graphs created from data:
![](https://raw.githubusercontent.com/billimek/modem_check/master/images/ping%20graph.png)
![](https://raw.githubusercontent.com/billimek/modem_check/master/images/snr%20power%20graph.png)
