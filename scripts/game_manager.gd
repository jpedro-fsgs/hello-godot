extends Node

var coins = 0
@onready var coins_label: Label = $"../Player/Camera2D/CoinsLabel"

@onready var coin_audio: AudioStreamPlayer2D = $CoinAudio

func add_coin():
	coins += 1
	coins_label.text = str(coins)
	if coins == 33:
		coins_label.text = "Você Venceu"
	coin_audio.play()
