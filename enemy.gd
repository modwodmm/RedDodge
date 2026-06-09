extends CharacterBody2D

var speed = 150
var direction = Vector2.ZERO

@onready var sprite = $AnimatedSprite2D

#When game starts
func _ready():
	sprite.play("default")

#Manages movement
func _physics_process(delta: float) -> void:
	var main = get_tree().get_root().get_node("Main")
	if main.game_state == main.GAMESTATE.Dead:
		queue_free()
	velocity = direction * speed
	move_and_slide()

#Handles despawning
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

#Makes it move towards the screen
func direction_towards_center(spawn_pos: Vector2, screen_size: Vector2):
	var screen_center = screen_size / 2
	var path_to_screen_center = screen_center - spawn_pos
	direction = path_to_screen_center.normalized()
	
