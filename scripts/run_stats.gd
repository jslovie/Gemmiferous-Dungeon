extends Node

var timer := Timer.new()
var run_timer: String = "00:00"

var time_in_secs: int = 0
var total_time_in_secs: int = 0

var score: int = 0
var score_text: String = "00000000"
const SCORE_DIGITS: int = 8



func _ready():
	process_mode = Node.PROCESS_MODE_ALWAYS
	timer_setup()

## Start tracking run stats
func start_run():
	timer_start()
	update_score()
	
## End tracking run stats
func end_run():
	timer_stop()
	timer_reset()
	score_reset()

func timer_setup():
	add_child(timer)
	timer.wait_time = 1
	timer.autostart = false
	timer.one_shot = false
	timer.timeout.connect(_on_timer_timeout)

func timer_reset():
	timer.wait_time = 1
	run_timer = "00:00"
	time_in_secs = 0
	total_time_in_secs = 0

func timer_start():
	timer.start()

func timer_stop():
	timer.stop()
	
func _on_timer_timeout():
	total_time_in_secs += 1
	var m = int(total_time_in_secs / 60.0)
	var s = total_time_in_secs - m * 60
	
	run_timer = '%02d:%02d' % [m, s]

func add_score(value: int):
	score += value
	update_score()

func update_score():
	score_text = str(score).pad_zeros(SCORE_DIGITS)

func score_reset():
	score = 0
	score_text = "00000000"
