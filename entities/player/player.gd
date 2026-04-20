extends CharacterBody2D

@onready var Gun = $Gun
@onready var PivotMarker: Marker2D = $PivotMarker
@onready var SpriteAnim = $AnimationPlayer

@export_group("Attributes")
@export var speed: float = 500
@export var health: int = 100

func _process(delta: float) -> void:
	var mouse_dir := PivotMarker.global_position.direction_to(get_global_mouse_position())
	Gun.global_position = PivotMarker.global_position + mouse_dir * 20

	Gun.scale.y = 1 if mouse_dir.x > 0 else -1

	Gun.look_at(get_global_mouse_position())
	Gun.rotate(deg_to_rad(30 if mouse_dir.x > 0 else -30))
	
	var angle = rad_to_deg(mouse_dir.angle())
	
	if angle <= 45 and angle >= -45:
		SpriteAnim.play("player_right")
	elif angle >= -135 and angle <= -45:
		SpriteAnim.play("player_up")
	elif angle <= -135 or angle >= 135:
		SpriteAnim.play("player_left")
	else:
		SpriteAnim.play("player_down")

func get_input():
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * speed

func _physics_process(delta: float):
	get_input()
	move_and_slide()
