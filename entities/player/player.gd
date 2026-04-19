extends CharacterBody2D

@onready var gun = $Gun
@onready var RotationOffset: Node2D = $Gun/RotationOffset
@onready var SpriteShadow: Sprite2D = $Gun/RotationOffset/Sprite2D/shadow

@export var speed = 400

func _process(delta: float) -> void:
	RotationOffset.rotation = lerp_angle(RotationOffset.rotation, (get_global_mouse_position() - global_position).angle(), 6.5 * delta)
	SpriteShadow.position = Vector2(-2, 2).rotated(-RotationOffset.rotation)

func get_input():
	var input_direction = Input.get_vector("Left", "Right", "Up", "Down")
	velocity = input_direction * speed

func _physics_process(delta: float):
	get_input()
	move_and_slide()
