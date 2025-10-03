extends CharacterBody2D

@export var type : String

var speed = 150

var health
var max_health
var shield
var xp
var coins


func _ready():
	pass

	
func _physics_process(delta):	
	var direction = Input.get_vector("Left","Right","Up","Down")
	velocity = direction * speed
	move_and_collide(velocity * delta)
	

##func update_data():
	##health = PlayerManager.health
	##max_health = PlayerManager.max_health
	##shield = PlayerManager.shield
	##xp = PlayerManager.xp
	##coins = PlayerManager.coins


func get_body_data(body):
	EnemyManager.type = body.get("type")
	EnemyManager.health = body.get("health")
	EnemyManager.health_increase = body.get("health_increase")
	EnemyManager.max_health = body.get("max_health")
	EnemyManager.shield = body.get("shield")
	EnemyManager.shield_increase = body.get("shield_increase")
	EnemyManager.damage = body.get("damage")
	EnemyManager.coin_worth = body.get("coin_worth")
	EnemyManager.action_delay = body.get("action_delay")
	EnemyManager.match_to_action = body.get("match_to_action")
	EnemyManager.blood_type = body.get("blood_type")
	EnemyManager.print_test()

func _on_enemy_detection_radius_body_entered(body):
	if body.is_in_group("enemies"):
		get_body_data(body)
		LevelManager.switch_to_game_window()
	
