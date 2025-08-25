extends Spatial

## Configurable size of the map in world units. Increasing this makes the world larger.
export (Vector3) var map_size = Vector3(300, 0, 300)

## Number of cabins to generate.
const CABIN_COUNT = 3

## Size of each cabin mesh so that they count as "medium" in the world.
const CABIN_SIZE = Vector3(10, 6, 10)

func _ready():
    randomize()
    _generate_ground()
    _spawn_cabins()

func _generate_ground():
    # Create a simple plane to serve as the world ground.
    var ground = MeshInstance.new()
    var mesh = PlaneMesh.new()
    mesh.size = Vector2(map_size.x, map_size.z)
    ground.mesh = mesh
    add_child(ground)

func _spawn_cabins():
    # Spawn the required number of cabins at random positions inside the map bounds.
    for i in CABIN_COUNT:
        var cabin = MeshInstance.new()
        var cube = CubeMesh.new()
        cube.size = CABIN_SIZE
        cabin.mesh = cube
        cabin.translation = Vector3(
            rand_range(-map_size.x * 0.5, map_size.x * 0.5),
            CABIN_SIZE.y * 0.5,
            rand_range(-map_size.z * 0.5, map_size.z * 0.5)
        )
        add_child(cabin)
