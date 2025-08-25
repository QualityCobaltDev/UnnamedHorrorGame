extends CharacterBody3D

# Monster chases the player and becomes faster as talismans are collected.

@export var base_speed := 2.0
@export var speed_increment := 1.5
var current_speed := 2.0
var player: Node3D
@export var clone_scene: PackedScene = preload("res://scenes/Monster.tscn")

func _ready() -> void:
    player = get_tree().get_first_node_in_group("player")

func reset() -> void:
    current_speed = base_speed
    _remove_clones()

func increase_speed(talisman_count: int) -> void:
    current_speed = base_speed + speed_increment * talisman_count

func _physics_process(delta: float) -> void:
    if player:
        var direction := (player.global_transform.origin - global_transform.origin).normalized()
        velocity = direction * current_speed
        move_and_slide()
        if global_transform.origin.distance_to(player.global_transform.origin) < 1.5:
            if player.has_method("die"):
                player.die()

func _spawn_clone() -> void:
    if clone_scene:
        var clone := clone_scene.instantiate()
        clone.global_transform = global_transform
        clone.current_speed = current_speed
        get_parent().add_child(clone)

func spawn_clone() -> void:
    _spawn_clone()

func _remove_clones() -> void:
    for child in get_parent().get_children():
        if child != self and child.get_script() == get_script():
            child.queue_free()
