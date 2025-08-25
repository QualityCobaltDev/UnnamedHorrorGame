extends Node3D

# Generates the map layout including cabins, foliage and talismans.

@export var cabin_scene: PackedScene
@export var talisman_scene: PackedScene
@export var cabin_count := 3
@export var foliage_count := 50
var rng := RandomNumberGenerator.new()

func generate() -> void:
    rng.randomize()
    _clear_children()
    var used_positions: Array[Vector3] = []
    for i in range(cabin_count):
        var pos := _random_unique_position(used_positions, 10.0)
        used_positions.append(pos)
        var cabin := cabin_scene.instantiate()
        cabin.global_transform.origin = pos
        add_child(cabin)
        var talisman := talisman_scene.instantiate()
        talisman.global_transform.origin = pos + Vector3(0, 1, 0)
        talisman.collected.connect(get_parent().on_talisman_collected)
        add_child(talisman)
    _spawn_foliage()

func _random_unique_position(used: Array[Vector3], min_dist: float) -> Vector3:
    var pos := _random_position()
    var attempts := 0
    while attempts < 10:
        var valid := true
        for u in used:
            if u.distance_to(pos) < min_dist:
                valid = false
                break
        if valid:
            return pos
        pos = _random_position()
        attempts += 1
    return pos

func _random_position() -> Vector3:
    return Vector3(rng.randf_range(-100, 100), 0, rng.randf_range(-100, 100))

func _spawn_foliage() -> void:
    for i in range(foliage_count):
        var tree := MeshInstance3D.new()
        tree.mesh = CylinderMesh.new()
        tree.scale = Vector3(0.5, rng.randf_range(2.0, 4.0), 0.5)
        tree.global_transform.origin = _random_position()
        add_child(tree)

func _clear_children() -> void:
    for child in get_children():
        child.queue_free()
