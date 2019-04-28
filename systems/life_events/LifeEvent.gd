extends Control

###
# Onready Properties
###
onready var text_value = $MarginContainer/CenterContainer/VBoxContainer/TextValue
onready var cost_value = $MarginContainer/CenterContainer/VBoxContainer/MarginContainer/HBoxContainer/CostContainer/CostValue
onready var reward_value = $MarginContainer/CenterContainer/VBoxContainer/MarginContainer/HBoxContainer/RewardContainer/RewardValue

export(int) var cost = 200
export(int) var reward = 1000
export(String) var text = "Your message goes here."

func _ready():
	text_value.text = text
	cost_value.text = String(cost)
	reward_value.text = String(reward)