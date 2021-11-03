--[[
	id: I2Q9ji211XL4j-wEO6zux
	name: CircleArea
	description: Finds the area of a circle.
	time1: 2021-05-19 01:52:32.180189+00
	time2: 2021-05-19 01:52:32.18019+00
	uploader: W8FWkprIhNQI7YQ7QPOCyvO4IKY4ZDXoHwppQrFA
	uploadersession: kwQzQ1-KWp1i1xlgg3opWMxfNCbkD1
	flag: f
--]]

local radius = 5 -- Put the radius of the circle here. If you only have the diameter, leave this as 0.
local diameter = 0 -- Leave this as 0 if you do not have a diameter.
print('|Created by Matthew Berry|')

if radius == 0 then
   if diameter == 0 then
     print("You did not insert a diameter or radius.")
   else
     print('Calculating the area of a circle with a diameter of ' .. diameter .. '...')
print("Found all calculations.")
     print("Answers")
     print("-------")
     local calculatedRadius = diameter / 2
     print('Radius: ' .. calculatedRadius)
     print('Area: ' .. calculatedRadius * calculatedRadius * 3.14)
     print('Step by Step:')
     print('To find the area of a circle from the diameter ' .. diameter .. ', all you have to do is the radius (' .. calculatedRadius .. ') x itself x Pi (3.14) which leaves you with the area ' .. calculatedRadius * calculatedRadius * 3.14 .. '. The radius is just half of ' .. diameter .. ' (' .. calculatedRadius .. ').')
   end
else
   if diameter == 0 then
     local calculatedDiameter = 0
     print('Calculating the area of a circle with a radius of ' .. radius .. '...')
     print("Found all calculations.")
     print("Answers")
     print("-------")
     local calculatedDiameter = radius * radius
     print('Diameter: ' .. calculatedDiameter)
     print('Area: ' .. calculatedDiameter * 3.14)
     print('Step by Step:')
     print('To find the area of a circle from the radius ' .. radius .. ', you must first find the diameter. To find the diameter of this circle, you must do ' .. radius .. ' x ' .. radius .. ' (or the radius multiplied by itself) which leaves us with the diameter ' .. calculatedDiameter .. '. From here you can find the area of the circle. You must now do ' .. calculatedDiameter .. ' x Pi (3.14) which leaves us with the area: ' .. calculatedDiameter * 3.14)
   else
     print("Please don't insert a diameter and radius at the same time.")
   end
end