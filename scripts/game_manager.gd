extends Node3D

# Handles high level game logic such as restarting and tracking talismans.

const TALISMAN_COUNT := 3
var talismans_collected := 0
var rng := RandomNumberGenerator.new()
var jumpscare_timer := 0.0

@onready var map_generator: Node3D = $MapGenerator
@onready var monster: Node3D = $Monster
@onready var jumpscare_manager: Node = $JumpscareManager
@onready var player: Node3D = $Player

func _ready() -> void:
    rng.randomize()
    player.died.connect(on_player_death)
    jumpscare_manager.spawn_clone.connect(monster.spawn_clone)
    start_run()

func _process(delta: float) -> void:
    jumpscare_timer -= delta
    if jumpscare_timer <= 0.0:
        if rng.randf() < 0.3:
            jumpscare_manager.trigger_random_event()
        jumpscare_timer = rng.randf_range(5.0, 10.0)

func start_run() -> void:
    talismans_collected = 0
    map_generator.generate()
    player.global_transform.origin = Vector3.ZERO
    monster.global_transform.origin = Vector3(20, 0, 20)
    monster.reset()

func on_player_death() -> void:
    start_run()

func on_talisman_collected() -> void:
    talismans_collected += 1
    monster.increase_speed(talismans_collected)
    if talismans_collected >= TALISMAN_COUNT:
        _on_all_talismans_found()

func _on_all_talismans_found() -> void:
    # Placeholder for victory condition.
    print("All talismans collected. Player wins.")
