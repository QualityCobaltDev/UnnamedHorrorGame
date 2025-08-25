extends Node

# Handles random jump scare events such as noises and popups.

signal spawn_clone
@export var noise_players: Array[AudioStreamPlayer] = []
@export var popup_scenes: Array[PackedScene] = []
var rng := RandomNumberGenerator.new()

func _ready() -> void:
    rng.randomize()

func trigger_random_event() -> void:
    var choice := rng.randi_range(0, 2)
    match choice:
        0:
            _play_random_noise()
        1:
            _show_random_popup()
        2:
            emit_signal("spawn_clone")

func _play_random_noise() -> void:
    if noise_players.is_empty():
        return
    var player := noise_players[rng.randi_range(0, noise_players.size() - 1)]
    player.play()

func _show_random_popup() -> void:
    if popup_scenes.is_empty():
        return
    var popup := popup_scenes[rng.randi_range(0, popup_scenes.size() - 1)].instantiate()
    get_tree().root.add_child(popup)
