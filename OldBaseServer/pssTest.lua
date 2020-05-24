local component = require("component")
local pss = component.proxy("c876459e-2c2d-4ed5-ba90-960b0cd2a9b8")
io.write("getEUStored " .. pss.getEUStored() .. "\ngetStoredEU " .. pss.getStoredEU() .. "\n")
io.write("getEUCapacity  " .. pss.getEUCapacity() .. "\n")
io.write("getEUMaxStored " .. pss.getEUMaxStored() .. "\n")
io.write("getAverageElectricInput " .. pss.getAverageElectricInput() .. "\n")
io.write("getEUInputAverage       " .. pss.getEUInputAverage() .. "\n")
io.write("getAverageElectricOutput " .. pss.getAverageElectricOutput() .. "\n")
io.write("getEUOutputAverage        " .. pss.getEUOutputAverage() .. "\n")

local inspect = require("inspect")
local table = pss.getSensorInformation()
io.write(inspect(table))
io.write(table[7] .. "\n")
local sub = string.sub(table[7], 26, 30)
if sub ~= "false" then
  sub = "true"
end
io.write(sub .. "\n")