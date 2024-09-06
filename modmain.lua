-- 文件: modmain.lua
GLOBAL.setmetatable(env,{__index=function(t,k) return GLOBAL.rawget(GLOBAL,k) end})	
-- 引入必要的API
--[[local require = GLOBAL.require
local STRINGS = GLOBAL.STRINGS

local Recipe = GLOBAL.Recipe
local Ingredient = GLOBAL.Ingredient
local RECIPETABS = GLOBAL.RECIPETABS
local TECH = GLOBAL.TECH
local CHARACTER_INGREDIENT = GLOBAL.CHARACTER_INGREDIENT]]

-- 注册新的预设物文件

PrefabFiles = {
    "chicken",
    "henhouse",
    "egg",
    "chicken_feather",
}

Assets = {

	Asset("ATLAS", "images/inventoryimages/henhouse.xml"), 
    Asset("IMAGE", "images/inventoryimages/henhouse.tex"),	

	Asset("ATLAS", "images/inventoryimages/egg.xml"),
    Asset("IMAGE", "images/inventoryimages/egg.tex"),

	Asset("ATLAS", "images/inventoryimages/chicken_feather.xml"),
    Asset("IMAGE", "images/inventoryimages/chicken_feather.tex"),

}

AddMinimapAtlas("images/inventoryimages/chicken.xml")
AddMinimapAtlas("images/inventoryimages/henhouse.xml")
AddMinimapAtlas("images/inventoryimages/egg.xml")
AddMinimapAtlas("images/inventoryimages/chicken_feather.xml")


--[[AddRecipe("henhouse",{
	Ingredient("rope", 3),  
    Ingredient("brid_egg", 2),    
    Ingredient(CHARACTER_INGREDIENT.SANITY, 15),   
	},RECIPETABS.REFINE, TECH.SCIENCE_TWO, nil, nil, nil, nil , henhouse_placer , "images/inventoryimages/henhouse.xml", "henhouse.tex")
]]
--[[AddRecipe("bird_egg",{
	Ingredient("egg", 1, "images/inventoryimages/egg.xml"),      
	Ingredient(CHARACTER_INGREDIENT.SANITY, 5),       
	},RECIPETABS.REFINE, TECH.NONE)]]

AddRecipe("goose_feather",{
    Ingredient("chicken_feather", 1, "images/inventoryimages/chicken_feather.xml"),      
    Ingredient(CHARACTER_INGREDIENT.SANITY, 15),       
      },RECIPETABS.REFINE, TECH.NONE)

local myrecipe = AddRecipe("henhouse", -- name
      {Ingredient("rope", 3),Ingredient("brid_egg", 2),Ingredient(CHARACTER_INGREDIENT.SANITY, 15),}, -- ingredients Add more like so , {Ingredient("boards", 1), Ingredient("rope", 2), Ingredient("twigs", 1), etc}
      GLOBAL.RECIPETABS.REFINE, -- tab ( FARM, WAR, DRESS etc)
      GLOBAL.TECH.SCIENCE_ONE, -- level (GLOBAL.TECH.NONE, GLOBAL.TECH.SCIENCE_ONE, etc)
      "henhouse_placer", -- placer
      1, -- min_spacing
      nil, -- nounlock
      nil, -- numtogive
      nil, -- builder_tag
      "images/inventoryimages/henhouse.xml", -- atlas
      "henhouse.tex") -- image

-- 添加鸡的生成代码
--[[local function AddSpawner()
    local function SpawnChicken(inst)
        local x, y, z = inst.Transform:GetWorldPosition()
        local chicken = GLOBAL.SpawnPrefab("chicken")
        if chicken then
            chicken.Transform:SetPosition(x, y, z)
        end
    end

    local function OnSpawnerWake(inst)
        if math.random() < 0.1 then
            SpawnChicken(inst)
        end
    end

    -- 确保在世界初始化后添加事件监听器
    AddPrefabPostInit("world", function(inst)
        inst:DoTaskInTime(0, function()
            inst:ListenForEvent("spawnerwake", OnSpawnerWake)
        end)
    end)
end

-- 执行初始化函数
AddSpawner()]]

-- 注册新的语言文件

STRINGS.NAMES.CHICKEN = "Chicken"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.CHICKEN = "A small bird with a yellow breast and a black crown."
STRINGS.CHARACTERS.WILLOW.DESCRIBE.CHICKEN = "A small bird with a yellow breast and a black crown."
STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.CHICKEN = "A small bird with a yellow breast and a black crown."
STRINGS.CHARACTERS.WENDY.DESCRIBE.CHICKEN = "A small bird with a yellow breast and a black crown."
STRINGS.CHARACTERS.WX78.DESCRIBE.CHICKEN = "A small bird with a yellow breast and a black crown."
STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.CHICKEN = "A small bird with a yellow breast and a black crown."    
STRINGS.CHARACTERS.WOODIE.DESCRIBE.CHICKEN = "A small bird with a yellow breast and a black crown."
STRINGS.CHARACTERS.WAXWELL.DESCRIBE.CHICKEN = "A small bird with a yellow breast and a black crown."    
STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.CHICKEN = "A small bird with a yellow breast and a black crown."
STRINGS.CHARACTERS.WEBBER.DESCRIBE.CHICKEN = "A small bird with a yellow breast and a black crown."
STRINGS.CHARACTERS.WINONA.DESCRIBE.CHICKEN = "A small bird with a yellow breast and a black crown."
STRINGS.CHARACTERS.WARLY.DESCRIBE.CHICKEN = "A small bird with a yellow breast and a black crown."
STRINGS.CHARACTERS.WORTOX.DESCRIBE.CHICKEN = "A small bird with a yellow breast and a black crown."
STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.CHICKEN = "A small bird with a yellow breast and a black crown."
STRINGS.CHARACTERS.WURT.DESCRIBE.CHICKEN = "A small bird with a yellow breast and a black crown."
STRINGS.CHARACTERS.WALTER.DESCRIBE.CHICKEN = "A small bird with a yellow breast and a black crown."
STRINGS.CHARACTERS.WANDA.DESCRIBE.CHICKEN = "A small bird with a yellow breast and a black crown."

STRINGS.NAMES.HENHOUSE = "Henhouse"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.HENHOUSE = "Henhouse is a small hut with a few chickens inside."
STRINGS.RECIPE_DESC.HENHOUSE = "鸡窝。" 

STRINGS.NAMES.EGG = "Egg"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.EGG = "An egg."

STRINGS.NAMES.CHICKEN_FEATHER = "Chicken Feather"
STRINGS.CHARACTERS.GENERIC.DESCRIBE.CHICKEN_FEATHER = " A feather of a chicken."
