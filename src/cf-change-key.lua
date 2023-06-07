---@diagnostic disable: undefined-global, duplicate-set-field
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

-- 分割字符串，返回数组
function string.split(str, separator)
    local result = {}
    local pattern = string.format('([^%s]+)', separator)
    for match in string.gmatch(str, pattern) do
        table.insert(result, match)
    end
    return result
end

-- 用户配置
Config = {
    -- 开启宏按键
    startScript = 'capslock', -- scrolllock | capslock | numlock
    -- 绑定开枪按键
    shootKey = 'i',
    -- 事件index
    eventIndex = {
        ['4'] = 1,
        ['5'] = 1,
        ['11'] = 1
    },
    -- 绑定功能键
    gBind = {
        ['G4'] = 'play4',
        ['G5'] = 'play5',
        ['G10'] = 'resetIndex',
        ['G11'] = 'play11',
        ['lalt + G4'] = 'next4',
        ['lalt + G5'] = 'next5',
        ['lalt + G11'] = 'next11',
    },
    -- 信息
    infos = {
        ['4'] = { 'gatlingShoot', 'instantSpy' },
        ['5'] = { 'gatlingStab', 'xkQuickAttack' },
        ['11'] = { 'tripleJump', 'doubleJump' }
    }
}

-- 函数绑定
FncEventBind = {}

-- 可用修饰符列表
ModifierList = { 'lalt', 'ralt', 'rctrl', 'rshift' }

EnablePrimaryMouseButtonEvents(true)

-- 是否开启宏
Config.isStartScript = function()
    return IsKeyLockOn(Config.startScript)
end

-- 判断按键是否按下
Config.isPressed = function(key)
    if (type(key) == 'number' and key <= 5 and key >= 1) then
        return IsMouseButtonPressed(key)
    elseif type(key) == 'string' then
        return IsModifierPressed(key)
    else
        return false
    end
end

-- 加特林点击
Config.gatlingShoot = function(key)
    if (not IsMouseButtonPressed(key)) then
        return
    end
    local baseDelay = 135
    local randomFn1 = GenerateRandomNumber()
    local randomFn2 = GenerateRandomNumber()
    repeat
        math.randomseed(GetRunningTime())
        PressKey(Config.shootKey)
        Sleep(randomFn1(math.random(baseDelay, baseDelay + 10), math.random(baseDelay + 15, baseDelay + 20)))
        ReleaseKey(Config.shootKey)
        Sleep(randomFn2(20, 36))
    until not Config.isPressed(key)
end

-- 加特林连刺
Config.gatlingStab = function(key)
    if (not IsMouseButtonPressed(key)) then
        return
    end
    local randomFn1 = GenerateRandomNumber()
    local randomFn2 = GenerateRandomNumber()
    repeat
        math.randomseed(GetRunningTime())
        -- 点击鼠标右键
        PressAndReleaseMouseButton(3)
        Sleep(randomFn1(270, 280))
        -- 点击绑定攻击键
        PressAndReleaseKey(Config.shootKey)
        Sleep(randomFn2(40, 63))
    until not Config.isPressed(key)
end

-- 闪蹲
function TapCtrl(key)
    local randomFn1 = GenerateRandomNumber()
    local randomFn2 = GenerateRandomNumber()
    repeat
        math.randomseed(GetRunningTime())
        PressKey('lctrl')
        Sleep(randomFn1(40, 50))
        ReleaseKey('lctrl')
        Sleep(randomFn2(26, 36))
    until not Config.isPressed(key)
end

-- 二级跳
Config.doubleJump = function()
    math.randomseed(GetRunningTime())
    -- 跳跳蹲
    PressKey('spacebar')
    Sleep(math.random(137, 139))
    ReleaseKey('spacebar')
    Sleep(math.random(490, 495))
    PressKey('spacebar')
    Sleep(math.random(137, 139))
    ReleaseKey('spacebar')
    Sleep(math.random(94, 96))
    PressKey('lctrl')
    Sleep(math.random(60, 65))
    ReleaseKey('lctrl')
end

-- 三级跳
Config.tripleJump = function()
    math.randomseed(GetRunningTime())
    PressKey('w')
    Sleep(50)
    PressKey('s')
    Sleep(500)
    PressKey('lctrl')
    Sleep(90)
    ReleaseKey('lctrl')
    Sleep(90)
    PressKey('lctrl')
    Sleep(90)
    ReleaseKey('lctrl')
    Sleep(90)
    PressKey('lctrl')
    Sleep(90)
    ReleaseKey('lctrl')
    Sleep(90)
    PressKey('lctrl')
    Sleep(90)
    ReleaseKey('lctrl')
    Sleep(200)
    PressKey('spacebar')
    Sleep(math.random(135, 137))
    ReleaseKey('spacebar')
    Sleep(math.random(95, 97))
    PressKey('lctrl')
    Sleep(math.random(62, 64))
    ReleaseKey('lctrl')
    Sleep(3)
    ReleaseKey('s')
    Sleep(2)
    ReleaseKey('w')
end

-- 虚空重刀宏
Config.xkQuickAttack = function(key)
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

-- 瞬狙
Config.instantSpy = function(key)
    PressMouseButton(3)
    Sleep(math.random(30, 40))
    ReleaseMouseButton(3)
    Sleep(math.random(30, 40))
    PressKey('i')
    Sleep(math.random(20, 25))
    ReleaseKey('i')
    Sleep(math.random(20, 25))
    PressKey('q')
    Sleep(math.random(100, 110))
    ReleaseKey('q')
    Sleep(math.random(80, 90))
    PressKey('q')
    Sleep(math.random(100, 110))
    ReleaseKey('q')
end

-- 蝴蝶
Config.hudieShoot = function()
    local baseDelay = 70
    local randomFn1 = GenerateRandomNumber()
    local randomFn2 = GenerateRandomNumber()
    repeat
        math.randomseed(GetRunningTime())
        PressKey(Config.shootKey)
        Sleep(randomFn1(math.random(baseDelay, baseDelay + 10), math.random(baseDelay + 15, baseDelay + 25)))
        ReleaseKey(Config.shootKey)
        Sleep(randomFn2(20, 30))
    until not Config.isPressed(key)
end

-- 更新event index
Config.updateEventIndex = function(key)
    local len = #FncEventBind[key]
    local nextIndex = (Config.eventIndex[key] + 1) % (len + 1)
    local realIndex = nextIndex == 0 and 1 or nextIndex
    Config.eventIndex[key] = realIndex
end

-- 重置event index
Config.resetEventIndex = function()
    for k, v in pairs(Config.eventIndex) do
        Config.eventIndex[k] = 1
    end
end

-- 输出当前
Config.outputMessage = function()
    ClearLog()
    OutputLogMessage(' -------------------------------------------------------------------------------------------- ')
    OutputLogMessage('\n')
    for k, v in pairs(Config.infos) do
        local index = Config.eventIndex[k]
        OutputLogMessage('        key' .. k .. 'events:   ' .. v[index])
        OutputLogMessage('\n')
    end
    OutputLogMessage('\n')
    OutputLogMessage(' -------------------------------------------------------------------------------------------- ')
end

Config.runCmd = function(cmd)
    local cmdSet = {
        ['next4'] = function()
            Config.updateEventIndex('4')
        end,
        ['next5'] = function()
            Config.updateEventIndex('5')
        end,
        ['next11'] = function()
            Config.updateEventIndex('11')
        end,
        ['play4'] = function()
            local _eventIndex = Config.eventIndex['4'];
            FncEventBind['4'][_eventIndex](4)
        end,
        ['play5'] = function()
            local _eventIndex = Config.eventIndex['5'];
            FncEventBind['5'][_eventIndex](5)
        end,
        ['play11'] = function()
            local _eventIndex = Config.eventIndex['11'];
            FncEventBind['11'][_eventIndex]()
        end,
        ['resetIndex'] = Config.resetEventIndex
    }
    if (cmdSet[cmd]) then
        cmdSet[cmd]()
    end
end

Config.modifierHandle = function(comboKey)
    local cmd = Config.gBind[comboKey]
    if (cmd) then
        Config.runCmd(cmd)
    end
    Config.outputMessage()
end

-- 初始化
Config.init = function()
    for k, v in pairs(Config.infos) do
        local t = {};
        for i = 1, #v do
            table.insert(t, Config[v[i]])
        end
        FncEventBind[k] = t;
    end
end

Config.init()

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
            if (Config.isPressed(ModifierList[i])) then
                -- 其中某一个修饰符被按下
                modifier = ModifierList[i] .. ' + ' .. modifier
                break
            end
        end
        local isChange = string.find(modifier, '+')
        if (isChange) then
            Config.modifierHandle(modifier)
        elseif (Config.isStartScript()) then
            Config.modifierHandle(modifier)
        elseif (arg == 4) then
            PressKey(Config.shootKey)
        end
    elseif (event == 'MOUSE_BUTTON_RELEASED' and arg == 4 and family == 'mouse' and not Config.isStartScript()) then
        ReleaseKey(Config.shootKey)
    end
end
