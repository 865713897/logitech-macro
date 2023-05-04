---@diagnostic disable: undefined-global
-- 用户配置
UserConfig = {
  -- 开启宏按键
  startScript = 'capslock', -- scrolllock | capslock | numlock
  -- 绑定开枪按键
  shootKey = 'i',
  -- 开枪绑定的G键
  shootKeyG = 4,
  -- 三级跳绑定G键
  tripleJumpKeyG = 7,
  -- G键5循环事件index
  Gkey5EventIndex = 1,
  -- 切换事件Gkey
  GkeyChangeEvent = 10
}

EnablePrimaryMouseButtonEvents(true)

-- 是否开启宏
function IsStartScript()
  return IsKeyLockOn(UserConfig.startScript)
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
  repeat
      math.randomseed(GetRunningTime())
      PressKey(UserConfig.shootKey)
      Sleep(math.random(math.random(baseDelay, baseDelay + 10), math.random(baseDelay + 20, baseDelay + 30)))
      ReleaseKey(UserConfig.shootKey)
      Sleep(math.random(28, 38))
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
  until not IsPressed(5)
end

-- 闪蹲
function TapCtrl()
  repeat
      math.randomseed(GetRunningTime())
      PressKey(UserConfig.ctrlKey)
      Sleep(math.random(48, 69))
      ReleaseKey(UserConfig.ctrlKey)
      Sleep(math.random(28, 44))
  until not IsPressed(5)
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
  Sleep(math.random(100, 110))
  -- 跳跳蹲
  PressKey('spacebar')
  Sleep(math.random(137, 139))
  ReleaseKey('spacebar')
  Sleep(math.random(94, 96))
  PressKey('lctrl')
  Sleep(math.random(65, 70))
  ReleaseKey('lctrl')
  Sleep(math.random(25, 35))
  ReleaseKey('s')
  Sleep(math.random(73, 83))
  ReleaseKey('w')
end

-- 虚空重刀宏
function XkQuickAttack()
  repeat
      math.randomseed(GetRunningTime())
      PressMouseButton(3)
      Sleep(math.random(45, 55))
      ReleaseMouseButton(3)
      Sleep(math.random(590, 610))
      PressKey('f')
      Sleep(math.random(30, 40))
      ReleaseKey('f')
      Sleep(math.random(30, 40))
      PressAndReleaseMouseButton(3)
      Sleep(math.random(100, 120))
  until not IsPressed(5)
end

-- 是否系统可监听按钮
function IsSystemMonitor(key)
  if (key >= 1 and key <= 5) then
      return true
  else
      return false
  end
end

UserConfig.Gkey5BindEvents = {
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
      PressKey(UserConfig.shootKey)
  elseif (not IsPressed(4) and newArg == 4) then
      -- shootKeyG释放
      ReleaseKey(UserConfig.shootKey)
  elseif (IsPressed(5) and newArg == 5 and IsStartScript()) then
      -- G5被按下，根据index执行Gkey5BindEvents中的事件
      UserConfig.Gkey5BindEvents[UserConfig.Gkey5EventIndex]()
  elseif (event == 'MOUSE_BUTTON_PRESSED' and newArg == UserConfig.tripleJumpKeyG) then
      -- tripleJumpKeyG按下，执行三级跳脚本
      TripleJump()
  elseif (event == 'MOUSE_BUTTON_PRESSED' and newArg == UserConfig.GkeyChangeEvent) then
      -- 循环增大index
      local len = #UserConfig.Gkey5BindEvents
      local newIndex = (UserConfig.Gkey5EventIndex + 1) % len
      UserConfig.Gkey5EventIndex = newIndex == 0 and 1 or newIndex
  end
end
