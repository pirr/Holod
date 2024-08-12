extends CharacterBody2D

# Grid parameters 
@export var grid_size: Vector2 = Vector2(32, 32)
@onready var anim_player = $PlayerAnimation
signal hit

# Movement speed
@export var speed: float = 200.0
var screen_size

var current_sprite: Sprite2D
var current_sprite_frame: int

# Direction vectors for grid movement
var move_vector: Vector2 = Vector2.ZERO


func _ready():
	add_to_group("player")
	screen_size = get_viewport_rect().size
	hide()

func _physics_process(delta):
	
	var velocity: Vector2 = Vector2.ZERO
	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		walk(velocity)
	else:
		idle()
	position += velocity * delta
	#position = position.clamp(Vector2.ZERO, screen_size)
	#update_collision_shape()
	move_and_slide()

		
func idle():
	$Dead.hide()
	$Walk.hide()
	$Idle.show()
	$Idle.flip_v = $Walk.flip_v
	$Idle.flip_h = $Walk.flip_h
	anim_player.play("idle")
	current_sprite = $Idle
	current_sprite_frame = $Idle.get_frame()

func walk(velocity):
	$Dead.hide()
	$Idle.hide()
	$Walk.show()
	$Walk.flip_v = false
	if velocity.x != 0:
		$Walk.flip_h = velocity.x < 0
	anim_player.play("walk")
	current_sprite = $Walk
	current_sprite_frame = $Walk.get_frame()
	
func dead():
	# Hide other animations
	$Idle.hide()
	$Walk.hide()
	$Dead.show()

	anim_player.play("death")

	set_process(false)
	set_physics_process(false)

	$CollisionShape2D.set_deferred("disabled", true)
	
func start(pos):
	set_position(pos)
	show()
	$CollisionShape2D.disabled = false
	
func update_collision_shape():
	# Get the size of the current sprite frame's region rect
	var sprite_size = current_sprite.texture.get_size() / Vector2(current_sprite.hframes, current_sprite.vframes)
	
	# Create a new RectangleShape2D and set its size
	var shape = RectangleShape2D.new()
	shape.extents = sprite_size / 2
	
	# Assign the shape to the CollisionShape2D node
	$CollisionShape2D.shape = shape
	#prints("sprite_size", sprite_size)

func _on_body_entered(body):
	prints("Collision with ", body.name)
	if body.is_in_group("mob") :
		dead()
		hit.emit()
		$CollisionShape2D.set_deferred("disabled", true)
	else:
		prints("Not a mob")
