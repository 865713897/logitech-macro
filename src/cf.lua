---@diagnostic disable: undefined-global, duplicate-set-field, param-type-mismatch
-- 自定义函数
-- 四舍五入
function math.round(number)
    local floor = math.floor(number)
    local ceil = math.ceil(number)
    local fractionalPart = number - floor
    if (fractionalPart < 0.5) then
        return floor
    else
        return ceil
    end
end

-- 分割字符串，返回数组
function string.split(str, separator)
    local result = {}
    local pattern = string.format('([^%s]+)', separator)
    for match in string.gmatch(str, pattern) do
        table.insert(result, match)
    end
    return result
end

-- 获取表长度
function GetTableLength(t)
    local i = 0
    for k, v in pairs(t) do
        i = i + 1
    end
    return i
end

-- 保留小数
function KeepDecimal(num, n)
    n = n or 2
    if (num < 0) then
        return -(math.abs(num) - math.abs(num) % 0.1 ^ n)
    else
        return num - num % 0.1 ^ n
    end
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
    math.randomseed(GetDate("%H%M%S"):reverse())
    local mean = (m + n) / 2
    local sigma = (n - m) / (2 * 1.645) -- 1.645 0.9500 1.2815 0.9000
    local random = BoxMuller(mean, sigma)
    while (random < m) do
        random = math.round(math.random(m, n))
    end
    return random
end

-- 返回不重复随机数方法
function GenerateRandomNumber()
    local prevNum = 0
    local currentNum = 0
    math.randomseed(GetRunningTime())
    -- math.randomseed(GetDate("%H%M%S"):reverse())
    return function(min, max)
        while (prevNum == currentNum) do
            currentNum = math.round(min + (max - min) * math.random())
        end
        prevNum = currentNum
        return currentNum
    end
end

-- 中文对照表
ChineseTextMap = {
    ['zombie'] = '生化模式',
    ['pve'] = '挑战模式',
    ['sport'] = '竞技模式',
    ['gatlingQuickShoot'] = '加特林速点宏',
    ['quickCtrl'] = '闪蹲宏',
    ['gatlingStab'] = '加特林连刺宏',
    ['xkQuickAttack'] = '虚空重刀宏',
    ['instantSpy'] = '一键瞬狙宏',
    ['pressAndReleaseKey'] = '挑战攻击释放双手',
    ['dropCard'] = '挑战-放置卡片',
    ['updateCardIndex'] = '更新卡片索引位置'
}

-- 可用修饰符列表
ModifierList = { 'lalt', 'ralt', 'rctrl', 'rshift' }

-- 用户配置信息
Config = {
    -- 开启宏按键配置
    startMacroKey = 'capslock', -- scrolllock | capslock | numlock
    -- 游戏模式列表
    gameMode = {
        'zombie',
        'pve',
        -- 'sport'
    },
    -- 绑定功能按键
    gBind = {
        ['G1'] = 'play_1',
        ['lalt + G1'] = 'next_1',
        ['G4'] = 'play_4',
        ['lalt + G4'] = 'next_4',
        ['ralt + G5'] = 'changeMode',
        ['G5'] = 'play_5',
        ['lalt + G5'] = 'next_5',
        ['G7'] = 'play_7'
    },
    -- 按键事件默认下标
    defaultEventIndex = {
        ['1'] = 1,
        ['4'] = 1,
        ['5'] = 1,
        ['7'] = 1
    },
    -- 生化模式绑定按键函数信息
    zombie = {
        ['4'] = { 'gatlingStab', 'xkQuickAttack' },
        ['5'] = { 'gatlingQuickShoot' }
    },
    -- 挑战模式
    pve = {
        ['4'] = { 'pressAndReleaseKey' },
        ['5'] = { 'dropCard' },
        ['7'] = { 'updateCardIndex' }
    },
    -- 挑战模式卡片位置
    cardPosition = {
        { { -120, -135, 0, 0 }, { 180, 195, 70, 76 } },
        { { -40, -55, 0, 0 },   { 130, 145, 70, 76 } },
        { { 10, 20, 0, 0 },     { 110, 120, 70, 76 } },
        { { 76, 90, 0, 0 },     { 40, 50, 70, 76 } }
    }
}

-- 运行时配置
CF = {
    -- 游戏模式下标
    gameModeIndex = 2,
    -- 按键事件下标
    eventIndex = {
        ['1'] = 1,
        ['4'] = 1,
        ['5'] = 1,
        ['7'] = 1
    },
    -- 事件函数绑定列表
    eventFuncList = {},
    -- 目前处于第几张卡片
    cardIndex = 1
}

-- 判断按键是否按下
CF.isPressed = function(key)
    if (type(key) == 'number' and key <= 5 and key >= 1) then
        return IsMouseButtonPressed(key)
    elseif type(key) == 'string' then
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
end

-- 更新卡片索引位置
CF.updateCardIndex = function()
    local cardNums = #Config.cardPosition
    local nextIndex = (CF.cardIndex + 1) % (cardNums + 1)
    local realIndex = nextIndex == 0 and 1 or nextIndex
    CF.cardIndex = realIndex
    CF.outputMessage()
end

-- 加特林速点
CF.gatlingQuickShoot = function(key)
    local randomFn = GenerateRandomNumber()
    repeat
        PressMouseButton(1)
        Sleep(randomFn(100, 160))
        ReleaseMouseButton(1)
        Sleep(randomFn(20, 45))
    until not CF.isPressed(key)
end

-- 加特林连刺
CF.gatlingStab = function(key)
    local randomFn = GenerateRandomNumber()
    repeat
        -- 点击鼠标右键
        PressAndReleaseMouseButton(3)
        Sleep(randomFn(270, 300))
        -- 点击绑定攻击键
        PressAndReleaseMouseButton(1)
        Sleep(randomFn(40, 63))
    until not CF.isPressed(key)
end

-- 虚空重刀宏i
CF.xkQuickAttack = function(key)
    if (not IsMouseButtonPressed(key)) then
        return
    end
    local randomFn = GenerateRandomNumber()
    PressMouseButton(3)
    Sleep(randomFn(65, 80))
    ReleaseMouseButton(3)
    Sleep(randomFn(580, 590))
    PressKey('f')
    Sleep(randomFn(30, 40))
    ReleaseKey('f')
    Sleep(randomFn(50, 60))
    PressMouseButton(3)
    Sleep(randomFn(65, 80))
    ReleaseMouseButton(3)
    Sleep(randomFn(120, 140))
end

-- 挑战放置卡片
CF.dropCard = function(key)
    if (not IsMouseButtonPressed(key)) then
        return
    end
    local index = CF.cardIndex or 1
    local curPosition = Config.cardPosition[index]
    local pointOne = curPosition[1]
    local pointTwo = curPosition[2]
    local randomFn = GenerateRandomNumber()
    PressKey('e')
    Sleep(randomFn(40, 60))
    ReleaseKey('e')
    Sleep(randomFn(40, 60))
    MoveMouseRelative(0, randomFn(3, 6))
    Sleep(randomFn(40, 60))
    MoveMouseRelative(randomFn(pointOne[1], pointOne[2]), 0)
    Sleep(randomFn(40, 60))
    PressMouseButton(1)
    Sleep(randomFn(40, 60))
    ReleaseMouseButton(1)
    Sleep(randomFn(40, 60))
    MoveMouseRelative(randomFn(pointTwo[1], pointTwo[2]), randomFn(pointTwo[3], pointTwo[4]))
    Sleep(randomFn(40, 60))
    PressMouseButton(1)
    Sleep(randomFn(40, 60))
    ReleaseMouseButton(1)
    Sleep(randomFn(40, 60))
end

-- 长按攻击键键-再次点击松开
CF.pressAndReleaseKey = function(key)
    if (not IsMouseButtonPressed(key)) then
        return
    end
    local randomFn = GenerateRandomNumber()
    local hasPressed = CF.hasPressed or false
    if hasPressed then
        ReleaseMouseButton(1)
        Sleep(randomFn(180, 200))
        PressKey('r')
        Sleep(randomFn(40, 60))
        ReleaseKey('r')
        CF.hasPressed = false
    else
        PressMouseButton(1)
        CF.hasPressed = true
    end
    Sleep(randomFn(65, 80))
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
    CF.cardIndex = 1
    CF.initEventFuncList()
end

-- 输出当前信息
CF.outputMessage = function()
    -- 当前游戏模式
    local curGameMode = Config.gameMode[CF.gameModeIndex]
    ClearLog()
    OutputLogMessage(' -------------------------------------------------------------------------------------------- ')
    OutputLogMessage('\n')
    OutputLogMessage('\n')
    OutputLogMessage('      当前游戏模式:          ' .. ChineseTextMap[curGameMode])
    OutputLogMessage('\n')
    OutputLogMessage('\n')
    for k, v in pairs(Config[curGameMode]) do
        local index = CF.eventIndex[k]
        OutputLogMessage('      按键' .. k .. '绑定事件:         ' .. ChineseTextMap[v[index]])
        if curGameMode == 'pve' and k == '5' then
            OutputLogMessage('(当前卡片下标:' .. CF.cardIndex .. ')')
        end
        OutputLogMessage('\n')
    end
    OutputLogMessage('\n')
    OutputLogMessage(' -------------------------------------------------------------------------------------------- ')
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
    local cmdGroup = string.split(cmd, '_')
    local type = cmdGroup[1]
    local key = cmdGroup[2]
    if type == 'next' then
        CF.updateEventIndex(key)
    elseif type == 'play' then
        local _eventIndex = CF.eventIndex[key]
        CF.eventFuncList[key][_eventIndex](tonumber(key))
    elseif type == 'changeMode' then
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

-- 监听鼠标点击事件
function OnEvent(event, arg, family)
    if event == 'MOUSE_BUTTON_PRESSED' and arg >= 1 and arg <= 11 and family == 'mouse' then
        -- 监听3-11的可绑定按键
        local modifier = 'G' .. arg
        for i = 1, #ModifierList do
            if (CF.isPressed(ModifierList[i])) then
                -- 其中某一个修饰符被按下
                modifier = ModifierList[i] .. ' + ' .. modifier
                break
            end
        end
        local isChange = string.find(modifier, '+')
        if isChange or CF.isStartMacro() then
            -- 事件属于切换事件或已开启宏按钮
            CF.modifierHandler(modifier)
        end
    end
end
