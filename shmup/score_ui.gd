extends RichTextLabel

@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("character")

func _process(delta: float) -> void:
	text = "Score: " + str(player.score)
