extends Control

onready var progress_bar = $HBoxContainer/ProgressBar

func _ready():
	EventBus.listen("update_ui_life_bar", self, "on_Update_ui_life_bar")

func on_Update_ui_life_bar(data):
	if data.has("current"):
		progress_bar.value = data.current
	
	if data.has("total"):
		progress_bar.max_value = data.total