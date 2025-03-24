extends Node2D
@export var cat_scene : PackedScene # 匯出變數，用於在編輯器中指定貓咪場景

@onready var timer_label = $"UI/Tomato Time" # 取得 TimerLabel 節點
@onready var start_button = $"UI/Start Btn"   # 取得 StartButton 節點
@onready var reset_button = $"UI/Reset Btn"   # 取得 ResetButton 節點

var work_time_minutes = 1 # 工作時間 (分鐘)
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
		timer_seconds -= delta

		if timer_seconds <= 0:
			timer_seconds = 0
			timer_running = false
			print("番茄鐘時間到！")
			spawn_cat() # 呼叫生成貓咪的函式 (下一步驟建立)
			# 在這裡可以加入時間結束後的其他邏輯，例如播放音效、顯示提示等等

		update_timer_label()
		
func spawn_cat():
	print("貓咪已生成!")
	if cat_scene: # 檢查是否已在編輯器中指定貓咪場景
		var cat_instance = cat_scene.instantiate() # 實例化貓咪場景 (建立貓咪場景的實例)
		add_child(cat_instance) # 將貓咪實例加入到 Main 場景中，成為 Main 節點的子節點
		cat_instance.position = Vector2(get_viewport_rect().size.x / 2, get_viewport_rect().size.y - 150) # 設定貓咪在畫面中的位置 (畫面底部中央偏上)
	else:
		print("貓咪場景未指定！請在 Main 節點的 Inspector 面板中指定貓咪場景 (.tscn 檔案)。")



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
