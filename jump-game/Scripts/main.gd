extends Node2D

var cactus = preload("res://Scenes/Cactus.tscn")
var obstacles : Array

const DINO_START_POS := Vector2i(318, 500)
var speed : float
var score : int
const START_SPEED : float = 10
const MAX_SPEED : int = 25
const SPEED_MODIFIER : int = 500
var screen_size : Vector2i
var game_running : bool
var last_obs

# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_window().size

func new_game():
	game_running = false
	score = 0
	show_score()
	$Dino.position.x = DINO_START_POS
	
		

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if game_running:
		speed = START_SPEED + score / SPEED_MODIFIER
		$Dino.position.x += speed
		$Camera2D.position.x += speed
		score += speed / 10
		show_score()
	
		generate_obstacle()
	
		if $Camera2D.position.x - $Ground.position.x > screen_size.x * 1.5:
			$Ground.position.x += screen_size.x
	else:
		if Input.is_action_pressed("jump"):
			$Score.get_node("StartLabel").text = " "
			game_running = true
	
func show_score() :
	$Score.get_node("ScoreLabel").text = "SCORE: " + str(score)
	
func generate_obstacle():
	if obstacles.is_empty() or last_obs.position.x < $Camera2D.position.x + randi_range(30, 300):
		var obs = cactus.instantiate()
		var obs_x = $Camera2D.position.x + screen_size.x - 100
		var obs_y : int = 513
		create_obs(obs, obs_x, obs_y)
		last_obs = obs
		
func create_obs(obs,x, y):
	obs.position = Vector2i(x, y)
	obs.body_entered.connect(hit_obs)
	add_child(obs)
	obstacles.append(obs)  
	
func hit_obs(body):
	if body.name == "Dino":
		print("collision")
		get_tree().paused = true
		game_running = false
	
