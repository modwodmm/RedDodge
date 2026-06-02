extends CharacterBody2D

var speed = 300
var move = false
signal died

@onready var sprite = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if move:
		velocity = Vector2.ZERO
		if Input.is_action_pressed("go_up"):
			velocity.y -= speed
		if Input.is_action_pressed("go_down"):
			velocity.y += speed
		if Input.is_action_pressed("go_left"):
			velocity.x -= speed
		if Input.is_action_pressed("go_right"):
			velocity.x += speed
		if velocity != Vector2.ZERO:
			sprite.play("default")
		else:
			sprite.stop()
	move_and_slide()


func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("enemy"):
		emit_signal("died")
