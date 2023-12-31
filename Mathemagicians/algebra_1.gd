# Algebra1

extends Node

# Camera Variables
var pageSize = 10
var numPages = 3
var pageNum = 1
var correctAnswer

#var questionFile
#var answerFile

var question
var answer
var answerFormat


var currentClicker = []
var currentTimer = []
var currentIcon = []

var upgradeClicker


func _ready():
	# Set up clickers
	$Clicker1/ClickerTitle.text = "Addition" # "Vaporous Potion of Variables"
	_clicker_setup($Clicker1, 1.4, 1, 10, 1.1, 1)
	$Clicker2/ClickerTitle.text = "Subtraction" # "Illusionary Elixir of Inequalities"
	_clicker_setup($Clicker2, 1.5, 10, 50, 1.2, 2)
	$Clicker3/ClickerTitle.text = "Multiplication" # "Unstable Sword of Units"
	_clicker_setup($Clicker3, 1.6, 100, 500, 1.3, 3)
	$Clicker4/ClickerTitle.text = "Division" # "Ghostly Amulet of Graphs"
	_clicker_setup($Clicker4, 1.7, 1000, 5000, 1.4, 4)
	$Clicker5/ClickerTitle.text = "Combined" # "Lit Bomb of Linear Equations"
	_clicker_setup($Clicker5, 1.8, 10000, 10000, 1.4, 10)
	
	# Set up new clickers
	_newclicker_setup($NewClicker2, "Subtraction", 100)
	_newclicker_setup($NewClicker3, "Multiplication", 1000)
	_newclicker_setup($NewClicker4, "Division", 10000)
	_newclicker_setup($NewClicker5, "Combined", 100000)


func _process(delta): # While the scene (Algebra 1) is running
#	# Camera functionality
#	if Input.is_action_pressed("up"): # "page_left" specified in Project Settings -> Input Map
#		$Camera2D.position.y -= pageSize
#		await get_tree().create_timer(0.5).timeout
#	if Input.is_action_pressed("down"):
#		$Camera2D.position.y += pageSize
#		await get_tree().create_timer(0.5).timeout
#
#	$Camera2D.position.y = clamp($Camera2D.position.y, 0, 1280)
	
	if Input.is_action_pressed("click"):
		$ClickSound.play()
	
	if !currentClicker.is_empty():
		$HUD/SpecialClicker.icon = load(currentIcon.front())

func _upgradeQuestion(clickerQuestions, clickerAnswers, case, clicker):
	upgradeClicker = clicker
	if ($HUD.totalMoney - upgradeClicker.upgradePrice) >= 0:
		$UpgradeBackground.show()
		$Question.show()
		$Answer.show()
		$AnswerFormat.show()
		$ExitButton.show()
		
		match(case):
			0: # Addition
				_addition_question()
			1: # Subtraction
				_subtraction_question()
			2: # Multiplication
				_multiplication_question()
			3: # Division
				_division_question()
			4: # Combined
				_combined_question()
			_:
				print("Error in _upgradeQuestion")
		
		$Question.text = question
		correctAnswer = answer
		$AnswerFormat.text = answerFormat
		
#		questionFile = FileAccess.open("res://QuestionBank/Algebra1/" + clickerQuestions + ".txt", FileAccess.READ)
#		answerFile = FileAccess.open("res://QuestionBank/Algebra1/" + clickerAnswers + ".txt", FileAccess.READ)
		
#		var questions = []
#		var answers = []
	
#		while not questionFile.eof_reached():
#			questions.append(questionFile.get_line())
#
#		while not answerFile.eof_reached():
#			answers.append(answerFile.get_line())
#
#		questionFile.close()
#		answerFile.close()
	
#		var index = randi() % (questions.size() - 1)
	
#		$Question.text = questions[index]
#		correctAnswer = answers[index]
	else:
		$UpgradeBackground.show()
		$ExitButton.show()
		$Question.show()
		
		$Question.text = "Not enough money to buy upgrade"

func _on_exit_button_pressed():
	$UpgradeBackground.hide()
	$Question.hide()
	$Answer.hide()
	$ExitButton.hide()
	$Correct.hide()
	$AnswerFormat.hide()
	$Answer.text = ""

func _on_answer_text_submitted(new_text):
	if new_text == correctAnswer:
		if ($HUD.totalMoney - upgradeClicker.upgradePrice) >= 0:
			upgradeClicker.numUpgrades += 1
			$HUD.totalMoney -= upgradeClicker.upgradePrice
			$Correct.show()
			$Answer.hide()

# Clicker 1
func _on_clicker_1_on_upgrade_pressed():
	_upgradeQuestion("Clicker1Questions", "Clicker1Answers", 0, $Clicker1)

func _on_clicker_1_pressed():
	_clicker_function($Clicker1, $Clicker1/ClickerTimer)
	_special_clicker_check($Clicker1, $Clicker1/ClickerTimer, "res://art/VaporVariables.png")

# Clicker 2
func _on_new_clicker_2_pressed(): # Switches NewClicker for Clicker
	_newclicker_function($NewClicker2, $Clicker2)

func _on_clicker_2_on_upgrade_pressed():
	_upgradeQuestion("Clicker2Questions", "Clicker2Answers", 1, $Clicker2)

func _on_clicker_2_pressed():
	_clicker_function($Clicker2, $Clicker2/ClickerTimer)
	_special_clicker_check($Clicker2, $Clicker2/ClickerTimer, "res://art/IllusionInequalities.png")

# Clicker 3
func _on_new_clicker_3_pressed():
	_newclicker_function($NewClicker3, $Clicker3)

func _on_clicker_3_on_upgrade_pressed():
	_upgradeQuestion("Clicker3Questions", "Clicker3Answers", 2, $Clicker3)

func _on_clicker_3_pressed():
	_clicker_function($Clicker3, $Clicker3/ClickerTimer)
	_special_clicker_check($Clicker3, $Clicker3/ClickerTimer, "res://art/UnstableUnits.png")

# Clicker 4
func _on_new_clicker_4_pressed():
	_newclicker_function($NewClicker4, $Clicker4)

func _on_clicker_4_on_upgrade_pressed():
	_upgradeQuestion("Clicker4Questions", "Clicker4Answers", 3, $Clicker4)

func _on_clicker_4_pressed():
	_clicker_function($Clicker4, $Clicker4/ClickerTimer)
	_special_clicker_check($Clicker4, $Clicker4/ClickerTimer, "res://art/GhostlyGraphs.png")

# Clicker 5
func _on_new_clicker_5_pressed():
	_newclicker_function($NewClicker5, $Clicker5)

func _on_clicker_5_on_upgrade_pressed():
	_upgradeQuestion("Clicker5Questions", "Clicker5Answers", 4, $Clicker5)

func _on_clicker_5_pressed():
	_clicker_function($Clicker5, $Clicker5/ClickerTimer)
	_special_clicker_check($Clicker5, $Clicker5/ClickerTimer, "res://art/LitLinear.png")

# More functions
func _clicker_setup(clicker, moneyScale, startMoney, baseUpgradePrice, upgradeScale, timePerClick):
	clicker.moneyScale = moneyScale
	clicker.startMoney = startMoney
	clicker.baseUpgradePrice = baseUpgradePrice
	clicker.upgradePriceScale = upgradeScale
	clicker.timePerClick = timePerClick

func _newclicker_setup(clicker, title, price):
	clicker.title = title
	clicker.price = price

func _clicker_function(clicker, ClickerTimer):
	if ClickerTimer.is_stopped():
		$HUD.totalMoney += clicker.moneyPerClick
		ClickerTimer.start()
		clicker.disabled = true

func _newclicker_function(newclicker, clicker):
	if $HUD.totalMoney >= newclicker.price:
		$HUD.totalMoney -= newclicker.price
		newclicker.hide()
		clicker.show()

func _special_clicker_setup(clicker, timer, icon):
	$HUD/SpecialClicker.show()
	currentIcon.push_front(icon)
	currentClicker.push_front(clicker)
	currentTimer.push_front(timer)
	$HUD/SpecialClicker.icon = load(currentIcon.front())

func _on_hud_special_clicker_pressed():
	print(currentClicker.size())
	_clicker_function(currentClicker.front(), currentTimer.front())
	currentClicker.pop_front()
	currentTimer.pop_front()
	currentIcon.pop_front()
	print(currentClicker.size())
	if !currentClicker.is_empty():
		$HUD/SpecialClicker.icon = load(currentIcon.front())
	else:
		$HUD/SpecialClicker.hide()

func _special_clicker_check(clicker, timer, icon):
	if currentClicker.has(clicker):
		currentClicker.erase(clicker)
		currentClicker.erase(timer)
		currentIcon.erase(icon)
		if currentClicker.is_empty():
			$HUD/SpecialClicker.hide()

func _addition_question():
	var randNum = randi() % 6
	match (randNum):
		0:
			var int1 = (randi() % 9) + 1
			var int2 = (randi() % 9) + 1
			question = str(int1) + " + " + str(int2) + " = ?"
			answer = str(int1 + int2)
			answerFormat = "Answer Format: #"
		1:
			var int1 = (randi() % 99) + 1
			var int2 = (randi() % 99) + 1
			question = str(int1) + " + " + str(int2) + " = ?"
			answer = str(int1 + int2)
			answerFormat = "Answer Format: #"
		2:
			var int1 = (randi() % 99) + 1
			var int2 = ((randi() % 9) + 1) * 10
			question = str(int1) + " + " + str(int2) + " = ?"
			answer = str(int1 + int2)
			answerFormat = "Answer Format: #"
		3:
			var int1 = ((randi() % 99) + 1) * 10
			var int2 = ((randi() % 99) + 1) * 10
			question = str(int1) + " + " + str(int2) + " = ?"
			answer = str(int1 + int2)
			answerFormat = "Answer Format: #"
		4:
			var int1 = (randi() % 10)
			var int2 = (randi() % 10)
			question = str(int1) + " + " + str(int2) + " = ?"
			answer = str(int1 + int2)
			answerFormat = "Answer Format: #"
		5: 
			var num1 = (randi() % 9) + 1
			var num2 = (randi() % 9) + 1
			var den
			if (num1 > num2):
				den = (randi() % (11 - num1)) + num1
			else:
				den = (randi() % (11 - num2)) + num2
			
			question = str(num1) + "/" + str(den) + " + " + str(num2) + "/" + str(den) + " = ?"
			answer = str(num1+num2) + "/" + str(den)
			answerFormat = "AnswerFormat: #/#"
		_:
			print("Error in _addition_question")

func _subtraction_question():
	var randNum = randi() % 6
	match (randNum):
		0:
			var int1 = (randi() % 9) + 1
			var int2 = (randi() % 9) + 1
			var bigNum
			var smallNum
			if (int1 > int2):
				bigNum = int1
				smallNum = int2
			else:
				bigNum = int2
				smallNum = int1
			question = str(bigNum) + " - " + str(smallNum) + " = ?"
			answer = str(bigNum-smallNum)
			answerFormat = "Answer Format: #"
		1:
			var int1 = (randi() % 99) + 1
			var int2 = (randi() % 99) + 1
			var bigNum
			var smallNum
			if (int1 > int2):
				bigNum = int1
				smallNum = int2
			else:
				bigNum = int2
				smallNum = int1
			question = str(bigNum) + " - " + str(smallNum) + " = ?"
			answer = str(bigNum-smallNum)
			answerFormat = "Answer Format: #"
		2:
			var int1 = (randi() % 99) + 1
			var int2 = ((randi() % 9) + 1) * 10
			var bigNum
			var smallNum
			if (int1 > int2):
				bigNum = int1
				smallNum = int2
			else:
				bigNum = int2
				smallNum = int1
			question = str(bigNum) + " - " + str(smallNum) + " = ?"
			answer = str(bigNum-smallNum)
			answerFormat = "Answer Format: #"
		3:
			var int1 = ((randi() % 99) + 1) * 10
			var int2 = ((randi() % 99) + 1) * 10
			var bigNum
			var smallNum
			if (int1 > int2):
				bigNum = int1
				smallNum = int2
			else:
				bigNum = int2
				smallNum = int1
			question = str(bigNum) + " - " + str(smallNum) + " = ?"
			answer = str(bigNum-smallNum)
			answerFormat = "Answer Format: #"
		4:
			var int1 = (randi() % 10)
			var int2 = (randi() % 10)
			var bigNum
			var smallNum
			if (int1 > int2):
				bigNum = int1
				smallNum = int2
			else:
				bigNum = int2
				smallNum = int1
			question = str(bigNum) + " - " + str(smallNum) + " = ?"
			answer = str(bigNum-smallNum)
			answerFormat = "Answer Format: #"
		5: 
			var num1 = (randi() % 9) + 1
			var num2 = (randi() % 9) + 1
			var bigNum
			var smallNum
			var den
			if (num1 > num2):
				den = (randi() % (11 - num1)) + num1
				bigNum = num1
				smallNum = num2
			else:
				den = (randi() % (11 - num2)) + num2
				bigNum = num2
				smallNum = num1
			
			question = str(bigNum) + "/" + str(den) + " - " + str(smallNum) + "/" + str(den) + " = ?"
			answer = str(bigNum-smallNum) + "/" + str(den)
			answerFormat = "AnswerFormat: #/#"
		_:
			print("Error in _subtraction_question")

func _multiplication_question():
	var randNum = randi() % 4
	match (randNum):
		0:
			var int1 = (randi() % 12) + 1
			var int2 = (randi() % 12) + 1
			question = str(int1) + " * " + str(int2) + " = ?"
			answer = str(int1 * int2)
			answerFormat = "Answer Format: #"
		1:
			var int1 = (randi() % 12) + 1
			var int2 = 10
			question = str(int1) + " * " + str(int2) + " = ?"
			answer = str(int1 * int2)
			answerFormat = "Answer Format: #"
		2:
			var int1 = (randi() % 12) + 1
			var int2 = 100
			question = str(int1) + " * " + str(int2) + " = ?"
			answer = str(int1 * int2)
			answerFormat = "Answer Format: #"
		3:
			var int1 = (randi() % 12) + 1
			var int2 = 0
			question = str(int1) + " * " + str(int2) + " = ?"
			answer = str(int1 * int2)
			answerFormat = "Answer Format: #"
		_:
			print("Error in _multiplication_question")

func _division_question():
	var randNum = randi() % 2
	match (randNum):
		0:
			var int1 = (randi() % 9) + 1
			var int2 = (randi() % 9) + 1
			# var int3 = int1 * int2
			question = str(int1 * int2) + " / " + str(int1) + " = ?"
			answer = str(int2)
			answerFormat = "Answer Format: #"
		1:
			var int1 = (randi() % 9) + 1
			var int2 = ((randi() % 9) + 1) * 100
			# var int3 = int1 * int2
			question = str(int1 * int2) + " / " + str(int1) + " = ?"
			answer = str(int2)
			answerFormat = "Answer Format: #"
		_:
			print("Error in _division_question")

func _combined_question():
	var randNum = randi() % 5
	match (randNum):
		0:
			var int1 = (randi() % 9) + 1
			var int2 = (randi() % 9) + 1
			var int3 = (randi() % 9) + 1
			var int4 = (randi() % 9) + 1
			var bigNum
			var smallNum
			if (int3 > int4):
				bigNum = int3
				smallNum = int4
			else:
				bigNum = int4
				smallNum = int3
			question = "(" + str(int1) + " + " + str(int2) + ")" + " * (" + str(bigNum) + " - " + str(smallNum) + ") = ?"
			answer = str((int1+int2)*(bigNum-smallNum))
			answerFormat = "Answer Format: #"
		1:
			var int1 = (randi() % 9) + 1
			var int2 = (randi() % 7) + 3
			var int3 = (randi() % 7) + 3
			var int4 = (randi() % 3) + 1
			question = str(int1) + " + " + str(int2) + " * " + str(int3) + " - " + str(int4) + " = ?"
			answer = str(int1 + (int2*int3) - int4)
			answerFormat = "Answer Format: #"
		2:
			var int1 = (randi() % 9) + 1
			var int2 = (randi() % 9) + 1
			var int3 = (randi() % 9) + 1
			var int4 = (randi() % 9) + 1
			question = str(int1*int2) + " / " + str(int2) + " + " + str(int3) + " * " + str(int4) + " = ?"
			answer = str(int1 + (int3*int4))
			answerFormat = "Answer Format: #"
		3:
			var int1 = (randi() % 9) + 1
			var int2 = (randi() % 7) + 3
			var int3 = (randi() % 7) + 3
			var int4 = (randi() % 3) + 1
			question = str(int1) + " + (" + str(int2*int3) + " / " + str(int3) + ") - " + str(int4) + " = ?"
			answer = str(int1 + int2 - int4)
			answerFormat = "Answer Format: #"
		4:
			var int1 = ((randi() % 9) + 1) * 10
			var int2 = ((randi() % 9) + 1) * 10
			var int3 = (randi() % 9) + 1
			var int4 = (randi() % 9) + 1
			question = str(int1) + " + " + str(int2) + " - " + str(int3*int4) + " * " + str(int3) + " / " + str(int4) + " = ?"
			answer = str(int1 + int2 - (int3*int3))
			answerFormat = "Answer Format: #"
		_:
			print("Error in _combined_question")

# Timeouts

func _on_clicker_1_clicker_timer_timout():
	$Clicker1.disabled = false
	_special_clicker_setup($Clicker1, $Clicker1/ClickerTimer, "res://art/VaporVariables.png")

func _on_clicker_2_clicker_timer_timout():
	$Clicker2.disabled = false
	_special_clicker_setup($Clicker2, $Clicker2/ClickerTimer, "res://art/IllusionInequalities.png")

func _on_clicker_3_clicker_timer_timout():
	$Clicker3.disabled = false
	_special_clicker_setup($Clicker3, $Clicker3/ClickerTimer, "res://art/UnstableUnits.png")

func _on_clicker_4_clicker_timer_timout():
	$Clicker4.disabled = false
	_special_clicker_setup($Clicker4, $Clicker4/ClickerTimer, "res://art/GhostlyGraphs.png")

func _on_clicker_5_clicker_timer_timout():
	$Clicker5.disabled = false
	_special_clicker_setup($Clicker5, $Clicker5/ClickerTimer, "res://art/LitLinear.png")
