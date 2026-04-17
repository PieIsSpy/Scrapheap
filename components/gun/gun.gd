extends Node2D

const bullet = preload("res://components/bullet/bullet.tscn")

const IS_PLAYER = true

@onready var RotationOffset: Node2D = $RotationOffset
@onready var SpriteShadow: Sprite2D = $RotationOffset/Sprite2D/shadow
@onready var ShootPos: Marker2D = $RotationOffset/Sprite2D/Marker2D

var fire_rate: float = 0.25
var can_shoot: bool = true

func _ready() -> void:
	$Timer.wait_time = fire_rate

func _physics_process(delta: float) -> void:
	RotationOffset.rotation = lerp_angle(RotationOffset.rotation, (get_global_mouse_position() - global_position).angle(), 6.5 * delta)
	SpriteShadow.position = Vector2(-2, 2).rotated(-RotationOffset.rotation)

	if Input.is_action_just_pressed("Shoot") and can_shoot:
		_shoot()
		can_shoot = false
		$Timer.start()

func _shoot():
	var new_bullet = bullet.instantiate()
	get_tree().root.add_child(new_bullet)
	new_bullet.global_position = ShootPos.global_position
	new_bullet.global_rotation = ShootPos.global_rotation

func _on_timer_timeout() -> void:
	can_shoot = true
