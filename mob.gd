extends Node2D

class_name Mob

var anim_player: AnimationPlayer
var mob_name: String = ""
var screen_size

var death_sprite: Sprite2D
var idle_sprite: Sprite2D
var walk_sprite: Sprite2D
var attack_sprite: Sprite2D
var collision_shape: CollisionShape2D
var collision_attack_shape: CollisionShape2D
var speed: float = 0.0
var is_attacking: bool = false

var current_sprite: Sprite2D
var current_sprite_frame: int

func walk(velocity):
	self.ani
	if death_sprite != null:
		death_sprite.hide()
	if idle_sprite != null:
		idle_sprite.hide()
	walk_sprite.show()
	walk_sprite.flip_v = false
	if velocity.x != 0:
		walk_sprite.flip_h = velocity.x < 0
	anim_player.play("walk")
	
func idle():
	if death_sprite != null:
		death_sprite.hide()
	if walk_sprite != null:
		walk_sprite.hide()
		idle_sprite.flip_v = walk_sprite.flip_v
		idle_sprite.flip_h = walk_sprite.flip_h
	anim_player.play("idle")
	current_sprite = $Idle
	current_sprite_frame = $Idle.get_frame()
	
func _ready():
	screen_size = get_viewport_rect().size
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity: Vector2 = Vector2.ZERO
	
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		walk(velocity)
	
	else:
		idle()

	position += velocity * delta
	position = position.clamp(Vector2.ZERO, screen_size)
	#update_collision_shape()

func attack():
	pass

func start(pos):
	set_position(pos)
	show()

func update_collision_shape():
	# Get the size of the current sprite frame's region rect
	var sprite_size = current_sprite.texture.get_size() / Vector2(current_sprite.hframes, current_sprite.vframes)
	
	# Create a new RectangleShape2D and set its size
	var shape = RectangleShape2D.new()
	shape.extents = sprite_size / 2
	
	# Assign the shape to the CollisionShape2D node
	collision_shape.shape = shape
	#prints("Enemy sprite_size", sprite_size)
