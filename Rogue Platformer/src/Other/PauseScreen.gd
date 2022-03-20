extends CanvasLayer

var choose=2
#back = 2
#help = 1
#quit = 0

var help_menu:=false
var help_page:=false
var help_choose=2
#left = 2
#right = 1
#back = 0

func _ready():
	set_visible(false)
	get_node("Help/Controls").animation="an1"

func _input(event):
	if(event.is_action_pressed("pause") and get_node("/root/Game").can_pause):
		choose=2
		set_buttons()
		set_visible(!get_tree().paused)
		get_tree().paused = !get_tree().paused
		if(get_tree().paused):
			get_node("AnimatedSprite").frame=0
			choose=2
		else:
			help_menu=false
	if(event.is_action_pressed("up")):
		if(!help_menu):
			if(choose==2):
				choose=0
			else:
				choose=choose+1
			set_buttons()
		else:
			if(help_choose==0):
				help_choose=2
			set_help()
	if(event.is_action_pressed("down")):
		if(!help_menu):
			if(choose==0):
				choose=2
			else:
				choose=choose-1
			set_buttons()
		else:
			help_choose=0
			set_help()
	
	if(event.is_action_pressed("move_right") and help_menu):
		if(help_choose!=0):
			help_choose=help_choose-1
			if(help_choose==-1):
				help_choose=2
			set_help()
	if(event.is_action_pressed("move_left") and help_menu):
		if(help_choose!=2):
			help_choose=help_choose+1
			if(help_choose==3):
				help_choose=2
			set_help()
	
	if(event.is_action_pressed("action") or event.is_action_pressed("ui_accept") or event.is_action_pressed("buy")):
		if(get_tree().paused and !help_menu):
			if(choose==0):
				set_visible(false)
				get_tree().paused = false
				get_tree().reload_current_scene()
			elif(choose==2):
				get_tree().paused = false
				set_visible(false)
			else:
				help_menu=true
				help_choose=2
				get_node("AnimatedSprite").visible=false
				get_node("Buttons").visible=false
				get_node("Help").visible=true
				set_help()
		if(help_menu):
			if(help_choose==2):
				if(help_page):
					get_node("Help/Controls").animation="an1"
					help_page=false
			elif(help_choose==1):
				if(!help_page):
					get_node("Help/Controls").animation="an2"
					help_page=true
			else:
				help_menu=false
				get_node("AnimatedSprite").visible=true
				get_node("Buttons").visible=true
				get_node("Help").visible=false

func set_help()->void:
	if(help_choose==0):
		get_node("Help/GoBack").visible=true
		get_node("Help/GoLeft").visible=false
		get_node("Help/GoRight").visible=false
	elif(help_choose==1):
		get_node("Help/GoBack").visible=false
		get_node("Help/GoLeft").visible=false
		get_node("Help/GoRight").visible=true
	else:
		get_node("Help/GoBack").visible=false
		get_node("Help/GoLeft").visible=true
		get_node("Help/GoRight").visible=false

func set_buttons()->void:
	if(choose==0):
		get_node("Buttons/Back").visible=false
		get_node("Buttons/Help").visible=false
		get_node("Buttons/Quit").visible=true
	elif(choose==1):
		get_node("Buttons/Back").visible=false
		get_node("Buttons/Help").visible=true
		get_node("Buttons/Quit").visible=false
	else:
		get_node("Buttons/Back").visible=true
		get_node("Buttons/Help").visible=false
		get_node("Buttons/Quit").visible=false

func set_visible(is_visible):
	for node in get_children():
		if((node.name!="Buttons" and is_visible) or !is_visible):
			node.visible = is_visible
	get_node("Help").visible=false
	var time_in_seconds = 0.2
	yield(get_tree().create_timer(time_in_seconds), "timeout")
	get_node("Buttons").visible=is_visible
