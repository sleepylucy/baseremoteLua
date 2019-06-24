local internet = require("internet")
local component = require("component")
local ip = "192.168.178.23"
-- local ip = "kekzdealer-laptop-old.fritz.box"

function updatePss()
  local pss = component.proxy("c876459e-2c2d-4ed5-ba90-960b0cd2a9b8")
  local capacity = pss.getEUCapacity()
  local stored = pss.getEUStored()

  local table = pss.getSensorInformation()
  local maintenance = string.sub(table[7], 26, 30)
  if maintenance ~= "false" then
    maintenance = "true"
  end

  local url = "http://" .. ip .. ":9876/pssStatus?capacity=" .. capacity .. "&stored=" .. stored .. "&maintenance=" .. maintenance
  pcall(internet.request, url)
end

function updateMe()
  local capBank = component.proxy("1faf0f4d-fbc5-4e8e-9f91-248e3487d6ed")
  local usageRF = capBank.getAverageOutputPerTick()

  local url = "http://" .. ip .. ":9876/meStatus?usageRF=" .. usageRF
  local result, response = pcall(internet.request, url)
  if result then
    for chunk in response do
	  io.write(chunk)
	  toggleMe(chunk)
	end
  else
    io.write("error\n")
  end
end

function toggleMe(status)
  local statusSub = string.sub(status, 1, 5)

  if statusSub == "true/" then
    dofile("activateME.lua")
  else
    dofile("deactivateME.lua")
  end
end


updateMe()
updatePss()
