require("card_move")
require("card_battle")
function love.load()
	love.graphics.setMode(1200, 1200)
	whale = love.graphics.newImage("new_5501.jpg")
	bute = love.graphics.newImage("new_5502.jpg")
	shadoll = love.graphics.newImage("new_5503.jpg")
	oddeye = love.graphics.newImage("new_5550.jpg")
	dragon = love.graphics.newImage("new_5551.jpg")
	decatron = love.graphics.newImage("new_5633.jpg")
	stone = love.graphics.newImage("new_5635.jpg")
	obrsk = love.graphics.newImage("obrsk.jpg")
	n5636 = love.graphics.newImage("new_5636.jpg")
	n5637 = love.graphics.newImage("new_5637.jpg")
	n5640 = love.graphics.newImage("new_5640.jpg")
	n5641 = love.graphics.newImage("new_5641.jpg")
	barbar = love.graphics.newImage("new_5770.jpg")
	burning = love.graphics.newImage("new_5771.jpg")
	cards = {
		New = function(imgx,imgy,pic,typec,at,def)
			return {
				x = imgx,
				y = imgy,
				picp = pic,
				mmt = typec,-- 1 monster 2 magic 3 trap
				attack = at, 
				defense = def
			}
		end
	}
	obj = {}
	obj[1] = cards.New(700,0,obrsk,1,2000,100)
	obj[2] = cards.New(700,0,obrsk,1,2000,100)
	obj[3] = cards.New(700,0,obrsk,1,2000,100)
	obj[4] = cards.New(700,0,whale,1,1950,650)
	obj[5] = cards.New(700,0,whale,1,1950,650)
	obj[6] = cards.New(700,0,whale,1,1950,650)
	obj[7] = cards.New(700,0,bute,1,1950,0)
	obj[8] = cards.New(700,0,bute,1,1950,0)
	obj[9] = cards.New(700,0,bute,1,1950,0)
	obj[10] = cards.New(700,0,shadoll,1,1900,1600)
	obj[11] = cards.New(700,0,shadoll,1,1900,1600)
	obj[12] = cards.New(700,0,shadoll,1,1900,1600)
	obj[13] = cards.New(700,0,oddeye,1,1900,1500)
	obj[14] = cards.New(700,0,oddeye,1,1900,1500)
	obj[15] = cards.New(700,0,oddeye,1,1900,1500)
	obj[16] = cards.New(700,0,dragon,1,1900,1500)
	obj[17] = cards.New(700,0,dragon,1,1800,1000)
	obj[18] = cards.New(700,0,dragon,1,1800,1000)
	obj[19] = cards.New(700,0,decatron,1,1800,1000)
	obj[20] = cards.New(700,0,decatron,1,1700,400)
	obj[21] = cards.New(700,0,decatron,1,1700,400)
	obj[22] = cards.New(700,0,stone,1,1700,400)
	obj[23] = cards.New(700,0,stone,1,1600,500)
	obj[24] = cards.New(700,0,stone,1,1600,500)
	obj[25] = cards.New(700,0,n5636,1,1600,500)
	obj[26] = cards.New(700,0,n5636,1,1500,1900)
	obj[27] = cards.New(700,0,n5636,1,1500,1900)
	obj[28] = cards.New(700,0,n5637,1,1500,1900)
	obj[29] = cards.New(700,0,n5637,1,1400,1500)
	obj[30] = cards.New(700,0,n5637,1,1400,1500)
	obj[31] = cards.New(700,0,n5640,1,1400,1500)
	obj[32] = cards.New(700,0,n5640,1,1300,1800)
	obj[33] = cards.New(700,0,n5640,1,1300,1800)
	obj[34] = cards.New(700,0,n5641,1,1300,1800)
	obj[35] = cards.New(700,0,n5641,1,1200,500)
	obj[36] = cards.New(700,0,n5641,1,1200,500)
	obj[37] = cards.New(700,0,barbar,1,1200,500)
	obj[38] = cards.New(700,0,barbar,1,1100,500)
	obj[39] = cards.New(700,0,barbar,1,1100,500)
	obj[40] = cards.New(700,0,burning,1,1100,500)
	n = 40
	while n > 1 do
		n = n - 1
		k = math.random(1,40)
		tmp = obj[k]
		obj[k] = obj[n]
		obj[n] = tmp
	end
	a = math.random(1,40)
	obj[a].x = 0
	b = math.random(1,40)
	while b == a do
		b = math.random(1,40)
	end
	obj[b].x = 90
	c = math.random(1,40)
	while c == b or c == a do
		c = math.random(1,40)
	end
	obj[c].x = 180
	d = math.random(1,40)
	while d == c or d == b or d == a do
		d = math.random(1,40)
	end
	obj[d].x = 270
	e = math.random(1,40)
	while e == d or e == c or e == b or e == a do
		e = math.random(1,40)
	end
	obj[e].x = 360
	HZone = {obj[a],obj[b],obj[c],obj[d],obj[e],0}
	opp = {}
	opp[1] = cards.New(700,600,obrsk,1,2000,100)
	opp[2] = cards.New(700,600,obrsk,1,2000,100)
	opp[3] = cards.New(700,600,obrsk,1,2000,100)
	opp[4] = cards.New(700,600,whale,1,1950,650)
	opp[5] = cards.New(700,600,whale,1,1950,650)
	opp[6] = cards.New(700,600,whale,1,1950,650)
	opp[7] = cards.New(700,600,bute,1,1950,0)
	opp[8] = cards.New(700,600,bute,1,1950,0)
	opp[9] = cards.New(700,600,bute,1,1950,0)
	opp[10] = cards.New(700,600,shadoll,1,1900,1600)
	opp[11] = cards.New(700,600,shadoll,1,1900,1600)
	opp[12] = cards.New(700,600,shadoll,1,1900,1600)
	opp[13] = cards.New(700,600,oddeye,1,1900,1500)
	opp[14] = cards.New(700,600,oddeye,1,1900,1500)
	opp[15] = cards.New(700,600,oddeye,1,1900,1500)
	opp[16] = cards.New(700,600,dragon,1,1900,1500)
	opp[17] = cards.New(700,600,dragon,1,1800,1000)
	opp[18] = cards.New(700,600,dragon,1,1800,1000)
	opp[19] = cards.New(700,600,decatron,1,1800,1000)
	opp[20] = cards.New(700,600,decatron,1,1700,400)
	opp[21] = cards.New(700,600,decatron,1,1700,400)
	opp[22] = cards.New(700,600,stone,1,1700,400)
	opp[23] = cards.New(700,600,stone,1,1600,500)
	opp[24] = cards.New(700,600,stone,1,1600,500)
	opp[25] = cards.New(700,600,n5636,1,1600,500)
	opp[26] = cards.New(700,600,n5636,1,1500,1900)
	opp[27] = cards.New(700,600,n5636,1,1500,1900)
	opp[28] = cards.New(700,600,n5637,1,1500,1900)
	opp[29] = cards.New(700,600,n5637,1,1400,1500)
	opp[30] = cards.New(700,600,n5637,1,1400,1500)
	opp[31] = cards.New(700,600,n5640,1,1400,1500)
	opp[32] = cards.New(700,600,n5640,1,1300,1800)
	opp[33] = cards.New(700,600,n5640,1,1300,1800)
	opp[34] = cards.New(700,600,n5641,1,1300,1800)
	opp[35] = cards.New(700,600,n5641,1,1200,500)
	opp[36] = cards.New(700,600,n5641,1,1200,500)
	opp[37] = cards.New(700,600,barbar,1,1200,500)
	opp[38] = cards.New(700,600,barbar,1,1100,500)
	opp[39] = cards.New(700,600,barbar,1,1100,500)
	opp[40] = cards.New(700,600,burning,1,1100,500)
	n = 40
	while n > 1 do
		n = n - 1
		k = math.random(1,40)
		tmp = opp[k]
		opp[k] = opp[n]
		opp[n] = tmp
	end
	a = math.random(1,40)
	opp[a].x = 0
	b = math.random(1,40)
	while b == a do
		b = math.random(1,40)
	end
	opp[b].x = 90
	c = math.random(1,40)
	while c == b or c == a do
		c = math.random(1,40)
	end
	opp[c].x = 180
	d = math.random(1,40)
	while d == c or d == b or d == a do
		d = math.random(1,40)
	end
	opp[d].x = 270
	e = math.random(1,40)
	while e == d or e == c or e == b or e == a do
		e = math.random(1,40)
	end
	opp[e].x = 360

	STZone = {0,0,0,0,0}
	MZone = {0,0,0,0,0}
	OppHZone = {opp[a],opp[b],opp[c],opp[d],opp[e],0}
	phase = 1 --1 draw 2 stand-by 3 main1 4 battle 5 main2 6 end 
	player = 1 -- 1 player 2 ai
	draw = 0
	lib = 6
	opplib = 6
	checkplace = 0
	AIPlace = 0
	OppPlace = 0
	OppMZone = {0,0,0,0,0}
end

function love.draw()
	--deck 40 hand 5
	for i=1,40 do
		love.graphics.draw(obj[i].picp, obj[i].x, obj[i].y)
		love.graphics.draw(opp[i].picp, opp[i].x, opp[i].y)
	end
end

function love.mousepressed(x, y, button)
	if button == 'l' then
		card_move.card_move(x,y)
		card_battle.card_battle(x,y)
	end
end

function love.keypressed(key, unicode)
	--phase change
	if key == 'f' then
		if phase == 1 then
			phase = 2
			print("standby phase", phase)
		else if phase == 2 then
			phase = 3
			print("main1 phase", phase)
		else if phase == 3 then
			phase = 4
			print("battle phase", phase)
		else if phase == 4 then
			phase = 5
			print("main2 phase", phase)
		else if phase == 5 then
			phase = 6
			print("end phase", phase)
		else if phase == 6 then
			print("opp turn")
			phase = 1
			draw = 0
			if player == 1 then
				player = 2
			else if player == 2 then
				player = 1
			end
			end
		end
		end
		end
		end
		end
		end
	end
	if key == 'd' and phase == 1 and draw == 0 then
		if player == 1 then
			for i=1,6 do 
				if HZone[i] == 0 then
					HZone[i] = obj[lib]
					HZone[i].x = (i-1)*90
					lib = lib + 1
					draw = 1
					break
				end
			end
			print("draw card")
		else if player == 2 then
			for i=1,6 do
				if OppHZone[i] == 0 then
					OppHZone[i] = opp[opplib]
					OppHZone[i].x = (i-1)*90
					opplib = opplib + 1
					draw = 1
					break
				end
			end
			print("draw card")
		end
		end
	end
end
