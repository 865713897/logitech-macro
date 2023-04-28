---@diagnostic disable: undefined-global
-- 用户配置
UserConfig = {
    -- 开启加特林连点按键
    startScript = "capslock", -- scrolllock | capslock | numlock
    -- 绑定开枪按键
    shootKey = "i",
    -- 开枪绑定的G键
    shootKeyG = 4,
    -- 连点按下延迟
    pressShootDelay = { 30, 43 },
    -- 连点释放延迟
    releaseShootDelay = { 140, 165 },
    -- 闪蹲绑定按键
    ctrlKey = 'lctrl',
    -- 闪蹲绑定的G键
    ctrlKeyG = 5,
    -- 闪蹲按下延迟
    pressCtrlDelay = { 28, 44 },
    -- 闪蹲释放延迟
    releaseCtrlDelay = { 48, 69 },
    -- 连刺绑定的G键
    stapKeyG = 7,
    -- 三级跳绑定G键
    tripleJumpKeyG = 6
}

-- 存储一些key是否按下的状态
KeyStatus = {
    G6 = false,
    G7 = false,
    G8 = false,
    G9 = false,
    G10 = false,
    G11 = false
}

EnablePrimaryMouseButtonEvents(true)

-- 更新key状态
function UpdateKeyStatus(key)
    KeyStatus[key] = not KeyStatus[key]
end

-- 是否开启加特林连点
function IsStartScript()
    return IsKeyLockOn(userConfig.startScript)
end

-- 判断按键是否按下
function IsPressed(key)
    if (type(key) == 'number' and key <= 5 and key >= 1) then
        return IsMouseButtonPressed(key)
    elseif (type(key) == 'number') then
        return KeyStatus('G' .. key)
    elseif type(key) == "string" then
        return IsModifierPressed(key)
    else
        return false
    end
end

-- 加特林点击
function GatlingShoot()
    local rsdBefore = userConfig.releaseShootDelay[1]
    local rsdAfter = userConfig.releaseShootDelay[2]
    local psdBefore = userConfig.pressShootDelay[1]
    local psdAfter = userConfig.pressShootDelay[2]
    repeat
        math.randomseed(GetRunningTime())
        PressKey(userConfig.shootKey)
        Sleep(math.random(math.random(rsdBefore, rsdBefore + 10), math.random(rsdAfter, rsdAfter + 10)))
        ReleaseKey(userConfig.shootKey)
        Sleep(math.random(psdBefore, psdAfter))
    until not IsPressed(userConfig.shootKeyG)
end

-- 加特林连刺
function GatlingStab()
    repeat
        math.randomseed(GetRunningTime())
        -- 点击鼠标右键
        PressAndReleaseMouseButton(3)
        Sleep(math.random(280, 320))
        -- 点击绑定攻击键
        PressAndReleaseKey(userConfig.shootKey)
        Sleep(math.random(60, 93))
    until not IsPressed(userConfig.stapKeyG)
end

-- 闪蹲
function TapCtrl()
    repeat
        math.randomseed(GetRunningTime())
        PressKey(userConfig.ctrlKey)
        Sleep(math.random(userConfig.releaseCtrlDelay[1], userConfig.releaseCtrlDelay[2]))
        Release(userConfig.ctrlKey)
        Sleep(math.random(userConfig.pressCtrlDelay[1], userConfig.pressCtrlDelay[2]))
    until not IsPressed(userConfig.ctrlKeyG)
end

-- 三级跳
function TripleJump()
    math.randomseed(GetRunningTime())
    PressKey('w')
    Sleep(math.random(73, 94))
    PressKey('s')
    -- 操作间隔
    Sleep(math.random(73, 94))
    -- 四次下蹲
    PressAndReleaseKey('lctrl')
    Sleep(math.random(73, 94))
    PressAndReleaseKey('lctrl')
    Sleep(math.random(73, 94))
    PressAndReleaseKey('lctrl')
    Sleep(math.random(73, 94))
    PressAndReleaseKey('lctrl')
    -- 操作间隔
    Sleep(math.random(87, 110))
    -- 跳起瞬间按蹲
    PressKey('spacebar')
    Sleep(math.random(87, 110))
    PressKey('lctrl')
    Sleep(math.random(87, 110))
    ReleaseKey('spacebar')
    Sleep(math.random(87, 110))
    ReleaseKey('lctrl')
    Sleep(math.random(30, 50))
    ReleaseKey('s')
    Sleep(math.random(30, 50))
    ReleaseKey('w')
end

-- 监听事件
function OnEvent(event, arg, family)
    local newArg = 0;
    -- 重置arg
    if arg == 1 then
        newArg = 4
    elseif arg == 4 then
        newArg = 1
    end
    -- 更新key状态
    if (type(arg) == 'number' and arg > 5 and family == 'mouse') then
        UpdateKeyStatus('G' .. arg)
    end
    if (IsPressed(userConfig.shootKeyG) and IsStartScript()) then
        -- shootKeyG按下并且打开脚本，执行加特林连点
        GatlingShoot()
    elseif (IsPressed(userConfig.shootKeyG)) then
        -- shootKeyG按下，但未开启脚本，执行绑定按键按下操作
        PressKey(userConfig.shootKey)
    elseif (not IsPressed(userConfig.shootKeyG) and newArg == userConfig.shootKeyG) then
        -- shootKeyG释放
        ReleaseKey(userConfig.shootKey)
    elseif (IsPressed(userConfig.ctrlKeyG)) then
        -- ctrlKeyG按下，执行闪蹲脚本
        TapCtrl()
    elseif (IsPressed(userConfig.stapKeyG) and IsStartScript()) then
        -- stapKeyG按下并且打开脚本，执行连刺脚本
        GatlingStab()
    elseif (IsPressed(userConfig.tripleJumpKeyG)) then
        -- tripleJumpKeyG按下，执行三级跳脚本
        TripleJump()
    end
end
