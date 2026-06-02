extends CharacterBody2D

var speed = 300
var direction = Vector2.ZERO

func _ready():
	pass

func _physics_process(delta: float) -> void:
	velocity = direction * speed
	move_and_slide()


func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	queue_free()

func direction_towards_center(spawn_pos: Vector2, screen_size: Vector2):
	var screen_center = screen_size / 2
	var path_to_screen_center = screen_center - spawn_pos
	direction = path_to_screen_center.normalized()
	
