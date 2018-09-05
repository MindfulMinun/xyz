xyz ?= {}

###*
 * The xyz.time namespace
 * @namespace
###
xyz.time ?= {}

###*
 * Returns the time since the given date in a human format.
 * @author MindfulMinun
 * @param {Date|DateResolvable} [date] - The date to determine the time from.
 * @returns {String} A human formatted date.
 * @example
 * xyz.time.since(+new Date() + (60 * 1000))           // -> "Soon..."
 * xyz.time.since(+new Date())                         // -> "Just now"
 * xyz.time.since(+new Date() - (60 * 1000))           // -> "A minute ago"
 * xyz.time.since(+new Date() - (86400 * 1000))        // -> "Yesterday"
 * xyz.time.since(+new Date() - (86400 * 14 * 1000))   // -> "14 days ago"
 * xyz.time.since(+new Date() - (86400 * 30 * 1000))   // -> "A month ago"
 * xyz.time.since(+new Date() - (86400 * 365 * 1000))  // -> "A year ago"
 * @since Sep 4, 2018 - 0.1.0
 * @version 0.1.0
###
xyz.time.since ?= (date) ->
    # Since: modeled after this Gist and Moment.js
    # https://gist.github.com/MindfulMinun/c82f976e7f9df746c22978ffd819c123
    if not date?                  then date = new Date
    if not (date instanceof Date) then date = new Date(date)
    if Number.isNaN +date         then throw Error "xyz.since: Invalid Date"

    secs = ((+new Date) - (+date)) / 1000
    s = Math.round secs % 60
    m = Math.round (secs % 3600) / 60
    h = Math.round (secs % 86400) / 3600
    d = Math.round (secs % (30.5 * 86400)) / 86400
    M = Math.round (secs % (365 * 86400)) / (30.5 * 86400)
    y = Math.round secs / (365 * 86400)

    switch
        when secs < -5          then "Soon..."
        when secs < 15          then "Just now"
        when secs < 45          then "#{s} seconds ago"
        when secs < 90          then "A minute ago"
        when secs < 60 * 45     then "#{m} minutes ago"
        when secs < 60 * 90     then "An hour ago"
        when secs < 22 * 3600   then "#{h} hours ago"
        when secs < 36 * 3600   then "Yesterday"
        # when secs < 60 * 3600   then "2 days ago"
        when secs < 26 * 86400  then "#{d} days ago"
        when secs < 45 * 86400  then "A month ago"
        when secs < 320 * 86400 then "#{M} months ago"
        when secs < 548 * 86400 then "A year ago"
        else                         "#{y} years ago"
    ###
        Range                           Return value
        ------------------------------  ------------------------------
        Before -6s                      Soon...
        -5s to 14s                      Just now
        15s to 44s                      _ seconds ago
        45s to 89s                      A minute ago
        90s to 44m                      _ minutes ago
        45m to 89m                      An hour ago
        90m to 21h                      _ hours ago
        22h to 35h                      Yesterday
        60h to 25d                      _ days ago
        26d to 44d                      A month ago
        45d to 319d                     _ months ago
        320d to 548d                    A year ago
        After 549 days                  _ years ago
    ###

###*
 * Formats a number of seconds into a nice, human-readable string.
 * @author MindfulMinun
 * @param {Number} secs - The number of seconds
 * @return {String} A human-readable string
 * @example
 * xyz.time.format(89)   // ->    "01:29"
 * xyz.time.format(5307) // -> "01:28:27"
 * @since Sep 4, 2018 - 0.1.0
 * @version 0.1.0
###
xyz.time.format ?= (secs) ->
    r = ''
    s = ~~secs % 60
    m = ~~(secs / 60) % 60
    h = ~~((secs) / 60 / 60)

    r += if h then (if h < 10 then "0#{h}:" else "#{h}:") else ""
    r += if m < 10  then "0#{m}:" else "#{m}:"
    r += if s < 10  then "0#{s}" else "#{s}"
