class_name ProgressionData
extends Resource

signal coins_changed(new_amount: int)

@export var _coins: int = 0:
    get:
        return _coins
    set(value):
        if value != _coins:
            _coins = value
            coins_changed.emit(_coins)
        
func add_coins(amount: int) -> void:
    _coins += amount

func remove_coins(amount: int) -> void:
    _coins -= amount

func spend_coins(amount: int) -> bool:
    if amount <= 0:
        return false
    if amount <= _coins:
        _coins -= amount
        return true
    return false