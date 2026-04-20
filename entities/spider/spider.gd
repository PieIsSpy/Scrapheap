extends CharacterBody2D

@onready var target = $"../Player"

@export_category("Attributes")
@export var speed: float = 300
@export var health: int = 50
@export var damage: int = 10

func _physics_process(delta: float) -> void:
	var direction = (target.position-position).normalized()
	velocity = direction * speed
	move_and_slide()
