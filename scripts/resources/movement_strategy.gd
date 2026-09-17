class_name MovementStrategy
extends Resource

@export_group("Movement")
@export var max_speed: float = 200.0
@export var acceleration: float = 500.0
@export var friction: float = 300.0

func calculate_velocity(current_velocity: Vector2, direction: Vector2, delta: float) -> Vector2:
    if direction != Vector2.ZERO:
        var target_velocity = direction.normalized() * max_speed
        return current_velocity.move_toward(target_velocity, acceleration * delta)
    
    return current_velocity.move_toward(Vector2.ZERO, friction * delta)