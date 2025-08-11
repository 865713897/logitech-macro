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
	local result = "Utf8Char("
	for _, code in utf8.codes(str) do
		result = result .. code .. ","
	end

	result = string.sub(result, 1, -2)

	result = result .. ")"

	print(result)
end

-- 字符转化
function Utf8Char(...)
	local args = { ... }
	local result = ""

	for _, v in ipairs(args) do
		-- 验证码点的范围，Unicode 有效码点范围为 0 - 0x10FFFF
		if v < 0 or v > 0x10FFFF then
			error("Invalid Unicode code point: " .. tostring(v))
		elseif v < 0x80 then
			result = result .. string.char(v)
		elseif v < 0x800 then
			result = result .. string.char(0xC0 + math.floor(v / 0x40), 0x80 + (v % 0x40))
		elseif v < 0x10000 then
			result = result
				.. string.char(0xE0 + math.floor(v / 0x1000), 0x80 + (math.floor(v / 0x40) % 0x40), 0x80 + (v % 0x40))
		else
			result = result
				.. string.char(
					0xF0 + math.floor(v / 0x40000),
					0x80 + (math.floor(v / 0x1000) % 0x40),
					0x80 + (math.floor(v / 0x40) % 0x40),
					0x80 + (v % 0x40)
				)
		end
	end

	return result
end

-- 中文对照表
ChineseTextMap = {
	["zombie"] = Utf8Char(29983, 21270, 27169, 24335), -- 生化模式
	["pve"] = Utf8Char(25361, 25112, 27169, 24335), -- 挑战模式
	["sport"] = Utf8Char(31454, 25216, 27169, 24335), -- 竞技模式
	["gatlingQuickShoot"] = Utf8Char(21152, 29305, 26519, 36895, 28857), -- 加特林速点
	["quickCtrl"] = Utf8Char(19968, 38190, 38378, 36466), -- 一键闪蹲
	["gatlingStab"] = Utf8Char(21152, 29305, 26519, 36830, 21050), -- 加特林连刺
	["xkQuickAttack"] = Utf8Char(34394, 31354, 37325, 20992), -- 虚空重刀
	["instantSpy"] = Utf8Char(19968, 38190, 30636, 29401), -- 一键瞬狙
	["continueAttack"] = Utf8Char(25361, 25112, 27169, 24335, 33258, 21160, 25915, 20987), -- 挑战攻击释放双手
	["dropCardFirst"] = Utf8Char(35797, 28860, 23707, 21345, 29255, 25918, 32622, 65306, 20301, 32622, 49), -- 试炼岛卡片放置：位置1
	["dropCardSecond"] = Utf8Char(35797, 28860, 23707, 21345, 29255, 25918, 32622, 65306, 20301, 32622, 50), -- 试炼岛卡片放置：位置2
	["autoDropCardSecond"] = Utf8Char(
		35797,
		28860,
		23707,
		21345,
		29255,
		33258,
		21160,
		25918,
		32622,
		65306,
		20301,
		32622,
		50
	),
	["dropCardThird"] = Utf8Char(35797, 28860, 23707, 21345, 29255, 25918, 32622, 65306, 20301, 32622, 51), -- 试炼岛卡片放置：位置3
	["dropCardFourth"] = Utf8Char(35797, 28860, 23707, 21345, 29255, 25918, 32622, 65306, 20301, 32622, 52), -- 试炼岛卡片放置：位置4
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
		["ralt + G3"] = "changeMode",
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
		["7"] = { "autoDropCardSecond" },
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
	-- 事件最后运行时间
	lastRunTime = 0,
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
CF.xkQuickAttack = function()
	-- 如果当前时间和最后运行时间相差少于500ms
	-- 则不执行
	local diffTime = GetRunningTime() - CF.lastRunTime
	if diffTime < 500 then
		return
	end
	CF.onClick(3)
	Sleep(Random(580, 590))
	CF.onClick("f")
	Sleep(Random(50, 60))
	CF.onClick(3)
	Sleep(Random(120, 140))
	CF.lastRunTime = GetRunningTime()
end

-- 一键瞬狙宏
CF.instantSpy = function()
	-- 如果当前时间和最后运行时间相差少于500ms
	-- 则不执行
	local diffTime = GetRunningTime() - CF.lastRunTime
	if diffTime < 500 then
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
	CF.lastRunTime = GetRunningTime()
end

-- 试炼岛卡片放置：位置1
CF.dropCardFirst = function()
	-- 如果当前时间和最后运行时间相差少于500ms
	-- 则不执行
	local diffTime = GetRunningTime() - CF.lastRunTime
	if diffTime < 500 then
		return
	end
	local position = { { -120, -135, 0, 0 }, { 180, 195, 70, 76 } }
	CF.dropCard(position)
	CF.lastRunTime = GetRunningTime()
end

-- 试炼岛卡片放置：位置2
CF.dropCardSecond = function()
	-- 如果当前时间和最后运行时间相差少于500ms
	-- 则不执行
	local diffTime = GetRunningTime() - CF.lastRunTime
	if diffTime < 500 then
		return
	end
	local position = { { -40, -55, 0, 0 }, { 130, 145, 70, 76 } }
	CF.dropCard(position)
	CF.lastRunTime = GetRunningTime()
end

-- 试炼岛卡片自动放置：位置2
CF.autoDropCardSecond = function()
	-- 如果当前时间和最后运行时间相差少于500ms
	-- 则不执行
	local diffTime = GetRunningTime() - CF.lastRunTime
	if diffTime < 500 then
		return
	end
	local position = { { -40, -55, 0, 0 }, { 130, 145, 70, 76 } }
	-- 默认一次性自动放置20张卡片
	local count = 20
	while count > 0 do
		CF.dropCard(position)
		-- 等待5s
		Sleep(5 * 1000)
		CF.continueAttack()
		-- 2s解决战斗
		Sleep(1.5 * 1000)
		CF.continueAttack()
		if CF.isPressed(2) or CF.isPressed(3) then
			count = 0
			break
		end
		-- 再次等待5s
		Sleep(4 * 1000)
		count = count - 1
	end
	CF.lastRunTime = GetRunningTime()
end

-- 试炼岛卡片放置：位置3
CF.dropCardThird = function()
	-- 如果当前时间和最后运行时间相差少于500ms
	-- 则不执行
	local diffTime = GetRunningTime() - CF.lastRunTime
	if diffTime < 500 then
		return
	end
	local position = { { 20, 30, 0, 0 }, { 100, 110, 70, 76 } }
	CF.dropCard(position)
	CF.lastRunTime = GetRunningTime()
end

-- 试炼岛卡片放置：位置4
CF.dropCardFourth = function()
	-- 如果当前时间和最后运行时间相差少于500ms
	-- 则不执行
	local diffTime = GetRunningTime() - CF.lastRunTime
	if diffTime < 500 then
		return
	end
	local position = { { 76, 90, 0, 0 }, { 40, 50, 70, 76 } }
	CF.dropCard(position)
	CF.lastRunTime = GetRunningTime()
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
CF.continueAttack = function()
	-- 如果当前时间和最后运行时间相差少于500ms
	-- 则不执行
	local diffTime = GetRunningTime() - CF.lastRunTime
	if diffTime < 500 then
		return
	end
	local hasPressed = CF.hasPressed or false
	if hasPressed then
		ReleaseMouseButton(1)
		Sleep(Random(180, 200))
		CF.onClick("r")
	else
		PressMouseButton(1)
	end
	CF.hasPressed = not hasPressed
	Sleep(Random(65, 80))
	CF.lastRunTime = GetRunningTime()
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
		"      " .. Utf8Char(24403, 21069, 28216, 25103, 27169, 24335) .. ":          " .. ChineseTextMap[curGameMode]
	)
	OutputLogMessage("\n")
	OutputLogMessage("\n")
	for k, v in pairs(Config[curGameMode]) do
		local index = CF.eventIndex[k]
		OutputLogMessage(
			"      "
				.. Utf8Char(25353, 38190)
				.. k
				.. Utf8Char(32465, 23450, 20107, 20214)
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

-- 鼠标平滑移动
function Utils.smoothMove(startX, startY, endX, endY, durationMs)
  -- 参数校验
  if durationMs <= 0 then return end

  -- 亚像素累积桶
  local accumX, accumY = 0, 0

  -- 移动参数
  local steps = math.max(10, durationMs / 10)
  local stepInterval = durationMs / steps
  local randomFn = Utils.generateRandomNumber()

  -- 贝塞尔曲线控制点
  local ctrlX1 = startX + randomFn(-15, 15)
  local ctrlY1 = startY + randomFn(-15, 15)
  local ctrlX2 = endX + randomFn(-15, 15)
  local ctrlY2 = endY + randomFn(-15, 15)

  -- 记录当前位置（绝对坐标）
  local currentX, currentY = startX, startY

  for t = 0, 1, 1 / steps do
    -- 三阶贝塞尔曲线计算
    local targetX = (1 - t) ^ 3 * startX +
        3 * (1 - t) ^ 2 * t * ctrlX1 +
        3 * (1 - t) * t ^ 2 * ctrlX2 +
        t ^ 3 * endX

    local targetY = (1 - t) ^ 3 * startY +
        3 * (1 - t) ^ 2 * t * ctrlY1 +
        3 * (1 - t) * t ^ 2 * ctrlY2 +
        t ^ 3 * endY

    -- 计算理论偏移量（可能是亚像素）
    local deltaX = targetX - currentX
    local deltaY = targetY - currentY

    -- 累积亚像素偏移
    accumX = accumX + deltaX
    accumY = accumY + deltaY

    -- 计算实际应移动的整像素值
    local moveX = math.floor(accumX)
    local moveY = math.floor(accumY)

    -- 执行移动（仅当累积量≥1像素）
    if moveX ~= 0 or moveY ~= 0 then
      MoveMouseRelative(moveX, moveY)
      -- 更新当前位置和剩余累积量
      currentX = currentX + moveX
      currentY = currentY + moveY
      accumX = accumX - moveX
      accumY = accumY - moveY
    end

    -- 随机间隔（添加微抖动）
    Sleep(stepInterval + randomFn(-3, 5))
  end

  -- 最终校正（确保到达终点）
  local finalX = endX - currentX
  local finalY = endY - currentY
  if finalX ~= 0 or finalY ~= 0 then
    MoveMouseRelative(finalX, finalY)
  end
end

function Utils.humanMouseMove(startX, startY, endX, endY, maxSpeed)
  -- 参数说明：
  -- maxSpeed: 最大速度（像素/秒），建议值：2000-5000（需设备支持）

  local distance = math.sqrt((endX - startX) ^ 2 + (endY - startY) ^ 2)
  local totalTime = math.max(50, (distance / maxSpeed) * 1000) -- 最短50ms

  -- 动态阶段划分
  local ACCEL_PHASE = 0.2  -- 加速阶段占比
  local CRUISE_PHASE = 0.6 -- 高速巡航
  local DECEL_PHASE = 0.2  -- 减速

  -- 亚像素累积
  local accumX, accumY = 0, 0
  local currentX, currentY = startX, startY

  for t = 0, 1, 0.01 do -- 1%精度步进
    -- 三阶段速度曲线
    local progress
    if t <= ACCEL_PHASE then
      progress = math.pow(t / ACCEL_PHASE, 1.8) * ACCEL_PHASE -- 1.8次方加速
    elseif t <= (ACCEL_PHASE + CRUISE_PHASE) then
      progress = ACCEL_PHASE + (t - ACCEL_PHASE)              -- 匀速
    else
      progress = 1 - math.pow((1 - t) / DECEL_PHASE, 2)       -- 二次方减速
    end

    -- 目标点计算（加入惯性预测）
    local targetX = startX + (endX - startX) * progress
    local targetY = startY + (endY - startY) * progress

    -- 亚像素级移动
    local deltaX = targetX - currentX
    local deltaY = targetY - currentY
    accumX = accumX + deltaX
    accumY = accumY + deltaY

    local moveX = math.floor(accumX)
    local moveY = math.floor(accumY)

    if moveX ~= 0 or moveY ~= 0 then
      MoveMouseRelative(moveX, moveY)
      currentX = currentX + moveX
      currentY = currentY + moveY
      accumX = accumX - moveX
      accumY = accumY - moveY
    end

    -- 动态间隔（关键提速点）
    local interval
    if t <= ACCEL_PHASE then
      interval = 1                                  -- 加速阶段最小间隔1ms
    elseif t >= (1 - DECEL_PHASE) then
      interval = 3                                  -- 减速阶段稍慢
    else
      interval = math.max(1, 2 - (distance / 2000)) -- 距离越长间隔越小
    end

    Sleep(math.floor(interval))
  end

  -- 终点强制校准
  local finalX = endX - currentX
  local finalY = endY - currentY
  if finalX ~= 0 or finalY ~= 0 then
    MoveMouseRelative(finalX, finalY)
  end
end
