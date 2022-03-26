extends KinematicBody2D

var gravity:=295.0
var speed:=Vector2(150.0, 100.0)
var velocity:=Vector2.ZERO

var price:int=50
var e:=false
var free:=false

func _ready() -> void:
	get_node("Text/price").text="$"+str(price*100)

func _physics_process(delta: float) -> void:
	velocity.y+=gravity*delta
	move_and_slide(velocity)
	if(velocity.y>speed.y):
		velocity.y=speed.y

func _process(delta: float) -> void:
	if(e):
		get_node("E").visible=true
		get_node("Text/price").visible=true
	else:
		get_node("E").visible=false
		get_node("Text/price").visible=false

func e()->void:
	if(free):
		get_parent().get_parent().get_node("Player").bomb+=3
		queue_free()
	e=true
	var time_in_seconds = 0.1
	yield(get_tree().create_timer(time_in_seconds), "timeout")
	e=false

func buy()->void:
	var player=get_parent().get_parent().get_node("Player")
	if(player.money>price-1):
		player.money-=price
		player.bomb+=3
		get_parent().count_items()
		queue_free()


func get_for_free()->void:
	get_parent().get_parent().get_node("Player").bomb+=3
	queue_free()
