extends KinematicBody2D

signal shoot

export (PackedScene) var Bullet
export (int) var GRAVITY
export (int) var SPEED
export (int) var JUMP_HEIGHT
export (float) var ACCELERATION 
export (float) var GUN_COOLDOWN

var motion = Vector2() 
var can_shoot = true
var alive = true
var asdad = Vector2()
var bounce = 0

func _ready():
	$GunTimer.wait_time = GUN_COOLDOWN

func _physics_process(delta):
	motion.y += GRAVITY * ACCELERATION
	$Gun.look_at(get_global_mouse_position())

	if Input.is_action_just_pressed("left_click"):
		if can_shoot:
			can_shoot = false
			$GunTimer.start()
			var dir = Vector2(1, 0).rotated($Gun.global_rotation)
			emit_signal('shoot', Bullet, $Gun/Muzzle.global_position, dir)
			motion.x += -dir.x * SPEED
			motion.y = -dir.y * JUMP_HEIGHT
			bounce = motion.x
			
	if is_on_floor():
		friction(10, 40)
	else:
		friction(2, 1.5)
		
	if is_on_wall():
		motion.x = -bounce * 0.6
		bounce = motion.x
		
	motion = move_and_slide(motion, Vector2(0, -1))
	

func _on_GunTimer_timeout():
	can_shoot = true	

func friction(decrease, zone):
	if motion.x > 0:
		motion.x -= decrease
		bounce -= decrease
	if motion.x < 0:
		motion.x += decrease
		bounce += decrease
	if motion.x >= -zone && motion.x <= zone:
		motion.x = 0