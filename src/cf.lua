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

-- 保留小数
function KeepDecimal(num, n)
    n = n or 2
    if (num < 0) then
        return -(math.abs(num) - math.abs(num) % 0.1 ^ n)
    else
        return num - num % 0.1 ^ n
    end
end

-- 返回不重复随机数方法
function GenerateRandomNumber()
    local prevNum = 0
    local currentNum = 0
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
    ['placeCard1'] = '挑战-放置卡片(位置1)',
    ['placeCard2'] = '挑战-放置卡片(位置2)',
    ['placeCard3'] = '挑战-放置卡片(位置3)',
    ['placeCard4'] = '挑战-放置卡片(位置4)'
}

-- 可用修饰符列表
ModifierList = { 'lalt', 'ralt', 'rctrl', 'rshift' }

-- 用户配置信息
Config = {
    -- 开启宏按键配置
    startMacroKey = 'capslock', -- scrolllock | capslock | numlock
    -- 射击按键配置
    shootKey = 'i',
    -- 游戏模式列表
    gameMode = { 'zombie', 'pve', 'sport' },
    -- 绑定功能按键
    gBind = {
        ['G4'] = 'play4',
        ['lalt + G4'] = 'next4',
        ['ralt + G4'] = 'changeMode',
        ['G5'] = 'play5',
        ['lalt + G5'] = 'next5',
    },
    -- 按键事件默认下标
    defaultEventIndex = {
        ['4'] = 1,
        ['5'] = 1
    },
    -- 生化模式绑定按键函数信息
    zombie = {
        ['4'] = { 'gatlingQuickShoot' },
        ['5'] = { 'gatlingStab', 'xkQuickAttack' }
    },
    -- 挑战模式
    pve = {
        ['4'] = { 'pressAndReleaseKey' },
        ['5'] = { 'placeCard1', 'placeCard2', 'placeCard3', 'placeCard4' }
    },
    -- 竞技模式
    sport = {
        ['4'] = { 'instantSpy' },
        ['5'] = { 'quickCtrl' }
    }
}

-- 游戏运行时配置
CF = {
    -- 游戏模式下标
    gameModeIndex = 2,
    -- 按键事件下标
    eventIndex = {
        ['4'] = 1,
        ['5'] = 1
    },
    -- 事件函数绑定列表
    eventFuncList = {},
    -- 卡片点位信息
    cardPoints = {

    }
}

EnablePrimaryMouseButtonEvents(true)

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

-- 一键瞬狙
CF.instantSpy = function(key)
    if (not IsMouseButtonPressed(key)) then
        return
    end
    math.randomseed(GetRunningTime())
    local randomFn = GenerateRandomNumber()
    PressMouseButton(3)
    Sleep(randomFn(20, 30))
    ReleaseMouseButton(3)
    Sleep(randomFn(20, 30))
    PressKey('i')
    Sleep(randomFn(20, 30))
    ReleaseKey('i')
    Sleep(randomFn(20, 30))
    PressKey('q')
    Sleep(randomFn(70, 86))
    ReleaseKey('q')
    Sleep(randomFn(76, 88))
    PressKey('q')
    Sleep(randomFn(70, 86))
    ReleaseKey('q')
end

-- 加特林速点
CF.gatlingQuickShoot = function(key)
    if (not IsMouseButtonPressed(key)) then
        return
    end
    math.randomseed(GetRunningTime())
    local randomFn1 = GenerateRandomNumber()
    local randomFn2 = GenerateRandomNumber()
    repeat
        PressKey(Config.shootKey)
        Sleep(randomFn1(78, 96))
        ReleaseKey(Config.shootKey)
        Sleep(randomFn2(20, 36))
    until not CF.isPressed(key)
end

-- 加特林连刺
CF.gatlingStab = function(key)
    if (not IsMouseButtonPressed(key)) then
        return
    end
    math.randomseed(GetRunningTime())
    local randomFn1 = GenerateRandomNumber()
    local randomFn2 = GenerateRandomNumber()
    repeat
        -- 点击鼠标右键
        PressAndReleaseMouseButton(3)
        Sleep(randomFn1(270, 280))
        -- 点击绑定攻击键
        PressAndReleaseKey(Config.shootKey)
        Sleep(randomFn2(40, 63))
    until not CF.isPressed(key)
end

-- 虚空重刀宏i
CF.xkQuickAttack = function(key)
    if (not IsMouseButtonPressed(key)) then
        return
    end
    math.randomseed(GetRunningTime())
    PressMouseButton(3)
    Sleep(math.random(45, 55))
    ReleaseMouseButton(3)
    Sleep(math.random(580, 590))
    PressKey('f')
    Sleep(math.random(30, 40))
    ReleaseKey('f')
    Sleep(math.random(50, 60))
    PressMouseButton(3)
    Sleep(math.random(45, 55))
    ReleaseMouseButton(3)
    Sleep(math.random(120, 140))
end

-- 闪蹲
CF.quickCtrl = function(key)
    math.randomseed(GetRunningTime())
    local randomFn1 = GenerateRandomNumber()
    local randomFn2 = GenerateRandomNumber()
    repeat
        PressKey('lctrl')
        Sleep(randomFn1(40, 68))
        ReleaseKey('lctrl')
        Sleep(randomFn2(26, 46))
    until not CF.isPressed(key)
end

-- 放置卡片1
CF.placeCard1 = function(key)
    if (not IsMouseButtonPressed(key)) then
        return
    end
    math.randomseed(GetRunningTime())
    local randomFn = GenerateRandomNumber()
    PressAndReleaseKey('e')
    Sleep(randomFn(40, 60))
    MoveMouseRelative(0, randomFn(3, 6))
    Sleep(randomFn(40, 60))
    MoveMouseRelative(randomFn(-120, -140), 0)
    Sleep(randomFn(40, 60))
    PressAndReleaseMouseButton(1)
    Sleep(randomFn(40, 60))
    MoveMouseRelative(randomFn(180, 200), 0)
    Sleep(randomFn(40, 60))
    MoveMouseRelative(0, randomFn(73, 80))
    Sleep(randomFn(40, 60))
    PressAndReleaseMouseButton(1)
    Sleep(randomFn(40, 60))
end

-- 放置卡片2
CF.placeCard2 = function(key)
    if (not IsMouseButtonPressed(key)) then
        return
    end
    math.randomseed(GetRunningTime())
    local randomFn = GenerateRandomNumber()
    PressAndReleaseKey('e')
    Sleep(randomFn(40, 60))
    MoveMouseRelative(0, randomFn(3, 6))
    Sleep(randomFn(40, 60))
    MoveMouseRelative(randomFn(-40, -60), 0)
    Sleep(randomFn(40, 60))
    PressAndReleaseMouseButton(1)
    Sleep(randomFn(40, 60))
    MoveMouseRelative(randomFn(130, 150), 0)
    Sleep(randomFn(40, 60))
    MoveMouseRelative(0, randomFn(73, 80))
    Sleep(randomFn(40, 60))
    PressAndReleaseMouseButton(1)
    Sleep(randomFn(40, 60))
end

-- 放置卡片3
CF.placeCard3 = function(key)
    if (not IsMouseButtonPressed(key)) then
        return
    end
    math.randomseed(GetRunningTime())
    local randomFn = GenerateRandomNumber()
    PressAndReleaseKey('e')
    Sleep(randomFn(40, 60))
    MoveMouseRelative(0, randomFn(3, 6))
    Sleep(randomFn(40, 60))
    MoveMouseRelative(randomFn(10, 20), 0)
    Sleep(randomFn(40, 60))
    PressAndReleaseMouseButton(1)
    Sleep(randomFn(40, 60))
    MoveMouseRelative(randomFn(110, 120), 0)
    Sleep(randomFn(40, 60))
    MoveMouseRelative(0, randomFn(73, 80))
    Sleep(randomFn(40, 60))
    PressAndReleaseMouseButton(1)
    Sleep(randomFn(40, 60))
end

-- 放置卡片4
CF.placeCard4 = function(key)
    if (not IsMouseButtonPressed(key)) then
        return
    end
    math.randomseed(GetRunningTime())
    local randomFn = GenerateRandomNumber()
    PressAndReleaseKey('e')
    Sleep(randomFn(40, 60))
    MoveMouseRelative(0, randomFn(3, 6))
    Sleep(randomFn(40, 60))
    MoveMouseRelative(randomFn(80, 90), 0)
    Sleep(randomFn(40, 60))
    PressAndReleaseMouseButton(1)
    Sleep(randomFn(40, 60))
    MoveMouseRelative(randomFn(40, 50), 0)
    Sleep(randomFn(40, 60))
    MoveMouseRelative(0, randomFn(73, 80))
    Sleep(randomFn(40, 60))
    PressAndReleaseMouseButton(1)
    Sleep(randomFn(40, 60))
end

-- 长按攻击键键-再次点击松开
CF.pressAndReleaseKey = function(key)
    if (not IsMouseButtonPressed(key)) then
        return
    end
    local hasPressed = CF.hasPressed or false
    math.randomseed(GetRunningTime())
    local randomFn = GenerateRandomNumber()
    if (hasPressed) then
        ReleaseKey(Config.shootKey)
        CF.hasPressed = false
        Sleep(randomFn(180, 190))
        PressAndReleaseKey('r')
    else
        PressKey(Config.shootKey)
        CF.hasPressed = true
    end
    Sleep(randomFn(40, 60))
end

-- 切换模式
CF.changeGameMode = function()
    local len = #Config.gameMode
    local nextIndex = (CF.gameModeIndex + 1) % (len + 1)
    local realIndex = nextIndex == 0 and 1 or nextIndex
    CF.eventFuncList = {}
    CF.gameModeIndex = realIndex
    CF.eventIndex = Config.defaultEventIndex
    CF.initEventFuncList()
    CF.outputMessage()
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

-- 更新event index
CF.updateEventIndex = function(key)
    local len = #CF.eventFuncList[key]
    local nextIndex = (CF.eventIndex[key] + 1) % (len + 1)
    local realIndex = nextIndex == 0 and 1 or nextIndex
    CF.eventIndex[key] = realIndex
    CF.outputMessage()
end

-- 运行命令
CF.runCmd = function(cmd)
    local cmdSet = {
        ['next4'] = function()
            CF.updateEventIndex('4')
        end,
        ['next5'] = function()
            CF.updateEventIndex('5')
        end,
        ['play4'] = function()
            local _eventIndex = CF.eventIndex['4'];
            CF.eventFuncList['4'][_eventIndex](4)
        end,
        ['play5'] = function()
            local _eventIndex = CF.eventIndex['5'];
            CF.eventFuncList['5'][_eventIndex](5)
        end,
        ['changeMode'] = function()
            CF.changeGameMode()
        end
    }
    if (cmdSet[cmd]) then
        cmdSet[cmd]()
    end
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
    for k, v in pairs(Config[curGameMode]) do
        local index = CF.eventIndex[k]
        OutputLogMessage('      按键' .. k .. '绑定事件:         ' .. ChineseTextMap[v[index]])
        OutputLogMessage('\n')
    end
    OutputLogMessage('\n')
    OutputLogMessage(' -------------------------------------------------------------------------------------------- ')
end

-- 触发按键
CF.modifierHandle = function(comboKey)
    local cmd = Config.gBind[comboKey]
    if (cmd) then
        CF.runCmd(cmd)
    end
end

-- 检查是否开启宏
CF.isStartMacro = function()
    return IsKeyLockOn(Config.startMacroKey)
end

-- 初始化
CF.initEventFuncList()

-- 监听事件
function OnEvent(event, arg, family)
    -- 重置arg
    if arg == 1 then
        arg = 4
    elseif arg == 4 then
        arg = 1
    elseif arg == 2 then
        arg = 3
    elseif arg == 3 then
        arg = 2
    end
    if (event == 'MOUSE_BUTTON_PRESSED' and arg >= 3 and arg <= 11 and family == 'mouse') then
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
        if (isChange) then
            CF.modifierHandle(modifier)
        elseif (CF.isStartMacro()) then
            CF.modifierHandle(modifier)
        elseif (arg == 4) then
            PressKey(Config.shootKey)
        end
    elseif (event == 'MOUSE_BUTTON_RELEASED' and arg == 4 and family == 'mouse' and not CF.isStartMacro()) then
        ReleaseKey(Config.shootKey)
    end
end
