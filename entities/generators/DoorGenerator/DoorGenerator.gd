extends "res://entities/generators/EntityGenerator/EntityGenerator.gd"

class_name DoorGenerator

# What is the minimum amount of doors we should spawn?
export(int) var lower_bound = 3

# What is the maximum amount of doors we should spawn?
export(int) var upper_bound = 5