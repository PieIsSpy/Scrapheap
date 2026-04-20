extends Node2D

const spider = preload("res://entities/spider/spider.tscn")
const min_dist = 661
const max_dist = 1000

func _on_timer_timeout() -> void:
	var angle = randf_range(0, 360)
	var distance = randf_range(min_dist, max_dist)

	var spawn_offset = Vector2(
		cos(deg_to_rad(angle)) * distance,
		sin(deg_to_rad(angle)) * distance
	)

	var new_enemy = spider.instantiate()
	new_enemy.global_position = $"../Player".global_position + spawn_offset
	add_child(new_enemy)
