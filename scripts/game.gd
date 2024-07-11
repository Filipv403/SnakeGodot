extends Node2D

@onready var timer = $Timer
@onready var head = $Snake/Head
@onready var tile_map = $TileMap
@onready var apples = $Apples
@onready var scoreLabel = $Score
@onready var snake = $Snake
@onready var game_over = $GameOver

var APPLE = preload("res://scenes/apple.tscn")
var BODY = preload("res://scenes/body.tscn")

var score = 4
var game_try = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	timer.start()
	GlobalSignals.apple_eaten.connect(on_apple_eaten)
	GlobalSignals.game_over.connect(on_game_over)
	
	scoreLabel.text = "Score\n" + str(score)
	
	for i in 5:
		create_body()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_timer_timeout():
	head.move_snake()
	move_body()
	
func on_apple_eaten():
	score += 1
	scoreLabel.text = "Score\n" + str(score)
	create_apple()
	create_body()
	
func on_game_over():
	if game_try > 0:
		timer.stop()
		game_over.visible = true
	game_try += 1
	
func create_apple():
	var random_x = randi_range(1, 16)
	var random_y = randi_range(1, 31)
	
	var apple = APPLE.instantiate()
	
	apple.position.x = random_x * 16
	apple.position.y = random_y * -16
	
	apples.call_deferred("add_child", apple)
	
func create_body():
	var body = BODY.instantiate()
	
	body.position = snake.get_children().pop_back().position
	
	for selected_body in snake.get_children():
		selected_body.z_index += 1
	
	snake.call_deferred("add_child", body)
	
func move_body():
	if snake.get_child_count() > 1:
		var body_positions = get_body_positions()		
		for body_index in snake.get_child_count():
			var selected_body = snake.get_child(body_index)
			if selected_body is Body:
				selected_body.position = body_positions[body_index-1]
				selected_body.set_collision_mask_value(2, true)

func get_body_positions():
	var snake_body: Array = snake.get_children()
	var body_positions: Array
	for body in snake_body:
		body_positions.append(body.position)
	return body_positions
