---@diagnostic disable: duplicate-set-field, undefined-global, param-type-mismatch
-------------------- 配置 --------------------
Config = {
  openMacroKey = 'capslock',                 -- scrolllock | capslock | numlock
  shootKey = 1,                              -- 攻击按键1:鼠标左键，也可设置键盘按键
  gameModeList = { 'zombie', 'pve', 'pvp' }, -- 模式列表
  -- 生化模式绑定按键函数信息
  zombie = {
    ['4'] = { 'gatlingStab', 'xkQuickAttack' },
    ['5'] = { 'gatlingQuickShoot' }
  },
  -- 挑战模式
  pve = {
    ['4'] = { 'continueAttack' },
    ['5'] = { 'dropCard' },
    ['6'] = { 'resetCardIndex' },
    ['7'] = { 'increaseCardIndex' }
  },
  -- 鼠标按键绑定
  gBind = {
    ['rctrl+G1'] = 'changeGameMode',
    ['G1'] = 'play_1',
    ['lalt+G1'] = 'next_1',
    ['ralt+G1'] = 'reset_1',
    ['G3'] = 'play_3',
    ['lalt+G3'] = 'next_3',
    ['ralt+G3'] = 'reset_3',
    ['G4'] = 'play_4',
    ['lalt+G4'] = 'next_4',
    ['ralt+G4'] = 'reset_4',
    ['G5'] = 'play_5',
    ['lalt+G5'] = 'next_5',
    ['ralt+G5'] = 'reset_5',
    ['G6'] = 'play_6',
    ['lalt+G6'] = 'next_6',
    ['ralt+G6'] = 'reset_6',
    ['G7'] = 'play_7',
  },
  -- 试炼岛卡片坐标
  cardPosition = {
    { { 0, 0, 3, 6 }, { -120, -135, 0, 0 }, { 180, 195, 0, 0 }, { 0, 0, 70, 76 } },
    { { 0, 0, 3, 6 }, { -40, -55, 0, 0 },   { 130, 145, 0, 0 }, { 0, 0, 70, 76 } },
    { { 0, 0, 3, 6 }, { 30, 40, 0, 0 },     { 90, 100, 0, 0 },  { 0, 0, 70, 76 } },
    { { 0, 0, 3, 6 }, { 76, 90, 0, 0 },     { 40, 55, 0, 0 },   { 0, 0, 70, 76 } },
  }
}

-- 可用修饰符列表
ModifierList = { 'lalt', 'ralt', 'rctrl', 'rshift' }

-- 中文对照表
ChineseTextMap = {
  ['zombie'] = '生化模式',
  ['pve'] = '挑战模式',
  ['pvp'] = '竞技模式',
  ['gatlingQuickShoot'] = '加特林速点宏',
  ['quickCtrl'] = '闪蹲宏',
  ['gatlingStab'] = '加特林连刺宏',
  ['xkQuickAttack'] = '虚空重刀宏',
  ['instantSpy'] = '一键瞬狙宏',
  ['continueAttack'] = '挑战攻击释放双手',
  ['dropCard'] = '挑战-放置卡片',
  ['increaseCardIndex'] = '更新卡片索引位置'
}

--------------------   end   --------------------

-------------------- 事件函数(运行时) --------------------
Runtiming = {
  curModeIndex = 1, -- 当前游戏模式下标
  curCardIndex = 1, -- 试炼岛卡片当前下标
  eventIndex = {
    ['1'] = 1,
    ['4'] = 1,
    ['5'] = 1,
    ['6'] = 1,
    ['7'] = 1
  },                 -- 按键事件下标
  eventFuncList = {} -- 运行时事件函数列表
}

-- 加特林速点宏
function Runtiming.gatlingQuickShoot(key)
  repeat
    BtDown(Config.shootKey)
    Sleep(Random(80, 110))
    BtUp(Config.shootKey)
    Sleep(Random(20, 44))
  until not IsPressed(key)
end

-- 加特林连刺宏
function Runtiming.gatlingStab(key)
  repeat
    BtClick(3)
    Sleep(Random(270, 300))
    BtClick(Config.shootKey)
    Sleep(Random(40, 63))
  until not IsPressed(key)
end

-- 虚空重刀宏
function Runtiming.xkQuickAttack(key)
  if (not IsPressed(key)) then
    -- 防止多次点击多次触发重复操作
    return false
  end
  BtClick(3)
  Sleep(Random(580, 600))
  BtClick('f')
  Sleep(Random(50, 70))
  BtClick(3)
  Sleep(Random(120, 140))
end

-- 挑战-试炼岛一键放置卡片
function Runtiming.dropCard(key)
  if (not IsPressed(key)) then
    -- 防止多次点击多次触发重复操作
    return false
  end
  local index = Runtiming.curCardIndex or 1
  local curPosition = Config.cardPosition[index]
  local randomFn = GenerateRandomNumber()
  BtClick('e')
  Sleep(Random(30, 50))
  for i = 1, #curPosition do
    local position = curPosition[i]
    local x = randomFn(position[1], position[2])
    local y = randomFn(position[3], position[4])
    MoveMouseRelative(x, y)
    Sleep(Random(30, 50))
    if i % 2 == 0 then
      BtClick(1)
      Sleep(Random(30, 50))
    end
  end
end

-- 挑战-试炼岛卡片下标增加
function Runtiming.increaseCardIndex()
  local cardNums = #Config.cardPosition or 0
  if cardNums == 0 then
    return false
  end
  local nextIndex = (Runtiming.curCardIndex + 1) % (cardNums + 1)
  local realIndex = nextIndex == 0 and 1 or nextIndex
  Runtiming.curCardIndex = realIndex
  PrintInfo()
end

-- 挑战-试炼岛卡片下标重置
function Runtiming.resetCardIndex()
  Runtiming.curCardIndex = 1
  PrintInfo()
end

-- 挑战-一键攻击
function Runtiming.continueAttack(key)
  if (not IsPressed(key)) then
    -- 防止多次点击多次触发重复操作
    return false
  end
  local hasPressed = Runtiming.hasPressed or false
  if hasPressed then
    BtUp(Config.shootKey)
    Sleep(Random(180, 200))
    BtClick('r')
    Runtiming.hasPressed = false
  else
    BtDown(Config.shootKey)
    Runtiming.hasPressed = true
  end
end

-- 一键瞬狙宏
function Runtiming.instantSpy(key)
  if (not IsPressed(key)) then
    -- 防止多次点击多次触发重复操作
    return false
  end
  BtClick(3)
  Sleep(Random(20, 40))
  BtClick(1)
  Sleep(Random(20, 40))
  BtClick('q')
  Sleep(Random(20, 40))
  BtClick('q')
  Sleep(Random(20, 40))
end

--------------------   end   --------------------

-------------------- 公共函数 --------------------
-- 四舍五入
function math.round(num)
  local floor = math.floor(num)
  local ceil = math.ceil(num)
  if num - floor < 0.5 then
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
function table.getLength(t)
  local i
  for k, v in pairs(t) do
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
  while (random < m) do
    random = math.round(math.random(m, n))
  end
  return random
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

-- 遍历数组-forEach
function table.forEach(t, c)
  for i = 1, #t do
    c(t[i], i)
  end
end

-- 触发点击
function BtClick(key)
  if type(key) == 'number' then
    PressMouseButton(key)
    Sleep(Random(30, 50))
    ReleaseMouseButton(key)
  else
    PressKey(key)
    Sleep(Random(30, 50))
    ReleaseKey(key)
  end
end

-- 按键按下
function BtDown(key)
  if type(key) == 'number' then
    PressMouseButton(key)
  else
    PressKey(key)
  end
end

-- 按键抬起
function BtUp(key)
  if type(key) == 'number' then
    ReleaseMouseButton(key)
  else
    ReleaseKey(key)
  end
end

-- 判断按键是否按下(系统级监听)
function IsPressed(key)
  if (type(key) == 'number' and key <= 5 and key >= 1) then
    return IsMouseButtonPressed(key)
  elseif type(key) == 'string' then
    return IsModifierPressed(key)
  else
    return false
  end
end

-- 是否开启宏
function IsOpenMacro(key)
  return IsKeyLockOn(key or Config.openMacroKey or 'capslock')
end

-- 按key的大小顺序返回新表
function GetTableSort(t)
  local keyT = {}
  local newT = {}
  for k, v in pairs(t) do
    table.insert(keyT, k)
  end
  table.sort(keyT, function(a, b)
    return tonumber(a) < tonumber(b)
  end)
  for i = 1, #keyT do
    table.insert(newT, { key = keyT[i], value = t[keyT[i]] })
  end
  return newT
end

--------------------   end   --------------------

--------------------   plugin   --------------------
Plugins = {}

--------------------   end   --------------------

--------------------   base   --------------------
-- 初始化事件函数列表
function InitEventFuncList()
  -- 当前游戏模式
  local index = Runtiming.curModeIndex
  local curGameMode = Config.gameModeList[index]
  for k, v in pairs(Config[curGameMode]) do
    local t = {}
    for i = 1, #v do
      local fn = Runtiming[v[i]]
      if type(fn) == 'function' then
        table.insert(t, fn)
      end
    end
    Runtiming.eventFuncList[k] = t
  end
  PrintInfo()
end

-- 更新按键绑定事件函数下标
function IncreaseEventIndex(key)
  local len = #Config.eventFuncList[key]
  if len == 0 then
    return false
  end
  local nextIndex = (Runtiming.eventIndex[key] + 1) % (len + 1)
  local realIndex = nextIndex == 0 and 1 or nextIndex
  Runtiming.eventIndex[key] = realIndex
  PrintInfo()
end

-- 重置按键绑定事件函数下标
function ResetEventIndex(key)
  local len = #Config.eventFuncList[key]
  if len == 0 then
    return false
  end
  Runtiming.eventIndex[key] = 1
  PrintInfo()
end

-- 更新游戏模式
function ChangeGameMode()
  local len = #Config.gameModeList
  local nextIndex = (Runtiming.curModeIndex + 1) % (len + 1)
  local realIndex = nextIndex == 0 and 1 or nextIndex
  Runtiming.curModeIndex = realIndex
  InitEventFuncList()
end

-- 打印当前游戏模式
function PrintGameMode()
  local curGameMode = Config.gameModeList[Runtiming.curModeIndex]
  OutputLogMessage('当前游戏模式: ' .. ChineseTextMap[curGameMode] .. '\n')
end

-- 打印事件绑定信息
function PrintEventInfo()
  local curGameMode = Config.gameModeList[Runtiming.curModeIndex]
  local eventList = GetTableSort(Config[curGameMode])
  for _, item in ipairs(eventList) do
    local key = item.key
    local value = item.value
    local index = Runtiming.eventIndex[key]
    if type(Runtiming.eventFuncList[key][value[index]]) == 'function' then
      local eventDesc = ChineseTextMap[value[index]]
      local info = string.format('按键%s绑定事件: %s', key, eventDesc)
      if curGameMode == 'pve' and value[index] == 'dropCard' then
        info = info .. string.format('(当前卡片下标:%d)', Runtiming.curCardIndex)
      end
      OutputLogMessage(info .. '\n')
    end
  end
end

-- 打印信息
function PrintInfo()
  ClearLog()
  OutputLogMessage(' -------------------------------------------------------------------------------------------- ')
  OutputLogMessage('\n')
  OutputLogMessage('\n')
  PrintGameMode()
  PrintEventInfo()
  OutputLogMessage('\n')
  OutputLogMessage(' -------------------------------------------------------------------------------------------- ')
end

-- 运行指令
function RunCmd(cmd)
  local cmdGroup = string.split(cmd, '_')
  local type = cmdGroup[1]
  local key = cmdGroup[2]
  if type == 'next' then
    IncreaseEventIndex(key)
  elseif type == 'reset' then
    ResetEventIndex(key)
  elseif type == 'play' then
    local eventIndex = Runtiming.eventIndex[key]
    local fn = Runtiming.eventFuncList[key][eventIndex]
    if type(fn) == 'function' then
      fn(tonumber(key))
    end
  end
end

-- 处理修饰符
function ModifierHandler(modifier)
  local cmd = Config.gBind[modifier]
  if cmd then
    RunCmd(cmd)
  end
end

--------------------   end   --------------------

-- 打开对鼠标左键的监听
EnablePrimaryMouseButtonEvents(true)

-- 设置随机数种子
math.randomseed(GetDate("%H%M%S"):reverse())

-- 初始化事件函数列表
InitEventFuncList()

-- 监听事件
function OnEvent(event, arg, family)
  if arg == 2 then
    arg = 3
  elseif arg == 3 then
    arg = 2
  end

  if event == 'MOUSE_BUTTON_PRESSED' and arg >= 1 and arg <= 11 and family == 'mouse' then
    -- 监听3-11的可绑定按键
    local modifier = 'G' .. arg
    for i = 1, #ModifierList do
      if (IsPressed(ModifierList[i])) then
        -- 其中某一个修饰符被按下
        modifier = ModifierList[i] .. ' + ' .. modifier
        break
      end
    end
    local isChange = string.find(modifier, '+')
    if isChange or IsOpenMacro() then
      -- 事件属于切换事件或已开启宏按钮
      ModifierHandler(modifier)
    end
  end
end
