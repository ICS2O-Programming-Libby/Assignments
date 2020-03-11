-----------------------------------------------------------------------------------------
--
-- main.lua
--
-----------------------------------------------------------------------------------------
--hide status bar 
display.setStatusBar(display.HiddenStatusBar)

-- set the background colour 
display.setDefault("background",205/255, 220/255, 243/255)

--create verticies for triangle
local myHeart
local myPentagon
local myOctagon
local myTriangle
local mySquare
local myRf

local verticesSqr = {50, 50, 50, -50, -50, -50, -50, 50}
local verticesRf = {50, 50, 0, 100, -50, 50}
local verticesTri = {60, 100, 110, -100, -90, -70}
local verticesOct = {55, 65, 65, 55, 65, -55, 55, -65, -55, -65, -65, -55, -65, 55, -55, 65}
local vreticesPnt = {-100, -100, -125, 25, 0, 150, 125, 25, 100, -100}
local verticesHrt = {0, -30, 30, 0, 30, 10, 20, 20, 10, 20, 0, 10, -10, 20, -20, 20, -30, 10, -30, 0}

--Display triangle 
myTriangle = display.newPolygon(256, 192, verticesTri)

--set the width of the border 
myTriangle.strokeWidth = 10

--set the colour of the border
myTriangle:setFillColor(1, 1, 1)


--set the colour of the shape
local paint = {
    type = "gradient",
    color1 = { 167/255, 186/255, 222/255 },
    color2 = { 231/255, 198/255, 222/255 },
    direction = "up"
}
myTriangle.fill = paint

--Display octagon
myOctagon = display.newPolygon(768, 192, verticesOct)

--set the width of the border 
myOctagon.strokeWidth = 10

--set the colour of the border
myOctagon:setStrokeColor (1, 1, 1)

--set the colour of the shape 
local paint = {
    type = "gradient",
    color1 = { 246/255,219/255,239/255 },
    color2 = { 185/255, 108/255, 164/255 },
    direction = "up"
}
myOctagon.fill = paint

--display hexgaon
myPentagon = display.newPolygon(256, 574, vreticesPnt)

--set the width of the border 
myPentagon.strokeWidth = 10

--set the colour of the border
--myPentagon

--set the colour of the shape
local paintPentagon = {
    type = "image",
    filename = "winniepooh.jpg"
      
}
myPentagon.fill = paintPentagon 


--Display heart
myHeart = display.newPolygon(768, 574, verticesHrt)

--set the colour of the border
myHeart:setStrokeColor (201/255, 129/255, 181/255)

--set the width of the border 
myHeart.strokeWidth = 5

-- flip my heart vertically
myHeart:scale(1.76,-1.76)

--ste the colour of the shape
local paintHeart = {
    type = "gradient",
    color1 = { 1, 1, 1 },
    color2 = { 214/255, 155/255, 198/255 },
    direction = "up"
}
myHeart.fill = paintHeart

--display name of shape
display.newText("Triangle", 256, 325, Arial, 50)

--display name of shape
display.newText("Pentagon", 256, 725, Arial, 50)

--display name of shape
display.newText("Octagon", 768 , 325, Arial, 50)

--display name of shape
display.newText("Tiny Heart", 768, 700, Arial, 50)

--display a house
mySquare = display.newPolygon(512, 384, verticesSqr)

--diaplay a roof
myRf = display.newPolygon(512, 375, verticesRf)