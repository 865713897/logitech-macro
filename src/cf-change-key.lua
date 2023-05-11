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

-- 用户配置
Config = {
    -- 开启宏按键
    startScript = 'capslock', -- scrolllock | capslock | numlock
    -- 绑定开枪按键
    shootKey = 'i',
    -- 开枪绑定的G键
    shootKeyG = 4,
    -- 三级跳绑定G键
    tripleJumpKeyG = 11,
    -- G键5循环事件index
    Gkey5EventIndex = 1,
    -- 切换事件Gkey
    GkeyChangeEvent = 10,
}

EnablePrimaryMouseButtonEvents(true)
EnablePrimaryColor(true)

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
        Sleep(randomFn1(math.random(baseDelay, baseDelay + 10), math.random(baseDelay + 20, baseDelay + 30)))
        ReleaseKey(Config.shootKey)
        Sleep(randomFn2(26, 36))
    until not IsPressed(Config.shootKeyG)
end

-- 加特林连刺
function GatlingStab()
    repeat
        math.randomseed(GetRunningTime())
        -- 点击鼠标右键
        PressAndReleaseMouseButton(3)
        Sleep(math.random(280, 320))
        -- 点击绑定攻击键
        PressAndReleaseKey(Config.shootKey)
        Sleep(math.random(60, 93))
    until not IsPressed(5)
end

-- 闪蹲
function TapCtrl()
    local randomFn1 = GenerateRandomNumber()
    local randomFn2 = GenerateRandomNumber()
    repeat
        math.randomseed(GetRunningTime())
        PressKey(Config.ctrlKey)
        Sleep(randomFn1(40, 50))
        ReleaseKey(Config.ctrlKey)
        Sleep(randomFn2(26, 36))
    until not IsPressed(5)
end

-- 三级跳
function TripleJump()
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

-- 是否系统可监听按钮
function IsSystemMonitor(key)
    if (key >= 1 and key <= 5) then
        return true
    else
        return false
    end
end

Config.Gkey5BindEvents = {
    GatlingStab,   -- 加特林连刺
    XkQuickAttack, -- 虚空重刀
    -- TapCtrl        -- 闪蹲
}

-- 监听事件
function OnEvent(event, arg, family)
    local newArg = arg;
    -- 重置arg
    if arg == 1 then
        newArg = 4
    elseif arg == 4 then
        newArg = 1
    elseif arg == 3 then
        newArg = 2
    elseif arg == 2 then
        newArg = 3
    end
    if (IsPressed(4) and IsStartScript() and newArg == 4) then
        -- shootKeyG按下并且打开脚本，执行加特林连点
        GatlingShoot()
    elseif (IsPressed(4) and newArg == 4) then
        -- shootKeyG按下，但未开启脚本，执行绑定按键按下操作
        PressKey(Config.shootKey)
    elseif (not IsPressed(4) and newArg == 4) then
        -- shootKeyG释放
        ReleaseKey(Config.shootKey)
    elseif (IsPressed(5) and newArg == 5 and IsStartScript()) then
        -- G5被按下，根据index执行Gkey5BindEvents中的事件
        Config.Gkey5BindEvents[Config.Gkey5EventIndex]()
    elseif (event == 'MOUSE_BUTTON_PRESSED' and newArg == Config.tripleJumpKeyG) then
        -- tripleJumpKeyG按下，执行三级跳脚本
        TripleJump()
    elseif (event == 'MOUSE_BUTTON_PRESSED' and newArg == Config.GkeyChangeEvent) then
        -- 循环增大index
        local len = #Config.Gkey5BindEvents
        local newIndex = (Config.Gkey5EventIndex + 1) % (len + 1)
        local realIndex = newIndex == 0 and 1 or newIndex
        Config.Gkey5EventIndex = realIndex
    end
end
