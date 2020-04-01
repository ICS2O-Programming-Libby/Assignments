-----------------------------------------------------------------------------------------
-- Title: Math Quiz 
-- Name: Libby Valentino
-- Course: ICS2O/3C
-- This program lets the user play a math game. 
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

--set the background colour
display.setDefault("background", 221/255, 200/255, 228/255)

------------------------------------------------------------------------------------------
--SOUND CREATION 
------------------------------------------------------------------------------------------

--correct sound 
local correctSound = audio.loadSound("Sounds/correct.mp3")
local correctSoundChannel

-- you won sound 
local winSound = audio.loadSound("Sounds/win.mp3")

--wrong sound
local wrongSound = audio.loadSound("Sounds/wrong.mp3")
local wrongSoundChannel

-- game over sound 
local gameOverSound = audio.loadSound("Sounds/gameOver.mp3")
local gameOverSoundChannel

------------------------------------------------------------------------------------------
-- VARIBLE CREATION
------------------------------------------------------------------------------------------

-- create local variables 
local Incorrect 
local questionObject
local correctObject
local NumericTextFields
local randomNumber1
local randomNumber2
local userAnswer
local correctAnswer
local incorrectAnswer
local points = 0
local incorrectPoints = 0
local displayCorrectAnswer
local randomOperator

-- variables for the timer
local totalSeconds = 5
local secondsLeft = 16
local clockText
local countDownTimer

local lives = 3
local heart1
local heart2
local heart3

------------------------------------------------------------------------------------------
-- LOCAL FUNTIONS
------------------------------------------------------------------------------------------

local function UpdateTime()
	-- decrement the number of seconds 
	secondsLeft = secondsLeft - 1
    --print ("secondsLeft : " .. secondsLeft)
	-- display the number of seconds left in the clock object 
	clockText.text = secondsLeft .. ""

	if (secondsLeft == 0) then 
	   -- rest the number of seconds left 
	   secondsLeft = totalSeconds
	   lives = lives - 1 
	    if (lives == 0) then 
	    	print ("lives = " .. lives)
	        loseSoundChannel = audio.play(loseSound)
			timer.performWithDelay(500)
			lose.isVisible = true
			--cancel timer
			timer.cancel(countDownTimer)
			clockText.isVisible = false
			correctObject.isVisible = false
			questionObject.isVisible = false 
			numericField.isVisible = false 

		end 
		
	    if (lives == 3) then 
		    heart3.isVisible = false
	    elseif (lives == 2) then 
		    --heart2.isVisible = false 
	    elseif (lives == 1) then 
			heart1.isVisible = false			
	    end 
	    



	   --cancel timer
	   timer.cancel(countDownTimer)

	 -- *****CALLL THE FUNCTION TO ASK A NEW QUESTION*****
     --AskQuestion()
     secondsLeft = 16 
     countDownTimer = timer.performWithDelay(1000, UpdateTime, secondsLeft)
    end 

end 

-- function that calls the timer 
local function StartTimer()
	-- create a countdown timer that loops infinitely
	if (lives > 0) then
		secondsLeft = 16
		countDownTimer = timer.performWithDelay(1000, UpdateTime, secondsLeft)
		print ("Start timer.")
	else
		timer.cancel(countDownTimer)
	end

end


local function AskQuestion()
	    -- generate a random number between 1 and 4. This number picks the operator 
	    randomOperator = math.random(4)
	    -- tell the console what the operator chosen is 
	    print("randomOperator = " .. randomOperator)

	    -- if the random operator is 1, then ask an addintion question.
		if (randomOperator == 1) then 

		    -- generate 2 random numbers
			randomNumber1 = math.random(1, 20)
			randomNumber2 = math.random(1, 20)
			-- tell the console the chosen numbers 
			print("Initalize randomNumber1 = " .. randomNumber1)
			print("Initalize randomNumber2 = " .. randomNumber2)

			-- calculate the correct answer
			correctAnswer = randomNumber1 + randomNumber2
			-- print ht e correct answer to the console 
			print("correctAnswer (+) = " .. correctAnswer)
			-- create question in the text object 
			questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " = "


		-- otherwise, if the random operator is 2, then ask a subtraction question
		elseif (randomOperator == 2) then 
                -- regenerate two new numbers for the new equation
		        randomNumber1 = math.random(1, 20)
			    randomNumber2 = math.random(1, 20)
				-- tell the consoe the new numbers
				print("randomNumber1 NEW = " .. randomNumber1)
				print("randomNumber2 NEW = " .. randomNumber2)
                -- calculate the correct answer 
			    correctAnswer = randomNumber1 - randomNumber2
			    --print the correct answer on the console 
			    print("correctAnswer (-) = " .. correctAnswer)

            -- if the ocrrect answer is negative then keep recaulculating until correctAnswer has a positive value

			while( correctAnswer <= -1 )
			do
				    -- regenerate two new numbers for the new equation
					randomNumber1 = math.random(1, 20)
					randomNumber2 = math.random(1, 20)
					-- tell the consoe the new numbers
					print("randomNumber1 NEW = " .. randomNumber1)
					print("randomNumber2 NEW = " .. randomNumber2)
					-- put the new numbers in the new equation
					correctAnswer = randomNumber1 - randomNumber2
					-- check if the correctAnswer has a positive value 
					print("correctAnswer NEW (-) = " .. correctAnswer)
			end
            -- create question in the text object 
			questionObject.text = randomNumber1 .. " - " .. randomNumber2 .. " = "

		elseif (randomOperator == 3) then 
			-- regenerate two new numbers for the new equation
			randomNumber1 = math.random(1, 10)
			randomNumber2 = math.random(1, 10)
			-- tell the consoe the new numbers
			print("randomNumber1 NEW = " .. randomNumber1)
			print("randomNumber2 NEW = " .. randomNumber2)
			--calculate the correct answer
			correctAnswer = randomNumber1 * randomNumber2
			print("correctAnswer (*) = " .. correctAnswer)
			--create the question in the text object
			questionObject.text = randomNumber1 .. " * " .. randomNumber2 .. " = "

	    elseif (randomOperator == 4) then 
	    	-- regenerate two new numbers for the new equation
			randomNumber1 = math.random(1, 100)
			randomNumber2 = math.random(1, 100)
			-- tell the consoe the new numbers
			print("randomNumber1 NEW = " .. randomNumber1)
			print("randomNumber2 NEW = " .. randomNumber2)
	    	--calculate the correct answer 
	    	correctAnswer = math.round(randomNumber1 / randomNumber2)
	    	print("correctAnswer (/) = " .. correctAnswer)

			-- convert corectAnswer to string and test fpr decimal.
			xText = tostring(correctAnswer)
			print("Test division answer : " .. xText)


			--[[
			
			while( correctAnswer <= -1 )
			do
				    -- regenerate two new numbers for the new equation
					randomNumber1 = math.random(1, 20)
					randomNumber2 = math.random(1, 20)
					-- tell the consoe the new numbers
					print("randomNumber1 NEW = " .. randomNumber1)
					print("randomNumber2 NEW = " .. randomNumber2)
					-- put the new numbers in the new equation
					correctAnswer = randomNumber1 - randomNumber2
					-- check if the correctAnswer has a positive value 
					print("correctAnswer NEW (-) = " .. correctAnswer)
			end
			]]
	    	--create the question in a text object 
	    	questionObject.text = randomNumber1 .. " / " .. randomNumber2 .. " = "

	    end 
end



local function HideCorrect()
	print("**HideCorrect CALLED")
	-- hide the correct answer text
	correctObject.isVisible = false
	AskQuestion()
end

local function HideIncorrect()
	print("**HideIncorrect CALLED")
	-- hide the incorrect answer text
	incorrectObject.isVisible = false 
	AskQuestion()
end

local function HideWin()
	print("**HideWin CALLED")
	-- hide the win image 
	win.isVisible = false  
	AskQuestion()
end

local function HideGameOver()
	print("**HideGameOver CALLED")
	-- hide the game over image 
	win.isVisible = false  
	AskQuestion()
end

local function Heart1()
	-- show the heart 
	heart1.isVisible = true
	AskQuestion()
end

local function heart2()
	-- show the heart until life is lost
	heart2.isVisible = true 
	AskQuestion()
end
 
local function Heart3()
	-- until life is lost show heart
	heart3.isVisible = true 
	AskQuestion()
end

local function HideQuestion()
	-- show question until lives == 0
	questionObject.isVisible = true 
end

local  function HideBox()
	-- show until lives == 0
	numericField.isVisible = true 
end

local function NumericFieldListener ( event )
	-- user begins editing "numericfield"
	if ( event.phase == "began") then 
		--clear text field 
		event.target.text = ""
		

	elseif (event.phase == "submitted") then 

		--when the answer is submitted (enter key is pressed) set the user
		local userAnswer = tonumber(event.target.text)
		-- cancel timer 
		timer.cancel(countDownTimer)


		--if the users answer and thhe correct answer are the same:
		if (userAnswer == correctAnswer) then
			correctObject.isVisible = true
			timer.performWithDelay(1500, HideCorrect)
			--give the user a point 
			points = points + 1
			--pointsText.text = "points = " .. points
			correctSoundChannel = audio.play(correctSound)
			timer.performWithDelay(500, HideCorrect)
			if (points == 5) then 
				win.isVisible = true
				youWinSoundChannel = audio.play(youWin) 
				--cancel timer
				timer.cancel(countDownTimer)
				clockText.isVisible = false
				correctObject.isVisible = false
				questionObject.isVisible = false 
				numericField.isVisible = false 
				heart2.isVisible = false 
				heart1.isVisible = false 
			end


		else 
			print (correctAnswer)
			-- displayCorrectAnswer.text = tostring(correctAnswer)
			incorrectObject.isVisible = true 
			timer.performWithDelay(50)
			-- make a ife disapear 
			-- displayCorrectAnswer = tostring(correctAnswer)
			print(displayCorrectAnswer)
			-- add a point to the incorrect points tally
            incorrectPoints = incorrectPoints + 1
             wrongSoundChannel = audio.play(wrongSound)
            timer.performWithDelay(500, HideIncorrect)
           lives = lives - 1 
	    if (lives == 0) then 
	    	print ("lives = " .. lives)
	        loseSoundChannel = audio.play(loseSound)
			timer.performWithDelay(500)
			lose.isVisible = true
			--cancel timer
			timer.cancel(countDownTimer)
			clockText.isVisible = false
			correctObject.isVisible = false
			questionObject.isVisible = false 
			numericField.isVisible = false 

		end 
            if (incorrectPoints == 1) then 
            	heart3.isVisible = false 
            elseif (incorrectPoints  == 2) then 
            	heart2.isVisible = false 
            elseif (incorrectPoints == 3) then
            	heart1.isVisible = false 
            	gameOverSoundChannel = audio.play(gameOverSound) 
            end 
            wrongSoundChannel = audio.play(wrongSound)
            timer.performWithDelay(500, HideIncorrect)
            if (incorrectPoints == 3) then
            	gameOver.isVisible = true 
            end

		end
        --clear the text field
		event.target.text = ""
	end 
end 


---------------------------------------------------------------------------------------------
--OBJECT CREATION 
---------------------------------------------------------------------------------------------

--displays a question and sets the colour 
questionObject = display.newText("",display.contentWidth/4, display.contentHeight/2, nil, 55)
questionObject:setTextColor(195/255, 147/255, 200/255)

--create the correct text object and make it invisible 
correctObject = display.newText("Correct!", 512, 500, nil, 50)
correctObject:setTextColor(195/255, 147/255, 200/255)
correctObject.isVisible = false

--create the Incorrect text object and ake it invisible
incorrectObject = display.newText("Incorrect!", 512, 500, nil, 30)
--incorrectObject = display.newText( tostring(displayCorrectAnswer), 512, 500, nil, 30)
incorrectObject:setTextColor(109/255, 86/255, 137/255)
incorrectObject.isVisible = false

--create numeric field
numericField = native.newTextField( 512, 385, 150, 70 )
numericField.inputType = "number"
 --add the event listner for the numeric field 
 numericField:addEventListener("userInput", NumericFieldListener)

--create the points text
--pointsText = display.newText("Points = " .. points, 800, 100, nil, 50 ) 

-- display Correct image and make it invisible
win = display.newImageRect("Images/win.png", 1024, 768)
win.x = display.contentWidth/2
win.y = display.contentHeight/2
win.isVisible = false 

--display you lose image and make it invisible
lose = display.newImageRect("Images/gameOver.jpg",1024, 768)
lose.x = display.contentWidth/2
lose.y = display.contentHeight/2
lose.isVisible = false 

--display the lives on screen 
heart1 = display.newImageRect("Images/heart.png", 100, 100)
heart1.x = display.contentWidth*7/8
heart1.y = display.contentHeight*1/7
heart1.isVisible = true

heart2 = display.newImageRect("Images/heart.png", 100, 100)
heart2.x = display.contentWidth*6/8
heart2.y = display.contentHeight*1/7
heart2.isVisible = true

heart3 = display.newImageRect("Images/heart.png", 100, 100)
heart3.x = display.contentWidth*5/8
heart3.y = display.contentHeight*1/7
heart3.isVisible = true

-- display the clock text, showing the number countdown 
clockText = display.newText("Start", 100, 80, native.systemFontBold, 80)
clockText:setFillColor(195/255, 147/255, 200/255)
clockText.isVisible = true

-----------------------------------------------------------------------------------------------
--FUNCTION CALLS
-----------------------------------------------------------------------------------------------

AskQuestion()
StartTimer()