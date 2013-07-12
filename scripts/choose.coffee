# Description:
#   Allows Hubot to play a choose your own adventure
#
# Dependencies:
#   None
#
# Configuration:
#   None
#
# Commands:
#   hubot roll dice - Roll two six-sided dice
#   hubot roll <x>d<y> - roll x dice, each of which has y sides
#
# Author:
#   ab9

module.exports = (robot) ->
  robot.respond /adventure/i, (msg) ->
    msg.reply "As you wish..."
    msg.send getRandomText(START_ADVENTURE)
  robot.hear /roll dice/i, (msg) ->
    msg.reply report roll 2, 6
  robot.hear /roll (\d+)d(\d+)/i, (msg) ->
    dice = parseInt msg.match[1]
    sides = parseInt msg.match[2]
    answer = if sides < 1
      "I don't know how to roll a zero-sided die."
    else if dice > 100
      "I'm not going to roll more than 100 dice for you."
    else
      report roll dice, sides
    msg.reply answer

report = (results) ->
  if results?
    switch results.length
      when 0
        "I didn't roll any dice."
      when 1
        "I rolled a #{results[0]}."
      else
        total = results.reduce (x, y) -> x + y
        finalComma = if (results.length > 2) then "," else ""
        last = results.pop()
        "I rolled #{results.join(", ")}#{finalComma} and #{last}, making #{total}."

roll = (dice, sides) ->
  rollOne(sides) for i in [0...dice]

rollOne = (sides) ->
  1 + Math.floor(Math.random() * sides)

getRandomText = (txt_array) ->
  txt_array[getRandomIndex(txt_array.length)]

getRandomIndex = (length) ->
  Math.floor(Math.random()*length)

START_ADVENTURE = [
  "You read those fateful words and suddenly your eyelids grow heavy and the worlds around you begins to go dark. Alarmed by the change that is instantly consuming your world, you attempt to stand but you only manage to fall forward, blacking out before you hit the desk...",
  "As you finish reading those fateful words, a tingling sensation overwhelms you. You begin to panic when you realize it feels like thousands of fire ants are crawling under your skin. Before you can tear the flesh off of your own arms, you become dizzy and black out...",
  "Those fateful words are barely finished being processed by your feeble mind when a blinding flash erupts from your monitor and engulfs you in a pure white light. It's beautiful and terrifying all at once and as tears stream down your face you lose consiousness, overcome by the flood of emotions..."
]