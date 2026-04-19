extends CharacterBody2D

@onready var Gun = $Gun
@onready var PivotMarker: Marker2D = $PivotMarker

@export var speed = 400

func _process(delta: float) -> void:
	var mouse_dir := PivotMarker.global_position.direction_to(get_global_mouse_position())
	Gun.global_position = PivotMarker.global_position + mouse_dir * 60

	Gun.scale.y = 1 if mouse_dir.x > 0 else -1

	Gun.look_at(get_global_mouse_position())
	Gun.rotate(deg_to_rad(30 if mouse_dir.x > 0 else -30))

func get_input():
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * speed

func _physics_process(delta: float):
	get_input()
	move_and_slide()
