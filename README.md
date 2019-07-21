# Godot Oculus VR Demo

This repository contains a demo showing off the Oculus Rift support for Godot.

# License

This repository is MIT licensed by Bastiaan Olij unless otherwise specified.
Note that various folders contains their own licenses applicable to the files contained within that folder.

# A note about the physics layers

You'll note that this project has a number of dedicated physics layers. This allows us to make assumptions of what is colliding.

The player is the only entity in the player physics layer, this allows doors etc. to react to the player
All objects we can interact with are in the objects layer.
All the walls, floors, etc. are all part of the environment physics layer and restricts the movement of the player.

By organising the physics layer in this way you make the physics engine work for you.

# Todos
- need to check with Nuno for license of godot arcade
- add more stuff
- make more rooms
