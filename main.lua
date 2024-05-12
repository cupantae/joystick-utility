--[[ Joystick Utility ]]--
-- Joystick/gamepad test for love2D
    --[[ v0.03 ]]--
-- slight mess now that needs to be tamed and improved
local joysticks = {}
--local joysticks = love.joystick.getJoysticks()
local showbutton = {}
showW = 100

function love.load()
	print("Joystick tester")
	XRES = 1000
	YRES = 700
    love.window.setMode(XRES, YRES)
    -- Set up the initial joysticks
    detectJoysticks()
end

function love.joystickadded(joystick)
    -- A new joystick has been connected
    table.insert(joysticks, joystick)
    print("Joystick added:", joystick:getName())
end

function love.joystickremoved(joystick)
    -- A joystick has been disconnected
    for i, j in ipairs(joysticks) do
        if j == joystick then
            table.remove(joysticks, i)
            print("Joystick removed:", joystick:getName())
            break
        end
    end
end

function detectJoysticks()
    -- Detect all connected joysticks at startup
    local count = love.joystick.getJoystickCount()
    for i = 1, count do
        local joystick = love.joystick.getJoysticks()[i]
        table.insert(joysticks, joystick)
        print("Detected Joystick " .. i .. ": " .. joystick:getName())
    end
end

function updateJoystickInput(joystick, dt)
    -- Update input for a single joystick
    -- Example: Get axis values
    local xAxis = joystick:getAxis(1)
    local yAxis = joystick:getAxis(2)
    
    -- Example: Check button presses
    for i = 1, joystick:getButtonCount() do
        if joystick:isDown(i) then
            print("Button " .. i .. " pressed on " .. joystick:getName())
        end
    end
    
    -- Add more input handling as needed
end
--old!:
function love.joystickpressed(joystick, button)
	showbutton[joystick] = button

	print("button " .. showbutton[joystick])
	id, instance = joystick:getID()
	print("ID: " .. id .. " | InstanceID: " .. instance .. " | Joystick #" .. tostring(i) ..
	"\nName: " .. joystick:getName()	.. "\nJoystick GUID: " .. joystick:getGUID() .. 
	"\nJoystick:getConnectedIndex: " .. joystick:getConnectedIndex() ..
	"\nJoystick:getDeviceInfo: " .. joystick:getDeviceInfo())
end


--END!!


function love.joystickreleased(joystick, button)
	showbutton[joystick] = nil
	--showbutton = 
end

function love.update(dt)
    -- Update joystick input for all connected joysticks
    --for i, joystick in ipairs(joysticks) do
    --    updateJoystickInput(joystick, dt)
    --end


end

function love.joystickremoved( joystick )
	print(joystick)
end

function love.draw()
	joysticks = love.joystick.getJoysticks()
	for i, joystick in pairs(joysticks) do
		--love.graphics.print(joystick:getName() .. " - a gamepad? " .. tostring(joystick:isGamepad()) .. tostring(lastpressed), 10, (i-1) * 200)
		joyID, joyInstance = joystick:getID() -- or "", ""
		love.graphics.print("ID: " .. tostring(joyID) .. " | InstanceID: " .. tostring(joyInstance) .. " | Joystick #" .. tostring(i) .. " | Name: ".. joystick:getName(), 10, (i-1)*100 + 10)
		--print("ID: " .. joyID .. " | InstanceID: " .. joyInstance .. " | Joystick #" .. tostring(i) .. " | Name: ".. joystick:getName())
		if joystick:isConnected() then
			connectmsg = " | Joystick is connected"
		else
			connectmsg = " | Joystick is *not* connected"
		end
		if joystick:isGamepad() then
			gamepadmsg = ", and is a gamepad."
		else
			gamepadmsg = ", and is *not* a gamepad."
		end
		love.graphics.print("Joystick GUID: " .. joystick:getGUID(), 10, (i-1)*100 + 38)
		axiscount = joystick:getAxisCount()
		axisstr = ""
		for axis=1,axiscount do
			axisstr = axisstr .. "  Axis " .. axis .. ": " .. tostring(joystick:getAxis(axis))
		end

		buttoncount = joystick:getButtonCount()
		buttonstr = ""
		for button=1,buttoncount do
			if joystick:isDown(button) then
				buttonstr = buttonstr .. " <Button " .. button .. " !> "-- .. tostring(joystick:isDown(button))
			end
		end

		hatcount = joystick:getHatCount()
		hatstr = ""
		for hat=1,hatcount do
			hatstr = hatstr .. "  Hat " .. hat .. ": " .. tostring(joystick:getHat(hat))
		end
		love.graphics.print("Axes: " .. axiscount .. " | Buttons: " .. buttoncount  .. " | Hats: " .. hatcount  .. connectmsg .. gamepadmsg, 10, (i-1)*100 + 24)
		love.graphics.print(axisstr, 10, (i-1)*100 + 52)
		love.graphics.print(buttonstr, 10, (i-1)*100 + 66)
		love.graphics.print(hatstr, 10, (i-1)*100 + 80)

		--love.graphics.
		--print(joystick:getGamepadMappingString() )--,10,10)
		if showbutton[joystick] then
			love.graphics.setColor(1,0,0,1)
			love.graphics.rectangle("fill", (i-1) * showW, YRES - showW, showW, showW)
			love.graphics.setColor(1,1,1,1)
			love.graphics.print("button", (i-1) * showW, YRES - showW)
			love.graphics.print(showbutton[joystick], ((2*i)-1)*(showW/2), YRES - (showW/2))
		end
	end
end
