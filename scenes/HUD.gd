extends CanvasLayer

func _ready():
	show_dialog(false)
	
func _process(delta):
	$Node2D/HealthBar.value = PlayerVariables.health
	$Node2D/HealthLabel.text = str(PlayerVariables.health)

func show_dialog(show, text = null):
	if text != null:
		$Node2D/DialogBox/Text.text = text
	$Node2D/DialogBox.visible = show

func _on_TextureButton_pressed():
	show_dialog(false)

func set_round_countdown_text(text):
	round_countdown_visible(true)
	$Node2D/RoundCountdownLabel.text = text

func round_countdown_visible(value):
	$Node2D/RoundCountdownLabel.visible = value

func show_boss_healthbar(value):
	$Node2D/BossHealthBar.visible = value
	$Node2D/BossHealthLabel.visible = value

func change_boss_health_label(text):
	$Node2D/BossHealthLabel.text = text

func change_boss_health_value(value, max_value):
	$Node2D/BossHealthBar.value = (value * 100) / max_value

func show_enemies_left(value):
	$Node2D/EnemiesLeftDisplay.visible = value

func update_enemies_left(enemy_count):
	if enemy_count == 1:
		$Node2D/EnemiesLeftDisplay/Text.text = "%s\nenemy left" % enemy_count
	else:
		$Node2D/EnemiesLeftDisplay/Text.text = "%s\nenemies left" % enemy_count

func hide_all():
	$Node2D.visible = false

func show():
	$Node2D.visible = true