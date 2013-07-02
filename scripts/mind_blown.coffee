# Description:
#   Mind.Blown.
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   mind blown
#   mind blown <text>

module.exports = (robot) ->

  robot.hear /(blows my )?mind( is )?(blown)?/i, (msg) ->
    msg.send "https://s3.amazonaws.com/uploads.hipchat.com/40440/284419/s3kihdl636imy0y/UmpOi.gif"