--[[-- modworldgen.lua

--[[ 定义一个函数来生成鸡
--local function AddhenhousesToGreatPlains(level)
    -- 获取大草原的生物群系
    local great_plains = level.map:GetBiome("Great Plains")

    -- 检查是否找到了大草原生物群系
    if great_plains then
        -- 在大草原中添加鸡
        level.map:AddEntityToBiome("henhouse", great_plains)
    end
end

-- 在地图生成时调用这个函数
AddPrefabPostInit("world", function(inst)
    if TheWorld.ismastersim then
        inst:DoTaskInTime(0, function()
            AddhenhousesToGreatPlains(TheWorld)
        end)
    end
end)


-- 添加鸡到 BeefalowPlain 房间
AddRoom("BeefalowPlain", {
    colour = {r = .45, g = .5, b = .85, a = .50},
    value = WORLD_TILES.SAVANNA,
    contents = {
        distributepercent = .05,
        distributeprefabs = {
            grass = .01,
            beefalo = 0.02,
            henhouse = 0.03,  -- 添加鸡的生成概率
        }
    }
})
]] --错误方法别学习。

-- 不能让生物这样添加，可以让“建筑”这样添加，让某个建筑充当动物的巢穴。
--没有巢穴无法生成动物，需要巢穴中添加inst:AddComponent("childspawner")。
--依旧不行，要么设置mao里的标准sta组，要么设置成矿物植物或者蜂巢可收集的形式才可以自然生成。

--[[local henhouse_rate = (GetModConfigData("henhouse_rate")/4)
local henhouse_regions = (GetModConfigData("henhouse_regions"))

--[[AddRoomPreInit("BGNoise", function(room)
	room.contents.distributeprefabs.henhouse = henhouse_rate
end)

AddRoomPreInit("NoisyCave", function(room)
	room.contents.distributeprefabs.henhouse = henhouse_rate
end)

AddRoomPreInit("CaveRoom", function(room)
	room.contents.distributeprefabs.henhouse = henhouse_rate
end)

AddRoomPreInit("RockLobsterPlains", function(room)
	room.contents.distributeprefabs.henhouse = henhouse_rate
end)

AddRoomPreInit("BatCaveRoom", function(room)
	room.contents.distributeprefabs.henhouse = (henhouse_rate/2)
end)

AddRoomPreInit("BatCaveRoomAntichamber", function(room)
	room.contents.distributeprefabs.henhouse = (henhouse_rate/2)
end)
Will be activated as soon as more caves are in multiplayer]]

print("Spawned Bee Beefalo and Moose Goose.")
AddRoomPreInit("BeeClearing", function(room)
	room.contents.distributeprefabs.henhouse = (henhouse_rate/2)

end)

AddRoomPreInit("BeeQueenBee", function(room)
	room.contents.distributeprefabs.henhouse = (henhouse_rate/3)

end)

AddRoomPreInit("BeefalowPlain", function(room)
	room.contents.distributeprefabs.henhouse = (henhouse_rate)	

end)

AddRoomPreInit("MooseGooseBreedingGrounds", function(room)	
	room.contents.distributeprefabs.henhouse = (henhouse_rate)

end)

print("Spawned Tough Stone in Rocky Biomes")

if henhouse_regions~=nil then
	if henhouse_regions > 0 then
		
		AddRoomPreInit("BGDirt", function(room)
			room.contents.distributeprefabs.henhouse = henhouse_rate/12
		
		end)
		
		AddRoomPreInit("BGBadlands", function(room)
			room.contents.distributeprefabs.henhouse = henhouse_rate/12
		
		end)
		
		AddRoomPreInit("BGChessRocky", function(room)
			room.contents.distributeprefabs.henhouse = (henhouse_rate/12
		
		end)
		
		AddRoomPreInit("BGRocky", function(room)
			room.contents.distributeprefabs.henhouse = henhouse_rate/12
		
		end)
		
		AddRoomPreInit("Rocky", function(room)
			room.contents.distributeprefabs.henhouse = henhouse_rate/12
		
		end)

	if henhouse_regions > 1 then
		AddRoomPreInit("Marsh", function(room)
			room.contents.distributeprefabs.henhouse = (henhouse_rate/16)

		end)

		AddRoomPreInit("BGMarsh", function(room)
			room.contents.distributeprefabs.henhouse = (henhouse_rate/16)

		end)

		AddRoomPreInit("SlightlyMermySwamp", function(room)
			room.contents.distributeprefabs.henhouse = (henhouse_rate/16)

		end)
		print("Spawned Tough Stone in Marsh Biomes")
	end

	if henhouse_regions > 2 then
		AddRoomPreInit("CrappyForest", function(room)
			room.contents.distributeprefabs.henhouse = (henhouse_rate/20)

		end)

		AddRoomPreInit("Forest", function(room)
			room.contents.distributeprefabs.henhouse = (henhouse_rate/20)

		end)

		AddRoomPreInit("DeepForest", function(room)
			room.contents.distributeprefabs.henhouse = (henhouse_rate/20)

		end)

		AddRoomPreInit("CrappyDeepForest", function(room)
			room.contents.distributeprefabs.henhouse = (henhouse_rate/20)

		end)

		AddRoomPreInit("BGForest", function(room)
			room.contents.distributeprefabs.henhouse = (henhouse_rate/20)

		end)

		print("Spawned Tough Stone in Forrest Biomes")
		--[[AddRoomPreInit("Graveyard", function(room)
			room.contents.distributeprefabs.henhouse = (henhouse_rate/4)
		end)]]

	end
	
	if henhouse_regions > 3 then
		AddRoomPreInit("BGNoise", function(room)
			room.contents.distributeprefabs.henhouse = (henhouse_rate/60)

		end)

		AddRoomPreInit("Plain", function(room)
			room.contents.distributeprefabs.henhouse = (henhouse_rate/80)

		end)

		AddRoomPreInit("BarePlain", function(room)
			room.contents.distributeprefabs.henhouse = (henhouse_rate/50)

		end)

		AddRoomPreInit("BGSavanna", function(room)
			room.contents.distributeprefabs.henhouse = (henhouse_rate/70)

		end)

		AddRoomPreInit("BGGrass", function(room)
			room.contents.distributeprefabs.henhouse = (henhouse_rate/50)

		end)

		AddRoomPreInit("EvilFlowerPatch", function(room)
			room.contents.distributeprefabs.henhouse = (henhouse_rate/50)

		end)
		print("Spawned Stone")
	end
else
	print("henhouse_regions is nil")
end

]]