extends Sprite

export(String) var player_variable_modify
export(float) var playe_variable_set
export(float) var Power_up = 2

func _on_Hitbox_area_entered(area):
	if area.is_in_group("Player"):
		area.get_parent().set(player_variable_modify, playe_variable_set)
		area.get_parent().get_node("Power_up"). wait_time = Power_up
		area.get_parent().get_node("Power_up"). start()
		area.get_parent().Power_up_reset.append(name)
		queue_free()
