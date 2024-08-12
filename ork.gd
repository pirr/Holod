extends Mob

class_name Ork

signal hit_frame

func _ready():
	super._ready()
	mob_name = "Ork"
	anim_player = $AnimationPlayer
	walk_sprite = $Walk
	idle_sprite = $Idle
	attack_sprite = $Attack
	collision_shape = $CollisionShape2D
	collision_attack_shape = $CollisionShapeAttackHit
	speed = 200.0
	add_to_group("mob")
	
func _process(delta):
	attack()

func attack():
	if is_attacking:
		return
	is_attacking = true
	
