extends Node2D


func _ready():
	HUD.hide_all()

func _on_TextureButton_pressed():
	Sounds.play_button_click_sound()
	Global.switch_scene_to("res://scenes/levels/MainMenu.tscn")

func _on_TextureButton_mouse_entered():
	$ButtonHoverSound.play()