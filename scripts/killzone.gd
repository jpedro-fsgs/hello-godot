extends Area2D

@onready var death_audio: AudioStreamPlayer2D = $DeathAudio
@onready var timer: Timer = $Timer

func _on_body_entered(body: Node2D) -> void:
	Engine.time_scale = 1.5
	body.die()
	death_audio.play()
	timer.start()


func _on_timer_timeout() -> void:
	Engine.time_scale = 1
	get_tree().reload_current_scene()
