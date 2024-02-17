extends Area2D

func _draw():
	draw_circle(Vector2(0, 0), 10, Color.WHITE)

func _process(delta):
	pass

func destroy():
	self.queue_free();
