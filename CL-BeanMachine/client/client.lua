local QBCore = exports['qb-core']:GetCoreObject()

local occupied = {}

local CanSit = false

PlayerJob = {}

----------------
----Handlers
----------------
RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
	QBCore.Functions.GetPlayerData(function(PlayerData)
		PlayerJob = PlayerData.job
	end)
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

AddEventHandler('onClientResourceStart',function(resource)
	if GetCurrentResourceName() == resource then
		Citizen.CreateThread(function()
			while true do
				QBCore.Functions.GetPlayerData(function(PlayerData)
					if PlayerData.job then
						PlayerJob = PlayerData.job
						QBCore.Functions.TriggerCallback('CL-BeanMachine:CheckDuty', function(result)
							if result then
								TriggerServerEvent("CL-BeanMachine:ResetDuty")
							end
						end)
					end
				end)
				break
			end
			Citizen.Wait(1)
		end)
	end
end)

----------------
----Blips
----------------
Citizen.CreateThread(function()
	for _, info in pairs(Config.BlipLocation) do
		if Config.UseBlips then
			info.blip = AddBlipForCoord(info.x, info.y, info.z)
			SetBlipSprite(info.blip, info.id)
			SetBlipDisplay(info.blip, 4)
			SetBlipScale(info.blip, 0.6)	
			SetBlipColour(info.blip, info.colour)
			SetBlipAsShortRange(info.blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(info.title)
			EndTextCommandSetBlipName(info.blip)
		end
	end	
end)

----------------
----Garage Marker
----------------
CreateThread(function()
    while true do
        local plyPed = PlayerPedId()
        local plyCoords = GetEntityCoords(plyPed)
        local letSleep = true        

        if PlayerJob.name == Config.Job then
            if (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, 130.01286, -1034.836, 29.433467, true) < Config.MarkerDistance) then
                letSleep = false
                DrawMarker(36, 130.01286, -1034.836, 29.433467 + 0.2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.7, 0.7, 0.5, 0.5, 120, 119, 42, 255, true, false, false, true, false, false, false)
                 if (GetDistanceBetweenCoords(plyCoords.x, plyCoords.y, plyCoords.z, 130.01286, -1034.836, 29.433467, true) < 1.5) then
                    DrawText3D(130.01286, -1034.836, 29.433467, "~g~E~w~ - Bean Machine Garage") 
                    if IsControlJustReleased(0, 38) then
                        TriggerEvent("CL-BeanMachine:Garage:Menu")
                    end
                end  
            end
        end

        if letSleep then
            Wait(2000)
        end

        Wait(1)
    end
end)

----------------
----Target
----------------
Citizen.CreateThread(function()
	exports[Config.Target]:AddBoxZone("Duty", vector3(126.99156, -1035.663, 29.569875), 0.3, 1.2, {
		name = "Duty",
		heading = 248.91331,
		debugPoly = Config.PolyZone,
		minZ = 28.569875,
		maxZ = 30.569875,
	}, {
		options = { 
			{
				type = "client",
				event = "CL-BeanMachine:DutyMenu",
				icon = Config.Locals["DutyTarget"]["Icon"],
				label = Config.Locals["DutyTarget"]["Label"],
				canInteract = function()
					if PlayerJob.name == Config.Job then
						return true
					else
						return false
					end
				end,
			},
			{
				type = "client",
				event = "qb-clothing:client:openMenu",
				icon = Config.Locals["ClothingTarget"]["Icon"],
				label = Config.Locals["ClothingTarget"]["Label"],
				canInteract = function()
					if Config.UseClothing == true and PlayerJob.name == Config.Job then
						return true
					else
						return false
					end
				end,
			}
		},
		distance = 1.1,
	})

	for k, v in pairs(Config.Chairs) do
		exports[Config.Target]:AddBoxZone("Chair"..k, vector3(v.coords.x, v.coords.y, v.coords.z), v.poly1, v.poly2, {
			name = "Chair"..k,
			heading = v.heading,
			debugPoly = Config.PolyZone,
			minZ = v.minZ,
			maxZ = v.maxZ,
			}, {
				options = { 
				{
					type = "client",
					event = "CL-BeanMachine:Sit",
					icon = Config.Locals['SitTarget']['Icon'],
					label = Config.Locals['SitTarget']['Label'],
					pos = v.coords,
					heading = v.heading
				}
			},
			distance = 1.2,
		})
	end

	exports[Config.Target]:AddBoxZone("Toasts", vector3(121.52722, -1038.46, 29.868322), 0.5, 1.4, {
		name = "Toasts",
		heading = 70.007614,
		debugPoly = Config.PolyZone,
		minZ = 28.274829,
		maxZ = 30.274829,
		}, {
			options = { 
			{
				type = "client",
				event = "CL-BeanMachine:ToastsMenu",
				icon = Config.Locals['ToastsTarget']['Icon'],
				label = Config.Locals['ToastsTarget']['Label'],
				canInteract = function()
					if PlayerJob.name == Config.Job then
						return true
					else
						return false
					end
				end,
			}
		},
		distance = 1.2,
	})

	exports[Config.Target]:AddBoxZone("Tray1", vector3(121.84783, -1037.075, 29.967689), 0.3, 0.5, {
		name = "Tray1",
		heading = 250.27737,
		debugPoly = Config.PolyZone,
		minZ = 28.967689,
		maxZ = 30.967689,
		}, {
			options = { 
			{
				type = "client",
				event = "CL-BeanMachine:OpenTray1",
				icon = Config.Locals['TrayTarget']['Icon'],
				label = Config.Locals['TrayTarget']['Label'],
			}
		},
		distance = 1.2,
	})

	exports[Config.Target]:AddBoxZone("Tray2", vector3(120.52185, -1040.673, 29.967689), 0.3, 0.5, {
		name = "Tray2",
		heading = 250.27737,
		debugPoly = Config.PolyZone,
		minZ = 28.967689,
		maxZ = 30.967689,
		}, {
			options = { 
			{
				type = "client",
				event = "CL-BeanMachine:OpenTray2",
				icon = Config.Locals['TrayTarget']['Icon'],
				label = Config.Locals['TrayTarget']['Label'],
			}
		},
		distance = 1.2,
	})

	exports[Config.Target]:AddBoxZone("Fruits", vector3(119.99523, -1043.654, 29.277912), 0.4, 0.4, {
		name = "Fruits",
		heading = 136.63201,
		debugPoly = Config.PolyZone,
		minZ = 28.277912,
		maxZ = 30.277912,
		}, {
			options = { 
			{
				type = "client",
				event = "CL-BeanMachine:FruitsMenu",
				icon = Config.Locals['FruitsTarget']['Icon'],
				label = Config.Locals['FruitsTarget']['Label'],
			}
		},
		distance = 1.2,
	})

	exports[Config.Target]:AddBoxZone("Oranges", vector3(119.18809, -1034.112, 29.606691), 0.4, 0.4, {
		name = "Oranges",
		heading = 70.05281,
		debugPoly = Config.PolyZone,
		minZ = 28.606691,
		maxZ = 30.606691,
		}, {
			options = { 
			{
				type = "client",
				event = "CL-BeanMachine:FruitsMenu2",
				icon = Config.Locals['FruitsTarget']['Icon'],
				label = Config.Locals['FruitsTarget']['Label'],
			}
		},
		distance = 1.2,
	})

	exports[Config.Target]:AddBoxZone("Muffins", vector3(122.76106, -1044.733, 29.598379), 0.5, 0.5, {
		name = "Muffins",
		heading = 161.81346,
		debugPoly = Config.PolyZone,
		minZ = 28.598379,
		maxZ = 30.598379,
		}, {
			options = { 
			{
				type = "client",
				event = "CL-BeanMachine:MuffinsMenu",
				icon = Config.Locals['MuffinsTarget']['Icon'],
				label = Config.Locals['MuffinsTarget']['Label'],
				canInteract = function()
					if PlayerJob.name == Config.Job then
						return true
					else
						return false
					end
				end,
			}
		},
		distance = 1.5,
	})

	exports[Config.Target]:AddBoxZone("Stash", vector3(121.75633, -1038.512, 28.200302), 0.5, 3.3, {
		name = "Stash",
		heading = 70.007614,
		debugPoly = Config.PolyZone,
		minZ = 27.127885,
		maxZ = 29.127885,
		}, {
			options = { 
			{
				type = "client",
				event = "CL-BeanMachine:OpenWorkersStash",
				icon = Config.Locals['StashTarget']['Icon'],
				label = Config.Locals['StashTarget']['Label'],
				canInteract = function()
					if PlayerJob.name == Config.Job then
						return true
					else
						return false
					end
				end,
			}
		},
		distance = 1.2,
	})

	exports[Config.Target]:AddBoxZone("Shop", vector3(120.53882, -1041.839, 28.596639), 0.5, 3.3, {
		name = "Shop",
		heading = 70.007614,
		debugPoly = Config.PolyZone,
		minZ = 27.127885,
		maxZ = 29.127885,
		}, {
			options = { 
			{
				type = "client",
				event = "CL-BeanMachine:OpenShop",
				icon = Config.Locals['ShopTarget']['Icon'],
				label = Config.Locals['ShopTarget']['Label'],
				canInteract = function()
					if PlayerJob.name == Config.Job then
						return true
					else
						return false
					end
				end,
			}
		},
		distance = 1.2,
	})

	exports[Config.Target]:AddBoxZone("Washbasin", vector3(123.72518, -1039.217, 29.277908), 0.5, 1.0, {
		name = "Washbasin",
		heading = 249.26232,
		debugPoly = Config.PolyZone,
		minZ = 28.96301,
		maxZ = 30.96301,
		}, {
			options = { 
			{
				type = "client",
				event = "CL-BeanMachine:WashHands",
				icon = Config.Locals['WashHandsTarget']['Icon'],
				label = Config.Locals['WashHandsTarget']['Label'],
				canInteract = function()
					if PlayerJob.name == Config.Job then
						return true
					else
						return false
					end
				end,
			},
		},
		distance = 1.2,
	})

	for k, v in pairs(Config.CupsLocations) do
		exports[Config.Target]:AddBoxZone("CupLocation"..k, vector3(v.coords.x, v.coords.y, v.coords.z), 0.3, 0.3, {
			name = "CupLocation"..k,
			heading = v.heading,
			debugPoly = Config.PolyZone,
			minZ = v.minZ,
			maxZ = v.maxZ,
			}, {
				options = { 
				{
					type = "client",
					event = "CL-BeanMachine:CupsMenu",
					icon = Config.Locals['CupTarget']['Icon'],
					label = Config.Locals['CupTarget']['Label'],
					canInteract = function()
						if PlayerJob.name == Config.Job then
							return true
						else
							return false
						end
					end,
				}
			},
			distance = 1.2,
		})
	end

	exports[Config.Target]:AddBoxZone("Drinks", vector3(123.5383, -1042.678, 29.466598), 0.5, 1.4, {
		name = "Drinks",
		heading = 339.35379,
		debugPoly = Config.PolyZone,
		minZ = 28.466598,
		maxZ = 30.466598,
		}, {
			options = { 
			{
				type = "client", 
				event = "CL-BeanMachine:DrinksMenu",
				icon = Config.Locals['DrinksTarget']['Icon'],
				label = Config.Locals['DrinksTarget']['Label'],
				canInteract = function()
					if PlayerJob.name == Config.Job then
						return true
					else
						return false
					end
				end,
			}
		},
		distance = 1.2,
	})

	exports[Config.Target]:AddBoxZone("Slush", vector3(126.05076, -1036.595, 29.085569), 0.4, 0.5, {
		name = "Slush",
		heading = 342.10079,
		debugPoly = Config.PolyZone,
		minZ = 28.085569,
		maxZ = 30.085569,
		}, {
			options = { 
			{
				type = "client", 
				event = "CL-BeanMachine:SlushsMenu",
				icon = Config.Locals['SlushsTarget']['Icon'],
				label = Config.Locals['SlushsTarget']['Label'],
				canInteract = function()
					if PlayerJob.name == Config.Job then
						return true
					else
						return false
					end
				end,
			}
		},
		distance = 1.0,
	})

	for k, v in pairs(Config.CoffeeLocations) do
		exports[Config.Target]:AddBoxZone("CoffeeLocation"..k, vector3(v.coords.x, v.coords.y, v.coords.z), 0.4, 0.7, {
			name = "CoffeeLocation"..k,
			heading = v.heading,
			debugPoly = Config.PolyZone,
			minZ = v.minZ,
			maxZ = v.maxZ,
			}, {
				options = { 
				{
					type = "client",
					event = "CL-BeanMachine:SeperatingEvent",
					icon = Config.Locals['CoffeeTarget']['Icon'],
					label = Config.Locals['CoffeeTarget']['Label'],
					firstmenu = v.firstmenu,
					secondmenu = v.secondmenu,
					canInteract = function()
						if PlayerJob.name == Config.Job then
							return true
						else
							return false
						end
					end,
				}
			},
			distance = 1.2,
		})
	end

	exports[Config.Target]:AddBoxZone("Beans", vector3(123.30837, -1040.704, 29.320747), 0.2, 0.8, {
		name = "Beans",
		heading = 249.3034,
		debugPoly = Config.PolyZone,
		minZ = 29.020747,
		maxZ = 29.920747,
		}, {
			options = { 
			{
				type = "client", 
				event = "CL-BeanMachine:BeansMenu",
				icon = Config.Locals['BeansTarget']['Icon'],
				label = Config.Locals['BeansTarget']['Label'],
				canInteract = function()
					if PlayerJob.name == Config.Job then
						return true
					else
						return false
					end
				end,
			}
		},
		distance = 1.0,
	})

	exports[Config.Target]:AddBoxZone("Beans2", vector3(124.29961, -1037.889, 29.320747), 0.2, 0.8, {
		name = "Beans2",
		heading = 249.3034,
		debugPoly = Config.PolyZone,
		minZ = 28.220747,
		maxZ = 30.020747,
		}, {
			options = { 
			{
				type = "client", 
				event = "CL-BeanMachine:BeansMenu",
				icon = Config.Locals['BeansTarget']['Icon'],
				label = Config.Locals['BeansTarget']['Label'],
				canInteract = function()
					if PlayerJob.name == Config.Job then
						return true
					else
						return false
					end
				end,
			}
		},
		distance = 1.0,
	})

	exports[Config.Target]:AddBoxZone("Glasses", vector3(123.37149, -1040.964, 29.997602), 0.4, 1.6, {
		name = "Glasses",
		heading = 249.3034,
		debugPoly = Config.PolyZone,
		minZ = 29.997602,
		maxZ = 30.597602,
		}, {
			options = { 
			{
				type = "client", 
				event = "CL-BeanMachine:GlassesMenu",
				icon = Config.Locals['GlassesTarget']['Icon'],
				label = Config.Locals['GlassesTarget']['Label'],
				canInteract = function()
					if PlayerJob.name == Config.Job then
						return true
					else
						return false
					end
				end,
			}
		},
		distance = 1.5,
	})
end)

----------------
----Events
----------------
RegisterNetEvent("CL-BeanMachine:OpenTray1", function()
	TriggerServerEvent("inventory:server:OpenInventory", "stash", "Bean Machine Tray", {maxweight = 30000, slots = 10})
	TriggerEvent("inventory:client:SetCurrentStash", "Bean Machine Tray") 
end)

RegisterNetEvent("CL-BeanMachine:OpenTray2", function()
	TriggerServerEvent("inventory:server:OpenInventory", "stash", "Bean Machine Tray 2", {maxweight = 30000, slots = 10})
	TriggerEvent("inventory:client:SetCurrentStash", "Bean Machine Tray 2") 
end)

RegisterNetEvent("CL-BeanMachine:OpenWorkersStash", function()
	QBCore.Functions.TriggerCallback('CL-BeanMachine:CheckDuty', function(result)
		if result then
			TriggerServerEvent("inventory:server:OpenInventory", "stash", "Bean Machine Stash", {maxweight = 100000, slots = 100})
			TriggerEvent("inventory:client:SetCurrentStash", "Bean Machine Stash") 
		else
			QBCore.Functions.Notify("You must be on duty.", "error")
		end
	end)
end)

RegisterNetEvent('CL-BeanMachine:OpenShop', function()
	QBCore.Functions.TriggerCallback('CL-BeanMachine:CheckDuty', function(result)
		if result then
			TriggerServerEvent("inventory:server:OpenInventory", "shop", "Main Shop", Config.ShopItems)
		else
			QBCore.Functions.Notify("You must be on duty.", "error")
		end
	end)
end)

RegisterNetEvent('CL-BeanMachine:WashHands', function()
	QBCore.Functions.TriggerCallback('CL-BeanMachine:CheckDuty', function(result)
		if result then
			QBCore.Functions.Progressbar("wash_hands", Config.Locals["WashingHandsProgressBar"]["Txt"], Config.Locals["WashingHandsProgressBar"]["Time"], false, true, {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			}, {
				animDict = "amb@world_human_bum_wash@male@low@base",
				anim = "base",
				flags = 49,
			}, {}, {}, function()
				TriggerServerEvent('hud:server:RelieveStress', Config.WashingHandsStress)
			end, function()
				QBCore.Functions.Notify("Canceled...", "error")
			end)
		else
			QBCore.Functions.Notify("You must be on duty.", "error")
		end
	end)
end)

RegisterNetEvent("CL-BeanMachine:Sit")
AddEventHandler("CL-BeanMachine:Sit", function(data)
	QBCore.Functions.TriggerCallback('CL-BeanMachine:GetPlace', function(occupied)
		if occupied then
			QBCore.Functions.Notify('Chair Is Being Used.', 'error')
		else
			local playerPos = GetEntityCoords(PlayerPedId())
			local playerPed = PlayerPedId()
			CanSit = true
		
			SetEntityHeading(data.heading)
		
			TriggerServerEvent('CL-BeanMachine:TakePlace', data.pos.x, data.pos.y, data.pos.z)
				
			TaskStartScenarioAtPosition(playerPed, "PROP_HUMAN_SEAT_CHAIR_MP_PLAYER", data.pos.x, data.pos.y, data.pos.z-0.20, data.heading, 0, true, true)
		
			Citizen.CreateThread(function()
				while true do
					if CanSit then
						ShowHelpNotification("Press ~INPUT_FRONTEND_RRIGHT~ To Get Up")
					elseif not CanSit then
						break
					end
					if IsControlJustReleased(0, 177) then
						CanSit = false
						ClearPedTasks(playerPed)
						TriggerServerEvent('CL-BeanMachine:LeavePlace', data.pos.x, data.pos.y, data.pos.z)
						TriggerServerEvent("CL-BeanMachine:CheckSit:Server:SetSitActive", false)
						PlaySoundFrontend(-1, "NO", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
						break
					end
					Citizen.Wait(1)
				end
			end)
		end
	end, data.pos.x, data.pos.y, data.pos.z)
end)

RegisterNetEvent('CL-BeanMachine:Grab')
AddEventHandler('CL-BeanMachine:Grab', function(data)
	QBCore.Functions.Progressbar('grab'..data.item, data.progressbartext, data.progressbartime, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = data.animationdict,
		anim = data.animation,
		flags = 49,
	}, {}, {}, function()
		TriggerServerEvent("QBCore:Server:AddItem", data.item, 1)
		TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[data.item], "add")
	end, function()
		QBCore.Functions.Notify("Canceled...", "error")
	end)
end)

RegisterNetEvent('CL-BeanMachine:Eat')
AddEventHandler('CL-BeanMachine:Eat', function(item, progressbartext, progressbartime, donut, fruit, muffin)
	if donut then
		TriggerEvent("CL-BeanMachine:SpawnObject", "prop_amb_donut", 18905, 0.13, 0.05, 0.02, -50.0, 16.0, 60.0, 3500, false)
		TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + Config.EatingDonutHunger)
	elseif fruit then
		TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + Config.EatingFruitsHunger)
	elseif muffin then
		TriggerServerEvent("QBCore:Server:SetMetaData", "hunger", QBCore.Functions.GetPlayerData().metadata["hunger"] + Config.EatingMuffinsHunger)
	end
	QBCore.Functions.Progressbar('eat'..item, progressbartext, progressbartime, false, true, {
		disableMovement = false,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "mp_player_inteat@burger",
		anim = "mp_player_int_eat_burger",
		flags = 49,
	}, {}, {}, function()
		TriggerServerEvent("QBCore:Server:RemoveItem", item, 1)
		TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[item], "remove")
	end, function()
		QBCore.Functions.Notify("Canceled...", "error")
	end)
end)

RegisterNetEvent('CL-BeanMachine:Drink')
AddEventHandler('CL-BeanMachine:Drink', function(item, progressbartext, progressbartime, cola, sprite, pepper, slush, coffee)
	TriggerServerEvent("QBCore:Server:SetMetaData", "thirst", QBCore.Functions.GetPlayerData().metadata["thirst"] + Config.DrinksThirstLevel)
	if cola then 
		TriggerEvent("CL-BeanMachine:SpawnObject", "prop_cs_bs_cup", 28422, 0.01, -0.01, -0.00, 0.0, 0.0, 0.0, 5500, false, false)
	elseif pepper then
		TriggerEvent("CL-BeanMachine:SpawnObject", "prop_plastic_cup_02", 28422, 0.01, -0.01, -0.00, 0.0, 0.0, 0.0, 5500, false, false)
	elseif sprite then
		TriggerEvent("CL-BeanMachine:SpawnObject", "ng_proc_sodacan_01b", 28422, 0.01, -0.01, -0.07, 0.0, 0.0, 0.0, 5500, false, false)
	elseif slush then
		TriggerEvent("CL-BeanMachine:SpawnObject", "v_ret_fh_bscup", 28422, 0.01, -0.01, -0.00, 0.0, 0.0, 0.0, 5500, true, false)
	elseif coffee then
		TriggerEvent("CL-BeanMachine:SpawnObject", "ng_proc_coffee_01a", 28422, 0.01, -0.01, -0.07, 0.0, 0.0, 0.0, 5500, false, true)
	end
	QBCore.Functions.Progressbar('drinking'..item, progressbartext, progressbartime, false, true, {
		disableMovement = false,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "amb@world_human_drinking@coffee@male@idle_a",
		anim = "idle_a",
		flags = 49,
	}, {}, {}, function()
		TriggerServerEvent("QBCore:Server:RemoveItem", item, 1)
		TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[item], "remove")
	end, function()
		QBCore.Functions.Notify("Canceled...", "error")
	end)
end)

RegisterNetEvent("CL-BeanMachine:SpawnObject")
AddEventHandler("CL-BeanMachine:SpawnObject", function(prop, bone, boneindex1, boneindex2, boneindex3, boneindex4, boneindex5, boneindex6, time, slush, coffee)
	LoadModel(prop)
	local Object = CreateObject(GetHashKey(prop), GetEntityCoords(PlayerPedId()), true)
	local pedCoords = GetEntityCoords(PlayerPedId())
	local object = GetClosestObjectOfType(pedCoords, 10.0, GetHashKey(prop), false)
	local itemid = object
	AttachEntityToEntity(object, GetPlayerPed(PlayerId()),GetPedBoneIndex(GetPlayerPed(PlayerId()), bone),boneindex1, boneindex2, boneindex3, boneindex4, boneindex5, boneindex6,1,1,0,1,0,1)
	Wait(time)
	DetachEntity(object, true, true)
	DeleteObject(object)
	if slush then
		SlushEffect()
		QBCore.Functions.Notify("Your Head Hurts A Bit")
	elseif coffee then
		CoffeeEffect()
		QBCore.Functions.Notify("You Are Feeling More Awake")
	end
end)

RegisterNetEvent("CL-BeanMachine:SpawnVehicle")
AddEventHandler("CL-BeanMachine:SpawnVehicle", function(vehicle)
    local coords = vector4(129.97741, -1035.136, 29.433469, 342.09756)

    QBCore.Functions.SpawnVehicle(vehicle, function(veh)
        SetVehicleNumberPlateText(veh, "BEAN"..tostring(math.random(1000, 9999)))
        exports['LegacyFuel']:SetFuel(veh, 100.0)
        CloseMenu()
        TaskWarpPedIntoVehicle(PlayerPedId(), veh, -1)
        TriggerEvent("vehiclekeys:client:SetOwner", QBCore.Functions.GetPlate(veh))
        SetVehicleEngineOn(veh, true, true)
    end, coords, true)
end)

RegisterNetEvent('CL-BeanMachine:StoreVehicle')
AddEventHandler('CL-BeanMachine:StoreVehicle', function()
    local ped = PlayerPedId()
    local car = GetVehiclePedIsIn(PlayerPedId(), true)

    if IsPedInAnyVehicle(ped, false) then
        TaskLeaveVehicle(ped, car, 1)
        Citizen.Wait(2000)
        QBCore.Functions.Notify('Vehicle Stored !', 'success')
        DeleteVehicle(car)
        DeleteEntity(car)
    else
        QBCore.Functions.Notify("You Are Not In Any Vehicle !", "error")
    end
end)

RegisterNetEvent('CL-BeanMachine:TakeCup')
AddEventHandler('CL-BeanMachine:TakeCup', function(data)
	QBCore.Functions.Progressbar('grab'.. data.cup, "Grabing " .. data.cupname .."...", 1700, false, true, {
		disableMovement = true,
		disableCarMovement = true,
		disableMouse = false,
		disableCombat = true,
	}, {
		animDict = "anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@normal",
		anim = "pour_one",
		flags = 49,
	}, {}, {}, function()
		QBCore.Functions.Notify("You Grabed " .. data.cupname, "success")
		TriggerServerEvent("QBCore:Server:AddItem", data.cup, 1)
		TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[data.cup], "add")
	end, function()
		QBCore.Functions.Notify("Canceled...", "error")
	end)
end)

RegisterNetEvent('CL-BeanMachine:MakeDrink')
AddEventHandler('CL-BeanMachine:MakeDrink', function(data)
	QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
		if result then
			QBCore.Functions.Progressbar('making'.. data.drink, "Making " .. data.drinkname .."...", 2700, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {
				animDict = "anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@normal",
				anim = "idle",
				flags = 49,
			}, {}, {}, function()
				QBCore.Functions.Notify(data.drinkname .. " Successfully Made", "success")
				TriggerServerEvent("QBCore:Server:AddItem", data.drink, 1)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[data.drink], "add")
				TriggerServerEvent("QBCore:Server:RemoveItem", data.cupneeded, 1)
			end, function()
				QBCore.Functions.Notify("Canceled...", "error")
			end)
		else
			QBCore.Functions.Notify("You Dont Have " ..data.cupsize, "error")
		end
	end, data.cupneeded)
end)

RegisterNetEvent('CL-BeanMachine:MakeSlush')
AddEventHandler('CL-BeanMachine:MakeSlush', function(data)
	QBCore.Functions.TriggerCallback('QBCore:HasItem', function(result)
		if result then
			QBCore.Functions.Progressbar('making'.. data.slush, "Making " .. data.slushname .."...", 2700, false, true, {
				disableMovement = true,
				disableCarMovement = true,
				disableMouse = false,
				disableCombat = true,
			}, {
				animDict = "anim@amb@nightclub@mini@drinking@drinking_shots@ped_a@normal",
				anim = "idle",
				flags = 49,
			}, {}, {}, function()
				QBCore.Functions.Notify(data.slushname .. " Successfully Made", "success")
				TriggerServerEvent("QBCore:Server:AddItem", data.slush, 1)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[data.slush], "add")
				TriggerServerEvent("QBCore:Server:RemoveItem", data.cupsize, 1)
			end, function()
				QBCore.Functions.Notify("Canceled...", "error")
			end)
		else
			QBCore.Functions.Notify("You Dont Have " ..data.cupname, "error")
		end
	end, data.cupsize)
end)

RegisterNetEvent("CL-BeanMachine:MakeCoffee")
AddEventHandler("CL-BeanMachine:MakeCoffee", function(data)
	QBCore.Functions.TriggerCallback('CL-BeanMachine:CheckFor'..data.coffeeevent..'Items', function(HasItems)
		if HasItems then
			SetEntityHeading(PlayerPedId(), 249.3034)
			QBCore.Functions.Progressbar("make_cloudcoffee", data.progressbartext, data.progressbartime, false, true, {
				disableMovement = true,
				disableCarMovement = false,
				disableMouse = false,
				disableCombat = true,
			}, {
				animDict = "anim@amb@nightclub@mini@drinking@bar@player_bartender@two",
                anim = "two_player",
				flags = 49,
			}, {}, {}, function()
				if data.item4 then
					TriggerServerEvent("QBCore:Server:RemoveItem", data.item4, 1)
					TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[data.item4], "remove")
				elseif data.item5 then
					TriggerServerEvent("QBCore:Server:RemoveItem", data.item5, 1)
					TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[data.item5], "remove")
				elseif data.item6 then
					TriggerServerEvent("QBCore:Server:RemoveItem", data.item6, 1)
					TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[data.item6], "remove")
				end
				TriggerServerEvent("QBCore:Server:RemoveItem", data.item2, 1)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[data.item2], "remove")
				TriggerServerEvent("QBCore:Server:RemoveItem", data.item3, 1)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[data.item3], "remove")
				TriggerServerEvent("QBCore:Server:AddItem", data.recieveitem, 2)
				TriggerEvent("inventory:client:ItemBox", QBCore.Shared.Items[data.recieveitem], "add")
			end, function()
				QBCore.Functions.Notify("Canceled...", "error")
			end)
		else
			QBCore.Functions.Notify('You Are Trying To Make '.. data.coffeeevent ..' With Nothing ?', 'error')
		end
	end)
end)

RegisterNetEvent('CL-BeanMachine:SeperatingEvent')
AddEventHandler('CL-BeanMachine:SeperatingEvent', function(data)
	QBCore.Functions.TriggerCallback('CL-BeanMachine:CheckDuty', function(result)
        if result then
			if data.firstmenu then
				TriggerEvent("CL-BeanMachine:FirstCoffeeMenu")
			elseif data.secondmenu then
				TriggerEvent("CL-BeanMachine:SecondCoffeeMenu")
			end
        else
            QBCore.Functions.Notify("You must be on duty.", "error")
        end
    end)
end)

RegisterNetEvent('CL-BeanMachine:OpenMenu')
AddEventHandler('CL-BeanMachine:OpenMenu', function()
  	SetNuiFocus(false, false)
  	SendNUIMessage({action = 'OpenMenu'})
	Citizen.CreateThread(function()
        while true do
			ShowHelpNotification("Press ~INPUT_FRONTEND_RRIGHT~ To Exit")
			if IsControlJustReleased(0, 177) then
				TriggerEvent("CL-BeanMachine:CloseMenu")
				PlaySoundFrontend(-1, "NO", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
				break
			end
			Citizen.Wait(1)
		end
	end)
end)

RegisterNetEvent('CL-BeanMachine:CloseMenu')
AddEventHandler('CL-BeanMachine:CloseMenu', function()
  	SetNuiFocus(false, false)
  	SendNUIMessage({action = 'CloseMenu'})
end)

----------------
----Menus
----------------
RegisterNetEvent("CL-BeanMachine:DutyMenu", function()
    local DutyMenu = {
        {
            header = "Duty",
            isMenuHeader = true,
        }
    }
	DutyMenu[#DutyMenu+1] = {
        header = Config.Locals["DutyMenu"]["Header"],
		txt = Config.Locals["DutyMenu"]["Txt"],
        params = {
			isServer = true,
            event = "QBCore:ToggleDuty"
        }
    }
    DutyMenu[#DutyMenu+1] = {
        header = "⬅ Close",
        params = {
            event = "qb-menu:client:closemenu"
        }
    }
    exports['qb-menu']:openMenu(DutyMenu)
end)

RegisterNetEvent("CL-BeanMachine:ToastsMenu", function()
	QBCore.Functions.TriggerCallback('CL-BeanMachine:CheckDuty', function(result)
        if result then
			local ToastsMenu = {
				{
					header = "Toasts / Donuts",
					isMenuHeader = true,
				}
			}
			ToastsMenu[#ToastsMenu+1] = {
				header = Config.Locals["ToastsMenu"]["Header"],
				txt = Config.Locals["ToastsMenu"]["Txt"],
				params = {
					event = "CL-BeanMachine:Grab",
					args = {
						item = Config.Items['ToastItem'],
						progressbartext = Config.Locals["GrabToastProgressBar"]["Txt"],
						progressbartime = Config.Locals["GrabToastProgressBar"]["Time"],
						animationdict = "anim@amb@clubhouse@boardroom@crew@male@var_a@base@",
						animation = "idle_c"
					}
				}
			}
			ToastsMenu[#ToastsMenu+1] = {
				header = Config.Locals["DonutsMenu"]["Header"],
				txt = Config.Locals["DonutsMenu"]["Txt"],
				params = {
					event = "CL-BeanMachine:Grab",
					args = {
						item = Config.Items['DonutItem'],
						progressbartext = Config.Locals["GrabDonutProgressBar"]["Txt"],
						progressbartime = Config.Locals["GrabDonutProgressBar"]["Time"],
						animationdict = "anim@amb@clubhouse@boardroom@crew@male@var_a@base@",
						animation = "idle_c"
					}
				}
			}
			ToastsMenu[#ToastsMenu+1] = {
				header = "⬅ Close",
				params = {
					event = "qb-menu:client:closemenu"
				}
			}
			exports['qb-menu']:openMenu(ToastsMenu)
        else
            QBCore.Functions.Notify("You must be on duty.", "error")
        end
    end)
end)

RegisterNetEvent("CL-BeanMachine:FruitsMenu", function()
    local FruitsMenu = {
        {
            header = "Fruits",
            isMenuHeader = true,
        }
    }
	FruitsMenu[#FruitsMenu+1] = {
        header = Config.Locals["BananaFruitMenu"]["Header"],
		txt = Config.Locals["BananaFruitMenu"]["Txt"],
        params = {
			event = "CL-BeanMachine:Grab",
			args = {
				item = Config.Items['BananaItem'],
				progressbartext = Config.Locals["GrabBananaProgressBar"]["Txt"],
				progressbartime = Config.Locals["GrabBananaProgressBar"]["Time"],
				animationdict = "anim@amb@clubhouse@bar@drink@one",
				animation = "one_player"
			}
        }
    }
	FruitsMenu[#FruitsMenu+1] = {
        header = Config.Locals["OrangeFruitMenu"]["Header"],
		txt = Config.Locals["OrangeFruitMenu"]["Txt"],
        params = {
			event = "CL-BeanMachine:Grab",
			args = {
				item = Config.Items['OrangeItem'],
				progressbartext = Config.Locals["GrabOrangeProgressBar"]["Txt"],
				progressbartime = Config.Locals["GrabOrangeProgressBar"]["Time"],
				animationdict = "anim@amb@clubhouse@bar@drink@one",
				animation = "one_player"
			}
        }
    }
	FruitsMenu[#FruitsMenu+1] = {
        header = Config.Locals["AppleFruitMenu"]["Header"],
		txt = Config.Locals["AppleFruitMenu"]["Txt"],
        params = {
			event = "CL-BeanMachine:Grab",
			args = {
				item = Config.Items['AppleItem'],
				progressbartext = Config.Locals["GrabAppleProgressBar"]["Txt"],
				progressbartime = Config.Locals["GrabAppleProgressBar"]["Time"],
				animationdict = "anim@amb@clubhouse@bar@drink@one",
				animation = "one_player"
			}
        }
    }
    FruitsMenu[#FruitsMenu+1] = {
        header = "⬅ Close",
        params = {
            event = "qb-menu:client:closemenu"
        }
    }
    exports['qb-menu']:openMenu(FruitsMenu)
end)

RegisterNetEvent("CL-BeanMachine:MuffinsMenu", function()
	QBCore.Functions.TriggerCallback('CL-BeanMachine:CheckDuty', function(result)
        if result then
			local MuffinsMenu = {
				{
					header = "Muffins",
					isMenuHeader = true,
				}
			}
			MuffinsMenu[#MuffinsMenu+1] = {
				header = Config.Locals["RegularMuffinMenu"]["Header"],
				txt = Config.Locals["RegularMuffinMenu"]["Txt"],
				params = {
					event = "CL-BeanMachine:Grab",
					args = {
						item = Config.Items['RegularMuffinItem'],
						progressbartext = Config.Locals["GrabRegularMuffinProgressBar"]["Txt"],
						progressbartime = Config.Locals["GrabRegularMuffinProgressBar"]["Time"],
						animationdict = "anim@amb@clubhouse@bar@drink@one",
						animation = "one_player"
					}
				}
			}
			MuffinsMenu[#MuffinsMenu+1] = {
				header = Config.Locals["ChocolateMuffinMenu"]["Header"],
				txt = Config.Locals["ChocolateMuffinMenu"]["Txt"],
				params = {
					event = "CL-BeanMachine:Grab",
					args = {
						item = Config.Items['ChocolateMuffinItem'],
						progressbartext = Config.Locals["GrabChocolateMuffinProgressBar"]["Txt"],
						progressbartime = Config.Locals["GrabChocolateMuffinProgressBar"]["Time"],
						animationdict = "anim@amb@clubhouse@bar@drink@one",
						animation = "one_player"
					}
				}
			}
			MuffinsMenu[#MuffinsMenu+1] = {
				header = Config.Locals["BerryMuffinMenu"]["Header"],
				txt = Config.Locals["BerryMuffinMenu"]["Txt"],
				params = {
					event = "CL-BeanMachine:Grab",
					args = {
						item = Config.Items['BerryMuffinItem'],
						progressbartext = Config.Locals["GrabBerryMuffinProgressBar"]["Txt"],
						progressbartime = Config.Locals["GrabBerryMuffinProgressBar"]["Time"],
						animationdict = "anim@amb@clubhouse@bar@drink@one",
						animation = "one_player"
					}
				}
			}
			MuffinsMenu[#MuffinsMenu+1] = {
				header = "⬅ Close",
				params = {
					event = "qb-menu:client:closemenu"
				}
			}
			exports['qb-menu']:openMenu(MuffinsMenu)
        else
            QBCore.Functions.Notify("You must be on duty.", "error")
        end
    end)
end)

RegisterNetEvent("CL-BeanMachine:FruitsMenu2", function()
    local FruitsMenu2 = {
        {
            header = "Fruits",
            isMenuHeader = true,
        }
    }
	FruitsMenu2[#FruitsMenu2+1] = {
        header = Config.Locals["OrangeFruitMenu"]["Header"],
		txt = Config.Locals["OrangeFruitMenu"]["Txt"],
        params = {
			event = "CL-BeanMachine:Grab",
			args = {
				item = Config.Items['OrangeItem'],
				progressbartext = Config.Locals["GrabOrangeProgressBar"]["Txt"],
				progressbartime = Config.Locals["GrabOrangeProgressBar"]["Time"],
				animationdict = "anim@amb@clubhouse@bar@drink@one",
				animation = "one_player"
			}        
		}
    }
	FruitsMenu2[#FruitsMenu2+1] = {
        header = Config.Locals["AppleFruitMenu"]["Header"],
		txt = Config.Locals["AppleFruitMenu"]["Txt"],
        params = {
			event = "CL-BeanMachine:Grab",
			args = {
				item = Config.Items['AppleItem'],
				progressbartext = Config.Locals["GrabAppleProgressBar"]["Txt"],
				progressbartime = Config.Locals["GrabAppleProgressBar"]["Time"],
				animationdict = "anim@amb@clubhouse@bar@drink@one",
				animation = "one_player"
			}        
		}
    }
    FruitsMenu2[#FruitsMenu2+1] = {
        header = "⬅ Close",
        params = {
            event = "qb-menu:client:closemenu"
        }
    }
    exports['qb-menu']:openMenu(FruitsMenu2)
end)

RegisterNetEvent('CL-BeanMachine:Garage:Menu', function()
	local GarageMenu = {
		{
			header = "Bean Machine Vehicles",
			txt = "View Vehicles",
			params = {
				event = "CL-BeanMachine:Catalog",
			}
		}
	}
	GarageMenu[#GarageMenu+1] = {
		header = "⬅ Store Vehicle",
		params = {
			event = "CL-BeanMachine:StoreVehicle"
		}
	}
	GarageMenu[#GarageMenu+1] = {
		header = "⬅ Close Menu",
		params = {
			event = "qb-menu:client:closeMenu"
		}
	}
	exports['qb-menu']:openMenu(GarageMenu)
end)

RegisterNetEvent("CL-BeanMachine:Catalog", function()
    local VehicleMenu = {
        {
            header = "Bean Machine Garage",
            isMenuHeader = true,
        }
    }
    for k, v in pairs(Config.Vehicles) do
        VehicleMenu[#VehicleMenu+1] = {
            header = v.vehiclename,
            txt = "Rent: " .. v.vehiclename .. " For: " .. v.price .. "$",
            params = {
                isServer = true,
                event = "CL-BeanMachine:TakeMoney",
                args = {
                    price = v.price,
                    vehiclename = v.vehiclename,
                    vehicle = v.vehicle
                }
            }
        }
    end
    VehicleMenu[#VehicleMenu+1] = {
        header = "⬅ Go Back",
        params = {
            event = "CL-BeanMachine:Garage:Menu"
        }
    }
    exports['qb-menu']:openMenu(VehicleMenu)
end)

RegisterNetEvent("CL-BeanMachine:CupsMenu", function()
	QBCore.Functions.TriggerCallback('CL-BeanMachine:CheckDuty', function(result)
        if result then
			local CupMenu = {
				{
					header = "Cups",
					isMenuHeader = true,
				}
			}
			for k, v in pairs(Config.Cups) do
				CupMenu[#CupMenu+1] = {
					header = v.cupname,
					txt = "Take: " .. v.cupname,
					params = {
						event = "CL-BeanMachine:TakeCup",
						args = {
							cup = v.cup,
							cupname = v.cupname,
						}
					}
				}
			end
			CupMenu[#CupMenu+1] = {
				header = "⬅ Close",
				params = {
					event = "qb-menu:client:closeMenu"
				}
			}
			exports['qb-menu']:openMenu(CupMenu)
        else
            QBCore.Functions.Notify("You must be on duty.", "error")
        end
    end)
end)

RegisterNetEvent("CL-BeanMachine:DrinksMenu", function()
	QBCore.Functions.TriggerCallback('CL-BeanMachine:CheckDuty', function(result)
        if result then
			local DrinksMenu = {
				{
					header = "Drinks Machine",
					txt = "View Drinks",
					params = {
						event = "CL-BeanMachine:DrinksCatalog",
					}
				}
			}
			DrinksMenu[#DrinksMenu+1] = {
				header = "⬅ Close",
				params = {
					event = "qb-menu:client:closeMenu"
				}
			}
			exports['qb-menu']:openMenu(DrinksMenu)
        else
            QBCore.Functions.Notify("You must be on duty.", "error")
        end
    end)
end)

RegisterNetEvent("CL-BeanMachine:DrinksCatalog", function()
	local DrinksMainMenu = {
		{
			header = "Drinks",
			txt = "Drinks Menu",
			isMenuHeader = true
		}
	}
	for k, v in pairs(Config.ColdDrinks) do
		DrinksMainMenu[#DrinksMainMenu+1] = {
			header = v.drinkname,
			txt = "Make: " .. v.drinkname .. " Needed: " .. v.cupsize,
			params = {
				event = "CL-BeanMachine:MakeDrink",
				args = {
					drink = v.drink,
					drinkname = v.drinkname,
					cupsize = v.cupsize,
					cupneeded = v.cupneeded,
				}
			}
		}
	end
    DrinksMainMenu[#DrinksMainMenu+1] = {
        header = "⬅ Go Back",
        params = {
			event = "CL-BeanMachine:DrinksMenu"
        }
    }
    exports['qb-menu']:openMenu(DrinksMainMenu)
end)

RegisterNetEvent("CL-BeanMachine:SlushsMenu", function()
	QBCore.Functions.TriggerCallback('CL-BeanMachine:CheckDuty', function(result)
        if result then
			local SlushsMenu = {
				{
					header = "Slushs",
					isMenuHeader = true,
				}
			}
			SlushsMenu[#SlushsMenu+1] = {
				header = "Orange Slush",
				txt = "Make Orange Slushs",
				params = {
					event = "CL-BeanMachine:SlushsOrangeMenu"
				}
			}
			SlushsMenu[#SlushsMenu+1] = {
				header = "Lemon Slush",
				txt = "Make Lemon Slushs",
				params = {
					event = "CL-BeanMachine:SlushsLemonMenu"
				}
			}
			SlushsMenu[#SlushsMenu+1] = {
				header = "⬅ Close",
				params = {
					event = "qb-menu:client:closeMenu"
				}
			}
			exports['qb-menu']:openMenu(SlushsMenu)
        else
            QBCore.Functions.Notify("You must be on duty.", "error")
        end
    end)
end)

RegisterNetEvent("CL-BeanMachine:SlushsLemonMenu", function()
    local LemonSlushsMenu = {
        {
            header = "Lemon Slushs",
            isMenuHeader = true,
        }
    }
	for k, v in pairs(Config.LemonSlushs) do
		LemonSlushsMenu[#LemonSlushsMenu+1] = {
			header = v.slushname,
			txt = "Make: " .. v.slushname .. " Needed: " .. v.cupname,
			params = {
				event = "CL-BeanMachine:MakeSlush",
				args = {
					slush = v.slush,
					cupsize = v.cupsize,
					cupname = v.cupname,
					slushname = v.slushname,
				}
			}
		}
	end
    LemonSlushsMenu[#LemonSlushsMenu+1] = {
        header = "⬅ Go Back",
        params = {
			event = "CL-BeanMachine:SlushsMenu"
        }
    }
    exports['qb-menu']:openMenu(LemonSlushsMenu)
end)

RegisterNetEvent("CL-BeanMachine:SlushsOrangeMenu", function()
    local OrangeSlushsMenu = {
        {
            header = "Orange Slushs",
            isMenuHeader = true,
        }
    }
	for k, v in pairs(Config.OrangeSlushs) do
		OrangeSlushsMenu[#OrangeSlushsMenu+1] = {
			header = v.slushname,
			txt = "Make: " .. v.slushname .. " Needed: " .. v.cupname,
			params = {
				event = "CL-BeanMachine:MakeSlush",
				args = {
					slush = v.slush,
					cupsize = v.cupsize,
					cupname = v.cupname,
					slushname = v.slushname,
				}
			}
		}
	end
    OrangeSlushsMenu[#OrangeSlushsMenu+1] = {
        header = "⬅ Go Back",
        params = {
			event = "CL-BeanMachine:SlushsMenu"
        }
    }
    exports['qb-menu']:openMenu(OrangeSlushsMenu)
end)

RegisterNetEvent("CL-BeanMachine:FirstCoffeeMenu", function()
    local FirstCoffeeMenu = {
        {
            header = "Frappuccino Coffee's",
            isMenuHeader = true,
        }
    }
	FirstCoffeeMenu[#FirstCoffeeMenu+1] = {
		header = "<img src=https://cdn.discordapp.com/attachments/926465631770005514/963452543512506398/Untitled-2.png width=30px> ".." ┇ Cloud Cafe",
		txt = "Ingredients: 1X High Coffee Glass 1X Milk 1X Coffee Beans 1X Whipped Cream",
        params = {
			event = "CL-BeanMachine:MakeCoffee",
			args = {
				coffeeevent = "CloudCafe",
				progressbartext = Config.Locals["CloudCafeProgressBar"]["Txt"],
				progressbartime = Config.Locals["CloudCafeProgressBar"]["Time"],
				item1 = "bhighcoffeeglasscup",	
				item2 = "bmilk",
				item3 = "bcoffeebeans",
				item4 = "bcream",
				recieveitem = "bcloudcafe",
			}
        }
    }
	FirstCoffeeMenu[#FirstCoffeeMenu+1] = {
		header = "<img src=https://cdn.discordapp.com/attachments/926465631770005514/963446572593582100/unknown.png width=30px> ".."  ┇ Strawberry Cream Frappuccino",
		txt = "Ingredients: 1X High Coffee Glass 1X Strawberrys 1X Milk 1X Coffee Beans 1X Whipped Cream",
        params = {
			event = "CL-BeanMachine:MakeCoffee",
			args = {
				coffeeevent = "StrawberryCreamFrappuccino",
				progressbartext = Config.Locals["StrawberryCreamFrappuccinoProgressBar"]["Txt"],
				progressbartime = Config.Locals["StrawberryCreamFrappuccinoProgressBar"]["Time"],
				item1 = "bhighcoffeeglasscup",	
				item2 = "bmilk",
				item3 = "bcoffeebeans",
				item4 = "bcream",
				item5 = "bstrawberry",
				recieveitem = "bstrawberrycreamfrappuccino",
			}
        }
    }
	FirstCoffeeMenu[#FirstCoffeeMenu+1] = {
		header = "<img src=https://cdn.discordapp.com/attachments/926465631770005514/963446621809561620/unknown.png width=30px> ".." ┇ Java Chip Frappuccino",
		txt = "Ingredients: 1X High Coffee Glass 1X Milk 1X Coffee Beans 1X Whipped Cream",
        params = {
			event = "CL-BeanMachine:MakeCoffee",
			args = {
				coffeeevent = "JavaChipFrappuccino",
				progressbartext = Config.Locals["JavaChipFrappuccinoProgressBar"]["Txt"],
				progressbartime = Config.Locals["JavaChipFrappuccinoProgressBar"]["Time"],
				item1 = "bhighcoffeeglasscup",	
				item2 = "bmilk",
				item3 = "bcoffeebeans",
				item4 = "bcream",
				recieveitem = "bjavachipfrappuccino",
			}
        }
    }
	FirstCoffeeMenu[#FirstCoffeeMenu+1] = {
        header = "<img src=https://cdn.discordapp.com/attachments/926465631770005514/963446803766853662/unknown.png width=30px> ".." ┇ Hot Choc",
		txt = "Ingredients: 1X Coffee Glass 1X Milk 1X Coffee Beans 1X Whipped Cream 1X Hot Chocolate Powder.",
        params = {
			event = "CL-BeanMachine:MakeCoffee",
			args = {
				coffeeevent = "HotChoc",
				progressbartext = Config.Locals["HotChocProgressBar"]["Txt"],
				progressbartime = Config.Locals["HotChocProgressBar"]["Time"],
				item1 = "bcoffeeglass",	
				item2 = "bmilk",
				item3 = "bcoffeebeans",
				item4 = "bcream",
				item5 = "bhotchocolatepowder",
				recieveitem = "bhotchoc",
			}        
		}
    }
	FirstCoffeeMenu[#FirstCoffeeMenu+1] = {
        header = "<img src=https://cdn.discordapp.com/attachments/930069494066475008/945394895328268419/caremel_frappucino.png width=30px> ".." ┇ Caramel Frappucino",
		txt = "Ingredients: 1X High Coffee Glass 1X Milk 1X Coffee Beans 1X Whipped Cream 1X Caramel Syrup",
        params = {
			event = "CL-BeanMachine:MakeCoffee",
			args = {
				coffeeevent = "CaramelFrappucino",
				progressbartext = Config.Locals["CaramelFrappucinoProgressBar"]["Txt"],
				progressbartime = Config.Locals["CaramelFrappucinoProgressBar"]["Time"],
				item1 = "bhighcoffeeglasscup",	
				item2 = "bmilk",
				item3 = "bcoffeebeans",
				item4 = "bcream",
				item5 = "bcaramelsyrup",
				recieveitem = "bcaramelfrappucino",
			}        
		}
    }
    FirstCoffeeMenu[#FirstCoffeeMenu+1] = {
        header = "⬅ Close",
        params = {
			event = "qb-menu:client:closemenu"
        }
    }
    exports['qb-menu']:openMenu(FirstCoffeeMenu)
end)

RegisterNetEvent("CL-BeanMachine:SecondCoffeeMenu", function()
    local SecondCoffeeMenu = {
        {
            header = "Latte And Espresso Coffee's",
            isMenuHeader = true,
        }
    }
	SecondCoffeeMenu[#SecondCoffeeMenu+1] = {
		header = "<img src=https://cdn.discordapp.com/attachments/926465631770005514/963446660959199362/unknown.png width=30px> ".." ┇ Honey Hazelnut Oat Latte",
		txt = "Ingredients: 1X Coffee Glass 1X Milk 1X Coffee Beans 1X Honey",
        params = {
			event = "CL-BeanMachine:MakeCoffee",
			args = {
				coffeeevent = "HoneyHazelnutOatLatte",
				progressbartext = Config.Locals["HoneyHazelnutOatLatteProgressBar"]["Txt"],
				progressbartime = Config.Locals["HoneyHazelnutOatLatteProgressBar"]["Time"],
				item1 = "bcoffeeglass",	
				item2 = "bmilk",
				item3 = "bcoffeebeans",
				item4 = "bhoney",
				recieveitem = "bhoneyhazelnutoatlatte",
			}           
		}
    }
	SecondCoffeeMenu[#SecondCoffeeMenu+1] = {
		header = "<img src=https://cdn.discordapp.com/attachments/930069494066475008/945394893474398238/cold_brew_latte.png width=30px> ".." ┇ Cold Brew Latte",
		txt = "Ingredients: 1X High Coffee Glass 1X Milk 1X Coffee Beans 1X Ice",
        params = {
			event = "CL-BeanMachine:MakeCoffee",
			args = {
				coffeeevent = "ColdBrewLatte",
				progressbartext = Config.Locals["ColdBrewLatteProgressBar"]["Txt"],
				progressbartime = Config.Locals["ColdBrewLatteProgressBar"]["Time"],
				item1 = "bhighcoffeeglasscup",	
				item2 = "bmilk",
				item3 = "bcoffeebeans",
				item4 = "bice",
				recieveitem = "bcoldbrewlatte",
			}           
		}
    }
	SecondCoffeeMenu[#SecondCoffeeMenu+1] = {
		header = "<img src=https://cdn.discordapp.com/attachments/930069494066475008/945394940282798201/strawberry_vanilla_oat_latte.png width=30px> ".." ┇ Strawberry Vanilla Oat Latte",
		txt = "Ingredients: 1X Coffee Glass 1X Milk 1X Coffee Beans 1X Strawberry",
        params = {
			event = "CL-BeanMachine:MakeCoffee",
			args = {
				coffeeevent = "StrawberryVanillaOatLatte",
				progressbartext = Config.Locals["StrawberryVanillaOatLatteProgressBar"]["Txt"],
				progressbartime = Config.Locals["StrawberryVanillaOatLatteProgressBar"]["Time"],
				item1 = "bcoffeeglass",	
				item2 = "bmilk",
				item3 = "bcoffeebeans",
				item4 = "bstrawberry",
				recieveitem = "bstrawberryvanillaoatlatte",
			}           
		}
    }
	SecondCoffeeMenu[#SecondCoffeeMenu+1] = {
		header = "<img src=https://cdn.discordapp.com/attachments/926465631770005514/963446465416552448/unknown.png width=30px> ".." ┇ Iced Caffe Latte",
		txt = "Ingredients: 1X High Coffee Glass 1X Ice 1X Milk 1X Coffee Beans",
        params = {
			event = "CL-BeanMachine:MakeCoffee",
			args = {
				coffeeevent = "IcedCaffeLatte",
				progressbartext = Config.Locals["IcedCaffeLatteProgressBar"]["Txt"],
				progressbartime = Config.Locals["IcedCaffeLatteProgressBar"]["Time"],
				item1 = "bhighcoffeeglasscup",	
				item2 = "bmilk",
				item3 = "bcoffeebeans",
				item4 = "bice",
				recieveitem = "bicedcaffelatte",
			}           
		}
    }
	SecondCoffeeMenu[#SecondCoffeeMenu+1] = {
		header = "<img src=https://cdn.discordapp.com/attachments/926465631770005514/963446773735637062/unknown.png width=30px> ".." ┇ Espresso",
		txt = "Ingredients: 1X Espresso Coffee Glass 1X Milk 1X Coffee Beans",
        params = {
			event = "CL-BeanMachine:MakeCoffee",
			args = {
				coffeeevent = "Espresso",
				progressbartext = Config.Locals["EspressoProgressBar"]["Txt"],
				progressbartime = Config.Locals["EspressoProgressBar"]["Time"],
				item1 = "bespressocoffeecup",	
				item2 = "bmilk",
				item3 = "bcoffeebeans",
				recieveitem = "bespresso",
			}           
		}
    }
	SecondCoffeeMenu[#SecondCoffeeMenu+1] = {
		header = "<img src=https://cdn.discordapp.com/attachments/926465631770005514/963446697059553351/unknown.png width=30px> ".." ┇ Espresso Macchiato",
		txt = "Ingredients: 1X Espresso Coffee Glass 1X Milk 1X Coffee Beans",
        params = {
			event = "CL-BeanMachine:MakeCoffee",
			args = {
				coffeeevent = "EspressoMacchiato",
				progressbartext = Config.Locals["EspressoMacchiatoProgressBar"]["Txt"],
				progressbartime = Config.Locals["EspressoMacchiatoProgressBar"]["Time"],
				item1 = "bespressocoffeecup",	
				item2 = "bmilk",
				item3 = "bcoffeebeans",
				recieveitem = "bespressomacchiato",
			}            
		}
    }
    SecondCoffeeMenu[#SecondCoffeeMenu+1] = {
        header = "⬅ Close",
        params = {
			event = "qb-menu:client:closemenu",
        }
    }
    exports['qb-menu']:openMenu(SecondCoffeeMenu)
end)

RegisterNetEvent("CL-BeanMachine:BeansMenu", function()
	QBCore.Functions.TriggerCallback('CL-BeanMachine:CheckDuty', function(result)
        if result then
			local BeansMenu = {
				{
					header = "Coffee Beans",
					isMenuHeader = true,
				}
			}
			for k, v in pairs(Config.Beans) do
				BeansMenu[#BeansMenu+1] = {
					header = v.beanimage.. " ┇ " .. v.beanname,
					txt = "Grab: " .. v.beanname,
					params = {
						event = "CL-BeanMachine:Grab",
						args = {
							item = v.bean,
							progressbartext = Config.Locals["GrabBeansProgressBar"]["Txt"],
							progressbartime = Config.Locals["GrabBeansProgressBar"]["Time"],
							animationdict = "anim@amb@clubhouse@boardroom@crew@male@var_a@base@",
							animation = "idle_c"
						}
					}
				}
			end
			BeansMenu[#BeansMenu+1] = {
				header = "⬅ Close",
				params = {
					event = "qb-menu:client:closemenu",
				}
			}
			exports['qb-menu']:openMenu(BeansMenu)
		else
            QBCore.Functions.Notify("You must be on duty.", "error")
        end
    end)
end)

RegisterNetEvent("CL-BeanMachine:GlassesMenu", function()
	QBCore.Functions.TriggerCallback('CL-BeanMachine:CheckDuty', function(result)
        if result then
			local GlassesMenu = {
				{
					header = "Glasses Menu",
					isMenuHeader = true,
				}
			}
			for k, v in pairs(Config.Glasses) do
				GlassesMenu[#GlassesMenu+1] = {
					header = v.image.." ┇ " ..v.glassname,
					txt = "Buy " .. v.glassname .. " For: " .. v.price .. "$",
					params = {
						isServer = true,
						event = "CL-BeanMachine:BuyGlass",
						args = {
							price = v.price,
							glassname = v.glassname,
							glass = v.glass
						}
					}
				}
			end
			GlassesMenu[#GlassesMenu+1] = {
				header = "⬅ Close",
				params = {
					event = "qb-menu:client:closemenu"
				}
			}
			exports['qb-menu']:openMenu(GlassesMenu)
		else
            QBCore.Functions.Notify("You must be on duty.", "error")
        end
    end)
end)

----------------
----Functions
----------------
function DrawText3D(x, y, z, text)
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    local factor = (string.len(text)) / 370
    DrawRect(0.0, 0.0+0.0125, 0.017+ factor, 0.03, 0, 0, 0, 75)
    ClearDrawOrigin()
end

function ShowHelpNotification(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function LoadModel(model)
	while not HasModelLoaded(model) do
		RequestModel(model)
		Wait(10)
	end
end

function SlushEffect()
	local Player = PlayerPedId()
	StartScreenEffect("MP_Celeb_Win", 3.0, 0)
	SetPedToRagdollWithFall(Player, 1500, 1000, 1, GetEntityForwardVector(Player), 1.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0)
    Citizen.Wait(5000)
    StopScreenEffect("MP_Celeb_Win")
end

function CoffeeEffect()
	local startStamina = 4
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.80)
    while startStamina > 0 do
        if math.random(5, 100) < 10 then
            RestorePlayerStamina(PlayerId(), 1.0)
        end
        startStamina = startStamina - 1
    end
    startStamina = 0
    SetRunSprintMultiplierForPlayer(PlayerId(), 1.0)
end

function CloseMenu()
    exports['qb-menu']:closeMenu()
end

RegisterCommand('removestuckprop', function()
    for k, v in pairs(GetGamePool('CObject')) do
        if IsEntityAttachedToEntity(PlayerPedId(), v) then
            SetEntityAsMissionEntity(v, true, true)
            DeleteObject(v)
            DeleteEntity(v)
		end
    end
end)