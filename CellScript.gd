extends Node2D

var rb

func _ready():
	rb = get_node("RigidBody2D")


# cell setters
func setPosition(x,y):
	position = Vector2(x,y)

func setVelocity(x, y):
	rb.linear_velocity = Vector2(x,y)
	
func setAngularVelocity(av):
	rb.angular_velocity = av
	
	