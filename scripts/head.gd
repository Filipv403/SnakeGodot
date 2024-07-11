class_name Head
extends Area2D

const size = 16
const speed = 0.025

var horizontalMove = 1
var verticalMove = 0

@onready var sprite = $Sprite2D

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var horizontalDirection = Input.get_axis("move_left", "move_right")
	var verticalDirection = Input.get_axis("move_up", "move_down")
	
	if (horizontalDirection != 0 && horizontalMove == 0):
		horizontalMove = horizontalDirection
		verticalMove = 0;
	if (verticalDirection != 0 && verticalMove == 0):
		verticalMove = verticalDirection
		horizontalMove = 0;
		
	if (self.position.x == 8 || self.position.x == 280 || self.position.y == -8 || self.position.y == -520):
		GlobalSignals.game_over.emit()
		
func move_snake():
	if (horizontalMove != 0):
		position.x += size * horizontalMove
		if (horizontalMove == 1):
			sprite.rotation_degrees = 0
		elif (horizontalMove == -1):
			sprite.rotation_degrees = 180
	if (verticalMove != 0):
		position.y += size * verticalMove
		if (verticalMove == 1):
			sprite.rotation_degrees = 90
		elif (verticalMove == -1):
			sprite.rotation_degrees = -90
