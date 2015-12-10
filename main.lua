function love.load(arg)
	love.window.setMode(1000, 800, {resizable=true, vsync=false, minwidth=400, minheight=300})
	whale = love.graphics.newImage("new_ws009459.jpg")
	obrsk = love.graphics.newImage("obrsk.jpg")
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
	obj = {obj1,obj2,obj3,obj4,obj5,obj6,obj7,obj8,obj9,obj10,obj11,obj12,obj13,obj14,obj15,obj16,obj17,obj18,obj19,obj20,obj21}
	obj[1] = cards.New(0,0,obrsk,1,4000,4000)
	obj[2] = cards.New(90,0,whale,2,4000,4000)
	obj[3] = cards.New(180,0,whale,3,4000,4000)
	obj[4] = cards.New(270,0,whale,1,4000,4000)
	obj[5] = cards.New(360,0,whale,2,4000,4000)
	obj[6] = cards.New(700,0,whale,1,4000,4000)
	obj[7] = cards.New(700,0,whale,1,4000,4000)
	obj[8] = cards.New(700,0,whale,1,4000,4000)
	obj[9] = cards.New(700,0,whale,1,4000,4000)
	obj[10] = cards.New(700,0,whale,1,4000,4000)
	obj[11] = cards.New(700,0,whale,1,4000,4000)
	obj[12] = cards.New(700,0,whale,1,4000,4000)
	obj[13] = cards.New(700,0,whale,1,4000,4000)
	obj[14] = cards.New(700,0,whale,1,4000,4000)
	obj[15] = cards.New(700,0,whale,1,4000,4000)
	obj[16] = cards.New(700,0,whale,1,4000,4000)
	obj[17] = cards.New(700,0,whale,1,4000,4000)
	obj[18] = cards.New(700,0,whale,1,4000,4000)
	obj[19] = cards.New(700,0,whale,1,4000,4000)
	obj[20] = cards.New(700,0,whale,1,4000,4000)
	obj[21] = cards.New(700,0,whale,1,4000,4000)
	obj[22] = cards.New(90,450,whale,1,4000,4000)
	STZone = {0,0,0,0,0}
	MZone = {0,0,0,0,0}
	HZone = {obj[1],obj[2],obj[3],obj[4],obj[5],0}
	phase = 1 --1 draw 2 stand-by 3 main1 4 battle 5 main2 6 end 
	player = 1 -- 1 player 2 ai
	draw = 0
	lib = 6
	checkplace = 0
	checkbplace = 0
	OppMZone = {obj[22],obj[23]}
end

function love.draw()
	--deck 40 hand 5
	for i=1,22 do
		love.graphics.draw(obj[i].picp, obj[i].x, obj[i].y)
	end
end

function love.mousepressed(x, y, button)
	if button == 'l' then
		if checkplace > 0 then
			for k=0, 360, 90 do
				if x >= k and x < k+90 and y > 150 and y <= 300 and MZone[(k/90)+1] == 0 then
					HZone[checkplace].x = k
					HZone[checkplace].y = 150
					MZone[(k/90)+1] = HZone[checkplace]
					HZone[checkplace] = 0
					checkplace = 0
				end
			end
		end
		for k=0, 450, 90 do
			if x >= k and x < k + 90 and y >= 0 and y < 150 then
				for i=1,6 do
					if HZone[i] ~= 0 then
						if HZone[i].x == k and HZone[i].y == 0 --[[and (obj[i].mmt == 2 or obj[i].mmt == 3)]] then
							checkplace = i
							print(obj[i].x,obj[i].y,"card move")
						end
					end
				end
			end
		end
		if checkbplace > 0 then
			if x >= 90 and x < 180 and y >= 300 and y < 450 then
				if MZone[checkbplace].attack >= obj[23].attack then
					obj[22].x = 360
				end
			end
		end
			
		for k=0,360,90 do
			if x >= k and x < k + 90 and y >= 150 and y < 300 then
				for i=1,5 do
					if MZone[i] ~= 0 then
						if MZone[i].x == k and MZone[i].y == 0 then
							checkbplace = i
						end
					end
				end
			end
		end
	end
end

function love.keypressed(key, unicode)
	--phase change
	if key == 's' and phase == 1 then
		print("standby phase")
		phase = 2
	end
	if key == 'm' and phase == 2 then
		print("main1 phase")
		phase = 3
	end
	if key == 'f' and phase == 3 then
		print("battle phase")
		phase = 4
	end
	if key == 'f' and phase == 4 then
		print("main2 phase")
		phase = 5
	end
	if key == 'f' and phase == 5 then
		print("end phase")
		phase = 6
	end
	if key == 'f' and phase == 6 then
		print("turn end")
		draw = 0
		player = 2
	end
	if key == 'd' --[[and phase == 1 and draw == 0]] then
		for i=1,6 do 
			if HZone[i] == 0 then
				HZone[i] = obj[lib]
				HZone[i].x = (i-1)*90
				lib = lib + 1
				break
			end
		end
		print("draw card")
	end
end
