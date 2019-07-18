# Godot Oculus VR Demo

This repository contains a demo showing off the Oculus Rift support for Godot.

# License

This repository is MIT licensed by Bastiaan Olij
Note that the addons folder contains plugins with their own licenses

The following 3rd party inclusions are also part of this repo:
- Assets from https://github.com/wburton95/Godot-FPS-Demo which are MIT licensed.
- Textures from cc0textures.com which are CC0 licensed

# A note about the physics layers

You'll note that this project has a number of dedicated physics layers. This allows us to make assumptions of what is colliding.

The player is the only entity in the player physics layer, this allows doors etc. to react to the player
All objects we can interact with are in the objects layer.
All the walls, floors, etc. are all part of the environment physics layer and restricts the movement of the player.

By organising the physics layer in this way you make the physics engine work for you.
