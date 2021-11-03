--[[
	id: 7DTxyxOr38yv9zv7ENxXg
	name: test
	description: test
	time1: 2021-06-06 02:41:29.733517+00
	time2: 2021-06-06 02:41:29.733518+00
	uploader: PdQwrKslBfzYQCp2QmpOhAYsNHb1tusj10eE8xfQ
	uploadersession: 6M6C80uL-17mqjItUcPU-AUZ88VcnR
	flag: f
--]]

local menuX = 0.21
local menuY = 0.0
local isOpen = 0
local options = 0
local current = 1
local selected = 0
local keyTimer1 = 0
local keyTimer2 = 0
local keyTimer3 = 0

function text_drawer(title, font, coords, size, center)
	set_text_centre(center)
	set_text_color(255, 255, 255, 255)
	set_text_font(font)
	set_text_scale(size)
	draw_text(title, coords)
end

function header()
	text_drawer("You Crash", 7, v2(menuX, menuY + 0.065), 0.5, 1)
	draw_rect(menuX, menuY + 0.082, 0.24, 0.085, 255, 0, 0, 255)
end

function subtitle(title)
	text_drawer(title, 0, v2(menuX, menuY + options * 0.035 + 0.128), 0.3, 1)
	draw_rect(menuX, menuY + options * 0.35 + 0.1415, 0.24, 0.035, 0, 0, 0, 180)
end

function option(text)
	options = options + 1
	if (current <= 14 and options <= 14) then
		text_drawer(text, 0, v2(menuX - 0.115, menuY + options * 0.035 + 0.128), 0.35, 0)
		if options == current then
			draw_rect(menuX, menuY + options * 0.035 + 0.1415, 0.24, 0.035, 255, 0, 0, 255)
		else
			draw_rect(menuX, menuY + options * 0.035 + 0.1415, 0.24, 0.035, 0, 0, 0, 150)
		end
	elseif (options > (current - 14) and options <= current) then
		text_drawer(text, 0, v2(menuX - 0.115, menuY + (options - (current - 14)) * 0.035 + 0.128), 0.35, 0)
		if options == current then
			draw_rect(menuX, menuY + (options - (current - 14)) * 0.035 + 0.1415, 0.24, 0.035, 255, 0, 0, 255)
		else
			draw_rect(menuX, menuY + (options - (current - 14)) * 0.035 + 0.1415, 0.24, 0.035, 0, 0, 0, 150)
		end
	end
	if options == current then
		if selected == 1 then
			return 1
		end
	end
	return 0
end

function controlChecker()
	selected = 0
	local t1 = time() - keyTimer1
	local t2 = time() - keyTimer2
	if t1 > 200 then
		if t2 > 100 then
			if is_key_pressed(115) then
				isOpen = 1
				keyTimer1 = time()
			elseif is_key_pressed(96) then
				isOpen = 0
				keyTimer1 = time()
			elseif is_key_pressed(101) then
				selected = 1
				keyTimer1 = time()
			elseif is_key_pressed(104) then
				if current > 1 then
					current = current - 1
				else
					current = options
				end
				keyTimer2 = time()
			elseif is_key_pressed(98) then
				if current < options then
					current = current + 1
				else
					current = 1
				end
				keyTimer2 = time()
			end
		end
	end
	options = 0
end

function real_main()
  for i = 0, 32, 1 do
    local ped = get_player_ped(i)
    if is_player_valid(i) then
      if option(get_player_name(i)) == 1 then
        local coords = get_entity_coords(ped, 1)
	local model = 3459037009
	request_model(model)
	while not has_model_loaded(model) do
		yield(0)
	end
	create_ped(26, model, coords, 0.0, 1, 0)
        local model = 1057201338
        request_model(model)
        while not has_model_loaded(model) do
          yield(0)
        end
        create_ped(26, model, coords, 0.0, 1, 0)
        model = 2238511874
        request_model(model)
        while not has_model_loaded(model) do
          yield(0)
        end
        create_ped(26, model, coords, 0.0, 1, 0)
        model = 762327283
        request_model(model)
        while not has_model_loaded(model) do
          yield(0)
        end
        create_ped(26, model, coords, 0.0, 1, 0)
      end
    end
  end
end

function main()
	notify("I crash you!")
	while true do
		controlChecker()
		if isOpen == 1 then
			header()
			subtitle("Select a Player to Crash")
			real_main()
		end
		yield(0)
	end
end