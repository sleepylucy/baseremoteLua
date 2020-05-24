local internet = require("internet")
local component = require("component")
local server = "sleepylucy.sytes.net"

function updateDam()
  local dam11 = component.proxy("8d0ed830-4ecf-45ca-a853-9717f5dac88a")
  local dam12 = component.proxy("3be5dba9-3bba-4bb1-a9c5-2ca3fa4f6887")
  local dam13 = component.proxy("4b8d4bc2-f0f9-45dd-974c-6a6943c4c04d")
  local dam14 = component.proxy("2eb7720a-455e-49b7-b7de-fa5714ffd22e")
  local dam15 = component.proxy("36991987-ceda-4b19-9bae-13cb982dd270")
  local dam16 = component.proxy("6f4e2c45-a2fc-4f1c-a038-43d3262f4bb4")

  local dam11prod = dam11.getOfferedEnergy()
  local dam12prod = dam12.getOfferedEnergy()
  local dam13prod = dam13.getOfferedEnergy()
  local dam14prod = dam14.getOfferedEnergy()
  local dam15prod = dam15.getOfferedEnergy()
  local dam16prod = dam16.getOfferedEnergy()
  local dam17prod = 0

  local dam21prod = 0
  local dam22prod = 0
  local dam23prod = 0
  local dam24prod = 0
  local dam25prod = 0
  local dam26prod = 0
  local dam27prod = 0

  local url = "http://" .. server .. ":9876/powerStatus?name=Dam11&production=" .. dam11prod
  pcall(internet.request, url)
  url = "http://" .. server .. ":9876/powerStatus?name=Dam12&production=" .. dam12prod
  pcall(internet.request, url)
  url = "http://" .. server .. ":9876/powerStatus?name=Dam13&production=" .. dam13prod
  pcall(internet.request, url)
  url = "http://" .. server .. ":9876/powerStatus?name=Dam14&production=" .. dam14prod
  pcall(internet.request, url)
  url = "http://" .. server .. ":9876/powerStatus?name=Dam15&production=" .. dam15prod
  pcall(internet.request, url)
  url = "http://" .. server .. ":9876/powerStatus?name=Dam16&production=" .. dam16prod
  pcall(internet.request, url)
  url = "http://" .. server .. ":9876/powerStatus?name=Dam17&production=" .. dam17prod
  pcall(internet.request, url)

  url = "http://" .. server .. ":9876/powerStatus?name=Dam21&production=" .. dam21prod
  pcall(internet.request, url)
  url = "http://" .. server .. ":9876/powerStatus?name=Dam22&production=" .. dam22prod
  pcall(internet.request, url)
  url = "http://" .. server .. ":9876/powerStatus?name=Dam23&production=" .. dam23prod
  pcall(internet.request, url)
  url = "http://" .. server .. ":9876/powerStatus?name=Dam24&production=" .. dam24prod
  pcall(internet.request, url)
  url = "http://" .. server .. ":9876/powerStatus?name=Dam25&production=" .. dam25prod
  pcall(internet.request, url)
  url = "http://" .. server .. ":9876/powerStatus?name=Dam26&production=" .. dam26prod
  pcall(internet.request, url)
  url = "http://" .. server .. ":9876/powerStatus?name=Dam27&production=" .. dam27prod
  pcall(internet.request, url)
end

function updatePSS()
  local pss = component.proxy("ade9cd8c-ddb2-427d-a5b8-2b296797c0b3")
  local capacity = pss.getEUCapacity()
  local stored = pss.getEUStored()

  local table = pss.getSensorInformation()
  local maintenance = string.sub(table[7], 26, 30)
  if maintenance ~= "false" then
    maintenance = "true"
  end

  local url = "http://" .. server .. ":9876/pssStatus?name=NewBase&capacity=" .. capacity .. "&stored=" .. stored .. "&maintenance=" .. maintenance
  pcall(internet.request, url)
end

updateDam()
updatePSS()
