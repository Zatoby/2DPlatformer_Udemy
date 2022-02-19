extends Node

var playerScene = preload("res://scenes/Player.tscn")
var spawnPosition = Vector2.ZERO
var currentPlayerNode = null

func _ready():
	spawnPosition = $Player.global_position
	register_player($Player)
	
	
func register_player(player):
	currentPlayerNode = player
	# [] -> placeholder
	# CONNECT_DEFERRED -> flag to avoid errors
	currentPlayerNode.connect("died", self, "on_player_died", [], CONNECT_DEFERRED)
	
func create_player():
	var playerInstance = playerScene.instance()
	# keep node position in node tree
	add_child_below_node(currentPlayerNode, playerInstance)
	playerInstance.global_position = spawnPosition
	register_player(playerInstance)
	
func on_player_died():
	currentPlayerNode.queue_free()
	create_player()
