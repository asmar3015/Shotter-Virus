extends Sprite

var speed = 150
var velocity = Vector2()
var dead = false
#export var bullet_speed = 1000
#export var rate_bullet = 0.2
var Reload_speed = 0.1
var default_reload_speed = Reload_speed
var Power_up_reset = [] 

var damage = 1
var default_damage = damage

var can_shot = true
var bullet = preload("res://scene/Bullet.tscn")

func _ready():
	Global.player = self

func _exit_tree():
	Global.player = null 

func _process(delta):
	velocity.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left"))
	velocity.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	
	velocity = velocity.normalized()
	
	global_position.x = clamp(global_position.x, 24, 615)
	global_position.y = clamp(global_position.y, 24, 300)
	
	if dead == false :
		global_position += speed * velocity * delta
	
	if Input.is_action_pressed("klik") and Global.node_creation_parent != null and can_shot and dead == false:
		var bullet_instance = Global.instance_node(bullet, global_position, Global.node_creation_parent)
		bullet_instance.damage = damage
		$Reload_speed.start()
		can_shot = false

func _on_Reload_speed_timeout():
	can_shot = true
	$Reload_speed.wait_time = Reload_speed
	pass # Replace with function body.

func _on_hitbox_area_entered(area):
	if area. is_in_group("Enemy"):
		dead = true
		visible = false
		Global.save_game()
		yield(get_tree().create_timer(1), "timeout")
		get_tree().reload_current_scene()
	pass # Replace with function body.

func _on_Power_up_timeout():
	if Power_up_reset.find("Power_up_reload") != null:
		Reload_speed = default_reload_speed
		Power_up_reset.erase("Power_up_reload")
	elif Power_up_reset.find("Power_up_damager") != null:
		damage = default_damage
		Power_up_reset.erase("Power_up_damager")
	pass # Replace with function body.
