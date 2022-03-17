Daily Programmer #154
=====================

This is a console implementation of "Hunt the Wumpus", a simple roguelike game. It is implemented in Ruby.

Full details of the problem (and similar solutions) can be found at http://www.reddit.com/r/dailyprogrammer/comments/21kqjq/4282014_challenge_154_hard_wumpus_cave_game/

Goals
-----

* Get into the swing of things
* Solve a fun problem
* Get guard (the fully automated test&spec runner) working
* Explore "as large as possible" spec writing, i.e. write functional tests, not "unit" tests.
* (failed) Explore test builders. This failed because the problem was **too simple** to use test builders. I could have shoehorned a test builder type setup into the cave generation (since cave generation had several complex scenarios), but the simplest way to generate caves is to draw them (which I did). I used a simple "Object Mother" instead.

Things I could  improve, but won't
----------------------------------

I'm done with this little sample project, but feel like I need to write out the list of things I'm aware could be improved, so that if you don't get the wrong idea. If you stumble upon this code and say to yourself "aha, this is how RSpec should be used"...maybe. I think the spec suite is good, overall. **But**, maybe also note the things I list below, even I know that my test suite could be improved.

* My RSpec specs should be updated to use the newer expect syntax.
* RSpec "behaves like"/"shared examples" could have been used, and I need to try them out.
* RSpec "Contexts" should be used, and possibly also "let" blocks, though I am not too sure about the "let" blocks being useful for my non-unit, wide-grain specs.
* My "message passing" of a command from the UI, and a "message" of sorts back to the client, seemed halfhearted and awkward. The most awkward part of this is inside HuntTheWumpus.rb where the command calls a series of methods, each of which may (or may not) append results to @messages, which eventually makes its way back to the client. Just be aware that I'm not happy with the way @messages is used, and could improve it with time.
* "Adding" two Locations objects together to calculate movement feels like I'm cheating. But I only calculate movement once in the entire codebase, so I don't feel so bad.
* Either everyone else should be using "OpenStruct" more often to quickly make objects, or I should be using "OpenStruct" less. Because I use "OpenStruct" quite a lot.
* I feel like I should figure out how everyone else (outside of Rails of course) includes files in Ruby, or if I should give up caring how, so long as it works. In the project I use a `require_all` gem to require the entire lib folder when running specs, and I use `require_relative` inconsistently within files within the lib folder itself. This is one of those things that either a) doesn't matter at all, or b) will secretly slow my program by a factor of 20.
* Upon re-reading my specs, it appears I left in some typos in my specs, as well as used the word "should" inside of the specs themselves. Using the word "should" in a spec is not a big deal, but I should be consistent, either 100% or 0%.

Things I am angry at
--------------------

* Guard and its limitations (and how no one seems to notice or care)
* RSpec "expect" syntax, which I have made peace with, despite being an inferior end-user experience to the "should" syntax

Specifcations pasted from RSpec output
--------------------------------------

Approaching a wumpus armed
* does not tell us we were eaten
* tells us slew a wumpus
* awards us points for slaying a wumpus
* does not tell us the game is over

Approaching a wumpus unarmed
* tells us we were eaten by a wumpus
* tells us the game is over

Attempting to start a new game with a cave size that is too small
* errors out

Attempting to start a new game with a cave size that is too large
* errors out

Starting a new game of Hunt the Wumpus
* starts the game

Starting a game with a specific cave size
* Creates a cave of that size

Displaying the game status
   * displays a cave
   * has the player character somewhere in the cave
   * At the beginning of the game
      * is completely unexplored

Entering the cave immediately next to a wumpus
* should indicate there is a foul stench in the air

Falling into a pitfall
* tells us we fell into a pitfall
* tells us the game is over

Creating a random cave
* has 1 entrance
* has weapons rooms with 15% chance
* has gold rooms with 15% chance
* has wumpus rooms with 15% chance
* has pitfall traps with 5% chance
* has exactly the right number of rooms

Leaving a slain wumpus
* shows the room with the slain wumpus as empty now

Attempting to loot an empty room
* should tell you you failed to loot
* should not award any extra points
* Attempting to loot the cave entrance
* should tell you you failed to loot
* should not award any extra points

Looting gold
* awards 5 points

Moving away from a looted room
* shows the looted room as empty

Looting a weapon when unarmed
* tells you you pick up the weapon
* arms you with the weapon
* awards 5 points
* changes any weapon rooms to gold rooms

Moving near a pitfall
* does not tell us there is a foul stench in the air
* tells us there is a howling wind

Moving near a wumpus
* does not tell us there is a howling wind
* tells us there is a foul odor

Moving the player north
* moves the player one spot to the north

Moving the player south
* moves the player one spot to the south

Moving the player west
* moves the player one spot to the west

Moving the player east
* moves the player one spot to the east

Moving the player
* moves the player to the new room
* reveals the contents of the previous room
* tells you you moved

Attempting to move into a wall
* does not move the player
* tells us we hit a wall
* doesn't tell us we moved
* does not award us points

Moving the player to a previously explored room
* does not award any extra points

Moving the player into a room with gold
* tells you you moved
* tells you there is gold in this room
* does not award us points

Moving the player into a room with a weapon
* tells you you moved
* tells you there is a weapon in this room
* does not award us points

Moving the player to an empty room
* awards 1 point for exploring a new, empty room

Receiving bad commands from the client
* errors out

Running out of the cave to safety
* tells us the game is over
* tells us we escape the cave
* tells us our final score

