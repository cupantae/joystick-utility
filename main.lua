--[[ Joystick Utility ]]--
-- Joystick/gamepad test for love2D
    --[[ v0.02 ]]--
-- TODO: Make the y coordinate move down like a terminal?

local joysticks = love.joystick.getJoysticks()
showbutton = nil
showW = 100
--[[
joy1 = joysticks[1]
joy2 = joysticks[2]
joy3 = joysticks[3]
joy4 = joysticks[4]
]]

function love.load()
	print("Joystick tester")
	XRES = 1000
	YRES = 700
    love.window.setMode(XRES, YRES)

end

function love.joystickpressed(joystick, button)
	showbutton = button
	print("button " .. showbutton)
	id, instance = joystick:getID()
	print("ID: " .. id .. " | InstanceID: " .. instance .. " | Joystick #" .. tostring(i) ..
	"\nName: " .. joystick:getName()	.. "\nJoystick GUID: " .. joystick:getGUID() .. 
	"\nJoystick:getConnectedIndex: " .. joystick:getConnectedIndex() ..
	"\nJoystick:getDeviceInfo: " .. joystick:getDeviceInfo())
end

function love.joystickreleased(joystick, button)
	if showbutton == button then showbutton = nil end
end

function love.draw()
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
		if showbutton then
			love.graphics.setColor(1,0,0,1)
			love.graphics.rectangle("fill", XRES - showW, YRES - showW, showW, showW)
			love.graphics.setColor(1,1,1,1)
			love.graphics.print("button", XRES - showW, YRES - showW)
			love.graphics.print(showbutton, XRES - (showW/2), YRES - (showW/2))
		end
	end
end
