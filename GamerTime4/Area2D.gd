extends Area2D

export (int) var speed
export (float) var lifetime

var velocity = Vector2()

func start(_position, _direction):
	position = _position
	rotation = _direction.angle()
	$LifeTime.wait_time = lifetime
	velocity = _direction * speed

func _process(delta):
	position += velocity * delta

func explode():
	queue_free()

func _on_Bullet_body_entered(body):
	explode()

func _on_LifeTime_timeout():
	explode()
