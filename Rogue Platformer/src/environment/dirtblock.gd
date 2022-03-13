extends KinematicBody2D


func destroy()->void:
	get_node("DirtParticles/Particles2D").rotation_degrees-=rotation_degrees
	get_node("CollisionShape2D").disabled=true
	get_node("Dirt").visible=false
	get_node("DirtParticles/Particles2D").emitting=true
	var time_in_seconds = 0.6
	yield(get_tree().create_timer(time_in_seconds), "timeout")
	queue_free()
