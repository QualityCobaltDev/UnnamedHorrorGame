extends CharacterBody3D

# Basic first-person controller placeholder.

@export var speed := 5.0
signal died

func _physics_process(delta: float) -> void:
    var input_dir := Vector3.ZERO
    input_dir.x = Input.get_action_strength("move_right") - Input.get_action_strength("move_left")
    input_dir.z = Input.get_action_strength("move_backward") - Input.get_action_strength("move_forward")
    if input_dir != Vector3.ZERO:
        input_dir = input_dir.normalized()
    velocity.x = input_dir.x * speed
    velocity.z = input_dir.z * speed
    move_and_slide()

func die() -> void:
    died.emit()
