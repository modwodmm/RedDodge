extends Node2D

enum GAMESTATE {Play, Dead}
var game_state = GAMESTATE.Dead

const enemy_scene = preload("res://enemy.tscn")

func _ready() -> void:
	$Player.died.connect(_on_player_died)
	$Player.visible = false
	$Player.move = false
	$Menu.visible = true


func _on_button_pressed() -> void:
	game_state = GAMESTATE.Play
	$Player.position = Vector2(574, 325)
	$Player.visible = true
	$Player.move = true
	$Menu.visible = false
	$Timer.start()

func _on_player_died():
	game_state = GAMESTATE.Dead
	$Player.visible = false
	$Player.move = false
	$Menu.visible = true
	$Timer.stop()

func generate_position(new_enemy):
	var screen_size = get_viewport_rect().size
	var height = screen_size.y
	var width = screen_size.x
	var offset = 50
	var spawn_pos = Vector2.ZERO
	
	var side = randi_range(0, 3)
	if side == 0:
		spawn_pos.x = randf_range(0, width)
		spawn_pos.y = -offset
	if side == 1:
		spawn_pos.x = randf_range(0, width)
		spawn_pos.y = height + offset
	if side == 2:
		spawn_pos.y = randf_range(0, height)
		spawn_pos.x = -offset
	if side == 3:
		spawn_pos.y = randf_range(0, height)
		spawn_pos.x = width + offset
	new_enemy.position = spawn_pos
	new_enemy.direction_towards_center(spawn_pos, screen_size)



func _on_timer_timeout() -> void:
	var new_enemy = enemy_scene.instantiate()
	generate_position(new_enemy)
	add_child(new_enemy)
