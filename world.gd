extends Node2D

var player_scene = load("res://player.tscn")
var tail_scene = load("res://tail.tscn")
var bounds = Vector2(28,15)

func _ready():
	pass
	
func generate_world():
	var player = player_scene.instantiate()
	player.position=Vector2(40,40)
	player.old_position=player.position
	get_node("Players").add_child(player)
	
	var prev_seg = player
	for i in range(player.tail_length):
		var tail = tail_scene.instantiate()
		tail.position=Vector2(40,40)
		tail.set_parent(prev_seg)
		get_node("Players").add_child(tail)
		prev_seg = tail
		player.last_tail = tail
	
	create_food()
	player.connect("food_collected", add_tail)
	
func add_tail(player,end_tail):
	var tail = tail_scene.instantiate()
	tail.position=end_tail.position
	tail.set_parent(end_tail)
	get_node("Players").add_child(tail)
	player.last_tail = tail
	create_food()

func create_food(x=null,y=null):
	var rng = RandomNumberGenerator.new()
	if x == null:
		x = rng.randi_range(1, bounds.x)
	if y == null:
		y = rng.randi_range(1, bounds.y)
	var food_scene = load("res://food.tscn")
	var food = food_scene.instantiate()
	food.position=Vector2(x,y)*40
	get_node("Food").add_child(food)
