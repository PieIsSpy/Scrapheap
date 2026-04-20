extends Node2D

const bullet = preload("res://components/bullet/bullet.tscn")

@onready var ShootPos: Marker2D = $RotationOffset/Sprite2D/Marker2D

var fire_rate: float = 0.1
var can_shoot: bool = true

func _ready() -> void:
	$Timer.wait_time = fire_rate

func _physics_process(delta: float) -> void:
	if Input.is_action_pressed("Shoot") and can_shoot:
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
