extends Node

enum {DNA_A, DNA_T, DNA_G, DNA_C}

signal pressed_protein(protein)

func _process(delta):
	if Input.is_action_just_pressed("ui_dna_a"):
		emit_signal("pressed_protein", self, DNA_A)
	elif Input.is_action_just_pressed("ui_dna_t"):
		emit_signal("pressed_protein", self, DNA_T)
	elif Input.is_action_just_pressed("ui_dna_g"):
		emit_signal("pressed_protein", self, DNA_G)
	elif Input.is_action_just_pressed("ui_dna_c"):
		emit_signal("pressed_protein", self, DNA_C)
	elif Input.is_key_pressed(KEY_ESCAPE):
		get_tree().change_scene("res://MainMenu.tscn")

