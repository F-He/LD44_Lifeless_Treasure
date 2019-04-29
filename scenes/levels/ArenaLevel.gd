extends Node2D

var slime_boss = preload("res://scenes/entities/SlimeBoss.tscn")
var slime_minion = preload("res://scenes/entities/SlimeMinion.tscn")
var insect = preload("res://scenes/entities/Insect.tscn")
var larry = preload("res://scenes/entities/Larry.tscn")

onready var spawn_points = [
	$SpawnPoints/SpawnPoint01.position, $SpawnPoints/SpawnPoint02.position, $SpawnPoints/SpawnPoint03.position, $SpawnPoints/SpawnPoint04.position,
	$SpawnPoints/SpawnPoint05.position, $SpawnPoints/SpawnPoint06.position, $SpawnPoints/SpawnPoint07.position, $SpawnPoints/SpawnPoint08.position,
	$SpawnPoints/SpawnPoint09.position, $SpawnPoints/SpawnPoint10.position, $SpawnPoints/SpawnPoint11.position, $SpawnPoints/SpawnPoint12.position,
	$SpawnPoints/SpawnPoint13.position, $SpawnPoints/SpawnPoint14.position, $SpawnPoints/SpawnPoint15.position, $SpawnPoints/SpawnPoint16.position,
	$SpawnPoints/SpawnPoint17.position, $SpawnPoints/SpawnPoint18.position, $SpawnPoints/SpawnPoint19.position, $SpawnPoints/SpawnPoint20.position
	]

enum Rounds{
	one,
	two,
	three,
	four,
	five,
	six,
	seven,
	eight,
	none
}

var current_round = Rounds.none

func _ready():
	Sounds.play_arena_music()
	$RoundCountdown.start()
	HUD.show_enemies_left(true)

func _process(delta):
	HUD.update_enemies_left($EnemyContainer.get_child_count())
	if $RoundCountdown.time_left > 0:
		HUD.set_round_countdown_text("Round begins in %s" % int($RoundCountdown.time_left))
	if $EnemyContainer.get_child_count() == 0 and $RoundCountdown.is_stopped():
		$RoundCountdown.start()

func round_one():
	current_round = Rounds.one
	for i in range(8):
		spawn_entity(insect, spawn_points[randi() % spawn_points.size()])
#	spawn_entity(slime_boss, $SpawnPoints/BossSpawnPoint.position)

func round_two():
	current_round = Rounds.two
	for i in range(4):
		spawn_entity(slime_minion, spawn_points[randi() % spawn_points.size()])
	for i in range(8):
		spawn_entity(insect, spawn_points[randi() % spawn_points.size()])

func round_three():
	current_round = Rounds.three
	for i in range(4):
		spawn_entity(slime_minion, spawn_points[randi() % spawn_points.size()])
	for i in range(8):
		spawn_entity(insect, spawn_points[randi() % spawn_points.size()])
	for i in range(1):
		spawn_entity(larry, spawn_points[randi() % spawn_points.size()])

func round_four():
	current_round = Rounds.four
	spawn_entity(slime_boss, $SpawnPoints/BossSpawnPoint.position)

func round_five():
	current_round = Rounds.five
	for i in range(4):
		spawn_entity(slime_minion, spawn_points[randi() % spawn_points.size()])
	for i in range(4):
		spawn_entity(insect, spawn_points[randi() % spawn_points.size()])
	for i in range(2):
		spawn_entity(larry, spawn_points[randi() % spawn_points.size()])

func round_six():
	current_round = Rounds.six
	for i in range(6):
		spawn_entity(slime_minion, spawn_points[randi() % spawn_points.size()])
	for i in range(4):
		spawn_entity(insect, spawn_points[randi() % spawn_points.size()])
	for i in range(3):
		spawn_entity(larry, spawn_points[randi() % spawn_points.size()])

func round_seven():
	current_round = Rounds.seven
	for i in range(6):
		spawn_entity(slime_minion, spawn_points[randi() % spawn_points.size()])
	for i in range(4):
		spawn_entity(insect, spawn_points[randi() % spawn_points.size()])
	for i in range(4):
		spawn_entity(larry, spawn_points[randi() % spawn_points.size()])

func round_eight():
	current_round = Rounds.eight
	spawn_entity(slime_boss, $SpawnPoints/BossSpawnPoint.position)
	for i in range(6):
		spawn_entity(slime_minion, spawn_points[randi() % spawn_points.size()])
	for i in range(4):
		spawn_entity(insect, spawn_points[randi() % spawn_points.size()])
	for i in range(4):
		spawn_entity(larry, spawn_points[randi() % spawn_points.size()])

func spawn_entity(entity, position):
	var entity_instance = entity.instance()
	entity_instance.position = position
	$EnemyContainer.add_child(entity_instance)

func _on_RoundCountdown_timeout():
	HUD.round_countdown_visible(false)
	match current_round:
		Rounds.one:
			round_two()
		Rounds.two:
			round_three()
		Rounds.three:
			round_four()
		Rounds.four:
			round_five()
		Rounds.five:
			round_six()
		Rounds.six:
			round_seven()
		Rounds.seven:
			round_eight()
		Rounds.eight:
			Global.switch_scene_to("res://scenes/levels/WonScreen.tscn")
		Rounds.none:
			round_four()
#			round_one()