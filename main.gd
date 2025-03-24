extends Node2D

@onready var timer_label = $"UI/Tomato Time" # 取得 TimerLabel 節點
@onready var start_button = $"UI/Start Btn"   # 取得 StartButton 節點
@onready var reset_button = $"UI/Reset Btn"   # 取得 ResetButton 節點

var work_time_minutes = 25 # 工作時間 (分鐘)
var break_time_minutes = 5  # 休息時間 (分鐘)  (目前暫時用不到，先設定好)
var timer_seconds # 剩餘時間 (秒)
var timer_running = false # 計時器是否正在運行

func _ready():
	timer_seconds = work_time_minutes * 60 # 初始化工作時間 (分鐘轉秒)
	update_timer_label() # 更新 TimerLabel 顯示初始時間
	start_button.text = "開始" # 設定開始按鈕文字
	reset_button.text = "重置" # 設定重置按鈕文字

	# 連接按鈕的按下訊號到對應的函式
	start_button.pressed.connect(_on_start_button_pressed)
	reset_button.pressed.connect(_on_reset_button_pressed)

func _process(delta):
	if timer_running:
		timer_seconds -= delta # 每一幀減少時間 (delta 是一幀的時間間隔)

		if timer_seconds <= 0:
			timer_seconds = 0 # 防止時間變成負數
			timer_running = false # 時間到，停止計時器
			print("番茄鐘時間到！") # 在 console 顯示時間到的訊息 (之後可以改成更明顯的提示)

		update_timer_label() # 更新 TimerLabel 顯示即時時間

func update_timer_label():
	var minutes = int(timer_seconds / 60) # 計算分鐘
	var seconds = int(timer_seconds) % 60 # 計算秒數
	timer_label.text = "%02d:%02d" % [minutes, seconds] # 格式化時間顯示 (MM:SS)

func _on_start_button_pressed():
	timer_running = !timer_running # 切換計時器運行狀態 (true <-> false)
	if timer_running:
		start_button.text = "暫停" # 計時器運行中，按鈕顯示 "暫停"
	else:
		start_button.text = "開始" # 計時器暫停，按鈕顯示 "開始"

func _on_reset_button_pressed():
	timer_seconds = work_time_minutes * 60 # 重置時間
	timer_running = false # 停止計時器
	start_button.text = "開始" # 重置後，開始按鈕顯示 "開始"
	update_timer_label() # 更新 TimerLabel 顯示重置後的時間
