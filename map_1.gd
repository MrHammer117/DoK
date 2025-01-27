extends Node2D

var current_wave: int
@export var elf_scene: PackedScene
var moving_to_next_wave: bool

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	current_wave = 0
	spawnEnemies()
	$"ActiveMineWorkers,NoVoice,Boulders,DwarvesAmbience1Hour#dnd".play()
	
func spawnEnemies():
	_rounds_survived()
	var spawnpoints = [$Spawner1,$Spawner2,$Spawner3,$Spawner4,$Spawner5,$Spawner6,$Spawner7]
	for spawnpoint in spawnpoints:
		var enemy = elf_scene.instantiate()
		enemy.position = Vector2(spawnpoint.position)
		add_child(enemy)
	await get_tree().create_timer(30.0).timeout
	spawnBoys()
	
func spawnBoys():
	while current_wave <= 5:
		var spawnpoints = [$Spawner1,$Spawner2,$Spawner3,$Spawner4,$Spawner5,$Spawner6,$Spawner7]
		for spawnpoint in spawnpoints:
			var enemy = elf_scene.instantiate()
			enemy.position = Vector2(spawnpoint.position)
			$"MAP/Energy-90321".play()
			add_child(enemy)
		await get_tree().create_timer(30.0).timeout
		current_wave += 1
		_rounds_survived()
		
	while current_wave > 5 and current_wave <= 14:
		var spawnpoints = [$Spawner1,$Spawner2,$Spawner3,$Spawner4,$Spawner5,$Spawner6,$Spawner7,$Spawner8,$Spawner9,$Spawner10,$Spawner11,$Spawner12,$Spawner13,$Spawner14,$Spawner15]
		for spawnpoint in spawnpoints:
			var enemy = elf_scene.instantiate()
			enemy.position = Vector2(spawnpoint.position)
			$"MAP/Energy-90321".play()
			add_child(enemy)
		await get_tree().create_timer(30.0).timeout
		current_wave +=1
		_rounds_survived()
	if current_wave == 15:
		get_tree().paused = false
		get_tree().change_scene_to_file("res://Menus/YOU WIN!.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	
func _rounds_survived():
	$Player/CanvasLayer/RoundsSurvived.text = "Round: %d" % (current_wave+1)
