---@diagnostic disable: undefined-global, duplicate-set-field, param-type-mismatch
-- 自定义函数
-- 四舍五入
function math.round(number)
	local floor = math.floor(number)
	local ceil = math.ceil(number)
	local fractionalPart = number - floor
	if fractionalPart < 0.5 then
		return floor
	else
		return ceil
	end
end

-- 分割字符串，返回数组
function string.split(str, separator)
	local result = {}
	local pattern = string.format("([^%s]+)", separator)
	for match in string.gmatch(str, pattern) do
		table.insert(result, match)
	end
	return result
end

-- 获取表长度
function GetTableLength(t)
	local i = 0
	for _, _ in pairs(t) do
		i = i + 1
	end
	return i
end

-- 正态分布变换
function BoxMuller(mean, stddev)
	-- 生成两个均匀分布的随机数
	local u1 = math.random()
	local u2 = math.random()
	-- 使用Box-Muller变换转换成正态分布随机数
	local z0 = math.sqrt(-2.0 * math.log(u1)) * math.cos(2.0 * math.pi * u2)
	-- 使用均值和标准差进行线性变换
	return math.round(mean + z0 * stddev)
end

-- 随机数方法
function Random(m, n)
	local mean = (m + n) / 2
	local sigma = (n - m) / (2 * 1.645) -- 1.645 0.9500 1.2815 0.9000
	local random = BoxMuller(mean, sigma)
	while random < m do
		random = math.round(math.random(m, n))
	end
	return random
end

-- 返回不重复随机数方法
function GenerateRandomNumber()
	local prevNum = 0
	local currentNum = 0
	return function(min, max)
		while prevNum == currentNum do
			currentNum = math.round(min + (max - min) * math.random())
		end
		prevNum = currentNum
		return currentNum
	end
end

-- 返回一个数组，其中每个数都在min和max之间，并且数组中的所有项之和等于num
function GenerateArrayHelper(num, arr, min, max)
	local _num = num
	while _num > 0 do
		local randNum = math.round(math.random(min, max))
		if _num <= math.floor(max / 2) then
			table.insert(arr, _num)
			_num = 0
		elseif randNum <= _num then
			table.insert(arr, randNum)
			_num = _num - randNum
		end
	end
	return arr
end

-- 获取Unicode编码
function GetUnicode()
	local utf8 = require("utf8")
	local str = "绑定事件"
	local result = "utf8_char("
	for _, code in utf8.codes(str) do
		result = result .. code .. ","
	end

	result = string.sub(result, 1, -2)

	result = result .. ")"

	print(result)
end

-- 字符转化
function utf8_char(...)
	local result = ""
	for _, v in ipairs({ ... }) do
		if v < 128 then
			result = result .. string.char(v)
		elseif v < 2048 then
			result = result .. string.char(192 + math.floor(v / 64), 128 + (v % 64))
		elseif v < 65536 then
			result = result .. string.char(224 + math.floor(v / 4096), 128 + (math.floor(v / 64) % 64), 128 + (v % 64))
		else
			result = result
				.. string.char(
					240 + math.floor(v / 262144),
					128 + (math.floor(v / 4096) % 64),
					128 + (math.floor(v / 64) % 64),
					128 + (v % 64)
				)
		end
	end
	return result
end

-- 中文对照表
ChineseTextMap = {
	["zombie"] = utf8_char(29983, 21270, 27169, 24335), -- 生化模式
	["pve"] = utf8_char(35802, 25112, 27169, 24335), -- 挑战模式
	["sport"] = utf8_char(31454, 20132, 27169, 24335), -- 竞技模式
	["gatlingQuickShoot"] = utf8_char(21152, 29305, 26519, 36895), -- 加特林速点
	["quickCtrl"] = utf8_char(38381, 20710), -- 闪蹲
	["gatlingStab"] = utf8_char(21152, 29305, 26519, 36830), -- 加特林连刺
	["xkQuickAttack"] = utf8_char(34394, 31354, 37325, 20992), -- 虚空重刀
	["instantSpy"] = utf8_char(19968, 38190, 30636, 29477), -- 一键瞬狙
	["continueAttack"] = utf8_char(35802, 25112, 25915, 20986, 25918, 21452), -- 挑战攻击释放双手
	["dropCardFirst"] = utf8_char(35797, 28889, 23707, 21345, 21360, 25918, 32622, 65306, 20301, 32622, 49), -- 试炼岛卡片放置：位置1
	["dropCardSecond"] = utf8_char(35797, 28889, 23707, 21345, 21360, 25918, 32622, 65306, 20301, 32622, 50), -- 试炼岛卡片放置：位置2
	["dropCardThird"] = utf8_char(35797, 28889, 23707, 21345, 21360, 25918, 32622, 65306, 20301, 32622, 51), -- 试炼岛卡片放置：位置3
	["dropCardFourth"] = utf8_char(35797, 28889, 23707, 21345, 21360, 25918, 32622, 65306, 20301, 32622, 52), -- 试炼岛卡片放置：位置4
}

-- 可用修饰符列表
ModifierList = { "lalt", "ralt", "rctrl", "rshift" }

-- 用户配置信息
Config = {
	-- 开启宏按键配置
	startMacroKey = "capslock", -- scrolllock | capslock | numlock
	-- 游戏模式列表
	gameMode = {
		"zombie",
		"pve",
		-- 'sport'
	},
	-- 绑定功能按键
	gBind = {
		["G1"] = "play_1",
		["lalt + G1"] = "next_1",
		["ralt + G1"] = "reset_1",
		["G4"] = "play_4",
		["lalt + G4"] = "next_4",
		["ralt + G4"] = "reset_4",
		["G5"] = "play_5",
		["lalt + G5"] = "next_5",
		["ralt + G5"] = "reset_5",
		["G7"] = "play_7",
		["lalt + G7"] = "next_7",
		["ralt + G7"] = "reset_7",
		["ralt + G6"] = "changeMode",
	},
	-- 按键事件默认下标
	defaultEventIndex = {
		["1"] = 1,
		["4"] = 1,
		["5"] = 1,
		["7"] = 1,
	},
	-- 生化模式绑定按键函数信息
	zombie = {
		["4"] = { "gatlingStab", "xkQuickAttack" },
		["5"] = { "gatlingQuickShoot" },
	},
	-- 挑战模式
	pve = {
		["4"] = { "continueAttack" },
		["5"] = { "dropCardFirst", "dropCardSecond", "dropCardThird", "dropCardFourth" },
	},
}

-- 运行时配置
CF = {
	-- 游戏模式下标
	gameModeIndex = 2,
	-- 按键事件下标
	eventIndex = {
		["1"] = 1,
		["4"] = 1,
		["5"] = 1,
		["7"] = 1,
	},
	-- 事件函数绑定列表
	eventFuncList = {},
}

-- 触发点击
CF.onClick = function(key)
	if type(key) == "number" then
		PressMouseButton(key)
		Sleep(Random(30, 50))
		ReleaseMouseButton(key)
	else
		PressKey(key)
		Sleep(Random(30, 50))
		ReleaseKey(key)
	end
end

-- 平滑的移动鼠标
CF.moveMouseSmooth = function(x, y, time)
	local duration = time or Random(30, 60)
	OutputLogMessage("\n")
	OutputLogMessage(x .. "duration: " .. duration)
	OutputLogMessage("\n")
	local durationArr = GenerateArrayHelper(duration, {}, 10, 18)
	local totalDuration = #durationArr
	local movedX, movedY = 0, 0
	for i = 1, totalDuration do
		OutputLogMessage("value: " .. durationArr[i])
		OutputLogMessage("\n")
		local stepX, stepY = math.round(x / duration * durationArr[i]), math.round(y / duration * durationArr[i])
		if (movedX + stepX >= x) or (movedY + stepY >= y and y ~= 0) or i == totalDuration then
			MoveMouseRelative(x - movedX, y - movedY)
			Sleep(durationArr[i])
			break
		else
			MoveMouseRelative(stepX, stepY)
		end
		movedX, movedY = movedX + stepX, movedY + stepY
		Sleep(durationArr[i])
	end
end

-- 判断按键是否按下
CF.isPressed = function(key)
	if type(key) == "number" and key <= 5 and key >= 1 then
		return IsMouseButtonPressed(key)
	elseif type(key) == "string" then
		return IsModifierPressed(key)
	else
		return false
	end
end

-- 检查是否开启宏
CF.isStartMacro = function()
	return IsKeyLockOn(Config.startMacroKey)
end

-- 更新按键绑定事件index
CF.updateEventIndex = function(key)
	local len = #CF.eventFuncList[key]
	local nextIndex = (CF.eventIndex[key] + 1) % (len + 1)
	local realIndex = nextIndex == 0 and 1 or nextIndex
	CF.eventIndex[key] = realIndex
	CF.outputMessage()
end

-- 重置按键绑定事件index
CF.resetEventIndex = function(key)
	CF.eventIndex[key] = Config.defaultEventIndex[key]
	CF.outputMessage()
end

-- 加特林速点
CF.gatlingQuickShoot = function(key)
	repeat
		PressMouseButton(1)
		Sleep(Random(80, 110))
		ReleaseMouseButton(1)
		Sleep(Random(20, 44))
	until not CF.isPressed(key)
end

-- 加特林连刺
CF.gatlingStab = function(key)
	repeat
		PressAndReleaseMouseButton(3)
		Sleep(Random(270, 300))
		PressAndReleaseMouseButton(1)
		Sleep(Random(40, 63))
	until not CF.isPressed(key)
end

-- 虚空重刀宏i
CF.xkQuickAttack = function(key)
	if not IsMouseButtonPressed(key) then
		return
	end
	CF.onClick(3)
	Sleep(Random(580, 590))
	CF.onClick("f")
	Sleep(Random(50, 60))
	CF.onClick(3)
	Sleep(Random(120, 140))
end

-- 一键瞬狙宏
CF.instantSpy = function(key)
	if not IsMouseButtonPressed(key) then
		return
	end
	CF.onClick(3)
	Sleep(Random(20, 40))
	CF.onClick(1)
	Sleep(Random(20, 40))
	CF.onClick("q")
	Sleep(Random(20, 40))
	CF.onClick("q")
	Sleep(Random(20, 40))
end

-- 试炼岛卡片放置：位置1
CF.dropCardFirst = function(key)
	if not IsMouseButtonPressed(key) then
		return
	end
	local position = { { -120, -135, 0, 0 }, { 180, 195, 70, 76 } }
	CF.dropCard(position)
end

-- 试炼岛卡片放置：位置2
CF.dropCardSecond = function(key)
	if not IsMouseButtonPressed(key) then
		return
	end
	local position = { { -40, -55, 0, 0 }, { 130, 145, 70, 76 } }
	CF.dropCard(position)
end

-- 试炼岛卡片放置：位置3
CF.dropCardThird = function(key)
	if not IsMouseButtonPressed(key) then
		return
	end
	local position = { { 20, 30, 0, 0 }, { 100, 110, 70, 76 } }
	CF.dropCard(position)
end

-- 试炼岛卡片放置：位置4
CF.dropCardFourth = function(key)
	if not IsMouseButtonPressed(key) then
		return
	end
	local position = { { 76, 90, 0, 0 }, { 40, 50, 70, 76 } }
	CF.dropCard(position)
end

-- 挑战放置卡片
CF.dropCard = function(position)
	local randomFn = GenerateRandomNumber()
	local pointOne = position[1]
	local pointTwo = position[2]
	CF.onClick("e")
	Sleep(Random(30, 50))
	MoveMouseRelative(0, randomFn(3, 6))
	Sleep(Random(30, 50))
	MoveMouseRelative(randomFn(pointOne[1], pointOne[2]), 0)
	Sleep(Random(30, 50))
	CF.onClick(1)
	Sleep(Random(30, 50))
	MoveMouseRelative(randomFn(pointTwo[1], pointTwo[2]), randomFn(pointTwo[3], pointTwo[4]))
	Sleep(Random(30, 50))
	CF.onClick(1)
	Sleep(Random(30, 50))
end

-- 长按攻击键键-再次点击松开
CF.continueAttack = function(key)
	if not IsMouseButtonPressed(key) then
		return
	end
	local hasPressed = CF.hasPressed or false
	if hasPressed then
		ReleaseMouseButton(1)
		Sleep(Random(180, 200))
		CF.onClick("r")
		CF.hasPressed = false
	else
		PressMouseButton(1)
		CF.hasPressed = true
	end
	Sleep(Random(65, 80))
end

-- 切换模式
CF.changeGameMode = function()
	local len = #Config.gameMode
	local nextIndex = (CF.gameModeIndex + 1) % (len + 1)
	local realIndex = nextIndex == 0 and 1 or nextIndex
	CF.eventFuncList = {}
	CF.gameModeIndex = realIndex
	for k, v in pairs(Config.defaultEventIndex) do
		CF.eventIndex[k] = v
	end
	CF.initEventFuncList()
end

-- 输出当前信息
CF.outputMessage = function()
	-- 当前游戏模式
	local curGameMode = Config.gameMode[CF.gameModeIndex]
	ClearLog()
	OutputLogMessage(" -------------------------------------------------------------------------------------------- ")
	OutputLogMessage("\n")
	OutputLogMessage("\n")
	OutputLogMessage(
		"      " .. utf8_char(24403, 21069, 28216, 25103, 27169, 24335) .. ":          " .. ChineseTextMap[curGameMode]
	)
	OutputLogMessage("\n")
	OutputLogMessage("\n")
	for k, v in pairs(Config[curGameMode]) do
		local index = CF.eventIndex[k]
		OutputLogMessage(
			"      "
				.. utf8_char(25353, 38190)
				.. k
				.. utf8_char(32465, 23450, 20107, 20214)
				.. ":         "
				.. ChineseTextMap[v[index]]
		)
		OutputLogMessage("\n")
	end
	OutputLogMessage("\n")
	OutputLogMessage(" -------------------------------------------------------------------------------------------- ")
end

-- 初始化事件函数绑定列表
CF.initEventFuncList = function()
	-- 当前游戏模式
	local curGameMode = Config.gameMode[CF.gameModeIndex]
	for key, value in pairs(Config[curGameMode]) do
		local t = {}
		for i = 1, #value do
			table.insert(t, CF[value[i]])
		end
		CF.eventFuncList[key] = t
	end
	CF.outputMessage()
end

-- 执行指令函数
CF.runCmd = function(cmd)
	local cmdGroup = string.split(cmd, "_")
	local _type = cmdGroup[1]
	local key = cmdGroup[2]
	if _type == "next" then
		CF.updateEventIndex(key)
	elseif _type == "reset" then
		CF.resetEventIndex(key)
	elseif _type == "play" then
		local _eventIndex = CF.eventIndex[key]
		local fnList = CF.eventFuncList[key]
		if type(fnList) == "nil" then
			return
		end
		fnList[_eventIndex](key)
	elseif _type == "changeMode" then
		CF.changeGameMode()
	end
end

-- 处理修饰符
CF.modifierHandler = function(modifier)
	-- 根据修饰符获取配置的指令
	local cmd = Config.gBind[modifier]
	if cmd then
		-- 执行指令
		CF.runCmd(cmd)
	end
end

-- 初始化
CF.initEventFuncList()

-- 打开对鼠标左键的监听
EnablePrimaryMouseButtonEvents(true)

-- 设置随机数种子
math.randomseed(GetDate("%H%M%S"):reverse())

-- 监听鼠标点击事件
function OnEvent(event, arg, family)
	if event == "MOUSE_BUTTON_PRESSED" and arg >= 1 and arg <= 11 and family == "mouse" then
		-- 监听3-11的可绑定按键
		local modifier = "G" .. arg
		for i = 1, #ModifierList do
			if CF.isPressed(ModifierList[i]) then
				-- 其中某一个修饰符被按下
				modifier = ModifierList[i] .. " + " .. modifier
				break
			end
		end
		local isChange = string.find(modifier, "+")
		if isChange or CF.isStartMacro() then
			-- 事件属于切换事件或已开启宏按钮
			CF.modifierHandler(modifier)
		end
	end
end
