require("dialog")

local imgPath="asset/images/"
local mouseX,mouseY
local tRX,tRY,tRH,tRW=30,500,200,1200
local imgNow,cur
local bgmFlag

function love.load()
	contents,size=love.filesystem.read("asset/words/word.txt")
	love.mouse.setVisible(false)
	
	--font
	font=love.graphics.newFont("asset/fonts/msyh.ttf",20)
	love.graphics.setFont(font)
	
	--cursor img, background img
	imgLen=107
	cur=0
	img=love.graphics.newImage(imgPath.."mouse.png")
	nextImg()
	
	--audio
	bgmFlag=false
	bgm=love.audio.newSource("asset/music/yyzt.mp3","static")
	love.audio.play(bgm)
end

function love.draw()	
	love.graphics.draw(imgNow,0,0)
	
	--textrectangle
	love.graphics.rectangle("line",tRX,tRY,tRW,tRH)
	
	--text
	love.graphics.print(dialog[dialogNow],tRX+20,tRY+20)
	
	--draw mouse the lastest
	love.graphics.draw(img,mouseX,mouseY)
	
	
end

function love.update(dt)
	--get mouse information
	mouseX,mouseY=love.mouse.getPosition()
	
	--check the mouse-left button 
	if love.mouse.isDown("l") then
		if mouseX>tRX and mouseX < tRX+tRW and mouseY>tRY and mouseY<tRY+tRH then
			nextImg()
		end
	end
	
	--test timer
	love.timer.sleep(5)
	
	--bgm set
	if bgmFlag then
		love.audio.pause(bgm)
	else
		love.audio.resume(bgm)
	end
	
end

function nextImg()
	cur=cur+1
	if cur>imgLen then
		cur=1
	end
	imgNow=love.graphics.newImage(imgPath.."img ("..cur..").PNG")
end

function keypressed(key,unicode)
	if key==' ' then
		bgmFlag=not bgmFlag
	end
end
