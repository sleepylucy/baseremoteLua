local thread = require("thread")

thread.create(function()
  while true do
    print(os.clock() .. " running loop")
    dofile("serverComm.lua")
    os.sleep(1)
  end
end)
