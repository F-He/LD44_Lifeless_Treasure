extends TextureButton


func _on_Quit_button_down():
	$Label.rect_position.y += 5


func _on_Quit_button_up():
	$Label.rect_position.y -= 5