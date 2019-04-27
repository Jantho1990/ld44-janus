extends Node

###
# Various helper functions
###

# Filter an array by a funcref.
func array_filter(arr, function):
	var ret = []
	for ent in arr:
		if function.call_func(ent) == true:
			ret.push_back(ent)
	return ret

# Find an array item by a funcref
func array_find(arr, function):
	for ent in arr:
		if function.call_func(ent) == true:
			return ent
	return null