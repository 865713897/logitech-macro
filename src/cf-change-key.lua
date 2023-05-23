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
    -- 蹲键
    ctrlKey = 'lctrl',
    -- 绑定开枪按键
    shootKey = 'i',
    -- 开枪绑定的G键
    shootKeyG = 4,
    -- 三级跳绑定G键
    tripleJumpKeyG = 11,
    -- G键5循环事件index
    Gkey5EventIndex = 1,
    -- G键11循环事件index
    Gkey11EventIndex = 1,
    -- 事件index
    eventIndex = {
        ['5'] = 1,
        ['11'] = 1
    },
    -- 切换事件Gkey
    GkeyChangeEvent = 10,
}

-- 绑定功能键
Gbind = {
    ['lalt + G5'] = '5-next',
    ['lalt + G11'] = '11-next'
}

-- 可用修饰符列表
ModifierList = { 'lalt', 'lctrl', 'lshift', 'ralt', 'rctrl', 'rshift' }

EnablePrimaryMouseButtonEvents(true)

-- 是否开启宏
function IsStartScript()
    return IsKeyLockOn(Config.startScript)
end

-- 判断按键是否按下
function IsPressed(key)
    if (type(key) == 'number' and key <= 5 and key >= 1) then
        return IsMouseButtonPressed(key)
    elseif type(key) == 'string' then
        return IsModifierPressed(key)
    else
        return false
    end
end

-- 加特林点击
function GatlingShoot()
    local baseDelay = 140
    local randomFn1 = GenerateRandomNumber()
    local randomFn2 = GenerateRandomNumber()
    repeat
        math.randomseed(GetRunningTime())
        PressKey(Config.shootKey)
        Sleep(randomFn1(math.random(baseDelay, baseDelay + 10), math.random(baseDelay + 15, baseDelay + 25)))
        ReleaseKey(Config.shootKey)
        Sleep(randomFn2(20, 30))
    until not IsPressed(Config.shootKeyG)
end

-- 加特林连刺
function GatlingStab(key)
    local randomFn1 = GenerateRandomNumber()
    local randomFn2 = GenerateRandomNumber()
    repeat
        math.randomseed(GetRunningTime())
        -- 点击鼠标右键
        PressAndReleaseMouseButton(3)
        Sleep(randomFn1(270, 280))
        -- 点击绑定攻击键
        PressAndReleaseKey(Config.shootKey)
        Sleep(randomFn2(40, 73))
    until not IsPressed(key)
end

-- 闪蹲
function TapCtrl(key)
    local randomFn1 = GenerateRandomNumber()
    local randomFn2 = GenerateRandomNumber()
    repeat
        math.randomseed(GetRunningTime())
        PressKey(Config.ctrlKey)
        Sleep(randomFn1(40, 50))
        ReleaseKey(Config.ctrlKey)
        Sleep(randomFn2(26, 36))
    until not IsPressed(key)
end

-- 二级跳
function DoubleJump()
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
function TripleJump()
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
function XkQuickAttack()
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
function Shunju()
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

Config.Gkey4BindEvents = {
    GatlingShoot,
    Shunju
}

Config.Gkey5BindEvents = {
    GatlingStab,   -- 加特林连刺
    XkQuickAttack, -- 虚空重刀宏
}

Config.Gkey11BindEvents = {
    TripleJump -- 三级跳
}

BindEvents = {
    ['5'] = { GatlingStab, XkQuickAttack },
    ['11'] = { TripleJump, DoubleJump }
}

-- 更新event index
function UpdateEventIndex(key)
    local len = #BindEvents[key]
    local nextIndex = (Config.eventIndex[key] + 1) % (len + 1)
    local realIndex = nextIndex == 0 and 1 or nextIndex
    Config.eventIndex[key] = realIndex
end

-- 重置event index
function ResetEventIndex()
    for k, v in pairs(Config.eventIndex) do
        Config.eventIndex[k] = 1
    end
end

function RunCmd(cmd)
    local cmdSet = {
        ['next'] = UpdateEventIndex,
        ['resetIndex'] = ResetEventIndex
    }
end

function ModifierHandle(comboKey)
    local cmd = Gbind[comboKey]
    if (cmd) then
        RunConfig.runCmd(cmd)
    end
end

-- 监听事件
function OnEvent(event, arg, family)
    -- 重置arg
    if arg == 1 then
        arg = 4
    else
        arg = 1
    end
    if (event == 'MOUSE_BUTTON_PRESSED' and arg >= 3 and arg <= 11 and family == 'mouse') then
        -- 监听3-11的可绑定按键
        local modifier = 'G' .. arg
        for i = 1, #ModifierList do
            if (IsModifierPressed(ModifierList[i])) then
                -- 其中某一个修饰符被按下
                modifier = ModifierList[i] .. ' + ' .. modifier
                break
            end
        end
    end
    -- if (IsPressed(4) and IsStartScript() and newArg == 4) then
    --     -- shootKeyG按下并且打开脚本，执行加特林连点
    --     GatlingShoot()
    -- elseif (IsPressed(4) and newArg == 4) then
    --     -- shootKeyG按下，但未开启脚本，执行绑定按键按下操作
    --     PressKey(Config.shootKey)
    -- elseif (not IsPressed(4) and newArg == 4) then
    --     -- shootKeyG释放
    --     ReleaseKey(Config.shootKey)
    -- elseif (IsPressed(5) and newArg == 5 and IsStartScript()) then
    --     -- G5被按下，根据index执行Gkey5BindEvents中的事件
    --     Config.Gkey5BindEvents[Config.Gkey5EventIndex](5)
    -- elseif (event == 'MOUSE_BUTTON_PRESSED' and newArg == 11) then
    --     -- tripleJumpKeyG按下，执行三级跳脚本
    --     Config.Gkey11BindEvents[Config.Gkey5EventIndex]()
    -- elseif (event == 'MOUSE_BUTTON_PRESSED' and newArg == Config.GkeyChangeEvent) then
    --     -- 循环增大index
    --     local len = #Config.Gkey5BindEvents
    --     local newIndex = (Config.Gkey5EventIndex + 1) % (len + 1)
    --     local realIndex = newIndex == 0 and 1 or newIndex
    --     Config.Gkey5EventIndex = realIndex
    -- end
end
