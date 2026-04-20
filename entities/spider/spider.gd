extends CharacterBody2D

@onready var target: CharacterBody2D
@onready var sprite = $Sprite2D
@onready var inv_timer = $Invulnerable
@onready var atk_timer = $Attack

@export_category("Attributes")
@export var speed: float = 300
@export var health: int = 50
@export var damage: int = 10

var is_invulnerable = false
var can_attack = true

func _ready():
	target = get_tree().get_first_node_in_group("Player")

func _physics_process(delta: float) -> void:
	var direction = (target.position-position).normalized()
	velocity = direction * speed
	move_and_slide()

func damage_animation():
	sprite.self_modulate = Color(1,0,0,.5)
	await get_tree().create_timer(.125).timeout
	sprite.self_modulate = Color(1,1,1,1)
	await get_tree().create_timer(.125).timeout

func take_damage(dmg: int):
	if is_invulnerable == false:
		is_invulnerable = true
		health -= dmg
		inv_timer.start()
		damage_animation()
		
	print(health)

	if health <= 0:
		queue_free()

func _on_invulnerable_timeout() -> void:
	is_invulnerable = false

func _on_attack_timeout() -> void:
	can_attack = true
