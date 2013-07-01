# Description:
#   Sheen!
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot sheen me - A randomly selected kitten
#   hubot sheen me <w>x<h> - A kitten of the given size
#   hubot sheen bomb me <number> - Many many kittens!
#
# Author:
#   paulcook

module.exports = (robot) ->
  robot.respond /sheen?(?: me)?$/i, (msg) ->
    msg.send sheenMe()

  robot.respond /sheen?(?: me)? (\d+)(?:[x ](\d+))?$/i, (msg) ->
    msg.send sheenMe msg.match[1], (msg.match[2] || msg.match[1])

  robot.respond /sheen bomb(?: me)?( \d+)?$/i, (msg) ->
    sheens = msg.match[1] || 5
    msg.send(sheenMe()) for i in [1..sheens]

sheenMe = (height, width)->
  h = height ||  Math.floor(Math.random()*250) + 250
  w = width  || Math.floor(Math.random()*250) + 250
  root = "http://placesheen.com"
  #root += "/g" if Math.random() > 0.5 # greyscale sheens!
  return "#{root}/#{h}/#{w}#.png"