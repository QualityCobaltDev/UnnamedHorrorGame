extends Node

# Applies a low resolution filter to mimic early console visuals.

func _ready() -> void:
    var viewport := get_viewport()
    viewport.scaling_3d_mode = Viewport.SCALING_3D_MODE_MANUAL
    viewport.scaling_3d_scale = 0.5
