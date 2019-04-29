extends Node2D


func _ready():
	HUD.hide_all()
	if !Sounds.is_menu_music_playing():
		Sounds.play_menu_music()

func _process(delta):
	$Path2D/PathFollow2D.set_offset($Path2D/PathFollow2D.get_offset() + 20 * delta)
	
	if $Path2D/PathFollow2D.get_offset() >= 2471:
		$Path2D/PathFollow2D.set_offset(0)

func _on_Start_pressed():
	Sounds.play_button_click_sound()
	Sounds.play_menu_music(false)
	Global.switch_scene_to("res://scenes/levels/ShopArea.tscn")


func _on_Controls_pressed():
	Sounds.play_button_click_sound()
	Global.switch_scene_to("res://scenes/levels/ControlsMenu.tscn")


func _on_Quit_pressed():
	Sounds.play_button_click_sound()
	get_tree().quit()


func _on_button_mouse_entered():
	$ButtonHoverSound.play()

func _on_LinkButton_pressed():
	OS.shell_open("https://twitter.com/grewoss")