extends Node
class_name State

signal transition  # Use me to transition states. 

var actor  # Owner of this state. 

## Note: You can't change states in the enter function! 
func enter():
	pass
	
func exit():
	pass
	
func process(_delta: float):
	pass
	
func physics_process(_delta: float):
	pass
	
func on_input(_event: InputEvent): 
	pass
	
