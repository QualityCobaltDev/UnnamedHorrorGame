extends SceneTree

func _init():
    var WorldGenerator = load("res://scripts/world_generator.gd")
    var world = WorldGenerator.new()
    world._ready()
    quit()
