extends Node

var game_over_timer

# Called when the node enters the scene tree for the first time.
func _ready():
	EventBus.listen("player_dead", self, "on_Player_dead")

func on_Player_dead(data):
	print("on player death")
	var player = data.player
	game_over_timer = Timer.new()
	game_over_timer.start(1.5)
	game_over_timer.connect("timeout", self, "_on_wait_over")
	add_child(game_over_timer)
	
func _on_wait_over():
	remove_child(game_over_timer)
	game_over()

func game_over():
	print("game over")
	$InterfaceLayer/GameOver.show()

func _on_Music_finished():
	$Sounds/Music.play()
