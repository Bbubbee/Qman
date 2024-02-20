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


"""
	What's my problem?
		How do I signal the damaged state that the player has taken damage? 
		
	Possible solutions. 
		Have a variable called take_damage. Set it to true when HealthComponent loses health.
		Check if its true within the states. If it is, go to damaged state. 
		PROBLEM: 
			What if I want to pass an AttackComponent? I want to access the variables within an attack
			component like knockback etc. 
			
			I could change the variable to getting_attacked : AttackComponent.
			Then if it's true (if it exists) go to the attacked state. You have access to the attack
			in actor. 
"""
	
