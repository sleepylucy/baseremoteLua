local internet = require("internet")
local component = require("component")
-- local url = "192.168.178.232"
local url = "sleepylucy.sytes.net"
local clock = os.clock()

function updateWindTurbine()
  local windDiode = component.proxy("2609f570-2f77-4629-b43b-a06c971bde4b")
  local production = windDiode.getAverageElectricOutput()
  local url = "http://" .. url .. ":9876/powerStatus?name=MountainWind&production=" .. production
  pcall(internet.request, url)
end

function updatePss()
  print((os.clock() - clock) .. " Updating PSS")
  local pss = component.proxy("c876459e-2c2d-4ed5-ba90-960b0cd2a9b8")
  local capacity = pss.getEUCapacity()
  local stored = pss.getEUStored()

  local table = pss.getSensorInformation()
  local maintenance = string.sub(table[7], 26, 30)
  if maintenance ~= "false" then
    maintenance = "true"
  end

  local url = "http://" .. url .. ":9876/pssStatus?name=OldBase&capacity=" .. capacity .. "&stored=" .. stored .. "&maintenance=" .. maintenance
  pcall(internet.request, url)
  print((os.clock() - clock) .. " Finished Updating PSS")
  print("------------------------------------")
end

function updateMe()
  print((os.clock() - clock) .. " Updating ME")
  local capBank = component.proxy("9febcb2b-b162-4a5a-a3b3-6b05859e9f56")
  print((os.clock() - clock) .. " A1")
  local usageRF = capBank.getAverageOutputPerTick()
  print((os.clock() - clock) .. " A2")

  local url = "http://" .. url .. ":9876/meStatus?usageRF=" .. usageRF
  print((os.clock() - clock) .. " A3")
  local result, response = pcall(internet.request, url)
  print((os.clock() - clock) .. " A4")
  if result then
    print((os.clock() - clock) .. " B1")
    for chunk in response do
      print((os.clock() - clock) .. " B2")
      toggleMe(chunk)
    end
    print((os.clock() - clock) .. " B3")
  else
    io.write("error\n")
  end
  print((os.clock() - clock) .. " Finished updating ME")
end

function toggleMe()
  print((os.clock() - clock) .. " Toggling ME")
  local url = "http://" .. url .. ":9876/meStatus?statusFor=OldBase"
  local result, response = pcall(internet.request, url)
  for chunk in response do
    if chunk == "true" then
      dofile("activateME.lua")
    else
      dofile("deactivateME.lua")
    end
  end
end

updateMe()
toggleMe()
updatePss()
updateWindTurbine()
