extends Node2D

func _ready():
	play_menu_music()

func play_menu_music(value = true):
	$MenuMusic.playing = value

func is_menu_music_playing():
	return $MenuMusic.is_playing()

func play_shop_music(value = true):
	$ShopMusic.playing = value

func play_arena_music(value = true):
	$ArenaMusic.playing = value


func play_button_click_sound():
	$ButtonClickSound.play()

func play_slime_boss_death_sound():
	$SlimeBossDeathSound.play()

func play_slime_minion_death_sound():
	$SlimeMinionDeathSound.play()

func play_larry_death_sound():
	$LarryDeathSound.play()

func play_insect_death_sound():
	$InsectDeathSound.play()