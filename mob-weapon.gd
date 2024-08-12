extends Area2D

# Called when the node enters the scene tree for the first time.
func _ready():
	add_to_group("mob-weapon")
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

#func _on_body_entered(body):
	#if $Ork.anim_player.current_animation == "attack-1":
		#var frame = attack_sprite.frame
		## Check if the current frame is within the attack range (4 to 6)
		#if frame >= 3 and frame <= 5:
			#hit_frame.emit()
		#is_attacking = false
	#if body.is_in_group("mob") :
		#dead()
		#hit.emit()
		#$CollisionShape2D.set_deferred("disabled", true)
	#else:
		#prints("Not a mob")
