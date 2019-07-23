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

# Reporting issues

If you have any problems running this demonstration please feel free to raise an issue on the github page. 
If it is a problem specific to the Oculus driver however I recommend raising the issue at https://github.com/GodotVR/godot_oculus/issues

# About this repository

This repository was created by and is maintained by Bastiaan Olij a.k.a. Mux213

You can follow me on twitter for regular updates here:
https://twitter.com/mux213

Videos about my work with Godot including tutorials on working with VR in Godot can by found on my youtube page:
https://www.youtube.com/BastiaanOlij
