globals [turtle-size highscore speed score lastAppleEaten rainbowApplesEaten treePineLivesAmt]
patches-own [age ground?]
turtles-own [direction trueEye? treePineLives]

to setup
  resize-world -16 16 -16 16
  Levels
  ask turtles [die]
  ask patches with [pxcor <= 2 and pxcor >= -2]
  [set pcolor brown - 2 set ground? true]
  ask patches with [pxcor > 2 or pxcor < -2]
  [set pcolor 53 set ground? true]
  ask patches with [pxcor > 6 and pxcor < 13
    and pycor > 6 and pycor < 14
    or (pxcor = 6 and (pycor  < 12 and pycor > 7))
    or (pxcor = 13 and (pycor < 13 and pycor > 7))
    or (pycor = 14 and (pxcor > 7 and pxcor < 13))]
  [set pcolor cyan set ground? true]
  ask patches with [
    (pxcor = 1 and pycor = -13)
  or (pxcor = 1 and pycor  = -8)
  or (pxcor = 1 and pycor = -5)
  or (pxcor = 1 and pycor = -3)
  or (pxcor = 1 and pycor = 0)
  or (pxcor = 1 and pycor = 1)
  or (pxcor = 1 and pycor = 7)
  or (pxcor = 1 and pycor = 9)
  or (pxcor = 1 and pycor = 11)
  or (pxcor = 1 and pycor = 14)
  or (pxcor = 1 and pycor = 16)
  or (pxcor = 0 and pycor = -11)
  or (pxcor = 0 and pycor = -10)
  or (pxcor = 0 and pycor = -6)
  or (pxcor = 0 and pycor = -2)
  or (pxcor = 0 and pycor = 2)
  or (pxcor = 0 and pycor = 7)
  or (pxcor = 0 and pycor = 8)
  or (pxcor = 0 and pycor = 12)
  or (pxcor = 0 and pycor = 16)
  or (pxcor = 2 and pycor = -15)
  or (pxcor = 2 and pycor = -11)
  or (pxcor = 2 and pycor = -6)
  or (pxcor = 2 and pycor = -3)
  or (pxcor = 2 and pycor = 0)
  or (pxcor = 2 and pycor = 5)
  or (pxcor = 2 and pycor = 8)
  or (pxcor = 2 and pycor = 12)
  or (pxcor = 2 and pycor = 14)
  or (pxcor = 2 and pycor = 16)
  or (pxcor = -2 and pycor = -16)
  or (pxcor = -2 and pycor = -12)
  or (pxcor = -2 and pycor = -9)
  or (pxcor = -2 and pycor = -4)
  or (pxcor = -2 and pycor = 0)
  or (pxcor = -2 and pycor = 1)
  or (pxcor = -2 and pycor = 3)
  or (pxcor = -2 and pycor = 7)
  or (pxcor = -2 and pycor = 11)
  or (pxcor = -2 and pycor = 14)
  or (pxcor = -2 and pycor = 16)
  or (pxcor = -1 and pycor = -13)
  or (pxcor = -1 and pycor = -7)
  or (pxcor = -1 and pycor = -6)
  or (pxcor = -1 and pycor = -2)
  or (pxcor = -1 and pycor = 0)
  or (pxcor = -1 and pycor = 3)
  or (pxcor = -1 and pycor = 4)
  or (pxcor = -1 and pycor = 6)
  or (pxcor = -1 and pycor = 10)]
  [set pcolor brown - 3
  set ground? true]
  ask patch (min-pxcor + 1) (max-pycor - 1)
      [sprout 1 [set shape "tree pine" set treePineLives 1 set size 1.5 set color lime]]
  ask patch (min-pxcor + 2) (max-pycor - 1)
      [sprout 1 [set shape "tree pine" set treePineLives 2 set size 1.5 set color lime]]
  ask patch (min-pxcor + 3) (max-pycor - 1)
      [sprout 1 [set shape "tree pine" set treePineLives 3 set size 1.5 set color lime]]
  ask patch (min-pxcor + 4) (max-pycor - 1)
      [sprout 1 [set shape "tree pine" set treePineLives 4 set size 1.5 set color lime]]
  ask patch (min-pxcor + 5) (max-pycor - 1)
      [sprout 1 [set shape "tree pine" set treePineLives 5 set size 1.5 set color lime set treePineLivesAmt 5]]
  ask n-of 18 patches with [
    pcolor = 53
    and pcolor != white
    and pcolor != cyan
    and not any? turtles-here]
  [sprout 1
    [set shape "flower"
      set size 1.25
      if (pxcor = max-pxcor or pxcor = min-pxcor or pycor = max-pycor or pycor = min-pycor)
      [die]
        ifelse random 5 = 0
          [set color red + 2]
          [ifelse random 5 = 1
            [set color orange + 2]
            [ifelse random 5 = 2
              [set color yellow + 2]
              [ifelse random 5 = 3
                [set color violet + 2]
                [if random 5 = 4
              [set color blue + 2]]]]]]]
;  ask patches with [pcolor = cyan]
;  [ask turtles-here with [shape = "flower"]
;    [die]]
  set turtle-size 1
  set score 0
  ask patches [set age 0 set plabel ""]
  set lastAppleEaten red
  set rainbowApplesEaten 0
  border
  tree
  cro 1
  [set color green
    set hidden? true]
  ask n-of 3 patches with [pcolor = cyan]
  [sprout 1
    [set shape "lily pad"
      set color lime]]
  ask n-of 3 patches with [pcolor = cyan and not any? turtles-here]
  [sprout 1
    [set shape "fish"
      ifelse random 2 = 1
      [set color magenta]
      [set color orange]]]
 ask patches
      [if any? turtles-here with [shape = "default"]
      [set pcolor green
          set age 1
            set ground? false
  sprout 1 ; 1 tongue down
            [set shape "circle"
              set color pink
              set heading 180
              set size .25
              fd .5
              set direction 180
              set heading 0
            set hidden? true]
  sprout 1 ; 2 tongue down
            [set shape "circle"
              set color pink
              set heading 180
              set size .25
              fd .75
              set direction 180
              set heading 0
            set hidden? true]
  sprout 1 ; 1 tongue left
            [set shape "circle"
              set color pink
              set heading 270
              set size .25
              fd .5
              set direction 270
              set heading 0
              set hidden? true]
  sprout 1 ; 2 tongue left
            [set shape "circle"
              set color pink
              set heading 270
              set size .25
              fd .75
              set direction 270
              set heading 0
              set hidden? true]
  sprout 1 ; 1 tongue right
            [set shape "circle"
              set color pink
              set heading 90
              set size .25
              fd .5
              set direction 90
              set heading 0
              set hidden? true]
  sprout 1 ; 2 tongue right
            [set shape "circle"
              set color pink
              set heading 90
              set size .25
              fd .75
              set direction 90
              set heading 0
              set hidden? true]
  sprout 1 ; 1 tongue up
            [set shape "circle"
              set color pink
              set heading 0
              set size .25
              fd .5
              set direction 0
              set hidden? true]
  sprout 1 ; 2 tongue up
            [set shape "circle"
              set color pink
              set heading 0
              set size .25
              fd .75
              set direction 0
              set hidden? true]
  sprout 1 ; 1 right eye
            [set size .25
              set shape "circle"
              set color yellow
              set heading 90
              fd .25
              set direction 90
              set heading 0
              set trueEye? true]
  sprout 1 ; 2 left eye
            [set size .25
              set shape "circle"
              set color yellow
              set heading 270
              fd .25
              set direction 270
              set heading 0
              set trueEye? true]
  sprout 1 ; 1 up eye
            [set size .25
              set shape "circle"
              set color yellow
              set heading 0
              fd .25
              set direction 0
              set heading 0
              set trueEye? true]
  sprout 1 ; 2 down eye
            [set size .25
              set shape "circle"
              set color yellow
              set heading 180
              fd .25
              set direction 180
              set heading 0
              set trueEye? true]
  sprout 1 ; 1 right eye
            [set size .25
              set shape "circle"
              set color black
              set heading 90
              fd .25
              set direction 90
              set heading 0
              set trueEye? true
              set hidden? true]
  sprout 1 ; 2 left eye
            [set size .25
              set shape "circle"
              set color black
              set heading 270
              fd .25
              set direction 270
              set heading 0
              set trueEye? true
              set hidden? true]
  sprout 1 ; 1 up eye
            [set size .25
              set shape "circle"
              set color black
              set heading 0
              fd .25
              set direction 0
              set heading 0
              set trueEye? true
              set hidden? true]
  sprout 1 ; 2 down eye
            [set size .2
              set shape "circle"
              set color black
              set heading 180
              fd .25
              set direction 180
              set heading 0
              set trueEye? true
              set hidden? true]]]
eyesOrient
end

to fishSwim
  every .75
  [ask turtles with [shape = "fish"]
    [fd .1
      rt random 45 - 22]
    ask patches with [pcolor != cyan]
    [if any? turtles-here with [shape = "fish"]
      [ask turtles-here with [shape = "fish"]
        [rt 180 fd .1]]]]
end

to eyesOrient
    ask turtles with [color = yellow]
[ifelse (direction = heading + 90 or direction = heading - 90
    or direction = heading + 270 or direction = heading - 270)
  [set hidden? false]
      [set hidden? true]]
end

to tongueOrient
  ask turtles with [color = pink]
  [ifelse direction != heading
  [set hidden? true]
  [if random 12000 = 1
  [ask turtles with [color = pink]
      [if (direction = heading)
          [set hidden? false]]]]]
  if random 48000 = 0
      [ask turtles with [color = pink]
        [set hidden? true]]
end

to eyesWiden
  ask patches [if any? turtles-here with [shape = "apple"]
    [ifelse any? turtles in-radius 5 with [color = yellow]
    [ask turtles in-radius 5 with [color = yellow]
        [set size .45]
        ask turtles in-radius 5 with [color = black]
          [ifelse (direction = heading + 90 or direction = heading - 90
            or direction = heading + 270 or direction = heading - 270)
              [set hidden? false]
              [set hidden? true]]]
    [ask turtles with [color = black]
      [set hidden? true]
          ask turtles with [color = yellow]
          [set size .25]]]]
end

to Levels
  ifelse Difficulty = "Easy"
  [set speed 0.15]
  [ifelse Difficulty = "Medium"
    [set speed 0.1]
    [if Difficulty = "Hard"
      [set speed 0.05]]]
end

to go
  every speed
  [Levels
    appleSprout
    rainbowAppleSprout
    poisonApple
    deathAppleSprout
    ask turtles with [shape = "default" or shape = "circle"]
    [fd 1]
    eyesOrient
    selfDestruct
    borderDeath
    treeStun
    treeDeath
    ask patches
    [ifelse any? turtles-here with [shape = "default"]
      [set pcolor green
        set ground? false
      set age turtle-size]
        [ifelse lastAppleEaten = red
      [ifelse age > 0
          [set age age - 1
        (ifelse (age mod 2) = 0
        [set pcolor yellow]
          [set pcolor green])]
        [if age = 0 and pcolor != white
          [if (pxcor <= 2 and pxcor >= -2)
              [set pcolor brown - 2
                set ground? true]
           if (pxcor > 2 or pxcor < -2)
              [set pcolor 53
                set ground? true]
           if ((pxcor = 1 and pycor = -13)
  or (pxcor = 1 and pycor  = -8)
  or (pxcor = 1 and pycor = -5)
  or (pxcor = 1 and pycor = -3)
  or (pxcor = 1 and pycor = 0)
  or (pxcor = 1 and pycor = 1)
  or (pxcor = 1 and pycor = 7)
  or (pxcor = 1 and pycor = 9)
  or (pxcor = 1 and pycor = 11)
  or (pxcor = 1 and pycor = 14)
  or (pxcor = 1 and pycor = 16)
  or (pxcor = 0 and pycor = -11)
  or (pxcor = 0 and pycor = -10)
  or (pxcor = 0 and pycor = -6)
  or (pxcor = 0 and pycor = -2)
  or (pxcor = 0 and pycor = 2)
  or (pxcor = 0 and pycor = 7)
  or (pxcor = 0 and pycor = 8)
  or (pxcor = 0 and pycor = 12)
  or (pxcor = 0 and pycor = 16)
  or (pxcor = 2 and pycor = -15)
  or (pxcor = 2 and pycor = -11)
  or (pxcor = 2 and pycor = -6)
  or (pxcor = 2 and pycor = -3)
  or (pxcor = 2 and pycor = 0)
  or (pxcor = 2 and pycor = 5)
  or (pxcor = 2 and pycor = 8)
  or (pxcor = 2 and pycor = 12)
  or (pxcor = 2 and pycor = 14)
  or (pxcor = 2 and pycor = 16)
  or (pxcor = -2 and pycor = -16)
  or (pxcor = -2 and pycor = -12)
  or (pxcor = -2 and pycor = -9)
  or (pxcor = -2 and pycor = -4)
  or (pxcor = -2 and pycor = 0)
  or (pxcor = -2 and pycor = 1)
  or (pxcor = -2 and pycor = 3)
  or (pxcor = -2 and pycor = 7)
  or (pxcor = -2 and pycor = 11)
  or (pxcor = -2 and pycor = 14)
  or (pxcor = -2 and pycor = 16)
  or (pxcor = -1 and pycor = -13)
  or (pxcor = -1 and pycor = -7)
  or (pxcor = -1 and pycor = -6)
  or (pxcor = -1 and pycor = -2)
  or (pxcor = -1 and pycor = 0)
  or (pxcor = -1 and pycor = 3)
  or (pxcor = -1 and pycor = 4)
  or (pxcor = -1 and pycor = 6)
  or (pxcor = -1 and pycor = 10))
           [set pcolor brown - 3
            set ground? true]
           if (pxcor > 6 and pxcor < 13
                and pycor > 6 and pycor < 14
                or (pxcor = 6 and (pycor  < 12 and pycor > 7))
                or (pxcor = 13 and (pycor < 13 and pycor > 7))
                or (pycor = 14 and (pxcor > 7 and pxcor < 13)))
                [set pcolor cyan
                  set ground? true]
        ]]]
    [if lastAppleEaten = white
          [ifelse age > 0
            [set age age - 1
              ifelse age mod 6 = 0
              [set pcolor (red - 1)]
              [ifelse age mod 6 = 1
                [set pcolor (orange - 1)]
                [ifelse age mod 6 = 2
                  [set pcolor (yellow - 1)]
                  [ifelse age mod 6 = 3
                    [set pcolor (green - 1)]
                    [ifelse age mod 6 = 4
                     [set pcolor blue - 1]
                       [if age mod 6 = 5
                    [set pcolor violet - 1]]]]]]]
            [if age = 0 and pcolor != white
              [if (pxcor <= 2 and pxcor >= -2)
                [set pcolor brown - 2
                  set ground? true]
               if (pxcor > 2 or pxcor < -2)
                [set pcolor 53
                  set ground? true]
               if ((pxcor = 1 and pycor = 1)
  or (pxcor = 1 and pycor = 0)
  or (pxcor = 1 and pycor = -1)
  or (pxcor = 1 and pycor = 9)
  or (pxcor = 1 and pycor = -11)
  or (pxcor = 1 and pycor = 4)
  or (pxcor = 0 and pycor = 1)
  or (pxcor = 0 and pycor = 13)
  or (pxcor = 0 and pycor = -12)
  or (pxcor = 0 and pycor = 6)
  or (pxcor = 2 and pycor = -15)
  or (pxcor = 2 and pycor = 8)
  or (pxcor = 2 and pycor = 6)
  or (pxcor = 2 and pycor = -4)
  or (pxcor = -2 and pycor = 2)
  or (pxcor = -2 and pycor = 3)
  or (pxcor = -2 and pycor = 14)
  or (pxcor = -2 and pycor = -9)
  or (pxcor = -1 and pycor = 7)
  or (pxcor = -1 and pycor = -6)
  or (pxcor = -1 and pycor = 2)
  or (pxcor = -1 and pycor = 0)
  or (pxcor = -1 and pycor = 3)
  or (pxcor = -1 and pycor = -10))
           [set pcolor brown - 3
            set ground? true]
               if (pxcor > 6 and pxcor < 13
                   and pycor > 6 and pycor < 14
                   or (pxcor = 6 and (pycor  < 12 and pycor > 7))
                   or (pxcor = 13 and (pycor < 13 and pycor > 7))
                   or (pycor = 14 and (pxcor > 7 and pxcor < 13)))
                [set pcolor cyan
                  set ground? true]]]]]]]
    grow
    scoreNumber
  highestScore]
tongueOrient
  ask turtles with [color = yellow and trueEye? != true]
  [die]
eyesWiden
tree
fishSwim
end

to w
  ask turtles with [shape = "default" or shape = "circle"]
  [set heading 0]
end

to d
  ask turtles with [shape = "default" or shape = "circle"]
  [set heading 90]
end

to s
  ask turtles with [shape = "default" or shape = "circle"]
  [set heading 180]
end

to a
  ask turtles with [shape = "default" or shape = "circle"]
  [set heading 270]
end

to appleSprout
  if not any? turtles with [shape = "apple" and color = red]
  [ask one-of patches with [pcolor = 53 or pcolor = brown - 2 and not any? turtles-here]
  [sprout 1
    [set shape "apple"
          set color red
          ifelse random 5 = 0
        [set size 5]
        [set size 1]]]]
end

to rainbowAppleSprout
  ifelse random 50 = 7
  [if not any? turtles with [size = 3]
    [ask one-of patches with [pcolor = 53 or pcolor = brown - 2 and not any? turtles-here]
      [sprout 1
        [set size 3
          set shape "apple"
          every 0.5
          [ifelse random 7 = 0
          [set color red + 1]
          [ifelse random 7 = 1
            [set color orange + 1]
            [ifelse random 7 = 2
              [set color yellow + 1]
              [ifelse random 7 = 3
                [set color green + 1]
                [ifelse random 7 = 4
                  [set color blue + 1]
                  [ifelse random 7 = 5
                    [set color violet + 1]
                    [if random 7 = 6
                        [set color white]]]]]]]]]]]]
  [if random 30 = 2
    [ask turtles with [size = 3]
      [die]]]
  rainbowSnake
  rainbowAppleColor
end

to rainbowAppleColor
  every 0.2
  [ask turtles with [size = 3]
          [ifelse random 7 = 0
          [set color red + 1]
          [ifelse random 7 = 1
            [set color orange + 1]
            [ifelse random 7 = 2
              [set color yellow + 1]
              [ifelse random 7 = 3
                [set color green + 1]
                [ifelse random 7 = 4
                  [set color blue + 1]
                  [ifelse random 7 = 5
                    [set color violet + 1]
                    [if random 7 = 6
                  [set color white]]]]]]]]]
end

to rainbowSnake
   ask patches
  [if (any? turtles in-radius 1 with
    [size = 3] and
    any? turtles in-radius 1 with
    [shape = "default"])
    [ask turtles in-radius 1 with
      [size = 3]
        [set turtle-size turtle-size + 7
      set lastAppleEaten white
        set rainbowApplesEaten rainbowApplesEaten + 1
        die]]]
end

to deathAppleSprout
    if not any? turtles with [color = green + 2]
  [if random 100 = 9
    [ask one-of patches with [pcolor = 53 or pcolor = brown - 2 and not any? turtles-here]
  [sprout 1
    [set shape "apple"
          set color green + 2
          set size 3.5]]]]
  deathAppleMove
  deathAppleDeath
end

to deathAppleMove
  every 10
  [ask turtles with [color = green + 2]
    [setxy random-pxcor  random-pycor
    ask patches in-radius 3
      [if any? turtles-here with [color = green + 2]
      [ask turtles-here with [color = green + 2]
            [die]]]]]
end

to deathAppleDeath
  ask patches
  [if (any? turtles in-radius 1 with [color = green + 2]
    and any? turtles-here in-radius 1 with [shape = "default"])
    [ask turtles in-radius 1 with
      [shape = "default"]
      [ask patch (max-pxcor - 1) (max-pycor - 1) [set plabel "GAME OVER"
      set plabel-color white]
      ask patch (max-pxcor - 1) (max-pycor - 2) [set plabel "DEATH BY DEATH APPLE"
        set plabel-color white]
      ask patch (max-pxcor - 1) (max-pycor - 3) [set plabel "AVOID THE DEATH APPLES!"
        set plabel-color white]
      ask patch (max-pxcor - 1) (max-pycor - 5) [set plabel word "SCORE:" score
        set plabel-color white]
      if score = highScore
      [ask patch (max-pxcor - 1) (max-pycor - 4) [set plabel "NEW HIGHSCORE!!!"
      set plabel-color white]]
        ask turtles-here [die]]
      ask turtles with [shape != "apple" and shape != "tree" and shape != "flower" and shape != "fish"] [die]
        ask turtles with [color = pink] [die]
        sprout 1 [set color red set shape "x"]]]
end

to grow
  ask patches
  [if (any? turtles-here with
    [color = red and size = 1] and
    any? turtles-here with
    [shape = "default"])
    [set turtle-size turtle-size + 1
      ask turtles-here with
      [color = red]
      [set lastAppleEaten red
        die]]
  if (any? turtles in-radius 2 with
    [color = red and size = 5] and
    any? turtles in-radius 2 with
    [shape = "default"])
    [ask turtles-here with
      [color = red]
      [set turtle-size turtle-size + 4
      set lastAppleEaten red
        die]]]
end

to selfDestruct
  ask patches with [pcolor != 53
    and pcolor != brown - 2
    and pcolor != brown - 3
    and pcolor != cyan
    and pcolor != white
    and (age != turtle-size)]
  [if any? turtles-here with [shape = "default"]
    [ask patch (max-pxcor - 1) (max-pycor - 1) [set plabel "GAME OVER"
        set plabel-color white]
      ask patch (max-pxcor - 1) (max-pycor - 2) [set plabel "DEATH BY SELF DESTRUCTION"
        set plabel-color white]
      ask patch (max-pxcor - 1) (max-pycor - 3) [set plabel "DON'T RUN INTO YOUR OWN BODY!"
        set plabel-color white]
      ask patch (max-pxcor - 1) (max-pycor - 5) [set plabel word "SCORE:" score
        set plabel-color white]
      if score = highScore
      [ask patch (max-pxcor - 1) (max-pycor - 4) [set plabel "NEW HIGHSCORE"
        set plabel-color white]]
      ask turtles-here [die]
        ask turtles with [shape = "circle"]
  [die]
      sprout 1
        [set shape "x"
          set color red]]]
end

to scoreNumber
  set score (turtle-size + (rainbowApplesEaten * 2))
end

to highestScore
  if (score >= highscore)
  [set highscore score]
end

to poisonApple
  if not any? turtles with [color = violet]
  [ask one-of patches with [pcolor = 53 or pcolor = brown - 2
    and not any? turtles-here]
  [sprout 1
    [set shape "apple"
        set color violet]]]
  poisonAppleSubtract
  poisonAppleMove
end

to poisonAppleMove
  every 5
  [ask turtles with [color = violet]
    [setxy random-pxcor  random-pycor
    ask patches in-radius 3
      [if any? turtles-here with [color = violet]
      [ask turtles-here with [color = violet]
            [die]]]]]
end

to poisonAppleSubtract
  ask patches
  [if (any? turtles-here with
    [color = violet] and
    any? turtles-here with
    [shape = "default"])
    [set turtle-size turtle-size - 5
      ask turtles-here with
      [color = violet]
      [set lastAppleEaten red
        die]]]
  if turtle-size < 0
  [ask patches [if any? turtles-here with [shape = "default"]
    [ask patch (max-pxcor - 1) (max-pycor - 1) [set plabel "GAME OVER"
      set plabel-color white]
      ask patch (max-pxcor - 1) (max-pycor - 2) [set plabel "DEATH BY POISON APPLE"
        set plabel-color white]
      ask patch (max-pxcor - 1) (max-pycor - 3) [set plabel "AVOID THE POISON APPLES!"
        set plabel-color white]
      ask patch (max-pxcor - 1) (max-pycor - 5) [set plabel word "SCORE:" score
        set plabel-color white]
      if score = highScore
      [ask patch (max-pxcor - 1) (max-pycor - 4) [set plabel "NEW HIGHSCORE!!!"
      set plabel-color white]]
      ask turtles-here [die]
      ask turtles with [shape = "circle"]
  [die]
      sprout 1 [set color red set shape "x"]]]]
end

to border
  ask patches with
  [pxcor = max-pxcor or
    pxcor = min-pxcor or
    pycor = max-pycor or
    pycor = min-pycor]
  [set pcolor white]
end

to borderDeath
  ask patches with [pcolor = white]
  [if any? turtles-here with [shape = "apple"]
    [ask turtles-here with [shape = "apple"] [die]]
  if any? turtles-here with [shape = "default"]
    [ask patch (max-pxcor - 1) (max-pycor - 1) [set plabel "GAME OVER"
      set plabel-color white]
      ask patch (max-pxcor - 1) (max-pycor - 2) [set plabel "DEATH BY BORDER"
        set plabel-color white]
      ask patch (max-pxcor - 1) (max-pycor - 3) [set plabel "DON'T RUN INTO WHITE PATCHES!"
        set plabel-color white]
      ask patch (max-pxcor - 1) (max-pycor - 5) [set plabel word "SCORE:" score
        set plabel-color white]
      if score = highScore
      [ask patch (max-pxcor - 1) (max-pycor - 4) [set plabel "NEW HIGHSCORE!!!"
      set plabel-color white]]
        ask turtles-here [die]
      ask turtles with [shape = "circle"]
  [die]
      sprout 1 [set color red set shape "x"]]]
end

to resetHighScore
  set highScore 0
end

to tree
  every 5
  [ask turtles with [shape = "tree"]
    [die]
    ask n-of 12 patches with [pcolor = 53 or pcolor = brown - 2 and not any? turtles-here]
    [sprout 1 [set shape "tree" set size 2]]
    ask turtles with [shape = "tree"]
    [ifelse random 5 = 4
    [set color red - 1]
    [ifelse random 5 = 3
      [set color orange + 1]
      [ifelse random 5 = 2
        [set color lime + 2]
        [ifelse random 5 = 1
          [set color yellow - 1]
            [set color pink + 1]]]]]]
end

to treeStun
  ask patches
  [if (any? turtles-here with [shape = "tree"]
    and any? turtles-here with [shape = "default"])
   [set treePineLivesAmt treePineLivesAmt - 1
      ifelse treePineLivesAmt = 4
      [ask turtles with [shape = "tree pine" and treePineLives = 5]
        [die]]
      [ifelse treePineLivesAmt = 3
      [ask turtles with [shape = "tree pine" and treePineLives = 4]
        [die]]
      [ifelse treePineLivesAmt = 2
      [ask turtles with [shape = "tree pine" and treePineLives = 3]
        [die]]
      [ifelse treePineLivesAmt = 1
      [ask turtles with [shape = "tree pine" and treePineLives = 2]
        [die]]
      [if treePineLivesAmt = 0
      [ask turtles with [shape = "tree pine" and treePineLives = 1]
                [die]]]]]]
      ask turtles with [color = yellow]
     [set shape "x"
      set size .5
      bk 1]
      ask patch (max-pxcor - 1) (max-pycor - 1) [set plabel "STUNNED FOR 3 SECS"
      set plabel-color white]
      ask patch (max-pxcor - 1) (max-pycor - 2) [set plabel "DON'T RUN INTO TREES!"
        set plabel-color white]
      ask turtles with [color = pink]
      [set hidden? true
        if heading = direction
        [bk 1
        set hidden? false
      wait 3
      set hidden? true
            fd 1]]
        ask turtles with [shape = "x"]
        [set shape "circle"
  set size .25
            fd 1
  ask patch (max-pxcor - 1) (max-pycor - 1) [set plabel ""]
      ask patch (max-pxcor - 1) (max-pycor - 2) [set plabel ""]]]]
end

to treeDeath
  if treePineLivesAmt = 0
  [ask patches
    [if any? turtles-here with [shape = "default"]
      [ask turtles with [shape = "circle" or shape = "default"]
  [die]
      sprout 1 [set color red set shape "x"]
      ask patch (max-pxcor - 1) (max-pycor - 1) [set plabel "GAME OVER"
      set plabel-color white]
      ask patch (max-pxcor - 1) (max-pycor - 2) [set plabel "DEATH BY TREE"
        set plabel-color white]
      ask patch (max-pxcor - 1) (max-pycor - 3) [set plabel "DON'T RUN INTO TREES!"
        set plabel-color white]
      ask patch (max-pxcor - 1) (max-pycor - 4) [set plabel "WATCH THE NUMBER OF PINE TREES"
        set plabel-color white]
      ask patch (max-pxcor - 1) (max-pycor - 5) [set plabel "IN THE TOP LEFT CORNER!"
        set plabel-color white]
      if score = highScore
      [ask patch (max-pxcor - 1) (max-pycor - 6) [set plabel  "NEW HIGHSCORE!!!"
      set plabel-color white]]
      ask patch (max-pxcor - 1) (max-pycor - 7) [set plabel word "SCORE:" score
          set plabel-color white]
  ]]]
end
@#$#@#$#@
GRAPHICS-WINDOW
386
15
823
453
-1
-1
13.0
1
10
1
1
1
0
1
1
1
-16
16
-16
16
0
0
1
ticks
30.0

BUTTON
5
10
68
43
Setup
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
147
96
210
129
Up
w
NIL
1
T
OBSERVER
NIL
W
NIL
NIL
1

BUTTON
85
129
148
162
Left
a
NIL
1
T
OBSERVER
NIL
A
NIL
NIL
1

BUTTON
147
129
210
162
Down
s
NIL
1
T
OBSERVER
NIL
S
NIL
NIL
1

BUTTON
209
129
272
162
Right
d
NIL
1
T
OBSERVER
NIL
D
NIL
NIL
1

BUTTON
5
42
68
75
Go
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
699
454
749
499
SCORE
score
17
1
11

MONITOR
750
454
822
499
HIGHSCORE
highScore
17
1
11

MONITOR
386
454
475
499
NIL
lastAppleEaten
17
1
11

MONITOR
476
454
602
499
NIL
rainbowApplesEaten
17
1
11

BUTTON
111
12
232
45
Reset Highscore
resetHighscore
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

CHOOSER
257
10
373
55
Difficulty
Difficulty
"Easy" "Medium" "Hard"
1

TEXTBOX
9
171
386
622
How to Play:\n-Use the W,A,S,D keys, or the buttons to change the snake's direction.\n-Click the Setup button to reset the game\n-Click the Reset Highscore button to reset your highscore\n-Select the Difficulty of the game using the chooser (Easy, Medium, or Hard)\n-Click the Go button to play!\n\nObjective:\n-Eat as many Red Apples and Rainbow Apples as you can to increase your score!\n\nTips:\n-Don't run into your own body!!!\n-Avoid Purple Poison Apples! \n-Avoid Green Death Apples!\n-Avoid running into the White Border!\n-Avoid running into Trees! Running into them will stun your snake for 3 seconds and running into them too many times will kill your snake! (Note: they change their positions from time to time)\n-Watch the number of times you can still run into trees without dying using the number of lime-colored pine trees in the top left corner.\n-Your snake can swim, so you can go into the lake as much as you want to, but you cannot eat the fish. (Fish are friends, not food!)\n\nScoring Rules: \n-Score = size of snake + (2 * # of Rainbow Apples eaten)\n-Eating a Regular Red Apple adds 1 to the size of your snake\n-Eating a Giant Red Apple adds 4 to the size of your snake\n-Eating a Rainbow Apple adds 7 to the size of your snake\n-Eating a Purple Poison Apple subtracts 5 from the size of your snake
9
0.0
1

TEXTBOX
305
77
377
121
Setting: Appelpond Park
11
65.0
1

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

apple
false
0
Polygon -7500403 true true 33 58 0 150 30 240 105 285 135 285 150 270 165 285 195 285 255 255 300 150 268 62 226 43 194 36 148 32 105 35
Line -16777216 false 106 55 151 62
Line -16777216 false 157 62 209 57
Polygon -6459832 true false 152 62 158 62 160 46 156 30 147 18 132 26 142 35 148 46
Polygon -16777216 false false 132 25 144 38 147 48 151 62 158 63 159 47 155 30 147 18

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

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

lily pad
false
0
Polygon -7500403 true true 148 151 137 37 119 25 111 36 78 54 40 99 30 137 32 175 56 223 87 251 137 275 157 275 213 250 239 221 257 178 262 137 244 91 210 53 172 37 160 22 154 36
Line -13840069 false 154 151 207 97
Circle -13840069 false false 133 148 26
Line -13840069 false 52 122 134 157
Line -13840069 false 133 171 89 196
Line -13840069 false 147 193 147 254
Line -13840069 false 157 171 205 233
Line -13840069 false 161 161 204 163
Line -13840069 false 141 149 111 72

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

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

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

tree pine
false
0
Rectangle -6459832 true false 120 225 180 300
Polygon -7500403 true true 150 240 240 270 150 135 60 270
Polygon -7500403 true true 150 75 75 210 150 195 225 210
Polygon -7500403 true true 150 7 90 157 150 142 210 157 150 7

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

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
NetLogo 6.0.2
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
