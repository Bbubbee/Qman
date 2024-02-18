extends Node

var states: Dictionary = {}
var current_state: State 

@export var initial_state : State

	
## Readies the state machine. 
func _ready(): 
	# Prepares all states. 
	for child in get_children(): 
		if child is State: 
			states[child.name.to_lower()] = child
			child.transition.connect(on_child_transition)


## Call this in the actor of the state machine. 
## Connects the actor to the states. Sets inital state. 
func init(actor):
	for child in get_children(): 
		if child is State: 
			child.actor = actor
	
	# Sets initial state. 
	if initial_state: 
		current_state = initial_state
		current_state.enter()

				
func _process(delta: float) -> void:
	if current_state: current_state.process(delta)
		
		
func _physics_process(delta: float) -> void:
	if current_state: current_state.physics_process(delta)


func _input(event: InputEvent) -> void:
	if current_state: current_state.on_input(event) 


## State transition. 
## Note: You can't change states from the enter function! 
func on_child_transition(state: State, new_state_name: String) -> void: 
	#print(str(state)+" -> "+new_state_name)
	if state != current_state: return
			
	var new_state = states.get(new_state_name.to_lower())
	if not new_state: return
	
	if current_state: current_state.exit()
	
	new_state.enter()
	
	current_state = new_state
