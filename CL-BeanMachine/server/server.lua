local QBCore = exports['qb-core']:GetCoreObject()

local seatsTaken = {}

QBCore.Functions.CreateCallback('CL-BeanMachine:GetPlace', function(source, cb, objectCoords)
	cb(seatsTaken[objectCoords])
end)

RegisterNetEvent('CL-BeanMachine:TakePlace', function(objectCoords)
	seatsTaken[objectCoords] = true
end)

RegisterNetEvent('CL-BeanMachine:LeavePlace', function(objectCoords)
	if seatsTaken[objectCoords] then
		seatsTaken[objectCoords] = nil
	end
end)

QBCore.Functions.CreateUseableItem("bdonut", function(source, item)
    local src = source
    TriggerClientEvent("CL-BeanMachine:Eat", src, Config.Items['DonutItem'], Config.Locals["EatDonutProgressBar"]["Txt"], Config.Locals["EatDonutProgressBar"]["Time"], true, false, false)                                                              				
end)

QBCore.Functions.CreateUseableItem("bbanana", function(source, item)
    local src = source
    TriggerClientEvent("CL-BeanMachine:Eat", src, Config.Items['BananaItem'], Config.Locals["EatBananaProgressBar"]["Txt"], Config.Locals["EatBananaProgressBar"]["Time"], false, true, false)                                                              				
end)

QBCore.Functions.CreateUseableItem("borange", function(source, item)
    local src = source
    TriggerClientEvent("CL-BeanMachine:Eat", src, Config.Items['OrangeItem'], Config.Locals["EatOrangeProgressBar"]["Txt"], Config.Locals["EatOrangeProgressBar"]["Time"], false, true, false)                                                              				
end)

QBCore.Functions.CreateUseableItem("bapple", function(source, item)
    local src = source
    TriggerClientEvent("CL-BeanMachine:Eat", src, Config.Items['AppleItem'], Config.Locals["EatAppleProgressBar"]["Txt"], Config.Locals["EatAppleProgressBar"]["Time"], false, true, false)                                                              				
end)

QBCore.Functions.CreateUseableItem("bmuffin", function(source, item)
    local src = source
    TriggerClientEvent("CL-BeanMachine:Eat", src, Config.Items['RegularMuffinItem'], Config.Locals["EatMuffinProgressBar"]["Txt"], Config.Locals["EatMuffinProgressBar"]["Time"], false, false, true)                                                              				
end)

QBCore.Functions.CreateUseableItem("bchocolatemuffin", function(source, item)
    local src = source
    TriggerClientEvent("CL-BeanMachine:Eat", src, Config.Items['ChocolateMuffinItem'], Config.Locals["EatChocolateMuffinProgressBar"]["Txt"], Config.Locals["EatChocolateMuffinProgressBar"]["Time"], false, false, true)                                                              				
end)

QBCore.Functions.CreateUseableItem("bberrymuffin", function(source, item)
    local src = source
    TriggerClientEvent("CL-BeanMachine:Eat", src, Config.Items['BerryMuffinItem'], Config.Locals["EatBerryMuffinProgressBar"]["Txt"], Config.Locals["EatBerryMuffinProgressBar"]["Time"], false)                                                              				
end)

QBCore.Functions.CreateUseableItem("bsprite", function(source, item)
    local src = source
    TriggerClientEvent("CL-BeanMachine:Drink", src, Config.Items['SpriteItem'], Config.Locals["DrinkingProgressBar"]["Txt"], Config.Locals["DrinkingProgressBar"]["Time"], false, true, false, false)                                                              				
end)

QBCore.Functions.CreateUseableItem("bcocacola", function(source, item)
    local src = source
    TriggerClientEvent("CL-BeanMachine:Drink", src, Config.Items['CocacolaItem'], Config.Locals["DrinkingProgressBar"]["Txt"], Config.Locals["DrinkingProgressBar"]["Time"], true, false, false, false, false)                                                              				
end)

QBCore.Functions.CreateUseableItem("bpepper", function(source, item)
    local src = source
    TriggerClientEvent("CL-BeanMachine:Drink", src, Config.Items['DRPepperItem'], Config.Locals["DrinkingProgressBar"]["Txt"], Config.Locals["DrinkingProgressBar"]["Time"], false, false, true, false, false)                                                              				
end)

QBCore.Functions.CreateUseableItem("blemonslush", function(source, item)
    local src = source
    TriggerClientEvent("CL-BeanMachine:Drink", src, Config.Items['LemonSlushItem'], Config.Locals["DrinkingProgressBar"]["Txt"], Config.Locals["DrinkingProgressBar"]["Time"], false, false, false, true, false)                                                              				
end)

QBCore.Functions.CreateUseableItem("borangeslush", function(source, item)
    local src = source
    TriggerClientEvent("CL-BeanMachine:Drink", src, Config.Items['OrangeSlushItem'], Config.Locals["DrinkingProgressBar"]["Txt"], Config.Locals["DrinkingProgressBar"]["Time"], false, false, false, true, false)                                                              				
end)

QBCore.Functions.CreateUseableItem("bcloudcafe", function(source, item)
    local src = source
    TriggerClientEvent("CL-BeanMachine:Drink", src, Config.Items['CloudCafeItem'], Config.Locals["DrinkingProgressBar"]["Txt"], Config.Locals["DrinkingProgressBar"]["Time"], false, false, false, false, true)                                                              				
end)

QBCore.Functions.CreateUseableItem("bjavachipfrappuccino", function(source, item)
    local src = source
    TriggerClientEvent("CL-BeanMachine:Drink", src, Config.Items['JavaChipFrappuccinoItem'], Config.Locals["DrinkingProgressBar"]["Txt"], Config.Locals["DrinkingProgressBar"]["Time"], false, false, false, false, true)                                                              				
end)

QBCore.Functions.CreateUseableItem("bhotchoc", function(source, item)
    local src = source
    TriggerClientEvent("CL-BeanMachine:Drink", src, Config.Items['HotChocItem'], Config.Locals["DrinkingProgressBar"]["Txt"], Config.Locals["DrinkingProgressBar"]["Time"], false, false, false, false, true)                                                              				
end)

QBCore.Functions.CreateUseableItem("bhoneyhazelnutoatlatte", function(source, item)
    local src = source
    TriggerClientEvent("CL-BeanMachine:Drink", src, Config.Items['HoneyHazelnutOatLatteItem'], Config.Locals["DrinkingProgressBar"]["Txt"], Config.Locals["DrinkingProgressBar"]["Time"], false, false, false, false, true)                                                              				
end)

QBCore.Functions.CreateUseableItem("bstrawberrycreamfrappuccino", function(source, item)
    local src = source
    TriggerClientEvent("CL-BeanMachine:Drink", src, Config.Items['StrawberryCreamFrappuccinoItem'], Config.Locals["DrinkingProgressBar"]["Txt"], Config.Locals["DrinkingProgressBar"]["Time"], false, false, false, false, true)                                                              				
end)

QBCore.Functions.CreateUseableItem("bicedcaffelatte", function(source, item)
    local src = source
    TriggerClientEvent("CL-BeanMachine:Drink", src, Config.Items['IcedCaffeLatteItem'], Config.Locals["DrinkingProgressBar"]["Txt"], Config.Locals["DrinkingProgressBar"]["Time"], false, false, false, false, true)                                                              				
end)

QBCore.Functions.CreateUseableItem("bespresso", function(source, item)
    local src = source
    TriggerClientEvent("CL-BeanMachine:Drink", src, Config.Items['EspressoItem'], Config.Locals["DrinkingProgressBar"]["Txt"], Config.Locals["DrinkingProgressBar"]["Time"], false, false, false, false, true)                                                              				
end)

QBCore.Functions.CreateUseableItem("bespressomacchiato", function(source, item)
    local src = source
    TriggerClientEvent("CL-BeanMachine:Drink", src, Config.Items['EspressoMacchiatoItem'], Config.Locals["DrinkingProgressBar"]["Txt"], Config.Locals["DrinkingProgressBar"]["Time"], false, false, false, false, true)                                                              				
end)

QBCore.Functions.CreateUseableItem("bcaramelfrappucino", function(source, item)
    local src = source
    TriggerClientEvent("CL-BeanMachine:Drink", src, Config.Items['CaramelFrappucinoItem'], Config.Locals["DrinkingProgressBar"]["Txt"], Config.Locals["DrinkingProgressBar"]["Time"], false, false, false, false, true)                                                              				
end)

QBCore.Functions.CreateUseableItem("bcoldbrewlatte", function(source, item)
    local src = source
    TriggerClientEvent("CL-BeanMachine:Drink", src, Config.Items['ColdBrewlatteItem'], Config.Locals["DrinkingProgressBar"]["Txt"], Config.Locals["DrinkingProgressBar"]["Time"], false, false, false, false, true)                                                              				
end)

QBCore.Functions.CreateUseableItem("bstrawberryvanillaoatlatte", function(source, item)
    local src = source
    TriggerClientEvent("CL-BeanMachine:Drink", src, Config.Items['StrawberryVanillaOatLatteItem'], Config.Locals["DrinkingProgressBar"]["Txt"], Config.Locals["DrinkingProgressBar"]["Time"], false, false, false, false, true)                                                              				
end)

QBCore.Functions.CreateUseableItem("bmenu", function(source, item)
    local src = source
    TriggerClientEvent("CL-BeanMachine:OpenMenu", src)                                                              				
end)

RegisterServerEvent('CL-BeanMachine:TakeMoney', function(data)
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

    if Player.PlayerData.money.cash >= data.price then
        TriggerClientEvent("CL-BeanMachine:SpawnVehicle", src, data.vehicle)  
        Player.Functions.RemoveMoney("cash", data.price)
        TriggerClientEvent('QBCore:Notify', src, 'Vehicle Successfully Bought', "success")    
    else
        TriggerClientEvent('QBCore:Notify', src, 'You Dont Have Enough Money !', "error")              
    end    
end)

RegisterServerEvent('CL-BeanMachine:BuyGlass', function(data)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.money.cash >= data.price then
        Player.Functions.RemoveMoney("cash", data.price)
        Player.Functions.AddItem(data.glass, 1)
        TriggerClientEvent("inventory:client:ItemBox", source, QBCore.Shared.Items[data.glass], "add")
        TriggerClientEvent('QBCore:Notify', src, data.glassname .. ' Successfully Bought', "success")   
    else
        TriggerClientEvent('QBCore:Notify', src, 'You Dont Have Enough Money !', "error")              
    end  
end)

QBCore.Functions.CreateCallback('CL-BeanMachine:ItemCheck', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local count = Config.Recipes[item].amount

    for k, v in pairs(Config.Recipes[item].Ingredients) do
        if Player.Functions.GetItemByName(k) == nil or Player.Functions.GetItemByName(k).amount < v then
            cb(true)
        else
            cb(false)
        end
    end
end)

QBCore.Functions.CreateCallback('CL-BeanMachine:CheckForCloudCafeItems', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local glass = Player.Functions.GetItemByName("bhighcoffeeglasscup")
    local milk = Player.Functions.GetItemByName("bmilk")
    local beans = Player.Functions.GetItemByName("bcoffeebeans")
    local cream = Player.Functions.GetItemByName("bcream")
    if glass ~= nil and milk ~= nil and beans ~= nil and cream ~= nil then
        cb(true)
    else
        cb(false)
	end
end)

QBCore.Functions.CreateCallback('CL-BeanMachine:CheckForStrawberryCreamFrappuccinoItems', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local glass = Player.Functions.GetItemByName("bhighcoffeeglasscup")
    local milk = Player.Functions.GetItemByName("bmilk")
    local beans = Player.Functions.GetItemByName("bcoffeebeans")
    local cream = Player.Functions.GetItemByName("bcream")
    local strawberrys = Player.Functions.GetItemByName("bstrawberry")
    if glass ~= nil and milk ~= nil and beans ~= nil and cream ~= nil and strawberrys ~= nil then
        cb(true)
    else
        cb(false)
	end
end)

QBCore.Functions.CreateCallback('CL-BeanMachine:CheckForJavaChipFrappuccinoItems', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local glass = Player.Functions.GetItemByName("bhighcoffeeglasscup")
    local milk = Player.Functions.GetItemByName("bmilk")
    local beans = Player.Functions.GetItemByName("bcoffeebeans")
    local cream = Player.Functions.GetItemByName("bcream")
    if glass ~= nil and milk ~= nil and beans ~= nil and cream ~= nil then
        cb(true)
    else
        cb(false)
	end
end)

QBCore.Functions.CreateCallback('CL-BeanMachine:CheckForHotChocItems', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local glass = Player.Functions.GetItemByName("bcoffeeglass")
    local milk = Player.Functions.GetItemByName("bmilk")
    local beans = Player.Functions.GetItemByName("bcoffeebeans")
    local cream = Player.Functions.GetItemByName("bcream")
    local hotchoc = Player.Functions.GetItemByName("bhotchocolatepowder")
    if glass ~= nil and milk ~= nil and beans ~= nil and cream ~= nil and hotchoc ~= nil then
        cb(true)
    else
        cb(false)
	end
end)

QBCore.Functions.CreateCallback('CL-BeanMachine:CheckForHoneyHazelnutOatLatteItems', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local glass = Player.Functions.GetItemByName("bcoffeeglass")
    local milk = Player.Functions.GetItemByName("bmilk")
    local beans = Player.Functions.GetItemByName("bcoffeebeans")
    local honey = Player.Functions.GetItemByName("bhoney")
    if glass ~= nil and milk ~= nil and beans ~= nil and honey ~= nil then
        cb(true)
    else
        cb(false)
	end
end)

QBCore.Functions.CreateCallback('CL-BeanMachine:CheckForIcedCaffeLatteItems', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local glass = Player.Functions.GetItemByName("bhighcoffeeglasscup")
    local milk = Player.Functions.GetItemByName("bmilk")
    local beans = Player.Functions.GetItemByName("bcoffeebeans")
    local ice = Player.Functions.GetItemByName("bice")
    if glass ~= nil and milk ~= nil and beans ~= nil and ice ~= nil then
        cb(true)
    else
        cb(false)
	end
end)

QBCore.Functions.CreateCallback('CL-BeanMachine:CheckForEspressoItems', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local glass = Player.Functions.GetItemByName("bespressocoffeecup")
    local milk = Player.Functions.GetItemByName("bmilk")
    local beans = Player.Functions.GetItemByName("bcoffeebeans")
    if glass ~= nil and milk ~= nil and beans ~= nil then
        cb(true)
    else
        cb(false)
	end
end)

QBCore.Functions.CreateCallback('CL-BeanMachine:CheckForEspressoMacchiatoItems', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local glass = Player.Functions.GetItemByName("bespressocoffeecup")
    local milk = Player.Functions.GetItemByName("bmilk")
    local beans = Player.Functions.GetItemByName("bcoffeebeans")
    if glass ~= nil and milk ~= nil and beans ~= nil then
        cb(true)
    else
        cb(false)
	end
end)

QBCore.Functions.CreateCallback('CL-BeanMachine:CheckForCaramelFrappucinoItems', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local glass = Player.Functions.GetItemByName("bhighcoffeeglasscup")
    local milk = Player.Functions.GetItemByName("bmilk")
    local beans = Player.Functions.GetItemByName("bcoffeebeans")
    local cream = Player.Functions.GetItemByName("bcream")
    local caramel = Player.Functions.GetItemByName("bcaramelsyrup")
    if glass ~= nil and milk ~= nil and beans ~= nil and cream ~= nil and caramel ~= nil then
        cb(true)
    else
        cb(false)
	end
end)

QBCore.Functions.CreateCallback('CL-BeanMachine:CheckForColdBrewLatteItems', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local glass = Player.Functions.GetItemByName("bhighcoffeeglasscup")
    local milk = Player.Functions.GetItemByName("bmilk")
    local beans = Player.Functions.GetItemByName("bcoffeebeans")
    local ice = Player.Functions.GetItemByName("bice")
    if glass ~= nil and milk ~= nil and beans ~= nil and ice ~= nil then
        cb(true)
    else
        cb(false)
	end
end)

QBCore.Functions.CreateCallback('CL-BeanMachine:CheckForStrawberryVanillaOatLatteItems', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    local glass = Player.Functions.GetItemByName("bcoffeeglass")
    local milk = Player.Functions.GetItemByName("bmilk")
    local beans = Player.Functions.GetItemByName("bcoffeebeans")
    local strawberry = Player.Functions.GetItemByName("bstrawberry")
    if glass ~= nil and milk ~= nil and beans ~= nil and strawberry ~= nil then
        cb(true)
    else
        cb(false)
	end
end)

QBCore.Functions.CreateCallback('CL-BeanMachine:CheckDuty', function(source, cb)
    local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    if Player.PlayerData.job.onduty then
        cb(true)
    else
        cb(false)
	end
end)

RegisterServerEvent('CL-BeanMachine:ResetDuty', function()
	local src = source
	local Player = QBCore.Functions.GetPlayer(src)

    Player.Functions.SetJobDuty(false)  
end)