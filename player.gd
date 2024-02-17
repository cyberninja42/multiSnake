#extends CharacterBody2D
extends Area2D

signal food_collected


const SPEED = 0.1
var buff_dir = Vector2(1,0)
var dir = Vector2(1,0)
var gridsize = 40
var old_position = position
var tail_length = 1
var spawn_inv = 2
var last_tail = null
var bounds = Vector2(28,15)

func _ready():
	pass
	
func _draw():
	draw_circle(Vector2(0, 0), 20, Color.WHITE)

func _physics_process(delta):

	var direction_x = Input.get_axis("ui_left", "ui_right")
	var direction_y = 0
	if not direction_x:
		direction_y = Input.get_axis("ui_up", "ui_down")
		
	# Based on movements buffer the next turn
	var currentGrid = round(position/gridsize)
	if direction_x or direction_y:
		if abs(dir.x) != abs(direction_x) and abs(dir.y) != abs(direction_y):
			buff_dir = Vector2(direction_x,direction_y)

	# Not using delta to avoid issues with moving outside of grid
	position = position.move_toward((((round(position/gridsize))+dir)*gridsize), SPEED*gridsize)
	
	var nextGrid = round(position/gridsize)
	var pZone = Vector2(delta * SPEED*gridsize,delta * SPEED*gridsize)

	# If snake is lined up with grid execute buffered turn, 
	# also store old position for other use
	if (position == round(position/gridsize)*gridsize):
		old_position = round(position/gridsize)*gridsize
		dir = buff_dir
		if spawn_inv > 0:
			spawn_inv -= 1

	# If out of bounds kill the snake
	var gridpos = round(position/gridsize)
	if gridpos.x < 1 or gridpos.x > bounds.x or gridpos.y < 1 or gridpos.y > bounds.y:
		die()


func _on_body_entered(body):
	print(body)


func _on_area_entered(area):
	#If hit snake part, die
	if spawn_inv == 0 and area.is_in_group("snake"):
		die()
		
	#If hit food destroy food and make snake bigger
	if area.is_in_group("food"):
		food_collected.emit(self,last_tail)
		area.destroy()

# Stop snake moving when die
func die():
	dir = Vector2(0,0)
	buff_dir = dir
	
