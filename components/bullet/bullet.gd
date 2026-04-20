extends Sprite2D

@onready var AnimPlayer: AnimationPlayer = $AnimationPlayer
@onready var RayCast: RayCast2D = $RayCast2D

@export_group("Attributes")
@export var speed: float = 2000.0
@export var damage: int = 10

func _physics_process(delta: float) -> void:
	global_position += Vector2(1, 0).rotated(rotation) * speed * delta

	if RayCast.is_colliding() && RayCast.get_collider().has_meta("Is Player") && !RayCast.get_collider().get_meta("Is Player"):
		AnimPlayer.play("remove")

func _on_animation_player_animation_finished(anim_name: StringName) -> void:
	if anim_name == "remove":
		queue_free()

func _on_timer_timeout() -> void:
	AnimPlayer.play("remove")
