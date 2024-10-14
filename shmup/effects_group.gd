extends Node2D

@onready var lose_sfx: AudioStreamPlayer = $LoserSoundEffects
@onready var bgm: AudioStreamPlayer = $"NatsukoNaitou-BestialBeat(boss)[mushihimesamaFutariOst]"
@onready var player: CharacterBody2D = get_tree().get_first_node_in_group("character")


var lose_played = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if player.hp <= 0:
		if not lose_played: 
			lose_sfx.play()
		lose_played = true
		bgm.stop()
	
