# Description:
#   Dialectize some talk stuff
#
# Commands:
#   hubot <dialect> me <text> - translates text to one of dialects: redneck, jive, cockney, fudd, bork, moron, piglatin, hckr, censor
#
# Events:
#   none

QS = require 'querystring'
htmlparser = require "htmlparser"
select = require('cheerio-select')
cheerio = require("cheerio")

dialects = [
  "redneck",
  "jive",
  "cockney",
  "fudd",
  "bork",
  "moron",
  "piglatin",
  "hckr",
  "censor"
]

module.exports = (robot) ->
  dialect_choices = (dialect for _, dialect of dialects).sort().join('|')
  pattern = new RegExp("(#{dialect_choices}) me (.*)",'i')

  robot.respond pattern, (msg) ->
    dialect = msg.match[1]
    text = msg.match[2]
    user_name = msg.message.user.name

    params = QS.stringify({
        'dialect': dialect,
        'text': text
        })
    #msg.send "I'm working on translating your perfectly good North American English to #{dialect}:"

    robot.http("http://www.rinkworks.com/dialect/dialectt.cgi")
      .header('User-Agent', 'Mozilla/5.0')
      .post(params) (err, res, body) ->
        message_text = ''
        $ = cheerio.load(body)
        $('.dialectized_text p').each( (idx, ele) ->
          message_text += $(this).text().trim()
        )
        msg.send "@#{user_name} speaking in #{dialect} said: #{message_text}"

