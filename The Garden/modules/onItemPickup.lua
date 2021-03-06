----------------
--Item Pickups--
----------------

function garden:itemPickedUp(player, statFromXML)
	local player = Isaac.GetPlayer(0)	
	
	if player:HasCollectible(garden.COLLECTIBLE_CREATION) and not garden.HAS_CREATION then
		garden.HAS_CREATION = true
		player:AddNullCostume(garden.COSTUME_ID_CREATION)	
	
		Game().TimeCounter = 0
		SFXManager():Play(SoundEffect.SOUND_GOLDENKEY, 4, 0, false, 1)           													 
	end

	if player:HasCollectible(garden.COLLECTIBLE_THE_FALL_OF_MAN) and not garden.HAS_THE_FALL_OF_MAN then		
		garden.HAS_THE_FALL_OF_MAN = true
		player:AddNullCostume(garden.COSTUME_ID_THE_FALL_OF_MAN)
        
        local totalHearts = player:GetMaxHearts()			
		local ignoreKeeper = true
		player:AddBlackHearts(4, ignoreKeeper)
		player:AddMaxHearts(totalHearts*-1, ignoreKeeper)

		for i = 1, totalHearts/2 do
			player.Damage = player.Damage + 0.5
		end		
	end	


	if player:HasCollectible(garden.COLLECTIBLE_MY_BELOVED) and not garden.HAS_MY_BELOVED then			
		garden.HAS_MY_BELOVED = true
		player:AddNullCostume(garden.COSTUME_ID_MY_BELOVED)
		local ignoreKeeper = false
		player:AddMaxHearts(2, ignoreKeeper)
		player:AddHearts(2)
		player.Luck = player.Luck + 1.0		
	end

	if player:HasCollectible(garden.COLLECTIBLE_SHAME) and not garden.HAS_SHAME then									
		garden.HAS_SHAME = true
		player:AddNullCostume(garden.COSTUME_ID_SHAME)				
	end

	if player:HasCollectible(garden.COLLECTIBLE_FORBIDDEN_FRUIT) and not garden.HAS_FORBIDDEN_FRUIT then			
		garden.HAS_FORBIDDEN_FRUIT = true 
		player:AddNullCostume(garden.COSTUME_ID_FORBIDDEN_FRUIT)
		player.ShotSpeed = player.ShotSpeed + 0.6		 
	end

	if player:HasCollectible(garden.COLLECTIBLE_THE_FIRST_DAY) and not garden.HAS_THE_FIRST_DAY then			
		garden.HAS_THE_FIRST_DAY = true
		player:AddNullCostume(garden.COSTUME_ID_THE_FIRST_DAY)		  

		player.Damage = player.Damage + 0.51		
		player.MoveSpeed = player.MoveSpeed + 0.1
		player.ShotSpeed = player.ShotSpeed + 0.1

		local white = Color(255, 255, 255, 255, 0, 0, 0)
		player.TearColor = white	
	end

	if player:HasCollectible(garden.COLLECTIBLE_DECEPTION) and not garden.HAS_DECEPTION then			
		garden.HAS_DECEPTION = true  
		player:AddNullCostume(garden.COSTUME_ID_DECEPTION)

		--Shuffle consumables
		for i = 1, 3 do
			local posOrNeg = math.random(10)
			local consumableOffset = math.random(15)
			if posOrNeg <= 4 then
				consumableOffset = consumableOffset*-1
			end
			local shuffleWhichConsumable = math.random(3)
			if shuffleWhichConsumable == 1 then
				player:AddCoins(consumableOffset)
			elseif shuffleWhichConsumable == 2 then
				player:AddKeys(consumableOffset)
			elseif shuffleWhichConsumable == 3 then
				player:AddBombs(consumableOffset)
			end
		end
	end

	if player:HasCollectible(garden.COLLECTIBLE_GRANTED_DOMAIN) and not garden.HAS_GRANTED_DOMAIN then			
		garden.HAS_GRANTED_DOMAIN = true  
		player:AddNullCostume(garden.COSTUME_ID_GRANTED_DOMAIN)		
	end

	if player:HasCollectible(garden.COLLECTIBLE_THE_HARVEST) and not garden.HAS_THE_HARVEST then			
		garden.HAS_THE_HARVEST = true  
		player:AddNullCostume(garden.COSTUME_ID_THE_HARVEST)		
	end

	if player:HasCollectible(garden.COLLECTIBLE_EXILED) and not garden.HAS_EXILED then			
		garden.HAS_EXILED = true 
		player:AddNullCostume(garden.COSTUME_ID_EXILED)
		
		local player = Isaac.GetPlayer(0)
		local totalHearts = player:GetMaxHearts()			
		local ignoreKeeper = true
		player:AddMaxHearts(4, ignoreKeeper)		
	end

	if player:HasCollectible(garden.COLLECTIBLE_MANKIND) and not garden.HAS_MANKIND then			
		garden.HAS_MANKIND = true
		local player = Isaac.GetPlayer(0)
		local playerPosition = player.Position			
		Isaac.Spawn(EntityType.ENTITY_FAMILIAR, garden.ADAM_FAMILIAR_VARIANT, 0, playerPosition, Vector(0,0), player)		

		local previousHeartContainers = player:GetMaxHearts()
		local previousSoulHearts = player:GetSoulHearts()
		local previousBlackHearts = player:GetBlackHearts()

		while player:GetPlayerType() ~= PlayerType.PLAYER_EVE do
			player:UseActiveItem(CollectibleType.COLLECTIBLE_CLICKER, false, false, false, false) --Change to Eve
		end			

		player:AddCollectible(CollectibleType.COLLECTIBLE_WHORE_OF_BABYLON , 0, true) -- Give Whore of Babylon

		local diff
		if player:GetMaxHearts() ~= previousHeartContainers then --Restore red heart containers
			diff = previousHeartContainers - player:GetMaxHearts()
			player:AddMaxHearts(diff, false)
		end
		if player:GetSoulHearts() ~= previousSoulHearts then --Restore Soul Hearts
			diff = previousSoulHearts - player:GetSoulHearts()
			player:AddSoulHearts(diff, false)
		end
		if player:GetBlackHearts() ~= previousBlackHearts then --Restore Black Hearts
			diff = previousBlackHearts - player:GetBlackHearts()
			player:AddBlackHearts(diff, false)
		end
		if player:GetHearts() < player:GetMaxHearts() then --Restore red hearts
			player:AddHearts(player:GetMaxHearts(), false)
		end
	end

	if player:HasCollectible(garden.COLLECTIBLE_CRACK_THE_EARTH) and not garden.HAS_CRACK_THE_EARTH then			
		garden.HAS_CRACK_THE_EARTH = true  
		player:AddNullCostume(garden.COSTUME_ID_CRACK_THE_EARTH)		
	end

	if player:HasCollectible(garden.COLLECTIBLE_LEGION) and not garden.HAS_LEGION then			
		garden.HAS_LEGION = true
		Game():ShakeScreen(12)
		SFXManager():Play("177", 3, 0, false, 1)
	end

	--Deceiver Tansformation
	if not garden.HAS_DECEIVER then
	    local shame = Isaac.GetItemIdByName("Shame")
	    local forbiddenFruit = Isaac.GetItemIdByName("Forbidden Fruit")
	    local deception = Isaac.GetItemIdByName("Deception")
	    local creation = Isaac.GetItemIdByName("Creation")	    
	    local grantedDomain = Isaac.GetItemIdByName("Granted Domain")
	    local fallOfMan = Isaac.GetItemIdByName("The Fall of Man")
	    local mankind = Isaac.GetItemIdByName("Mankind")
	    local exiled = Isaac.GetItemIdByName("Exiled")
	    local firstDay = Isaac.GetItemIdByName("The First Day")
	    local beloved = Isaac.GetItemIdByName("My Beloved")
	    local harvest = Isaac.GetItemIdByName("The Harvest")	    
	    local crackTheEarth = Isaac.GetItemIdByName("Crack The Earth")
	    local legion = Isaac.GetItemIdByName("Legion")
		local possibleItems = {shame, forbiddenFruit, deception, creation, grantedDomain, fallOfMan, mankind, exiled, firstDay, beloved, harvest, crackTheEarth, legion}
        local itemCount = 0        
        for k,v in pairs(possibleItems) do        
          if player:HasCollectible(v) then
            itemCount = itemCount + 1
          end
        end 
        
        if itemCount >= 2 then
            garden.HAS_DECEIVER = true 
            player.TearFlags = player.TearFlags | TearFlags.FLAG_POISONING
            local green = Color(0, 255, 0, 255, 0, 0, 0)
			player.TearColor = green		            
            player:AddNullCostume(garden.COSTUME_ID_DECEIVER)            
			local pillText = Isaac.GetPillEffectByName("Deceiver!")
			player:UsePill(pillText,PillColor.PILL_BLUE_BLUE)
			player:StopExtraAnimation() 
			SFXManager():Play(SoundEffect.SOUND_POWERUP_SPEWER, 0.9, 0, false, 1)           											
        end
	end
end
