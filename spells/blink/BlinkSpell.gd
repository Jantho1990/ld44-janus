extends "res://spells/Spell.gd"

func effect():
	.effect()
	var player = Spellcaster.Caster
	var direction = player.direction
	
	var space_state = get_world_2d().direct_space_state
	var result = space_state.intersect_ray(position, Vector2(0, 0), [self])
	
	if result:
		pass