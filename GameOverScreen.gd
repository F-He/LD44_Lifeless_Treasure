extends Node2D


func _ready():
	HUD.hide_all()
	Sounds.play_menu_music()
	PlayerVariables.reset()
	Sounds.play_arena_music(false)
	Sounds.play_shop_music(false)

func _on_TextureButton_pressed():
	Sounds.play_button_click_sound()
	Global.switch_scene_to("res://scenes/levels/MainMenu.tscn")

func _on_TextureButton_mouse_entered():
	$ButtonHoverSound.play()