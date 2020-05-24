-- N1 1e6f53ae-9b68-400d-8388-9beb0f92def8
-- N2 817afe23-f342-4f96-92ae-d4b8281c4c35
-- E1 8672d11f-2d30-400f-a6ac-3660b76a5668
-- E2 97a6d5ea-56e7-491a-9909-51aeca2235e0
-- S1 31478356-91df-4a13-a684-af965ae866f0
-- S2 72a16c66-abb7-4176-9a0f-905c783908e8
-- W1 83f6cbf4-048b-4f95-8803-1da3ebd98ec8
-- W2 815b9d77-79d1-43d9-a303-066c481bd360

-- PSS 59739460-1e4e-4610-bc6b-3d431cfede87

local internet = require("internet")
local component = require("component")
local server = "sleepylucy.sytes.net"

function updateSolars()
  local n1 = component.proxy("1e6f53ae-9b68-400d-8388-9beb0f92def8")
  local n2 = component.proxy("817afe23-f342-4f96-92ae-d4b8281c4c35")
  local e1 = component.proxy("8672d11f-2d30-400f-a6ac-3660b76a5668")
  local e2 = component.proxy("97a6d5ea-56e7-491a-9909-51aeca2235e0")
  local s1 = component.proxy("31478356-91df-4a13-a684-af965ae866f0")
  local s2 = component.proxy("72a16c66-abb7-4176-9a0f-905c783908e8")
  local w1 = component.proxy("83f6cbf4-048b-4f95-8803-1da3ebd98ec8")
  local w2 = component.proxy("815b9d77-79d1-43d9-a303-066c481bd360")

  local n1prod = n1.getAverageElectricOutput()
  local n2prod = n2.getAverageElectricOutput()
  local e1prod = e1.getAverageElectricOutput()
  local e2prod = e2.getAverageElectricOutput()
  local s1prod = s1.getAverageElectricOutput()
  local s2prod = s2.getAverageElectricOutput()
  local w1prod = w1.getAverageElectricOutput()
  local w2prod = w2.getAverageElectricOutput()

  local url = "http://" .. server .. ":9876/powerStatus?name=ChemN1&production=" .. n1prod
  pcall(internet.request, url)
  local url = "http://" .. server .. ":9876/powerStatus?name=ChemN2&production=" .. n2prod
  pcall(internet.request, url)
  local url = "http://" .. server .. ":9876/powerStatus?name=ChemE1&production=" .. e1prod
  pcall(internet.request, url)
  local url = "http://" .. server .. ":9876/powerStatus?name=ChemE2&production=" .. e2prod
  pcall(internet.request, url)
  local url = "http://" .. server .. ":9876/powerStatus?name=ChemS1&production=" .. s1prod
  pcall(internet.request, url)
  local url = "http://" .. server .. ":9876/powerStatus?name=ChemS2&production=" .. s2prod
  pcall(internet.request, url)
  local url = "http://" .. server .. ":9876/powerStatus?name=ChemW1&production=" .. w1prod
  pcall(internet.request, url)
  local url = "http://" .. server .. ":9876/powerStatus?name=ChemW2&production=" .. w2prod
  pcall(internet.request, url)
end

function updatePSS()
  local pss = component.proxy("59739460-1e4e-4610-bc6b-3d431cfede87")
  local capacity = pss.getEUCapacity()
  local stored = pss.getEUStored()

  local table = pss.getSensorInformation()
  local maintenance = string.sub(table[7], 26, 30)
  if maintenance ~= "false" then
    maintenance = "true"
  end

  local url = "http://" .. server .. ":9876/pssStatus?name=Chem&capacity=" .. capacity .. "&stored=" .. stored .. "&maintenance=" .. maintenance
  pcall(internet.request, url)
end

updateSolars()
updatePSS()
