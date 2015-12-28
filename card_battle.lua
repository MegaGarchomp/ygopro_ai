module("card_battle", package.seeall)
function card_battle(x,y)
	if phase == 4 and player == 1 then
		print("check")
		if AIPlace > 0 then
			for k=0, 360, 90 do
				if x >= k and x < k+90 and y > 300 and y <= 600 then
					for i=1,5 do
						if OppMZone[i] ~= 0 then
							print("opp card xy match")
							if OppMZone[i].x == k and OppMZone[i].y == 450 then
								OppPlace = i
								print("OppCard select")
							end
						end
					end
				end
			end
		end
		if AIPlace > 0 and OppPlace > 0 then
			if MZone[AIPlace].attack > OppMZone[OppPlace].attack then
				OppMZone[OppPlace].x = 720
				OppMZone[OppPlace] = 0
				print("Opp lose")
			else
				MZone[AIPlace].x = 720
				MZone[AIPlace] = 0
				print("AI lose")
			end
			AIPlace = 0
			OppPlace = 0
		end
		for k=0, 360, 90 do
			if x >= k and x < k + 90 and y >= 150 and y < 300 then
				for i=1,5 do
					if MZone[i] ~= 0 then
						if MZone[i].x == k and MZone[i].y == 150  then
							AIPlace = i 
							print("AIcard select")
						end
					end
				end
			end
		end
	end	
	if phase == 4 and player == 2 then
		if OppPlace > 0 then
			for k=0, 360, 90 do
				if x >= k and x < k+90 and y > 150 and y <= 300 then
					for i=1,5 do
						if MZone[i] ~= 0 then
							print("ai card xy match")
							if MZone[i].x == k and MZone[i].y == 150 then
								AIPlace = i
								print("AICard select")
							end
						end
					end
				end
			end
		end
		if AIPlace > 0 and OppPlace > 0 then
			if MZone[AIPlace].attack > OppMZone[OppPlace].attack then
				OppMZone[OppPlace].x = 720
				OppMZone[OppPlace] = 0
				print("Opp lose")
			else
				MZone[AIPlace].x = 720
				MZone[OppPlace] = 0
				print("AI lose")
			end
			AIPlace = 0
			OppPlace = 0
		end
		for k=0, 360, 90 do
			if x >= k and x < k + 90 and y >= 300 and y < 600 then
				for i=1,5 do
					if OppMZone[i] ~= 0 then
						if OppMZone[i].x == k and OppMZone[i].y == 300  then
							OppPlace = i 
							print("Oppcard select")
						end
					end
				end
			end
		end
	end	
end
