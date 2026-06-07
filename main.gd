extends Node2D

enum GAMESTATE {Play, Dead}
var game_state = GAMESTATE.Dead

const enemy_scene = preload("res://enemy.tscn")

var score = 0

var menu_scene = preload("res://menu.tscn")
var menu_instance

#When game starts
func _ready() -> void:
	$Panel.visible = false
	menu_instance = menu_scene.instantiate()
	$CanvasLayer.add_child(menu_instance)
	menu_instance.play.connect(_on_play)
	$Background.play()
	$Player.died.connect(_on_player_died)
	$Player.visible = false
	$Player.move = false

#When "Play" is pressed
func _on_play() -> void:
	game_state = GAMESTATE.Play
	$Panel.visible = true
	$Press.play()
	$Background.stop()
	score = 0
	$Player.reset_player()
	menu_instance.visible = false
	display_score()
	$Timer.start()

#When player dies
func _on_player_died():
	$Panel.visible = false
	game_state = GAMESTATE.Dead
	$Background.play()
	$Death.play()
	$Player.visible = false
	$Player.move = false
	menu_instance.visible = true
	$Timer.stop()

#Generates enemies position
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


#Generates enemies
func _on_timer_timeout() -> void:
	var new_enemy = enemy_scene.instantiate()
	generate_position(new_enemy)
	add_child(new_enemy)
	score += 1
	display_score()
	
#Displays score
func display_score():
	$Label.text = "Score: " + str(score)
	
