class_name PIDController extends RefCounted

var _proportional_factor: float
var _integral_factor: float
var _derivative_factor: float

var _integral := 0.0
var _derivative := 0.0
var _last_error := 0.0

func _init(kp: float = 1.0, ki: float = 1.0, kd: float = 1.0) -> void:
	_proportional_factor = kp
	_integral_factor = ki
	_derivative_factor = kd

func get_output(error: float, delta: float) -> float:
	_integral += error * delta
	_derivative = (error - _last_error) / delta
	_last_error = error
	return (error * _proportional_factor) + (_integral * _integral_factor) + (_derivative * _derivative_factor)
