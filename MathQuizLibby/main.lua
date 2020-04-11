-----------------------------------------------------------------------------------------
-- Title: Math Quiz 
-- Name: Libby Valentino
-- Course: ICS2O/3C
-- This program displays a math game for its user. 
-----------------------------------------------------------------------------------------

-- hide the status bar
display.setStatusBar(display.HiddenStatusBar)

--set the background colour
display.setDefault("background", 242/255, 212/255, 245/255)

-----------------------------------------------------------------------------------------
--LOCAL VARIABLES
-----------------------------------------------------------------------------------------

--creat local variables
local Incorrect 
local questionObject
local correctObject
local NumericTextFields
local randomNumber1
local randomNumber2
local userAnswer
local correctAnswer = 0
local incorrectAnswer
local points = 0
local incorrectPoints = 0
local displayCorrectAnswer
local randomOperator

-- variables for the timer
local totalSeconds = 5
local secondsLeft = 5
local clockText
local countDownTimer

local lives = 3
local heart1
local heart2

-----------------------------------------------------------------------------------------
--CEREATE SOUNDS
-----------------------------------------------------------------------------------------

--correct sound 
local correctSound = audio.loadSound("Sounds/win.mp3")
local correctSoundChannel

--wrong sound
local wrongSound = audio.loadSound("Sounds/lose.mp3")
local wrongSoundChannel

-- you lose sound 
local loseSound = audio.loadSound("Sounds/gameOver.mp3")
local loseSoundChannel

-- you win sound 
local winSound = audio.loadSound("Sounds/youWin.mp3")
local winSoundChannel 


-----------------------------------------------------------------------------------------
--LOCAL FUNCTIONS
-----------------------------------------------------------------------------------------

-- Keep track of time in seconds
--local secondsLeft = 20 * 60   -- 20 minutes * 60 seconds
local secondsLeft = 11   -- 20 minutes * 60 seconds

--local clockText = display.newText("20:00", display.contentCenterX, 80, native.systemFontBold, 80)
--local clockText = display.newText("Start", 100, 80, native.systemFontBold, 80)
--clockText:setFillColor(195/255, 147/255, 200/255)

-------  ### INSTRUCTIOR CODE : TIMER ### ----------------

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

	    if (lives == 2) then 
		    heart3.isVisible = false 
		    wrongSoundChannel = audio.play(wrongSound)

	    elseif (lives == 1) then 
			heart2.isVisible = false
			heart3.isVisible = false 
			wrongSoundChannel = audio.play(wrongSound)
	
		elseif (lives == 0) then 
			heart1.isVisible = false
			heart2.isVisible = false 
			heart3.isVisible = false 		
	    end 
	   --cancel timer
	   --timer.cancel(countDownTimer)

	 -- *****CALLL THE FUNCTION TO ASK A NEW QUESTION*****
     --AskQuestion()
     secondsLeft = 11
     --countDownTimer = timer.performWithDelay(1000, UpdateTime, secondsLeft)
    end 

end 

-- function that calls the timer 
local function StartTimer()
	-- create a countdown timer that loops infinitely
	if (lives > 0) then
		secondsLeft = 11
		countDownTimer = timer.performWithDelay(1000, UpdateTime, 0)
		print ("Start timer.")
	else
		timer.cancel(countDownTimer)
	end

end



local function AskQuestion()

	--StartTimer()
	--local countDownTimer = timer.performWithDelay( 1000, updateTime, secondsLeft )
	--StartTimer()

	--generate a random number between 1 and 4 this number picks the operator.  
	randomOperator = math.random(1, 6)
	print("randomOperator = " .. randomOperator)

	--if the random operator is 1, then ask an addintion question.
		if (randomOperator == 1) then 
			--generate 2 random numbers
			randomNumber1 = math.random(1, 20)
			randomNumber2 = math.random(1, 20)
			--calculate the correct answer
			correctAnswer = randomNumber1 + randomNumber2
			print("correctAnswer (+) = " .. correctAnswer)
			--create question in the text object 
			questionObject.text = randomNumber1 .. " + " .. randomNumber2 .. " = "


		-- otherwise, if the random operator is 2, then ask a subtraction question
		elseif (randomOperator == 2) then 
			--generate 2 random numbers
			randomNumber1 = math.random(1, 20)
			randomNumber2 = math.random(1, 20)

            --calculate the correct answer 
			correctAnswer = randomNumber1 - randomNumber2
			--print the correct answer on the console 
			print("correctAnswer (-) = " .. correctAnswer)

            -- if the ocrrect answer is negative then keep recaulculating until correctAnswer is a positive answer
			while( correctAnswer <= -1 )
			do
				    -- regenerate two new numbers for the new equation
					randomNumber1 = math.random(1, 20)
					randomNumber2 = math.random(1, 20)
					-- tell the consoe the new numbers
					print("randomNumber1 NEW = " .. randomNumber1)
					print("randomNumber2 NEW = " .. randomNumber2)
					-- the new numbers in the new equation
					correctAnswer = randomNumber1 - randomNumber2
					-- check if the correctAnswer has a positive value 
					print("correctAnswer NEW (-) = " .. correctAnswer)
			end
               -- create question in the text object 
			questionObject.text = randomNumber1 .. " - " .. randomNumber2 .. " = "

		elseif (randomOperator == 3) then 
			--generate 2 random numbers
			randomNumber1 = math.random(0, 4)
			randomNumber2 = math.random(0, 4)
			--calculate the correct answer
			correctAnswer = randomNumber1 * randomNumber2
			print("correctAnswer (*) = " .. correctAnswer)
			--create the question in the text object
			questionObject.text = randomNumber1 .. " * " .. randomNumber2 .. " = "

	    elseif (randomOperator == 4) then 
	    	--generate 2 random numbers
			randomNumber1 = math.random(0, 4)
			randomNumber2 = math.random(0, 4)
			--calculate the correct answer
			local multiAnswer = randomNumber1 * randomNumber2
			print("multiAnswer (*) = " .. multiAnswer) 
			local diviAnswer = multiAnswer 
			correctAnswer = randomNumber2

			--create the question in the text object
			questionObject.text = diviAnswer .. " / " .. randomNumber1 .. " = "
	    	--[[

			-- ### NUMBER SALAD USING (*) as a base to get number

	    	-- calculate the correct answer 
	    	correctAnswer = randomNumber1 / randomNumber2
	    	
	    	print("correctAnswer (/) = " .. correctAnswer)
			local correctAnswerText = tostring(correctAnswer)
 			print("tell me what what is correctAnswerText : " .. correctAnswerText)
 			local findDecimal = string.find(correctAnswerText, ".") 
 			print ("tell me where the decimal is : " .. findDecimal)
			
			
			while( findDecimal > 0  )
			do
				    -- regenerate two new numbers for the new equation
					randomNumber1 = math.random(1, 100)
					randomNumber2 = math.random(1, 100)
					-- tell the consoe the new numbers
					print("randomNumber1 NEW = " .. randomNumber1)
					print("randomNumber2 NEW = " .. randomNumber2)
					-- put the new numbers in the new equation
					correctAnswer = randomNumber1 / randomNumber2
					-- check if the correctAnswer has a positive value 
					print("correctAnswer NEW (-) = " .. correctAnswer)
					-- test for decimal again 
					local correctAnswerText = tostring(correctAnswer)
		 			print("the NEW correct answer is : " .. correctAnswerText)
		 			local findDecimal = string.find(correctAnswerText, ".") 
		 			print ("Is there a decimal in the NEW answer : " .. findDecimal)
			end
	    	--create the question in a text object 
	    	questionObject.text = randomNumber1 .. " / " .. randomNumber2 .. " = "
	    end ]]

	    -- if the random operator chosen was 5 then ask a question with exponents
	    elseif  (randomOperator == 5) then 
	    	--generate 2 random numbers
			randomNumber1 = math.random(1, 3)
			randomNumber2 = math.random(1, 3)
			-- tell the consoe the new numbers
			print("randomNumber1 = " .. randomNumber1)
			print("randomNumber2 = " .. randomNumber2)
			-- calculate the correct answer
			-- correctAnswer = randomNumber1 ^ randomNumber2
			local expAnswer = randomNumber1 ^ randomNumber2
			local loopAnswer
			for loopAnswer = randomNumber1, expAnswer, randomNumber2
			do 
   				print("loopAnswer = " .. loopAnswer)  
			end
			correctAnswer = expAnswer
			print("correctAnswer (^) = " .. expAnswer)
			--create the question in the text object
			questionObject.text = randomNumber1 .. " ^ " .. randomNumber2 .. " = "

		elseif (randomOperator == 6) then 
			-- generate a new number √ 
			randomNumber1 = math.random(1, 100)
            -- create tempAnswer
            tempAnswer = randomNumber1 * randomNumber1
            correctAnswer = randomNumber1
            print ("correctAnswer (√) = " .. correctAnswer)
            questionObject.text = "√" .. tempAnswer .. " = "



	    end


end

local function HideCorrect()
	print("**HideCorrect CALLED")
	-- hide the correct answer text
	correctObject.isVisible = false
	AskQuestion()
	-- StartTimer()
end

local function HideIncorrect()
	print("**HideIncorrect CALLED")
	--hide the incorrect answer text
	incorrectObject.isVisible = false 
	AskQuestion()
	-- StartTimer()
end

local function HideWin()
	print("**HideWin CALLED")
	-- hide the win image 
	win.isVisible = false  
	--AskQuestion()
end

local function HideGameOver()
	print("**HideGameOver CALLED")
	-- hide the game over image 	
	win.isVisible = false  
	--AskQuestion()
end

local function HideQuestion()
	-- show until lives == 0 
	questionObject.isVisible = true 
end

local function HidenBox()
	-- hide the numeric text field when you lose the game.
	numericField.isVisible = true 
end


local function NumericFieldListener ( event )
	-- user begins editing "numericfield"
	if ( event.phase == "began") then 
		--clear text field 
		event.target.text = ""
		

	elseif event.phase == "submitted" then 

		--when the answer is submitted (enter key is pressed) set the user
		local userAnswer = tonumber(event.target.text)
		print ("---- userAnswer = " .. userAnswer .. " -----")
		-- cancel timer 
		timer.cancel(countDownTimer)

		--if the users answer and thhe correct answer are the same:
		if (userAnswer == correctAnswer) then
			correctObject.isVisible = true
			timer.performWithDelay(50, HideCorrect)
			--give the user a point 
			points = points + 1
			--pointsText.text = "points = " .. points
			correctSoundChannel = audio.play(correctSound)
			timer.performWithDelay(50, HideCorrect)
			if (points == 5) then 
				win.isVisible = true 
				winSoundChannel = audio.play(winSound)
				--cancel timer
				timer.cancel(countDownTimer)
				clockText.isVisible = false
				correctObject.isVisible = false
				questionObject.isVisible = false 
				numericField.isVisible = false 
				heart3.isVisible = false 
				heart2.isVisible = false 
				heart1.isVisible = false 

			end

		else 
			print (correctAnswer)
			--displayCorrectAnswer.text = tostring(correctAnswer)
			incorrectObject.isVisible = true 
			-- update the incorrectObject with the correct answer
            incorrectObject.text = "Incorrect! The correct answer is " .. correctAnswer
			timer.performWithDelay(50)
			--displayCorrectAnswer = tostring(correctAnswer)
			print(displayCorrectAnswer)
			-- add a point to the incorrect points tally
            incorrectPoints = incorrectPoints + 1
            wrongSoundChannel = audio.play(wrongSound)
            timer.performWithDelay(500, HideIncorrect)
           lives = lives - 1 

	    if (lives == 0) then 
	    	print ("lives = " .. lives)
	    	heart1.isVisible = false 
	    	heart2.isVisible = false 
	    	heart3.isVisible = false 
	        loseSoundChannel = audio.play(loseSound)
			timer.performWithDelay(500)
			lose.isVisible = true
			--cancel timer
			timer.cancel(countDownTimer)
			clockText.isVisible = false
			correctObject.isVisible = false
			questionObject.isVisible = false 
			numericField.isVisible = false 
			incorrectObject.isVisible = false 
		end 

		    if (incorrectPoints == 1) then 
            	heart3.isVisible = false
            end 
            if (incorrectPoints == 2) then
            	heart2.isVisible = false 
            	heart3.isVisible = false  
            end 
            if (incorrectPoints == 3) then
            	heart1.isVisible = false 
            	heart2.isVisible = false
            	heart3.isVisible = false 
            	lose.isVisible = true            	
            end

		end
        --clear the text field
		event.target.text = ""
	end 
end 



---------------------------------------------------------------------------
--Anniation
---------------------------------------------------------------------------

--add in minnie charecter image
--local minnie = display.newImageRect("Images/heart.png", 100, 100)


--add the global variable for speed
scrollspeed = 5
--set the direction 
local MovingUp = 1


--Funtion: MoveWin
--Input: this function accepts an event 
--Output: none
--Description: this function ads the scroll speed to the x-value of win
local function MoveWin( event )

	if (MovingUp == 1) then 
		win.y = win.y - scrollspeed 
	else 
		win.y = win.y + scrollspeed
	end 

	if (win.y < 0) then 
		MovingUp = 0 

	end 

	if (win.y > 1024) then 
		MovingUp = 1
	end
end

--MoveWin will be called over and over again
Runtime:addEventListener("enterFrame", MoveWin)




---------------------------------------------------------------------------------------------
--OBJECT CREATION
---------------------------------------------------------------------------------------------

-- display you win image 
win = display.newImageRect("images/youWin.gif", 500, 500)
win.x = display.contentWidth/2
win.y = display.contentHeight/2
win.isVisible = false 

--displays a question and sets the colour 
questionObject = display.newText("",display.contentWidth/3, display.contentHeight/2, nil, 55)
questionObject:setTextColor(195/255, 147/255, 200)
questionObject.isVisible = true 

--create the correct text object and make it invisible 
correctObject = display.newText("Correct!", 512, 500, nil, 50)
correctObject:setTextColor(195/255, 147/255, 200/255)
correctObject.isVisible = false

--create the Incorrect text object and ake it invisible
-- update the incorrectObject with the correct answer
-- incorrectObject.text = "Incorrect! The correct answer is " .. correctAnswer
incorrectObject = display.newText("Incorrect!", 512, 500, nil, 30)
-- incorrectObject = display.newText( tostring(displayCorrectAnswer), 512, 500, nil, 30)
incorrectObject:setTextColor(109/255, 86/255, 137/255)
incorrectObject.isVisible = false

--create numeric field
numericField = native.newTextField( 512, 385, 150, 70 )
numericField.inputType = "number"
numericField.isVisible = true 

--add the event listner for the numeric field 
numericField:addEventListener("userInput", NumericFieldListener)

--create the points text
--pointsText = display.newText("Points = " .. points, 800, 100, nil, 50 ) 

-- display Correct image and make it invisible
--[[
win = display.newImageRect("Images/youWin.gif", 1024, 768)
win.x = display.contentWidth/2
win.y = display.contentHeight/2
win.isVisible = false 
]]

-- display you lose image and make it invisible
lose = display.newImageRect("Images/gameOver.png",1024, 768)
lose.x = display.contentWidth/2
lose.y = display.contentHeight/2
lose.isVisible = false 

-- display the lives on screen 
heart1 = display.newImageRect("images/heart.png", 100, 100)
heart1.x = display.contentWidth*5/8
heart1.y = display.contentHeight*1/7

heart2 = display.newImageRect("Images/heart.png", 100, 100)
heart2.x = display.contentWidth*6/8
heart2.y = display.contentHeight*1/7

heart3 = display.newImageRect("Images/heart.png", 100, 100)
heart3.x = display.contentWidth*7/8
heart3.y = display.contentHeight/7
heart3.isVisible = true  

-- display the clock text, showing the number countdown 
clockText = display.newText("Start", 100, 80, native.systemFontBold, 80)
clockText:setFillColor(195/255, 147/255, 200/255)
clockText.isVisible = true


--------------------------------------------------------------------
--FUNCTION CALLS
--------------------------------------------------------------------

--call the function to ask the question 
AskQuestion()
StartTimer()