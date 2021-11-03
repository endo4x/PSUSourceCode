--[[
	id: Atu-1K4Xp2ovsHXKObMc3
	name: RandomTables
	description: Source code for random table values
	time1: 2021-05-05 20:29:04.882397+00
	time2: 2021-05-05 20:29:04.882398+00
	uploader: W8FWkprIhNQI7YQ7QPOCyvO4IKY4ZDXoHwppQrFA
	uploadersession: kwQzQ1-KWp1i1xlgg3opWMxfNCbkD1
	flag: f
--]]

local word1 = { 'a', 'b', 'c', 'd' }
print( word1[ math.random( #word1 ) ] )

-- Current Script for lua (MadLibs) 
local word1 = { 'My', 'Dead', 'My brothers', 'Steamed', 'Mr. Petersons', 'Tegans', 'Overcooked', 'Sebastians', 'Mr Owens', 'A bitches', 'Milos', 'My dogs', 'Stepbros', 'Parkers', 'Ryders', 'Stepsises', 'Marks' }
local word2 = { 'dog', 'rocks', 'girl', 'balls', 'kids', 'ass', 'rattlesnake', '.50 Cal Rifle', 'giver book', 'pacifier', 'cum', 'beans', 'pussy' }
local word3 = { 'feel', 'bounce', 'jiggle', 'taste', 'smell', 'sound', 'crush', 'moan', 'suck', 'cook' }
local word4 = { 'weird', 'satisfying', 'salty', 'wet', 'like Xanders balls', 'small like Tegans dicc', 'as sad as Christians brain.', 'as big as obamas left nut', 'like grandma floating down a river', 'as good as boob implants', 'as fake as Kim Kardashian', 'as hard as trumps schlong', 'as bad as the school pizza', 'as tiny as mark'}
for i = 1,10 do
local word1result =  word1[ math.random( #word1 ) ] 
local word2result =  word2[ math.random( #word2 ) ] 
local word3result =  word3[ math.random( #word3 ) ] 
local word4result =  word4[ math.random( #word4 ) ] 

print("Sentence Generated:")
print(word1result .. ' ' ..word2result .. ' ' .. word3result .. ' ' .. 
 '' ..word4result)
print('----------------')
end