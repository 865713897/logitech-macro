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
    pressShootDelay = { 28, 37 },
    -- 连点释放延迟
    releaseShootDelay = { 140, 155 },
    -- 闪蹲绑定按键
    ctrlKey = 'lctrl',
    -- 闪蹲绑定的G键
    ctrlKeyG = 0,
    -- 闪蹲按下延迟
    pressCtrlDelay = { 28, 44 },
    -- 闪蹲释放延迟
    releaseCtrlDelay = { 48, 69 },
    -- 连刺绑定的G键
    stapKeyG = 5,
    -- 三级跳绑定G键
    tripleJumpKeyG = 7
}


EnablePrimaryMouseButtonEvents(true)


-- 是否开启加特林连点
function IsStartScript()
    return IsKeyLockOn(UserConfig.startScript)
end

-- 判断按键是否按下
function IsPressed(key)
    if (type(key) == 'number' and key <= 5 and key >= 1) then
        return IsMouseButtonPressed(key)
    elseif type(key) == "string" then
        return IsModifierPressed(key)
    else
        return false
    end
end

-- 加特林点击
function GatlingShoot()
    local rsdBefore = UserConfig.releaseShootDelay[1]
    local rsdAfter = UserConfig.releaseShootDelay[2]
    local psdBefore = UserConfig.pressShootDelay[1]
    local psdAfter = UserConfig.pressShootDelay[2]
    repeat
        math.randomseed(GetRunningTime())
        PressKey(UserConfig.shootKey)
        Sleep(math.random(math.random(rsdBefore, rsdBefore + 10), math.random(rsdAfter, rsdAfter + 10)))
        ReleaseKey(UserConfig.shootKey)
        Sleep(math.random(psdBefore, psdAfter))
    until not IsPressed(UserConfig.shootKeyG)
end

-- 加特林连刺
function GatlingStab()
    repeat
        math.randomseed(GetRunningTime())
        -- 点击鼠标右键
        PressAndReleaseMouseButton(3)
        Sleep(math.random(280, 320))
        -- 点击绑定攻击键
        PressAndReleaseKey(UserConfig.shootKey)
        Sleep(math.random(60, 93))
    until not IsPressed(UserConfig.stapKeyG)
end

-- 闪蹲
function TapCtrl()
    repeat
        math.randomseed(GetRunningTime())
        PressKey(UserConfig.ctrlKey)
        Sleep(math.random(UserConfig.releaseCtrlDelay[1], UserConfig.releaseCtrlDelay[2]))
        ReleaseKey(UserConfig.ctrlKey)
        Sleep(math.random(UserConfig.pressCtrlDelay[1], UserConfig.pressCtrlDelay[2]))
    until not IsPressed(UserConfig.ctrlKeyG)
end

-- 三级跳
function TripleJump()
    math.randomseed(GetRunningTime())
    PressKey('w')
    Sleep(math.random(200, 230))
    PressKey('s')
    -- 操作间隔
    Sleep(math.random(200, 230))
    -- 四次下蹲
    PressKey('lctrl')
    Sleep(math.random(50, 70))
    ReleaseKey('lctrl')
    Sleep(math.random(30, 49))
    PressKey('lctrl')
    Sleep(math.random(50, 70))
    ReleaseKey('lctrl')
    Sleep(math.random(30, 49))
    PressKey('lctrl')
    Sleep(math.random(50, 70))
    ReleaseKey('lctrl')
    Sleep(math.random(30, 49))
    PressKey('lctrl')
    Sleep(math.random(50, 70))
    ReleaseKey('lctrl')
    -- 操作间隔
    Sleep(math.random(100, 150))
    -- 跳跳蹲
    PressKey('spacebar')
    Sleep(math.random(120, 140))
    ReleaseKey('spacebar')
    Sleep(math.random(65, 81))
    PressKey('lctrl')
    Sleep(math.random(50, 70))
    ReleaseKey('lctrl')
    Sleep(math.random(25, 35))
    ReleaseKey('s')
    Sleep(math.random(25, 35))
    ReleaseKey('w')
end

-- 是否系统可监听按钮
function IsSystemMonitor(key)
    if (key >= 1 and key <= 5) then
        return true
    else
        return false
    end
end

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
    if (IsPressed(UserConfig.shootKeyG) and IsStartScript()) then
        -- shootKeyG按下并且打开脚本，执行加特林连点
        GatlingShoot()
    elseif (IsPressed(UserConfig.shootKeyG)) then
        -- shootKeyG按下，但未开启脚本，执行绑定按键按下操作
        PressKey(UserConfig.shootKey)
    elseif (not IsPressed(UserConfig.shootKeyG) and newArg == UserConfig.shootKeyG) then
        -- shootKeyG释放
        ReleaseKey(UserConfig.shootKey)
    elseif (IsPressed(UserConfig.ctrlKeyG) and newArg == UserConfig.ctrlKeyG) then
        -- ctrlKeyG按下，执行闪蹲脚本
        TapCtrl()
    elseif (IsPressed(UserConfig.stapKeyG) and IsStartScript() and newArg == UserConfig.stapKeyG) then
        -- stapKeyG按下并且打开脚本，执行连刺脚本
        GatlingStab()
    elseif (event == 'MOUSE_BUTTON_PRESSED' and newArg == UserConfig.tripleJumpKeyG) then
        -- tripleJumpKeyG按下，执行三级跳脚本
        TripleJump()
    end
end
