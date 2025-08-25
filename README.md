# UnnamedHorrorGame
PolygonForge and Mike Brogan - Horror Game Project on GoDot

## World Generation

The `scripts/world_generator.gd` script provides a scalable, open-world
map generator. It builds a ground plane based on the configurable
`map_size` property and spawns three medium-sized cabins at random
locations. The `randomize()` call ensures that the layout is different on
every restart.
