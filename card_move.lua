module("card_move", package.seeall)
function card_move(x,y)
	if player == 1 then
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
						if HZone[i].x == k and HZone[i].y == 0 then
							checkplace = i
							print(obj[i].x,obj[i].y,"card move")
						end
					end
				end
			end
		end
	end
	if player == 2 then
		if checkplace > 0 then
			for k=0, 360, 90 do
				if x >= k and x < k+90 and y > 300 and y <= 600 and OppMZone[(k/90)+1] == 0 then
					OppHZone[checkplace].x = k
					OppHZone[checkplace].y = 300
					OppMZone[(k/90)+1] = OppHZone[checkplace]
					OppHZone[checkplace] = 0
					checkplace = 0
				end
			end
		end
		for k=0, 450, 90 do
			if x >= k and x < k + 90 and y >= 600 and y < 1000 then
				for i=1,6 do
					if OppHZone[i] ~= 0 then
						if OppHZone[i].x == k and OppHZone[i].y == 600 then
							checkplace = i
							print(opp[i].x,opp[i].y,"card move")
						end
					end
				end
			end
		end
	end
end
	
	
