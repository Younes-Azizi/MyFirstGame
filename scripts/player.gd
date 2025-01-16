extends CharacterBody2D

signal score_changed(new_score: int)  

var player_score: int = 0
@onready var animation = $AnimatedSprite2D
@export var SPEED = 300.0
@export var JUMP_VELOCITY = -500.0

func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction := Input.get_axis("moveL", "moveR")
	if direction:
		velocity.x = direction * SPEED
		animation.flip_h = direction == -1
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	update_animation()
	move_and_slide()

func update_animation():
	if velocity.x != 0:
		animation.play("run")
	else:
		animation.play("idle")

	if velocity.y < 0:
		animation.play("jump")
	elif velocity.y > 0:
		animation.play("falling")

func add_almas_number(number: int) -> void:
	player_score += number
	emit_signal("score_changed", player_score)
	print("Player score updated:", player_score)  
	
func _on_game_over_zone_body_entered(_body: Node2D) -> void:
	get_tree().reload_current_scene()
