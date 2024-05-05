---@diagnostic disable: duplicate-set-field, undefined-global, param-type-mismatch
-- [[  用户配置  ]]
Config = {
  openMacroKey = 'capslock',                 -- scrolllock | capslock | numlock
  shootKey = 1,                              -- 攻击按键1:鼠标左键，也可设置键盘按键
  gameModeList = { 'zombie', 'pve', 'pvp' }, -- 模式列表
  defaultGameModeIndex = 2,                  -- 默认游戏模式下标
  openDebugger = false,                      -- 是否开启调试模式（输出打印信息）
  -- 生化模式绑定按键函数信息
  zombie = {
    ['4'] = { 'gatlingStab', 'xkQuickAttack' },
    ['5'] = { 'gatlingQuickShoot' }
  },
  -- 挑战模式
  pve = {
    ['4'] = { 'continueAttack', 'continueGrenade' },
    ['5'] = { 'dropCard', 'nonStopJump' },
    ['6'] = { 'resetCardIndex' },
    ['7'] = { 'increaseCardIndex' }
  },
  -- 竞技模式
  pvp = {
    ['4'] = { 'rifleQuickShoot', 'nonStopSquat' },
    ['5'] = { 'usbQuickShoot', 'tangDaoQuickShoot' },
  },
  defaultCardIndex = 1, -- 默认卡片下标
  -- 默认按键事件下标
  defaultEventIndex = {
    ['1'] = 1,
    ['3'] = 1,
    ['4'] = 1,
    ['5'] = 1,
    ['6'] = 1,
    ['7'] = 1
  },
  -- 试炼岛卡片坐标
  cardPosition = {
    { { 0, 0, 3, 6 }, { -120, -135, 0, 0 }, { 180, 195, 70, 76 } },
    { { 0, 0, 3, 6 }, { -40, -55, 0, 0 },   { 130, 145, 70, 76 } },
    { { 0, 0, 3, 6 }, { 30, 40, 0, 0 },     { 90, 100, 70, 76 } },
    { { 0, 0, 3, 6 }, { 76, 90, 0, 0 },     { 40, 55, 70, 76 } },
  },
  -- 鼠标按键绑定
  modifierMap = {
    ['G1'] = 'play_1',
    ['lalt+G1'] = 'next_1',
    ['ralt+G1'] = 'reset_1',
    ['G3_release'] = 'play_3',
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
    ['lalt+G10'] = 'nextGameMode',
    ['lalt+G11'] = 'resetGameMode',
  },
}

-- 可用修饰符列表
ModifierList = { 'lalt', 'ralt', 'rctrl', 'rshift' }

-- 中文对照表
ChineseTextMap = {
  ['zombie'] = '生化模式',
  ['pve'] = '挑战模式',
  ['pvp'] = '竞技模式',
  ['gatlingQuickShoot'] = '加特林速点',
  ['usbQuickShoot'] = 'usb速点',
  ['gatlingStab'] = '加特林连刺',
  ['xkQuickAttack'] = '虚空重刀',
  ['instantSpy'] = '一键瞬狙',
  ['continueAttack'] = '挑战攻击释放双手',
  ['dropCard'] = '挑战试炼岛放置卡片',
  ['increaseCardIndex'] = '更新试炼岛卡片索引位置',
  ['resetCardIndex'] = '重置试炼岛卡片索引位置',
  ['nonStopSquat'] = '一键闪蹲',
  ['nonStopJump'] = '一键鬼跳',
  ['continueGrenade'] = '挑战爆裂者一键榴弹',
  ['rifleQuickShoot'] = '步枪速点',
  ['tangDaoQuickShoot'] = '唐刀快速刀',
  ['autoDropCard'] = '试炼岛自动放卡攻击',
  ['decreaseAutoDropTime'] = '减少自动放卡时间',
  ['increaseAutoDropTime'] = '增加自动放卡时间'
}


-- [[  运行时函数及部分参数模块  ]]
Runtiming = {
  eventIndex = {},
  eventFuncList = {}, -- 运行时事件函数列表
  autoDropTime = 4000
}

-- 加特林速点宏
function Runtiming.gatlingQuickShoot(key)
  repeat
    Utils.handleKeyDown(Config.shootKey)
    Sleep(Utils.random(80, 110))
    Utils.handleKeyUp(Config.shootKey)
    Sleep(Utils.random(20, 44))
  until not Utils.isKeyPressed(key)
end

-- usb速点
function Runtiming.usbQuickShoot(key)
  repeat
    Utils.handleKeyClick(Config.shootKey)
    Sleep(Utils.random(40, 70))
  until not Utils.isKeyPressed(key)
end

-- 步枪速点
function Runtiming.rifleQuickShoot(key)
  repeat
    Utils.handleKeyClick(Config.shootKey)
    Sleep(Utils.random(75, 100))
  until not Utils.isKeyPressed(key)
end

-- 唐刀速点
function Runtiming.tangDaoQuickShoot(key)
  repeat
    Utils.handleKeyClick(Config.shootKey)
    Sleep(Utils.random(400, 450))
  until not Utils.isKeyPressed(key)
end

-- 加特林连刺宏
function Runtiming.gatlingStab(key)
  repeat
    Utils.handleKeyClick(3)
    Sleep(Utils.random(270, 300))
    Utils.handleKeyClick(Config.shootKey)
    Sleep(Utils.random(40, 63))
  until not Utils.isKeyPressed(key)
end

-- 虚空重刀宏
function Runtiming.xkQuickAttack()
  local endTime = Runtiming.xkEndTime or 0
  if GetRunningTime() - endTime < 500 then
    -- 防止多次点击多次触发重复操作
    return false
  end
  Utils.handleKeyClick(3)
  Sleep(Utils.random(580, 600))
  Utils.handleKeyClick('f')
  Sleep(Utils.random(50, 70))
  Utils.handleKeyClick(3)
  Sleep(Utils.random(120, 140))
  Runtiming.xkEndTime = GetRunningTime()
end

-- 挑战-试炼岛一键放置卡片
function Runtiming.dropCard()
  local endTime = Runtiming.dropCardEndTime or 0
  if GetRunningTime() - endTime < 500 then
    -- 防止多次点击多次触发重复操作
    return false
  end
  local index = Runtiming.curCardIndex or 1
  local curPosition = Config.cardPosition[index]
  local randomFn = Utils.generateRandomNumber()
  Utils.handleKeyClick('e')
  Sleep(Utils.random(30, 50))
  for i = 1, #curPosition do
    local position = curPosition[i]
    local x = randomFn(position[1], position[2])
    local y = randomFn(position[3], position[4])
    MoveMouseRelative(x, y)
    Sleep(Utils.random(30, 50))
    if i ~= 1 then
      Utils.handleKeyClick(1)
      Sleep(Utils.random(50, 70))
    end
  end
  Runtiming.dropCardEndTime = GetRunningTime()
end

-- 试炼岛-自动放卡
function Runtiming.autoDropCard()
  Sleep(500)
  local flag = true
  local n = 1
  while flag and n < 20 do
    if Utils.isKeyPressed(2) then
      flag = false
      break
    end
    -- first -> 放卡
    Runtiming.dropCard()
    if Utils.isKeyPressed(2) then
      flag = false
      break
    end
    Sleep(5000)
    -- second -> 攻击
    Runtiming.continueAttack()
    Sleep(Runtiming.autoDropTime)
    Runtiming.continueAttack()
    if Utils.isKeyPressed(2) then
      flag = false
      break
    end
    n = n + 1
    Sleep(4000)
  end
end

-- 试炼岛-增加自动放卡时间
function Runtiming.increaseAutoDropTime()
  Runtiming.autoDropTime = Runtiming.autoDropTime + 1000
end

-- 试炼岛-减少自动放卡时间
function Runtiming.decreaseAutoDropTime()
  if Runtiming.autoDropTime == 1000 then
    return false
  end
  Runtiming.autoDropTime = Runtiming.autoDropTime - 1000
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
  Main.printInfo()
end

-- 挑战-试炼岛卡片下标重置
function Runtiming.resetCardIndex()
  Runtiming.curCardIndex = 1
  Main.printInfo()
end

-- 挑战-一键攻击
function Runtiming.continueAttack()
  local endTime = Runtiming.attackEndTime or 0
  if GetRunningTime() - endTime < 500 then
    -- 防止多次点击多次触发重复操作
    return false
  end
  local hasPressed = Runtiming.hasPressed or false
  if hasPressed then
    Utils.handleKeyUp(Config.shootKey)
    Sleep(Utils.random(180, 200))
    Utils.handleKeyClick('r')
  else
    Utils.handleKeyDown(Config.shootKey)
  end
  Runtiming.hasPressed = not hasPressed
  Runtiming.attackEndTime = GetRunningTime()
end

-- 挑战-爆裂者一键榴弹
function Runtiming.continueGrenade(key)
  repeat
    Utils.handleKeyClick(3)
    Sleep(Utils.random(640, 670))
  until not Utils.isKeyPressed(key)
end

-- 一键瞬狙宏
function Runtiming.instantSpy(key)
  local endTime = Runtiming.spyEndTime or 0
  if GetRunningTime() - endTime < 300 then
    -- 防止多次点击多次触发重复操作
    return false
  end
  Utils.handleKeyClick(Config.shootKey)
  Sleep(Utils.random(20, 40))
  Utils.handleKeyClick('q')
  Sleep(Utils.random(20, 40))
  Utils.handleKeyClick('q')
  Runtiming.spyEndTime = GetRunningTime()
end

-- 连续蹲下
function Runtiming.nonStopSquat(key)
  repeat
    Utils.handleKeyClick('lctrl')
    Sleep(Utils.random(40, 60))
  until not Utils.isKeyPressed(key)
end

-- 一键鬼跳
function Runtiming.nonStopJump(key)
  local endTime = Runtiming.jumpEndTime or 0
  if GetRunningTime() - endTime < 500 then
    -- 防止多次点击多次触发重复操作
    return false
  end
  local isFirst = true
  repeat
    local totalTime = Utils.random(637, 640)
    local delay = Utils.random(30, 50)
    Utils.handleKeyClick('spacebar', delay)
    if isFirst then
      -- 第一次起跳
      Utils.handleKeyDown('lctrl')
      isFirst = false
    end
    Sleep(totalTime - delay)
  until not Utils.isKeyPressed(key)
  Sleep(Utils.random(40, 60))
  Utils.handleKeyUp('lctrl')
  Runtiming.jumpEndTime = GetRunningTime()
end

-- [[  工具函数模块  ]]
Utils = {}
-- 四舍五入
function Utils.round(num)
  local floor = math.floor(num)
  local ceil = math.ceil(num)
  return num - floor < 0.5 and floor or ceil
end

-- 分割字符串，返回数组
function Utils.split(str, separator)
  local pattern = string.format('([^%s]+)', separator)
  local result = {}
  for match in string.gmatch(str, pattern) do
    table.insert(result, match)
  end
  if #result == 1 then
    table.insert(result, '')
  end
  return table.unpack(result)
end

-- 获取表长度
function Utils.getTableLength(t)
  local i = 0
  for _, _ in pairs(t) do
    i = i + 1
  end
  return i
end

-- 正态分布变换
function Utils.boxMuller(mean, stddev)
  -- 生成两个均匀分布的随机数
  local u1 = math.random()
  local u2 = math.random()
  -- 使用Box-Muller变换转换成正态分布随机数
  local z0 = math.sqrt(-2.0 * math.log(u1)) * math.cos(2.0 * math.pi * u2)
  -- 使用均值和标准差进行线性变换
  return Utils.round(mean + z0 * stddev)
end

-- 随机数方法
function Utils.random(m, n)
  local mean = (m + n) / 2
  local sigma = (n - m) / (2 * 1.645) -- 1.645 0.9500 1.2815 0.9000
  local random = Utils.boxMuller(mean, sigma)
  while (random < m) do
    random = Utils.round(math.random(m, n))
  end
  return random
end

-- 返回不重复随机数方法
function Utils.generateRandomNumber()
  local prevNum = 0
  local currentNum = 0
  return function(min, max)
    if (max - min) == 0 then
      return 0
    end
    while (prevNum == currentNum) do
      currentNum = Utils.round(min + (max - min) * math.random())
    end
    prevNum = currentNum
    return currentNum
  end
end

-- 触发点击
function Utils.handleKeyClick(key, delay)
  if type(key) == 'number' then
    PressMouseButton(key)
    Sleep(delay or Utils.random(30, 50))
    ReleaseMouseButton(key)
  else
    PressKey(key)
    Sleep(delay or Utils.random(30, 50))
    ReleaseKey(key)
  end
end

-- 按键按下
function Utils.handleKeyDown(key)
  if type(key) == 'number' then
    PressMouseButton(key)
  else
    PressKey(key)
  end
end

-- 按键抬起
function Utils.handleKeyUp(key)
  if type(key) == 'number' then
    ReleaseMouseButton(key)
  else
    ReleaseKey(key)
  end
end

-- 判断按键是否按下(系统级监听)
function Utils.isKeyPressed(key)
  if (type(key) == 'number' and key <= 5 and key >= 1) then
    return IsMouseButtonPressed(key)
  elseif type(key) == 'string' then
    return IsModifierPressed(key)
  else
    return false
  end
end

-- 是否开启宏
function Utils.isOpenMacro(key)
  return IsKeyLockOn(key or Config.openMacroKey or 'capslock')
end

-- 按key的大小顺序返回新表
function Utils.getTableSort(t)
  local keyT = {}
  local newT = {}
  for k, _ in pairs(t) do
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

-- 返回固定长度的字符串
function Utils.completeStr(str, num)
  return string.format('%-' .. num .. 's', str)
end

-- [[  主函数  ]]
Main = {}
-- 初始化事件函数列表
function Main.initEventFuncList()
  -- 当前游戏模式
  local index = Runtiming.curModeIndex
  local curGameMode = Config.gameModeList[index]
  Runtiming.eventFuncList = {}
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
  Main.printInfo()
end

-- 初始化游戏模式下标
function Main.initGameModeIndex()
  Runtiming.curModeIndex = Config.defaultGameModeIndex or 1
end

-- 初始化按键事件下标
function Main.initEventIndex()
  for k, v in pairs(Config.defaultEventIndex) do
    Runtiming.eventIndex[k] = v
  end
end

-- 初始化试炼岛卡片下标
function Main.initCardIndex()
  Runtiming.curCardIndex = Config.defaultCardIndex
end

-- 初始化函数
function Main.init()
  Main.initGameModeIndex()
  Main.initEventIndex()
  Main.initCardIndex()
  Main.initEventFuncList()
end

-- 更新按键绑定事件函数下标
function Main.increaseEventIndex(key)
  local len = #Runtiming.eventFuncList[key]
  if len <= 1 then
    return false
  end
  local nextIndex = (Runtiming.eventIndex[key] + 1) % (len + 1)
  local realIndex = nextIndex == 0 and 1 or nextIndex
  Runtiming.eventIndex[key] = realIndex
  Main.printInfo()
end

-- 重置按键绑定事件函数下标
function Main.resetEventIndex(key)
  local len = #Runtiming.eventFuncList[key]
  if len <= 1 then
    return false
  end
  Runtiming.eventIndex[key] = 1
  Main.printInfo()
end

-- 更新游戏模式
function Main.nextGameMode()
  local len = #Config.gameModeList
  local nextIndex = (Runtiming.curModeIndex + 1) % (len + 1)
  local realIndex = nextIndex == 0 and 1 or nextIndex
  Runtiming.curModeIndex = realIndex
  Main.initEventIndex()
  Main.initCardIndex()
  Main.initEventFuncList()
end

-- 重置游戏模式
function Main.resetGameMode()
  Main.init()
end

-- 打印当前游戏模式
function Main.printGameMode()
  local curGameMode = Config.gameModeList[Runtiming.curModeIndex]
  OutputLogMessage('\t当前游戏模式: ' .. ChineseTextMap[curGameMode] .. '\n\n')
end

-- 打印事件绑定信息
function Main.printEventInfo()
  local curGameMode = Config.gameModeList[Runtiming.curModeIndex]
  local eventList = Utils.getTableSort(Config[curGameMode])
  -- 打印表头
  OutputLogMessage('\t按键\t\t%s\t\t中文\n', Utils.completeStr('方法名', 20))
  OutputLogMessage('\t----------------------------------------------------------------------------------\n')
  -- 遍历事件列表并打印信息
  for _, item in ipairs(eventList) do
    local key = item.key
    local value = item.value
    local index = Runtiming.eventIndex[key]
    for i = 1, #value do
      local eventName = Utils.completeStr(value[i], 20)
      local eventDesc = type(Runtiming[value[i]]) == "function" and ChineseTextMap[value[i]] or '未定义'
      local prefix = (index == i) and string.format('\tG%s=>', Utils.completeStr(key, 2)) or Utils.completeStr('\t', 6)
      -- 打印事件信息
      local info = string.format('%s\t\t%s\t\t%s', prefix, eventName, eventDesc)
      if curGameMode == 'pve' and value[index] == 'dropCard' then
        info = info .. string.format('(当前卡片下标:%d)', Runtiming.curCardIndex)
      end
      OutputLogMessage('%s\n', info)
    end
  end
end

-- 打印信息
function Main.printInfo()
  if Config.openDebugger then
    ClearLog()
    OutputLogMessage(
      ' --------------------------------------------------------------------------------------------------- \n\n')
    Main.printGameMode()
    Main.printEventInfo()
    OutputLogMessage(
      ' \n--------------------------------------------------------------------------------------------------- ')
  end
end

-- 执行事件
function Main.playEvent(key)
  local eventIndex = Runtiming.eventIndex[key]
  local fn = Runtiming.eventFuncList[key][eventIndex]
  if type(fn) == 'function' then
    fn(tonumber(key))
  end
end

-- 运行指令
function Main.runCmd(cmd)
  local type, key = Utils.split(cmd, '_')
  if type == 'next' then
    Main.increaseEventIndex(key)
  elseif type == 'reset' then
    Main.resetEventIndex(key)
  elseif type == 'play' then
    Main.playEvent(key)
  elseif type == 'nextGameMode' then
    Main.nextGameMode()
  elseif type == 'resetGameMode' then
    Main.resetGameMode()
  end
end

-- 处理修饰符
function Main.modifierHandler(modifier)
  local cmd = Config.modifierMap[modifier]
  if cmd then
    Main.runCmd(cmd)
  end
end

-- 鼠标点击事件
function Main.mouseButtonListener(arg, isPressed)
  if arg >= 3 and arg <= 11 then
    -- 监听3-11的可绑定按键
    local modifier = ''
    if isPressed then
      modifier = 'G' .. arg
    else
      modifier = 'G' .. arg .. '_release'
    end
    for i = 1, #ModifierList do
      if (Utils.isKeyPressed(ModifierList[i])) then
        -- 其中某一个修饰符被按下
        modifier = ModifierList[i] .. '+' .. modifier
        break
      end
    end
    local isChange = string.find(modifier, '+')
    if isChange or Utils.isOpenMacro() then
      -- 事件属于切换事件或已开启宏按钮
      Main.modifierHandler(modifier)
    end
  end
end

-- [[  罗技脚本模块  ]]
-- 打开对鼠标左键的监听
EnablePrimaryMouseButtonEvents(true)

-- 设置随机数种子
math.randomseed(GetDate("%H%M%S"):reverse())

Main.init()

-- 监听事件
function OnEvent(event, arg)
  if string.find(event, 'MOUSE_BUTTON') then
    if (arg == 2) then
      arg = 3
    elseif arg == 3 then
      arg = 2
    end
    Main.mouseButtonListener(arg, event == 'MOUSE_BUTTON_PRESSED')
  end
end
