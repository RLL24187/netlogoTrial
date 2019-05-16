breed [players player]
breed [dragons dragon]
breed [bullets bullet]
breed [rocks rock]
breed [monsters monster]
breed [item-drops item-drop]
breed [bosses boss]
breed [feathers feather]
monsters-own [HP weakness]
item-drops-own [reward]
bosses-own [HP species direction weakness]
bullets-own [power DragonColor]
globals
[
  highscore score                                         ;--Score Count Vars--;
  kills boss-kills                                        ;--Kill Count Vars--;
  coinGet powerupGet Bank-Acct max-upgrade                ;--Item Count Vars--;
  standardPower standardHP attackPattern                  ;--Attack and HP Vars--;
  bossType
  doubleBulletDuration triplePowerDuration magnetDuration ;--Powerup Duration Vars--;
  powerNumber
  pullRadius
  originalPull
  crystalProb
  standardSpeed
  speed
  cooldown
  buyDragon1 buyDragon2 buyDragon3 buyDragon4 buyDragon5  ;--Buying dragons--;
  buyAvatar                                               ;--Buying avatars--;
]
players-own [lives]
patches-own [original-color nextColor]

;;;;;;;;;;;;
;Setup code;---------------------------------------------------------------------------
;;;;;;;;;;;;
to resetGame ;sets up the initial power and resets highscore and score
  ca
  set highscore 0
  set score 0
  set standardPower 250
  set powerNumber 0
  set buyDragon1 0
  set buyDragon2 0
  set buyDragon3 0
  set buyDragon4 0
  set buyDragon5 0
  set dragon1 ""
  set dragon2 ""
  set avatar "blueman"
end

to setup
  ask turtles [die]
  set-patch-size 34
  reset-ticks
  resize-world -5 5 -5 10
  set-default-shape monsters "monster"
  set-default-shape bullets "circle"
  set-default-shape rocks "stone"
  set-default-shape feathers "feather"
  set-default-shape bullets "bullet"
  set standardHP 4500  ;standardHP = HP of monsters--standardHP * 5 = HP of bosses;
  set standardPower (250 + powerNumber)
  set coinGet 0
  set powerupGet 0
  set score 0
  set kills 0
  set boss-kills 0
  set doubleBulletDuration 0
  set triplePowerDuration 0
  set magnetDuration 0
  set standardSpeed 0.001
  set speed 0.001
  set cooldown 0
  ifelse dragon1 = "pebbles" or dragon2 = "pebbles"
  [set originalPull 2]
  [set originalPull 1.5]
  ifelse dragon1 = "thorn" or dragon2 = "thorn"
  [set crystalProb 75]
  [set crystalProb 51]
  set pullRadius originalPull
  randomBoss
  ask patches
  [set pcolor (green - 1) + random 3]
  create-players 1
  [
    set color sky
    set size 2
    set ycor min-pycor + 2
    set heading 0
    if avatar = "burntambre"
    [
      user-message "You cannot start the game using this avatar. Sorry!"
      ifelse buyAvatar = 1
      [set avatar "ambre"]
      [set avatar "blueman"]
    ]
    if avatar = "ambre"
    [
    ifelse buyAvatar != 1
    [
      ifelse Bank-Acct >= 1000
      [
      set Bank-Acct Bank-Acct - 1000
      set buyAvatar 1
      set lives 2
      ]
      [
        user-message "You don't have enough to buy this avatar! You need at least 1000 coins to purchase it!"
        set avatar "blueman"
      ]
    ]
      [set lives 2]
    ]
    set shape word avatar "rt"
  if avatar = "blueman"
  [set lives 1]
  ]
   if dragon1 != ""
  [
    create-dragons 1
    [
      set shape dragon1
      set size 1.5
      set ycor min-pycor + 1.5
      set heading 0
      set xcor -2
      if shape = "aquawing"
      [
        ifelse buyDragon1 = 1
        [set color cyan]
        [
          ifelse Bank-Acct >= 100
          [
            set Bank-Acct Bank-Acct - 100
            set buyDragon1 1
            set color cyan
          ]
          [
            set dragon1 ""
            user-message "You don't have enough for this dragon!"
            die
          ]
        ]
      ]
      if shape = "charlie"
      [
        ifelse buyDragon2 = 1
        [set color orange]
        [
          ifelse Bank-Acct >= 100
          [
            set Bank-Acct Bank-Acct - 100
            set buyDragon2 1
            set color orange
          ]
          [
            set dragon1 ""
            user-message "You don't have enough for this dragon!"
            die
          ]
        ]
      ]
      if shape = "pebbles"
      [
        ifelse buyDragon3 = 1
        [set color brown]
        [
          ifelse Bank-Acct >= 100
          [
            set Bank-Acct Bank-Acct - 100
            set buyDragon3 1
            set color brown
          ]
          [
            set dragon1 ""
            user-message "You don't have enough for this dragon!"
            die
          ]
        ]
      ]
      if shape = "stormy"
      [
        ifelse buyDragon4 = 1
        [set color gray]
        [
          ifelse Bank-Acct >= 100
          [
            set Bank-Acct Bank-Acct - 100
            set buyDragon4 1
            set color gray
          ]
          [
            set dragon1 ""
            user-message "You don't have enough for this dragon!"
            die
          ]
        ]
      ]
      if shape = "thorn"
      [
        ifelse buyDragon5 = 1
        [set color turquoise]
        [
          ifelse Bank-Acct >= 100
          [
            set Bank-Acct Bank-Acct - 100
            set buyDragon5 1
            set color turquoise
          ]
          [
            set dragon1 ""
            user-message "You don't have enough for this dragon!"
            die
          ]
        ]
      ]
    ]
  ]
  if dragon2 != ""
  [
    create-dragons 1
    [
      set shape dragon2
      set size 1.5
      set ycor min-pycor + 1.5
      set heading 0
      set xcor 2
      if shape = "aquawing"
      [
      ifelse buyDragon1 = 1
      [set color cyan]
      [
        ifelse Bank-Acct >= 100
        [
          set Bank-Acct Bank-Acct - 100
          set buyDragon1 1
          set color cyan
        ]
        [
          set dragon2 ""
          die
          ]
        ]
      ]
      if shape = "charlie"
      [
        ifelse buyDragon2 = 1
        [set color orange]
        [
          ifelse Bank-Acct >= 100
          [
            set Bank-Acct Bank-Acct - 100
            set buyDragon2 1
            set color orange
          ]
          [
            set dragon2 ""
            die
           ]
        ]
      ]
      if shape = "pebbles"
      [
        ifelse buyDragon3 = 1
        [set color brown]
        [
          ifelse Bank-Acct >= 100
          [
            set Bank-Acct Bank-Acct - 100
            set buyDragon3 1
            set color brown
          ]
          [
            set dragon2 ""
            die
          ]
        ]
      ]
      if shape = "stormy"
      [
        ifelse buyDragon4 = 1
        [set color gray]
        [
          ifelse Bank-Acct >= 100
          [
            set Bank-Acct Bank-Acct - 100
            set buyDragon4 1
            set color gray
          ]
          [
            set dragon2 ""
            die
          ]
        ]
      ]
      if shape = "thorn"
      [
        ifelse buyDragon5 = 1
        [set color turquoise]
        [
          ifelse Bank-Acct >= 100
          [
            set Bank-Acct Bank-Acct - 100
            set buyDragon5 1
            set color turquoise
          ]
          [
            set dragon2 ""
            die
          ]
        ]
      ]
    ]
  ]
end

to go
  every speed
  [
    tick
    if ticks mod 30 = 0
    [shiftOver]
    dragPlayer
    runIllusion
    shoot
    flyIllusion
    spit
    spawnWave
    spawnRocks
    hurtMonstersandBosses
    randomBoss
    spawnBoss
    snakeBossBehavior
    birdBossBehavior
    featherBehavior
    getKilled
    if cooldown > 0
    [set cooldown cooldown - 1]
    if cooldown = 199
    [ask patches [set pcolor pcolor - 30]]
    if cooldown = 10
    [ask patches [set pcolor pcolor + 30]]
    if cooldown = 0
    [set speed 0.001]
    coinBehavior
    countScore
    newHighScore
    set max-upgrade Bank-Acct - remainder Bank-Acct 10
    if count players = 0
    [
      ask patches
      [set pcolor pcolor mod 10]
      user-message "You died!"
      stop
    ]
    rockBehavior
    increaseHP
  ]
end

;;;;;;;;;;;;;;;;;
;Player Behavior;----------------------------------------------------------------------
;;;;;;;;;;;;;;;;;
to dragPlayer ;moves the player;
  if mouse-down? and mouse-inside?
  [
    ask patch mouse-xcor mouse-ycor
    [
      ask players in-radius 10
      [
        set xcor mouse-xcor
      ]
      ask dragons in-radius 10
      [
        if shape = dragon1 or shape = word dragon1 " flap"
        [set xcor item 0 [xcor] of players - 2]
        if shape = dragon2 or shape = word dragon2 " flap"
        [set xcor item 0 [xcor] of players + 2]
      ]
    ]
  ]
end

to shoot ;players shoot bullets;
  ask players
  [
    if ticks mod 5 = 0
    [
      if doubleBulletDuration > 0
      [
        shootDouble
        set doubleBulletDuration doubleBulletDuration - 1
      ]
      if triplePowerDuration > 0
      [
        shootTriplePower
        set triplePowerDuration triplePowerDuration - 1
      ]
      if doubleBulletDuration <= 0 and triplePowerDuration <= 0
      [hatch-bullets 1
        [
          set color white
          set heading 0
          set size 2
          set power standardPower
        ]
      ]
    ]
    powerIncrease
  ]
    ask bullets
    [
      fd .5
      if [pycor] of patch-ahead -1 = max-pycor
      [die]
    ]
end

to runIllusion
if ticks mod 30 = 0
  [
    ask players
    [
      ifelse shape = word avatar "rt"
      [set shape word avatar "lt"]
      [set shape word avatar "rt"]
    ]
  ]
end

;;;;;;;;;;;;;;;;;
;Dragon Behavior;
;;;;;;;;;;;;;;;;;
to spit
  ask dragons with [shape != "charlie" and shape != "stormy"]
  [
    if ticks mod 5 = 0
    [
      hatch-bullets 1
      [
        set color [color] of myself
        set heading 0
        set size 1
        set power standardPower * .75 ;dragon bullets are 3/4 the power of player bullets
      ]
    ]
  ]
  ask dragons with [shape = "charlie"]
  [
    if ticks mod 5 = 0
    [
      hatch-bullets 2
      [
        set color [color] of myself
        set heading 0
        set size 1
        set power standardPower * .75
        ifelse who mod 2 = 1
        [set xcor xcor + .25]
        [set xcor xcor - .25]
      ]
    ]
  ]
  ask dragons with [shape = "stormy"]
  [
    hatch-bullets 2
    [
      set color [color] of myself
      set heading 0
      set size 1
      set power standardPower * .5
      ifelse who mod 2 = 1
      [set xcor xcor + .25]
      [set xcor xcor - .25]
    ]
  ]
    ask bullets
    [
      ifelse any? monsters and color = gray
      [
        fd 1
        face min-one-of monsters [distance myself]
      ]
      [
        set heading 0
        fd 1
        if [pycor] of patch-ahead -1 = max-pycor
        [die]
      ]
    ]
end

to flyIllusion
if ticks mod 20 = 0
  [
    ask dragons with [shape = dragon1 or shape = word dragon1 " flap"]
    [
      ifelse shape = dragon1
      [set shape word dragon1 " flap"]
      [set shape dragon1]
    ]
    ask dragons with [shape = dragon2 or shape = word dragon2 " flap"]
    [
      ifelse shape = dragon2
      [set shape word dragon2 " flap"]
      [set shape dragon2]
    ]
  ]
end

;;;;;;;;;;;;;;;;;
;Bullet Behavior;
;;;;;;;;;;;;;;;;;

to hurtMonstersandBosses ;bullets hurt monsters and bosses;
  ask patches
  [
    if any? monsters and any? bullets in-radius 1.5 ;Monsters---------------------------
    [
      ask monsters-here
      [
        if length [power] of bullets-here > 0
        [set HP HP - item 0 [power] of bullets-here]
        ask bullets-here [die]
        ifelse HP < standardHP / 5
        [set color red]
        [ifelse HP < standardHP / 3
          [set color orange]
          [if HP < standardHP / 2
            [set color yellow]
          ]
        ]
        monsterReward
      ]
    ]
    if any? bosses-here with [species = "bird"] and any? bullets in-radius 3 ;Bird------
    [
      ask bosses-here
      [
        if length [power] of bullets in-radius 3 > 0
        [set HP HP - item 0 [power] of bullets in-radius 3]
        ask bullets-here [die]
        ifelse HP < standardHP * 2
        [set color 18]
        [ifelse HP < standardHP * 10 / 3
          [set color 17]
          [if HP < standardHP * 10 / 2
            [set color 16]
          ]
        ]
        bossReward
      ]
    ]
    if any? bosses-here with [species = "snake"] and any? bullets in-radius 5 ;Snake----
    [
      ask bosses-here
      [
        if length [power] of bullets in-radius 5 > 0
        [set HP HP - item 0 [power] of bullets in-radius 5]
        ask bullets-here [die]
        ifelse HP < standardHP * 2
        [set color 108]
        [ifelse HP < standardHP * 10 / 3
          [set color 107]
          [if HP < standardHP * 10 / 2
            [set color 106]
          ]
        ]
        bossReward
      ]
    ]
  ]
end

;;;;;;;;;;;;
;Item-drops;
;;;;;;;;;;;;
to coinBehavior ;item-drops fall
  ask item-drops
  [
    fd .02
    if heading < 180
    [set heading .005 + heading]
    if heading > 180
    [set heading heading - .005]
    if [pycor] of patch-ahead 1 = max-pycor
    [die]
    if [pxcor] of patch-here = min-pxcor
    or [pxcor] of patch-here = max-pxcor
    [set heading 180]
  ]
  ask patches
  [if any? players-here and any? item-drops with [reward = "coin"] in-radius pullRadius
    [
      set coinGet coinGet + 1
      set Bank-Acct Bank-Acct + 1
      ask item-drops in-radius originalPull [die]
    ]
    if any? players-here and any? item-drops with [reward = "crystal"] in-radius pullRadius
    [
      set coinGet coinGet + 10
      set Bank-Acct Bank-Acct + 10
      ask item-drops in-radius originalPull [die]
    ]
   if any? players-here and any? item-drops in-radius pullRadius with [reward = "doubleBullet"]
    [
      set powerupGet powerupGet + 1
      set doubleBulletDuration 2000
      ask item-drops in-radius originalPull [die]
    ]
   if any? players-here and any? item-drops in-radius pullRadius with [reward = "triplePower"]
    [
      set powerupGet powerupGet + 1
      set triplePowerDuration 2000
      ask item-drops in-radius originalPull [die]
    ]
   if any? players-here and any? item-drops in-radius pullRadius with [reward = "magnet"]
    [
      set powerupGet powerupGet + 1
      set magnetDuration 3000
      ask item-drops in-radius originalPull [die]
    ]
    powerIncrease
  ]
  if magnetDuration > 0
  [
    magnetize
    set magnetDuration magnetDuration - 1
    if magnetDuration <= 0
    [set pullRadius originalPull]
  ]
end

to monsterReward
  if HP <= 0 ;1 reward when monster is killed
        [
          set kills kills + 1
          if dragon1 = "aquawing" or dragon2 = "aquawing"and random 10 = 9
          [hatch-item-drops 2
          [
            set reward "coin"
            set shape "circle"
            set size .75
            set color yellow]
          ]
          hatch-item-drops 1
          [
            ifelse random 75 = 1
            [set reward "doubleBullet"]
            [
              ifelse random 75 = 1
              [set reward "triplePower"]
              [
                ifelse random 75 = 1
                [set reward "magnet"]
                [
                  ifelse random 75 = 1
                  [set reward "increasePower"]
                  [
                    ifelse random crystalProb = 1 ;changed by whether or not "thorn" is being used
                    [set reward "crystal"]
                    [set reward "coin"]
                  ]
                ]
              ]
            ]
            if reward = "coin"
            [
              set heading (random 16) + 175
              set size .75
              set color yellow
              set shape "circle"
            ]
            if reward = "crystal"
            [
              set heading (random 16) + 175
              set size 1.5
              set shape "crystal"
            ]
            if reward = "doubleBullet"
            [
              set heading (random 16) + 175
              set color red
              set shape "powerupx2"
              set size 2.5
            ]
            if reward = "triplePower"
            [
              set heading (random 16) + 175
              set color sky
              set shape "triplePowerup"
              set size 2.5
            ]
            if reward = "magnet"
            [
              set heading (random 16) + 175
              set color gray
              set shape "magnet"
              set size 2.5
            ]
            if reward = "increasePower"
            [
              set heading (random 16) + 175
              set color orange
              set shape "arrow"
              set size 1.5
            ]
          ]
          die
        ]
end

to bossReward
  if HP <= 0 ;50 rewards when boss is killed
        [
          set boss-kills boss-kills + 1
          if dragon1 = "aquawing" or dragon2 = "aquawing" and random 10 = 9
          [hatch-item-drops 2
          [
            set reward "coin"
            set shape "circle"
            set size .75
            set color yellow]
          ]
          hatch-item-drops 50
          [
            ifelse random 75 = 1
            [set reward "doubleBullet"]
            [
              ifelse random 75 = 1
              [set reward "triplePower"]
              [
                ifelse random 75 = 1
                [set reward "magnet"]
                [
                  ifelse random 75 = 1
                  [set reward "increasePower"]
                  [
                    ifelse dragon1 != "aquawing" or dragon2 != "aquawing" and random 75 = 1
                    [set reward "crystal"]
                    [set reward "coin"]
                  ]
                ]
              ]
            ]
            if reward = "coin"
            [
              set heading (random 16) + 175
              set size .75
              set color yellow
              set shape "circle"
            ]
            if reward = "crystal"
            [
              set heading (random 16) + 175
              set size 1.5
              set shape "crystal"
            ]
            if reward = "doubleBullet"
            [
              set heading (random 16) + 175
              set color red
              set shape "powerupx2"
              set size 2.5
            ]
            if reward = "triplePower"
            [
              set heading (random 16) + 175
              set color sky
              set shape "triplePowerup"
              set size 2.5
            ]
            if reward = "magnet"
            [
              set heading (random 16) + 175
              set color gray
              set shape "magnet"
              set size 2.5
            ]
            if reward = "increasePower"
            [
              set heading (random 16) + 175
              set color orange
              set shape "arrow"
              set size 1.5
            ]
          ]
          die
        ]
end

;;;;;;;;;;;
;Powerups;----------------------------------------------------------------------------
;;;;;;;;;;;
to upgradePower ;increases standardPower by 10 at cost of 10 Coins from Bank-Acct;
  if Bank-Acct >= 10
  [
    set Bank-Acct Bank-Acct - 10
    set standardPower standardPower + 10
    set powerNumber powerNumber + 10
  ]
end

to upgradePowerMax ;increases standardPower to the max possible based on current coin count
  if Bank-Acct >= 10
  [
    set max-upgrade Bank-Acct - remainder Bank-Acct 10
    set Bank-Acct Bank-Acct - max-upgrade
    set standardPower standardPower + max-upgrade
    set powerNumber powerNumber + max-upgrade
    set max-upgrade 0
  ]
end

to powerIncrease ;item drop that can increase power by 10 for that game
  if any? players-here and any? item-drops in-radius 1.5
  [
    ask item-drops
    [
      if reward = "increasePower"
      [
        set standardPower standardPower + 10
        set powerupGet powerupGet + 1
        die
      ]
    ]
  ]
end

to shootDouble ;Player shoots 2 bullets at a time;
  ask players
    [
      hatch-bullets 2
      [
        set color white
        set heading 0
        set size 2
        set power standardPower
        if who mod 2 = 1
        [
          setxy xcor - .5 pycor]
        if who mod 2 = 0
        [
          setxy xcor + .5 pycor]
      ]
    ]
  ask bullets with [color = white]
  [
    fd .5
    if [pycor] of patch-ahead -1 = max-pycor
    [die]
  ]
end

to shootTriplePower ;Player shoots 1 bullet at a time with 3 times the power;
  ask players
    [
      hatch-bullets 1
      [
        set color white
        set heading 0
        set size 3.5
        set power standardPower * 3
      ]
    ]
  ask bullets
  [
    fd .5
    if [pycor] of patch-ahead -1 = max-pycor
    [die]
  ]
end

to magnetize ;pullRadius increases by .5
  ask players
  [
    if pullRadius != originalPull + .5
    [set pullRadius pullRadius + .5]
    if any? item-drops in-radius pullRadius
    [ask item-drops in-radius pullRadius
      [
        face myself
        fd .1
      ]
    ]
  ]
end

;;;;;;;;;;;;;;
;Scoring code;
;;;;;;;;;;;;;;
to getKilled ;players get killed by monsters, rocks, feathers, or snake
  ask patches
  [
    if (any? monsters in-radius 1.5
      or any? rocks in-radius 1.5
      or any? feathers-here
      or any? bosses in-radius 4)
      and any? players-here
    [
      ask players-here
      [set lives lives - 1]
      ask monsters in-radius 1.5 [die]
      ask rocks in-radius 1.5 [die]
      ask feathers-here [die]
      set speed 0.01
      set cooldown 200
      set avatar "burntambre"
      ask players [set color gray]
    ]
  ]
  ask players
  [
   if lives = 0
   [die]
  ]
end

to countScore
  set score kills + coinGet + (10 * boss-kills)
end

to newHighScore
  if score > highscore
  [set highscore score]
end

;;;;;;;;;;;;;;;;;;;;;;;;;;;
;Monster and Rock Behavior;------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;;;;;;;
to spawnWave ;spawns monsters at regular intervals;
  if ticks mod 1000 = 0 and count bosses <= 0
    [
      create-monsters 5
      [
        set size 2
        set color blue
        set heading 180
        ifelse random 3 = 1
        [set HP standardHP * 2 set color magenta]
        [set HP standardHP]
        setxy ((who mod 5) * 2 - 4) max-pycor
        ifelse random 5 = 4 ;monsters have weaknesses: certain dragons will be more powerful against them
        [set weakness cyan]
        [ifelse random 5 = 3
          [set weakness orange]
          [ifelse random 5 = 2
            [set weakness brown]
            [ifelse random 5 = 1
              [set weakness gray]
              [set weakness turquoise]
            ]
          ]
        ]
      ]
    ]
    ask monsters
    [
      fd .01
      if [pycor] of patch-ahead 1 = max-pycor
      [
        die
      ]
    ]
end


to spawnRocks ;spawns rocks at regular intervals
  if ticks mod 5000 = 0 and count bosses <= 0
  [
    ask patch random-pxcor (max-pycor - 1)
    [
      sprout-rocks 1
      [
        set size 3
        set color gray - 2
      ]
      sprout 1
      [
        set shape "warning"
        set color yellow
        set size 2
      ]
    ]
  ]
end

to rockBehavior ;rocks follow the player for a short interval before falling
  if count players > 0
  [
  ask rocks
  [
    if ticks mod 5000 < 1200
    [set xcor item 0 [xcor] of players]
    if ticks mod 5000 >= 1200
    [
      set heading 180
      fd .05
      if [pycor] of patch-ahead 1 = max-pycor
      [die]
    ]
  ]
  ask turtles with [shape = "warning"]
  [
    if ticks mod 5000 < 1200
    [set xcor item 0 [xcor] of players]
    if ticks mod 5000 >= 1200
    [die]
  ]
  ]
end

;;;;;;;;;;;;;;;;;;;;;
;Background movement;------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;
to storeColor
  set original-color pcolor
end

to storeNextColor
    set nextColor
    [original-color] of patch pxcor (pycor + 1)
end

to changeColor
  set pcolor nextColor
end

to shiftOver ;shifts the entire image one patch down
  ask patches [storeColor]
  ask patches [storeNextColor]
  ask patches [changeColor]
end

;;;;;;;;;;;;;;;;;;;;;
;Difficulty increase;------------------------------------------------------------------
;;;;;;;;;;;;;;;;;;;;;
to increaseHP
  if ticks mod 10000 = 0 and count bosses <= 0
  [set standardHP standardHP + 750]
end

;;;;;;;;
;Bosses;-------------------------------------------------------------------------------
;;;;;;;;
to spawnBoss
  if ticks mod 16000 = 0 and count bosses <= 0
  [
    ask monsters [die]
    ask rocks [die]
    ask turtles with [shape = "warning"] [die]
    ask patch 0 (max-pycor - 4)
    [
      if bossType = "bird"
      [sprout-bosses 1
        [
          set size 7
          set heading 0
          set HP standardHP * 50 * (boss-kills + 1)
          set color red
          set species "bird"
          set shape "bird boss"
          ifelse random 5 = 4 ;weakness
        [set weakness cyan]
        [ifelse random 5 = 3
          [set weakness orange]
          [ifelse random 5 = 2
            [set weakness brown]
            [ifelse random 5 = 1
              [set weakness gray]
              [set weakness turquoise]
            ]
          ]
        ]
        ]
      ]
      if bossType = "snake"
      [sprout-bosses 1
        [
          set size 10
          set heading 180
          set HP standardHP * 50 * (boss-kills + 1)
          set color blue
          set shape "snake boss"
          set species "snake"
          ifelse random 5 = 4 ;weakness
        [set weakness cyan]
        [ifelse random 5 = 3
          [set weakness orange]
          [ifelse random 5 = 2
            [set weakness brown]
            [ifelse random 5 = 1
              [set weakness gray]
              [set weakness turquoise]
            ]
          ]
        ]
          ifelse random 2 = 0
      [set direction "right"]
      [set direction "left"]
        ]
      ]
    ]
  ]
end

to randomBoss                  ;randomizes boss and attack pattern;
   ifelse random 2 = 0
  [
    set bossType "bird"
  ]
  [
    set bossType "snake"
  ]
  set attackPattern random 4   ;attackPattern of bosses changes;
end

to birdBossBehavior
  if ticks mod 500 = 0
    [
      ask bosses with [species = "bird"]
      [
       ifelse any? bosses with [shape = "bird boss"]
        [set shape "bird boss flap"]
        [set shape "bird boss"]
      ]
    ]
    if ticks mod 1000 = 0
  [
    ask bosses with [shape = "bird boss" or shape = "bird boss flap"]
    [
      if attackPattern = 0 or attackPattern = 1
      [hatch-feathers 15
        [
          set heading (who * 24)
          set size 2
        ]
        if attackPattern = 1
        [
        ask feathers [set heading heading + 12]
        ]
      ]
      if attackPattern = 2 or attackPattern = 3
      [hatch-feathers 30
        [
          set heading (who * 12)
          set size 2
        ]
          if attackPattern = 2
          [
            ask feathers [if heading > 180 [die]]
          ]
          if attackPattern = 3
          [
            ask feathers [if heading < 180 [die]]
          ]
        ]
      ]
    ]
end

to featherBehavior
  ask feathers
  [
    fd 0.02
    if [pycor] of patch-ahead -1 = max-pycor
    or [pycor] of patch-ahead -1 = min-pycor
    or [pxcor] of patch-ahead -1 = max-pxcor
    or [pxcor] of patch-ahead -1 = min-pxcor
    [die]
  ]
end

to snakeBossBehavior
  ask bosses with [species = "snake"]
  [
    if random  750 = 1
      [
        set direction "attack"
      ]
    if direction = "attack"
      [
        fd .002
        set shape "snake boss attack"
      ]
    if any? players
    [
      if pycor = (item 0 [pycor] of players + 3)
      [
        set direction "recoil"
        set shape "snake boss"
      ]
    ]
    if direction = "recoil"
      [
        bk .1
        if pycor = max-pycor - 1
        [ifelse random 2 = 1
          [set direction "right"]
          [set direction "left"]
        ]
      ]
      if direction = "right"
      [
        fd .005
        set xcor xcor + .05
      ]
      if direction = "left"
      [
        fd .005
        set xcor xcor - .05
      ]
        if [pxcor] of patch [pxcor] of patch-here pycor = min-pxcor
        [set direction "right"]
        if [pxcor] of patch [pxcor] of patch-here pycor = max-pxcor
        [set direction "left"]
    ]
end
@#$#@#$#@
GRAPHICS-WINDOW
497
10
879
563
-1
-1
34.0
1
10
1
1
1
0
1
1
1
-5
5
-5
10
0
0
1
ticks
30.0

BUTTON
32
20
124
53
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
32
52
124
85
NIL
go
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
268
21
376
66
HIGHSCORE
highscore
17
1
11

MONITOR
375
21
494
66
SCORE
score
17
1
11

MONITOR
268
108
376
153
Coins collected
coinGet
17
1
11

MONITOR
268
64
376
109
Monsters killed
kills
17
1
11

BUTTON
32
84
124
117
NIL
resetGame
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
270
198
378
243
Bank Account
Bank-Acct
17
1
11

BUTTON
270
241
495
274
Upgrade Power: +10 Power-10 Coins
upgradePower
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
32
217
124
262
Power
standardPower
17
1
11

MONITOR
32
261
124
306
NIL
standardHP
17
1
11

TEXTBOX
129
25
266
117
To start playing the game for the first time, you MUST click \"resetGame\", then the \"setup\" button, then the \"go\" button.
12
0.0
1

MONITOR
32
174
124
219
NIL
attackPattern
17
1
11

MONITOR
375
64
494
109
Bosses killed
boss-kills
17
1
11

MONITOR
32
130
124
175
NIL
bossType
17
1
11

MONITOR
126
174
268
219
NIL
doubleBulletDuration
17
1
11

MONITOR
126
217
268
262
NIL
triplePowerDuration
17
1
11

MONITOR
377
198
495
243
NIL
max-upgrade
17
1
11

BUTTON
270
273
495
306
NIL
upgradePowerMax
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

MONITOR
126
261
268
306
NIL
magnetDuration
17
1
11

MONITOR
375
108
494
153
Powerups collected
powerupGet
17
1
11

CHOOSER
210
313
348
358
dragon1
dragon1
"" "aquawing" "charlie" "pebbles" "stormy" "thorn"
2

CHOOSER
348
313
486
358
dragon2
dragon2
"" "aquawing" "charlie" "pebbles" "stormy" "thorn"
3

CHOOSER
73
313
211
358
avatar
avatar
"ambre" "blueman" "burntambre"
0

MONITOR
112
434
197
479
NIL
originalPull
17
1
11

TEXTBOX
277
362
427
475
DRAGONS: cost 100 coins for first time purchase (will have to be REPURCHASED if your click \"resetGame\")
12
0.0
1

MONITOR
43
434
112
479
NIL
pullRadius
17
1
11

@#$#@#$#@
## WHAT IS IT?

Charge! is a game similar to Everwing or Space Invader, where the avatar has multiple obstacles, like monsters, rocks, and bosses, to overcome to gain points, coins, and powerups during the game.

## HOW IT WORKS

The avatar runs while waves of monsters and occassional rocks come down the world to attack the avatar. The avatar has to dodge or fight off the obstacles in its way to continue in the game and get a higher score.

## HOW TO USE IT

To begin playing for the first time, press resetGame. Then press setup to display the world, and press go to begin the game. Use the mouse to drag the avatar left and right to kill monsters and bosses, as well as avoid them and rocks. You can select different avatars and dragons as sidekicks using the choosers. You MUST play with an avatar, but it is not necessary to play with sidekicks.

## THINGS TO NOTICE

The score is tracked based off of the monsters and bosses killed and the coins collected. If the score of a current game is higher than the high score, it will replace the high score. The number of monsters and bosses killed are counted, as well as the number of coins and powerups collected of that game.  The player can track the power of the avatar's bullets and see the monsters' standardHP. Sometimes, a purple monster will appear. The HP of this monster is twice that of a regular blue monster, with HP equal to the standardHP. There is also a monitor to track the duration of the powerups for the double bullet, triple bullet, and magnet. The bank account keeps track of all the coins collected. Dragons have their own special perks, which help the player increase his/her score. Dragons must be purchased however, before being able to use them. Monsters and bosses will always drop rewards when they are killed by the player. They will either be coins, crystals, or some kind of powerup.

## THINGS TO TRY

Using the coins from the bank account, try buying powerups and different dragons. Different dragons have unique perks that can aid the avatar in killing certain monsters.

## EXTENDING THE MODEL

It is possible to increase the speed of the monsters and attacks as time passes, as well as the frequency of bosses, rocks, and monsters. 

## NETLOGO FEATURES

Unique features of this model included the purchasing system of the dragons and powerups using the bank account. As well as the moving background to imitate movement of the avatar and the movement of dragons and bosses.

## RELATED MODELS

There are Code Examples in the NetLogo Models Library relating to dragging with the Mouse. These include "Mouse Drag Multiple Example" and "Mouse Drag One Example".

## CREDITS AND REFERENCES

Blackstorm Labs (2017). EverWing (2.0) [Mobile application software]. Retrieved from https://androidappsapk.co/download/com.superapp.everwing/.
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

ambrelt
true
0
Polygon -1184463 true false 90 120 75 75 105 30 135 120
Polygon -1184463 true false 210 180 225 225 195 270 165 180
Polygon -2674135 true false 75 120 45 165 90 270 120 240
Polygon -2674135 true false 225 180 255 135 210 30 180 60
Rectangle -955883 true false 75 120 225 180
Circle -2674135 true false 107 105 88

ambrert
true
0
Polygon -1184463 true false 210 120 225 75 195 30 165 120
Polygon -1184463 true false 90 180 75 225 105 270 135 180
Polygon -2674135 true false 225 120 255 165 210 270 180 240
Polygon -2674135 true false 75 180 45 135 90 30 120 60
Rectangle -955883 true false 75 120 225 180
Circle -2674135 true false 105 105 88

aquawing
true
8
Polygon -11221820 true true 120 105 180 105 210 150 195 270 105 270 90 150
Polygon -11221820 true true 120 120 105 75 135 15 165 15 195 75 180 120
Polygon -11221820 true true 105 255 195 255 195 270 165 435 150 480 135 435 105 270
Polygon -13791810 true false 180 120 285 135 375 210 390 345 315 270 255 240 180 225
Polygon -13345367 true false 150 120 135 165 150 195 165 165
Polygon -13345367 true false 150 195 135 240 150 270 165 240
Polygon -1 true false 180 75 180 90 165 90
Polygon -1 true false 120 75 120 90 135 90
Polygon -13345367 true false 150 270 135 315 165 375 150 405 135 375 165 315
Polygon -13791810 true false 120 120 15 135 -75 210 -90 345 -15 270 45 240 120 225
Polygon -1 true false 180 105 165 105 165 135 180 150 210 150 180 135
Polygon -1 true false 120 105 135 105 135 135 120 150 90 150 120 135

aquawing flap
true
8
Polygon -11221820 true true 120 105 180 105 210 150 195 270 105 270 90 150
Polygon -11221820 true true 120 120 105 75 135 15 165 15 195 75 180 120
Polygon -11221820 true true 105 255 195 255 195 270 165 435 150 480 135 435 105 270
Polygon -13791810 true false 180 120 270 60 375 90 435 195 315 180 255 180 195 225
Polygon -13345367 true false 150 120 135 165 150 195 165 165
Polygon -13345367 true false 150 195 135 240 150 270 165 240
Polygon -1 true false 180 75 180 90 165 90
Polygon -1 true false 120 75 120 90 135 90
Polygon -13345367 true false 150 270 135 315 165 375 150 405 135 375 165 315
Polygon -13791810 true false 120 120 30 60 -75 90 -135 195 -15 180 45 180 105 225
Polygon -1 true false 180 105 165 105 165 150 210 150 180 135
Polygon -1 true false 120 105 135 105 135 150 90 150 120 135

arrow
false
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

bird boss
true
1
Polygon -2674135 true true 195 105 300 45 285 105 270 150 255 135 255 165 240 150 240 180 225 165 225 195 210 165
Polygon -2674135 true true 150 105 105 105 90 165 120 210 180 210 210 165 195 105
Polygon -1184463 true false 180 210 195 240 225 240 240 240
Polygon -1184463 true false 120 210 105 240 75 240 60 240
Polygon -2674135 true true 105 105 0 45 15 105 30 150 45 135 45 165 60 150 60 180 75 165 75 195 90 165
Polygon -1184463 true false 285 60 210 120 225 165 225 135 240 150 240 120 255 135 255 105 270 135
Polygon -1184463 true false 15 60 90 120 75 165 75 135 60 150 60 120 45 135 45 105 30 135
Polygon -955883 true false 135 195 165 195 180 165 180 135 165 150 165 120 150 150 135 120 135 150 120 135 120 165
Polygon -1184463 true false 135 180 150 195 150 195 165 180 150 165
Polygon -1 true false 135 165 120 150 120 135
Polygon -1 true false 165 165 180 150 180 135
Polygon -16777216 true false 180 165 165 165 180 150
Polygon -16777216 true false 120 165 135 165 120 150
Polygon -2674135 true true 105 105 90 45 105 15 120 45 150 0 180 45 195 15 210 45 195 105
Polygon -955883 true false 105 105 105 60 120 75 150 30 180 75 195 60 195 105
Polygon -1184463 true false 120 105 120 90 135 105 150 75 165 105 180 90 180 105
Polygon -1184463 true false 195 240 210 255 210 240
Polygon -1184463 true false 105 240 90 255 90 240
Polygon -1184463 true false 210 240 180 225 195 225
Polygon -1184463 true false 90 240 120 225 105 225

bird boss flap
true
1
Polygon -2674135 true true 150 105 105 105 90 165 120 210 180 210 210 165 195 105
Polygon -1184463 true false 180 210 195 240 225 240 240 240
Polygon -1184463 true false 120 210 105 240 75 240 60 240
Polygon -2674135 true true 195 105 300 90 285 135 270 180 255 165 255 165 240 195 240 180 225 195 225 195 210 165
Polygon -955883 true false 135 195 165 195 180 165 180 135 165 150 165 120 150 150 135 120 135 150 120 135 120 165
Polygon -1184463 true false 135 180 150 195 150 195 165 180 150 165
Polygon -1 true false 135 165 120 150 120 135
Polygon -1 true false 165 165 180 150 180 135
Polygon -16777216 true false 180 165 165 165 180 150
Polygon -16777216 true false 120 165 135 165 120 150
Polygon -2674135 true true 105 105 90 45 105 15 120 45 150 0 180 45 195 15 210 45 195 105
Polygon -955883 true false 105 105 105 60 120 75 150 30 180 75 195 60 195 105
Polygon -1184463 true false 120 105 120 90 135 105 150 75 165 105 180 90 180 105
Polygon -1184463 true false 195 240 210 255 210 240
Polygon -1184463 true false 105 240 90 255 90 240
Polygon -1184463 true false 210 240 180 225 195 225
Polygon -1184463 true false 90 240 120 225 105 225
Polygon -2674135 true true 105 105 0 90 15 135 30 180 45 165 45 165 60 195 60 180 75 195 75 195 90 165
Polygon -1184463 true false 285 105 210 120 210 150 210 150 225 180 240 150 240 180 255 150 270 165
Polygon -1184463 true false 15 105 90 120 90 150 90 150 75 180 60 150 60 180 45 150 30 165

bluemanlt
true
0
Polygon -11221820 true false 90 120 75 75 105 30 135 120
Polygon -11221820 true false 210 180 225 225 195 270 165 180
Polygon -13345367 true false 90 120 60 165 105 270 135 240
Polygon -13345367 true false 225 180 255 135 210 30 180 60
Rectangle -13791810 true false 90 120 240 180
Circle -13345367 true false 107 105 88

bluemanrt
true
0
Polygon -11221820 true false 210 120 225 75 195 30 165 120
Polygon -11221820 true false 90 180 75 225 105 270 135 180
Polygon -13345367 true false 225 120 255 165 210 270 180 240
Polygon -13345367 true false 75 180 45 135 90 30 120 60
Rectangle -13791810 true false 75 120 225 180
Circle -13345367 true false 105 105 88

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

bullet
true
0
Polygon -7500403 true true 105 105 105 225 195 225 195 105 180 90 150 75 120 90
Polygon -1184463 true false 119 229 179 229 188 260 162 247 150 256 137 247 112 259

burntambrelt
true
0
Polygon -1 true false 90 120 75 75 105 30 135 120
Polygon -1 true false 210 180 225 225 195 270 165 180
Polygon -6459832 true false 75 120 45 165 90 270 120 240
Polygon -6459832 true false 225 180 255 135 210 30 180 60
Rectangle -7500403 true true 75 120 225 180
Circle -2674135 true false 107 105 88

burntambrert
true
0
Polygon -1 true false 210 120 225 75 195 30 165 120
Polygon -1 true false 90 180 75 225 105 270 135 180
Polygon -6459832 true false 225 120 255 165 210 270 180 240
Polygon -6459832 true false 75 180 45 135 90 30 120 60
Rectangle -7500403 true true 75 120 225 180
Circle -2674135 true false 107 105 88

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

charlie
true
2
Polygon -955883 true true 120 105 180 105 210 150 195 270 105 270 90 150
Polygon -955883 true true 120 120 105 75 135 15 165 15 195 75 180 120
Polygon -955883 true true 105 255 195 255 195 270 165 435 150 480 135 435 105 270
Polygon -955883 true true 180 120 285 135 375 210 390 345 315 270 255 240 180 225
Polygon -2674135 true false 150 120 135 165 150 195 165 165
Polygon -2674135 true false 150 195 135 240 150 270 165 240
Polygon -1 true false 180 75 180 90 165 90
Polygon -1 true false 120 75 120 90 135 90
Polygon -2674135 true false 150 270 135 315 165 375 150 405 135 375 165 315
Polygon -1184463 true false 180 105 165 105 180 150
Polygon -1184463 true false 120 105 135 105 120 150
Polygon -955883 true true 120 120 15 135 -75 210 -90 345 -15 270 45 240 120 225

charlie flap
true
2
Polygon -955883 true true 120 105 180 105 210 150 195 270 105 270 90 150
Polygon -955883 true true 120 120 105 75 135 15 165 15 195 75 180 120
Polygon -955883 true true 105 255 195 255 195 270 165 435 150 480 135 435 105 270
Polygon -955883 true true 180 120 270 60 375 90 435 195 315 180 255 180 195 225
Polygon -2674135 true false 150 120 135 165 150 195 165 165
Polygon -2674135 true false 150 195 135 240 150 270 165 240
Polygon -1 true false 180 75 180 90 165 90
Polygon -1 true false 120 75 120 90 135 90
Polygon -2674135 true false 150 270 135 315 165 375 150 405 135 375 165 315
Polygon -1184463 true false 180 105 165 105 180 150
Polygon -1184463 true false 120 105 135 105 120 150
Polygon -955883 true true 120 120 30 60 -75 90 -135 195 -15 180 45 180 105 225

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

crystal
false
0
Polygon -1184463 true false 150 240 150 165 210 150
Polygon -1184463 true false 150 90 150 165 90 150
Polygon -1 true false 90 150 150 240 150 165
Polygon -1 true false 150 90 150 165 210 150
Polygon -1 true false 45 75 75 60 90 30 105 60 135 75 105 90 90 120 75 90
Polygon -1 true false 195 105 225 90 240 60 255 90 285 105 255 120 240 150 225 120
Polygon -1 true false 15 210 45 195 60 165 75 195 105 210 75 225 60 255 45 225
Polygon -1 true false 165 240 195 225 210 195 225 225 255 240 225 255 210 285 195 255

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

feather
true
0
Polygon -955883 true false 105 210 105 150 180 15 195 90 180 180 120 210
Polygon -1184463 true false 105 210 90 240 105 240 120 210
Polygon -16777216 true false 105 210 180 30 120 210
Line -16777216 false 150 105 195 90
Line -16777216 false 150 75 150 105
Line -16777216 false 135 135 135 105
Line -16777216 false 120 180 180 150
Line -16777216 false 135 135 180 120
Line -16777216 false 120 180 120 135

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

magnet
false
0
Polygon -7500403 true true 195 45 240 45 240 195 240 240 225 270 194 290 150 297 105 290 75 270 60 240 60 195 60 45 105 45 105 195 105 225 116 245 135 255 165 255 185 245 195 225 195 195
Polygon -2674135 true false 60 45 105 45 105 105 60 98
Polygon -13345367 true false 240 45 195 45 195 105 239 103

monster
false
0
Polygon -7500403 true true 75 150 90 195 210 195 225 150 255 120 255 45 180 0 120 0 45 45 45 120
Circle -16777216 true false 165 60 60
Circle -16777216 true false 75 60 60
Polygon -7500403 true true 225 150 285 195 285 285 255 300 255 210 180 165
Polygon -7500403 true true 75 150 15 195 15 285 45 300 45 210 120 165
Polygon -7500403 true true 210 210 225 285 195 285 165 165
Polygon -7500403 true true 90 210 75 285 105 285 135 165
Rectangle -7500403 true true 135 165 165 270

pebbles
true
3
Polygon -6459832 true true 90 165 45 135 45 90 90 90 90 105 120 120
Polygon -6459832 true true 180 120 210 135 210 120 255 120 255 150 225 195 180 180
Polygon -6459832 true true 120 225 90 240 90 225 45 225 45 255 75 300 120 300
Polygon -6459832 true true 120 105 180 105 210 150 195 270 105 270 90 150
Polygon -6459832 true true 120 120 105 75 135 15 165 15 195 75 180 120
Polygon -6459832 true true 105 255 195 255 195 270 165 435 150 480 135 435 105 270
Polygon -7500403 true false 150 120 135 165 150 195 165 165
Polygon -7500403 true false 150 195 135 240 150 270 165 240
Polygon -1 true false 180 75 180 90 165 90
Polygon -1 true false 120 75 120 90 135 90
Polygon -7500403 true false 150 270 135 315 165 375 150 405 135 375 165 315
Polygon -1 true false 180 105 165 105 165 150 210 150 180 135
Polygon -1 true false 120 105 135 105 135 150 90 150 120 135
Polygon -6459832 true true 180 300 240 285 255 210 210 210 210 225 180 240
Polygon -7500403 true false 255 210 254 197 246 207 243 196 238 207 232 195 227 206 222 196 217 206 210 195 210 210
Polygon -7500403 true false 45 225 46 212 54 222 57 211 62 222 68 210 73 221 78 211 83 221 90 210 90 225
Polygon -7500403 true false 255 120 254 107 246 117 243 106 238 117 232 105 227 116 222 106 217 116 210 105 210 120
Polygon -7500403 true false 45 90 46 77 54 87 57 76 62 87 68 75 73 86 78 76 83 86 90 75 90 90

pebbles flap
true
3
Polygon -6459832 true true 210 165 255 135 255 90 210 90 210 105 180 120
Polygon -6459832 true true 120 120 90 135 90 120 45 120 45 150 75 195 120 180
Polygon -6459832 true true 180 225 210 240 210 225 255 225 255 255 225 300 180 300
Polygon -6459832 true true 120 105 180 105 210 150 195 270 105 270 90 150
Polygon -6459832 true true 120 120 105 75 135 15 165 15 195 75 180 120
Polygon -6459832 true true 105 255 195 255 195 270 165 435 150 480 135 435 105 270
Polygon -7500403 true false 150 120 135 165 150 195 165 165
Polygon -7500403 true false 150 195 135 240 150 270 165 240
Polygon -1 true false 180 75 180 90 165 90
Polygon -1 true false 120 75 120 90 135 90
Polygon -7500403 true false 150 270 135 315 165 375 150 405 135 375 165 315
Polygon -1 true false 180 105 165 105 165 150 210 150 180 135
Polygon -1 true false 120 105 135 105 135 150 90 150 120 135
Polygon -6459832 true true 120 300 60 285 45 210 90 210 90 225 120 240
Polygon -7500403 true false 45 210 46 197 54 207 57 196 62 207 68 195 73 206 78 196 83 206 90 195 90 210
Polygon -7500403 true false 255 225 254 212 246 222 243 211 238 222 232 210 227 221 222 211 217 221 210 210 210 225
Polygon -7500403 true false 45 120 46 107 54 117 57 106 62 117 68 105 73 116 78 106 83 116 90 105 90 120
Polygon -7500403 true false 255 90 254 77 246 87 243 76 238 87 232 75 227 86 222 76 217 86 210 75 210 90

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

powerupx2
false
0
Circle -13791810 true false 44 44 212
Circle -2674135 true false 60 60 180
Polygon -1184463 true false 75 165 90 180 105 165 120 180 135 165 120 150 135 135 120 120 105 135 90 120 60 75 60 75 90 120 75 135 90 150
Polygon -1184463 true false 165 105 165 120 195 120 195 135 165 135 165 180 210 180 210 165 180 165 180 150 210 150 210 105
Circle -1184463 false false 60 60 180
Circle -1184463 false false 45 45 210

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

snake boss
false
10
Polygon -6459832 true false 45 150 45 120 60 105 75 120 75 150
Line -16777216 false 45 120 75 120
Line -16777216 false 60 105 60 150
Line -16777216 false 45 135 75 135
Polygon -13345367 true true 45 150 45 180 45 195 75 225 120 240 180 240 225 225 255 195 240 165 225 165 210 180 195 195 105 195 75 180 75 150
Polygon -10899396 true false 75 180
Polygon -1184463 true false 120 195 150 210 180 195
Polygon -13345367 true true 240 165 210 150 135 150 120 135 135 90 150 90 180 90 210 90 180 60 120 60 90 90 75 150 90 180 120 195 180 195 195 195
Line -16777216 false 75 150 75 180
Line -16777216 false 75 180 105 195
Line -16777216 false 105 195 195 195
Line -16777216 false 195 195 210 180
Polygon -1184463 true false 150 150 180 165 210 150 180 150
Polygon -1184463 true false 60 150 45 165 60 180 75 165
Polygon -1184463 true false 75 180 90 210 105 195 75 180
Polygon -1184463 true false 195 195 225 195 225 165
Polygon -1184463 true false 105 150 120 165 135 150 120 135
Polygon -1184463 true false 90 90 90 105 90 135 75 150
Polygon -1184463 true false 90 90 120 75 120 60
Polygon -13345367 true true 135 60 120 90 150 135 180 135 210 90 195 60
Polygon -2674135 true false 195 90 180 120 195 105
Polygon -2674135 true false 135 90 150 120 135 105
Polygon -2674135 true false 150 60 165 75 150 90 180 90 165 75 180 60
Polygon -1 true false 150 135 150 165 165 105 180 165 180 135
Rectangle -13345367 true true 150 105 180 135

snake boss attack
false
10
Line -13791810 false 150 135 180 135
Polygon -2064490 true false 135 105 150 135 180 135 195 105
Polygon -6459832 true false 45 150 45 120 60 105 75 120 75 150
Line -16777216 false 45 120 75 120
Line -16777216 false 60 105 60 150
Line -16777216 false 45 135 75 135
Polygon -13345367 true true 45 150 45 180 45 195 75 225 120 240 180 240 225 225 255 195 240 165 225 165 210 180 195 195 105 195 75 180 75 150
Polygon -10899396 true false 75 180
Polygon -1184463 true false 120 195 150 210 180 195
Polygon -13345367 true true 240 165 210 150 135 150 120 135 135 90 150 90 180 90 210 90 180 60 120 60 90 90 75 150 90 180 120 195 180 195 195 195
Line -16777216 false 75 150 75 180
Line -16777216 false 75 180 105 195
Line -16777216 false 105 195 195 195
Line -16777216 false 195 195 210 180
Polygon -1184463 true false 150 150 180 165 210 150 180 150
Polygon -1184463 true false 60 150 45 165 60 180 75 165
Polygon -1184463 true false 75 180 90 210 105 195 75 180
Polygon -1184463 true false 195 195 225 195 225 165
Polygon -1184463 true false 105 150 120 165 135 150 120 135
Polygon -1184463 true false 90 90 90 105 90 135 75 150
Polygon -1184463 true false 90 90 120 75 120 60
Polygon -13345367 true true 135 60 120 90 150 120 180 120 210 90 195 60
Polygon -2674135 true false 195 75 180 105 195 90
Polygon -2674135 true false 135 75 150 105 135 90
Polygon -2674135 true false 150 60 165 75 150 90 180 90 165 75 180 60
Polygon -1 true false 150 120 150 150 165 90 180 150 180 120
Rectangle -13345367 true true 150 90 180 120
Line -16777216 false 135 60 120 90
Line -16777216 false 120 90 135 105
Line -13791810 false 135 105 150 135
Line -13791810 false 180 135 195 105

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

stone
true
0
Polygon -7500403 true true 165 75 90 105 75 180 120 240 195 240 240 180 225 105
Polygon -16777216 true false 165 165 195 225 195 240
Polygon -16777216 true false 90 105 150 165 90 120
Polygon -16777216 true false 165 150 210 105 225 105
Polygon -16777216 true false 165 75 150 105 165 90
Polygon -16777216 true false 120 240 135 225 135 210
Polygon -1 true false 75 180 90 180 120 225
Circle -7500403 true true 42 42 216
Polygon -1 true false 150 60 195 90 225 135 195 75
Polygon -16777216 true false 75 150 75 180 60 195 75 195 90 225 90 195 105 180 90 180

stormy
true
0
Polygon -7500403 true true 120 105 180 105 210 150 195 270 105 270 90 150
Polygon -7500403 true true 120 120 105 75 135 15 165 15 195 75 180 120
Polygon -7500403 true true 105 255 195 255 195 270 165 435 150 480 135 435 105 270
Polygon -7500403 true true 180 120 285 135 375 210 390 345 315 270 255 240 180 225
Polygon -1 true false 150 120 135 165 150 195 165 165
Polygon -1 true false 150 195 135 240 150 270 165 240
Polygon -1184463 true false 180 75 180 90 165 90
Polygon -1184463 true false 120 75 120 90 135 90
Polygon -1 true false 150 270 135 315 165 375 150 405 135 375 165 315
Polygon -7500403 true true 120 120 15 135 -75 210 -90 345 -15 270 45 240 120 225
Circle -1 true false 209 111 16
Circle -1 true false 194 114 22
Circle -1 true false 112 94 32
Circle -1 true false 156 94 32
Circle -1 true false 174 109 27
Circle -1 true false 99 109 27
Circle -1 true false 84 114 22
Circle -1 true false 75 111 16
Circle -16777216 true false 160 28 6
Circle -16777216 true false 134 28 6

stormy flap
true
0
Polygon -7500403 true true 120 105 180 105 210 150 195 270 105 270 90 150
Polygon -7500403 true true 120 120 105 75 135 15 165 15 195 75 180 120
Polygon -7500403 true true 105 255 195 255 195 270 165 435 150 480 135 435 105 270
Polygon -7500403 true true 180 120 270 60 375 90 435 195 315 180 255 180 195 225
Polygon -1 true false 150 120 135 165 150 195 165 165
Polygon -1 true false 150 195 135 240 150 270 165 240
Polygon -1184463 true false 180 75 180 90 165 90
Polygon -1184463 true false 120 75 120 90 135 90
Polygon -1 true false 150 270 135 315 165 375 150 405 135 375 165 315
Polygon -7500403 true true 120 120 30 60 -75 90 -135 195 -15 180 45 180 105 225
Circle -1 true false 162 95 27
Circle -1 true false 111 95 27
Circle -1 true false 178 110 22
Circle -1 true false 100 110 22
Circle -1 true false 194 115 19
Circle -1 true false 87 115 19
Circle -1 true false 210 113 12
Circle -1 true false 78 113 12
Circle -16777216 true false 160 24 6
Circle -16777216 true false 134 24 6

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

thorn
true
7
Polygon -14835848 true true 120 105 180 105 210 150 195 270 105 270 90 150
Polygon -14835848 true true 120 120 105 75 135 15 165 15 195 75 180 120
Polygon -14835848 true true 105 255 195 255 195 270 165 435 150 480 135 435 105 270
Polygon -14835848 true true 180 120 285 135 375 210 390 345 315 270 255 240 180 225
Polygon -13840069 true false 150 120 135 165 150 195 165 165
Polygon -13840069 true false 150 195 135 240 150 270 165 240
Polygon -1 true false 180 75 180 90 165 90
Polygon -1 true false 120 75 120 90 135 90
Polygon -13840069 true false 150 270 135 315 165 375 150 405 135 375 165 315
Polygon -14835848 true true 120 120 15 135 -75 210 -90 345 -15 270 45 240 120 225
Polygon -6459832 true false 180 105 165 105 165 135 180 150 195 150 210 135 210 120 195 135 180 135
Polygon -6459832 true false 120 105 135 105 135 135 120 150 105 150 90 135 90 120 105 135 120 135
Polygon -1 true false 285 135 270 105 257 131
Polygon -1 true false 15 135 30 105 43 131

thorn flap
true
7
Polygon -14835848 true true 120 105 180 105 210 150 195 270 105 270 90 150
Polygon -14835848 true true 120 120 105 75 135 15 165 15 195 75 180 120
Polygon -14835848 true true 105 255 195 255 195 270 165 435 150 480 135 435 105 270
Polygon -14835848 true true 180 120 270 60 375 90 435 195 315 180 255 180 195 225
Polygon -13840069 true false 150 120 135 165 150 195 165 165
Polygon -13840069 true false 150 195 135 240 150 270 165 240
Polygon -1 true false 180 75 180 90 165 90
Polygon -1 true false 120 75 120 90 135 90
Polygon -13840069 true false 150 270 135 315 165 375 150 405 135 375 165 315
Polygon -14835848 true true 120 120 30 60 -75 90 -135 195 -15 180 45 180 105 225
Polygon -6459832 true false 180 105 165 105 165 135 180 150 195 150 210 135 210 120 195 135 180 135
Polygon -6459832 true false 120 105 135 105 135 135 120 150 105 150 90 135 90 120 105 135 120 135
Polygon -1 true false 270 60 255 45 247 75
Polygon -1 true false 30 60 45 45 53 75

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

triplepowerup
false
0
Circle -11221820 true false 30 30 240
Circle -1 true false 60 60 180
Polygon -13840069 true false 75 135 90 120 105 135 120 120 135 135 120 150 135 165 120 180 105 165 90 180 75 165 90 150
Polygon -13840069 true false 165 105 165 120 195 120 195 135 180 135 180 150 195 150 195 165 165 165 165 180 210 180 210 105

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

warning
false
0
Polygon -7500403 true true 0 240 15 270 285 270 300 240 165 15 135 15
Polygon -16777216 true false 180 75 120 75 135 180 165 180
Circle -16777216 true false 129 204 42

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.0.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
