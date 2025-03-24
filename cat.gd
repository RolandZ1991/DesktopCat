extends Node2D

func _input(event):
	if event is InputEventMouseButton: # 檢查是否為滑鼠按鈕事件
		if event.pressed and event.button_index == MOUSE_BUTTON_LEFT: # 檢查是否為滑鼠左鍵按下
			print("貓咪被點擊了！") # 在 console 顯示訊息 (之後可以改成其他互動)
