class_name ClockManager extends Node

var has_been_reset = false
var game_start_time: float = 0
var seconds_since_run_start: float = 0.0

var hour: int = 0
var minute: int = 0 
var second: int = 0

signal clock(hour:int, minute:int, second:int)

func _ready() -> void:
	game_start_time = Time.get_unix_time_from_system()

func _process(delta):
	seconds_since_run_start += delta
	set_clock()

func set_clock():
	var unix_seconds :int = game_start_time + seconds_since_run_start + Time.get_time_zone_from_system().get("bias") * 60
	var datetime := Time.get_datetime_dict_from_unix_time(unix_seconds)
	var should_send_update: bool = hour != datetime.get("hour") or minute != datetime.get("minute") or second != datetime.get("second")

	hour = datetime.get("hour")
	minute = datetime.get("minute")
	second = datetime.get("second")
	
	if should_send_update:
		clock.emit(hour, minute, second)


func reset() -> void:
	seconds_since_run_start = 0.0
	set_clock()
