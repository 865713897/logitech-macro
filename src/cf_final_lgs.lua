---@diagnostic disable: duplicate-set-field, undefined-global, param-type-mismatch
-- [[  用户配置  ]]
Config = {
  openMacroKey = 'capslock',                  -- scrolllock | capslock | numlock
  shootKey = 1,                               -- 攻击按键1:鼠标左键，也可设置键盘按键
  gameModeList = { 'pve', 'zombie', 'auto' }, -- 模式列表
  defaultGameModeIndex = 1,                   -- 默认游戏模式下标
  openDebugger = false,                       -- 是否开启调试模式（输出打印信息）
  scale = 2,                                  -- 系统缩放
  -- 生化模式绑定按键函数信息
  zombie = {
    ['4'] = { 'xkQuickAttack', 'swordsmenMove' },
    ['5'] = { 'gatlingQuickShoot', 'nonStopSquat' }
  },
  -- 挑战模式
  pve = {
    ['4'] = { 'continueAttack', 'continueGrenade' },
    ['5'] = { 'dropCard1', 'dropCard2', 'dropCard3', 'dropCard4', 'dropCard5' },
  },
  -- 竞技模式
  pvp = {
    ['4'] = { 'rifleQuickShoot', 'nonStopSquat' },
    ['5'] = { 'usbQuickShoot', 'tangDaoQuickShoot' },
  },
  -- 挑战试炼岛-自动模式
  auto = {
    ['4'] = { 'autoArriveBoss' },
    ['5'] = { 'autoArriveHs' },
  },
  defaultCardIndex = 1, -- 默认卡片下标
  -- 默认按键事件下标
  defaultEventIndex = {
    ['1'] = 1,
    ['3'] = 1,
    ['4'] = 1,
    ['5'] = 1,
    ['6'] = 1,
    ['7'] = 1,
    ['10'] = 1,
    ['11'] = 1,
  },
  -- 试炼岛卡片坐标
  cardPosition = {
    { { 0, 0, 3, 6 }, { -225, -245, -12, 12 }, { 500, 530, 182, 200 } },
    { { 0, 0, 3, 6 }, { -90, -110, -12, 12 },  { 365, 395, 182, 200 } },
    { { 0, 0, 3, 6 }, { 25, 45, -12, 12 },     { 240, 260, 182, 200 } },
    { { 0, 0, 3, 6 }, { 160, 180, -12, 12 },   { 95, 125, 182, 200 } },
    { { 0, 0, 3, 6 }, { 295, 315, -12, 12 },   { -10, -35, 182, 200 } },
  },
  -- 鼠标按键绑定
  modifierMap = {
    ['G3_release'] = 'play_3',
    ['lalt+G3'] = 'nextGameMode',
    ['ralt+G3'] = 'resetGameMode',
    ['G4'] = 'play_4',
    ['lalt+G4'] = 'next_4',
    ['ralt+G4'] = 'reset_4',
    ['G5'] = 'play_5',
    ['lalt+G5'] = 'next_5',
    ['ralt+G5'] = 'reset_5',
    ['G10'] = 'play_10',
    ['lalt+G10'] = 'next_10',
    ['ralt+G10'] = 'reset_10',
    ['G11'] = 'play_11',
    ['lalt+G11'] = 'next_11',
    ['ralt+G11'] = 'reset_11',
  },
}

-- 可用修饰符列表
ModifierList = { 'lalt', 'ralt', 'rctrl', 'rshift' }

-- 字符转换汉字
function Utf8Char(...)
  local args = { ... }
  local result = ""

  for _, v in ipairs(args) do
    -- 验证码点的范围，unicode 有效码点范围为 0 - 0x10ffff
    if v < 0 or v > 0x10ffff then
      error("invalid unicode code point: " .. tostring(v))
    elseif v < 0x80 then
      result = result .. string.char(v)
    elseif v < 0x800 then
      result = result .. string.char(0xc0 + math.floor(v / 0x40), 0x80 + (v % 0x40))
    elseif v < 0x10000 then
      result = result
          .. string.char(0xe0 + math.floor(v / 0x1000), 0x80 + (math.floor(v / 0x40) % 0x40), 0x80 + (v % 0x40))
    else
      result = result
          .. string.char(
            0xf0 + math.floor(v / 0x40000),
            0x80 + (math.floor(v / 0x1000) % 0x40),
            0x80 + (math.floor(v / 0x40) % 0x40),
            0x80 + (v % 0x40)
          )
    end
  end

  return result
end

-- 中文对照表
ChineseTextMap = {
  ['zombie'] = Utf8Char(29983, 21270, 27169, 24335),
  ['pve'] = Utf8Char(25361, 25112, 27169, 24335),
  ['pvp'] = Utf8Char(31454, 25216, 27169, 24335),
  ['auto'] = Utf8Char(25361, 25112, 35797, 28860, 23707, 45, 33258, 21160, 27169, 24335),
  ['gatlingQuickShoot'] = Utf8Char(21152, 29305, 26519, 36895, 28857),
  ['usbQuickShoot'] = Utf8Char(117, 115, 98, 36895, 28857),
  ['gatlingStab'] = Utf8Char(21152, 29305, 26519, 36830, 21050),
  ['xkQuickAttack'] = Utf8Char(34394, 31354, 37325, 20992),
  ['instantSpy'] = Utf8Char(19968, 38190, 30636, 29401),
  ['continueAttack'] = Utf8Char(25361, 25112, 27169, 24335, 33258, 21160, 25915, 20987),
  ['dropCard1'] = Utf8Char(25361, 25112, 35797, 28860, 23707, 25918, 32622, 21345, 29255, 45, 20301, 32622, 49),
  ['dropCard2'] = Utf8Char(25361, 25112, 35797, 28860, 23707, 25918, 32622, 21345, 29255, 45, 20301, 32622, 50),
  ['dropCard3'] = Utf8Char(25361, 25112, 35797, 28860, 23707, 25918, 32622, 21345, 29255, 45, 20301, 32622, 51),
  ['dropCard4'] = Utf8Char(25361, 25112, 35797, 28860, 23707, 25918, 32622, 21345, 29255, 45, 20301, 32622, 52),
  ['dropCard5'] = Utf8Char(25361, 25112, 35797, 28860, 23707, 25918, 32622, 21345, 29255, 45, 20301, 32622, 53),
  ['increaseCardIndex'] = Utf8Char(26356, 26032, 35797, 28860, 23707, 21345, 29255, 32034, 24341, 20301, 32622),
  ['resetCardIndex'] = Utf8Char(37325, 32622, 35797, 28860, 23707, 21345, 29255, 32034, 24341, 20301, 32622),
  ['nonStopSquat'] = Utf8Char(19968, 38190, 38378, 36466),
  ['nonStopJump'] = Utf8Char(19968, 38190, 39740, 36339),
  ['continueGrenade'] = Utf8Char(25361, 25112, 29190, 35010, 32773, 19968, 38190, 27060, 24377),
  ['rifleQuickShoot'] = Utf8Char(27439, 26538, 36895, 28857),
  ['tangDaoQuickShoot'] = Utf8Char(21776, 20992, 24555, 36895, 20992),
  ['autoDropCard'] = Utf8Char(35797, 28860, 23707, 33258, 21160, 25918, 21345, 25915, 20987),
  ['decreaseAutoDropTime'] = Utf8Char(20943, 23569, 33258, 21160, 25918, 21345, 26102, 38388),
  ['increaseAutoDropTime'] = Utf8Char(22686, 21152, 33258, 21160, 25918, 21345, 26102, 38388),
  ['autoDropCardHS'] = Utf8Char(35797, 28860, 23707, 33258, 21160, 25918, 21345, 25915, 20987, 40, 23506, 38684, 24040,
    20861, 41),
  ['swordsmenMove'] = Utf8Char(29983, 21270, 21073, 23458, 30636, 31227),
  ['autoArriveHs'] = Utf8Char(33258, 21160, 21040, 36798, 49, 42, 23506, 38684, 24040, 20861, 21047, 21345, 28857),
  ['autoArriveBoss'] = Utf8Char(33258, 21160, 21040, 36798, 66, 79, 83, 83, 28857, 20301),
}


-- [[  运行时函数及部分参数模块  ]]
Runtiming = {
  eventIndex = {},
  eventFuncList = {}, -- 运行时事件函数列表
  autoDropTime = 1500,
  maxCount = 20,      -- 自动放卡最大次数
}

-- 加特林速点宏
function Runtiming.gatlingQuickShoot(key)
  local exceedChance = 20 -- 20%的概率会超过35ms
  repeat
    local upTime = 0;
    local downTime = Utils.random(80, 110);
    if math.random(1, 100) <= exceedChance then
      upTime = Utils.random(36, 45)
    else
      upTime = Utils.random(20, 35)
    end
    Utils.handleKeyDown(Config.shootKey)
    Sleep(downTime)
    Utils.handleKeyUp(Config.shootKey)
    Sleep(upTime)
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
  if GetRunningTime() - endTime < 10 then
    -- 防止多次点击多次触发重复操作
    return false
  end
  Utils.handleKeyClick(3)
  Sleep(Utils.random(530, 560))
  Utils.handleKeyClick('f')
  Sleep(Utils.random(50, 70))
  Utils.handleKeyClick(3)
  Runtiming.xkEndTime = GetRunningTime()
end

-- 生化剑客瞬移
function Runtiming.swordsmenMove()
  local endTime = Runtiming.swordsmenEndTime or 0
  if GetRunningTime() - endTime < 10 then
    -- 防止多次点击多次触发重复操作
    return false
  end
  Utils.handleKeyClick('f')
  Sleep(Utils.random(100, 140))
  Utils.handleKeyClick('spacebar')
  Sleep(Utils.random(100, 140))
  Utils.handleKeyClick('f')
  Runtiming.swordsmenEndTime = GetRunningTime()
end

-- 挑战-试炼岛一键放置卡片
function Runtiming.dropCard(index)
  local endTime = Runtiming.dropCardEndTime or 0
  if GetRunningTime() - endTime < 20 then
    -- 防止多次点击多次触发重复操作
    return false
  end
  local curPosition = Config.cardPosition[index]
  local randomFn = Utils.generateRandomNumber()
  Utils.handleKeyClick('e')
  Sleep(Utils.random(30, 60))
  local offsetY = 0
  local scale = Config.scale
  for i = 1, #curPosition do
    local position = curPosition[i]
    local x = randomFn(position[1], position[2])
    local y = randomFn(position[3], position[4])
    x = Utils.round(x / scale)
    y = Utils.round(y / scale)
    if i == 3 then
      y = y - offsetY
    else
      offsetY = offsetY + y
    end
    MoveMouseRelative(x, y)
    Sleep(Utils.random(40, 80))
    if i ~= 1 then
      Utils.handleKeyClick(1)
      Sleep(Utils.random(40, 80))
    end
  end
  Runtiming.dropCardEndTime = GetRunningTime()
end

-- 试炼岛放卡位置1
function Runtiming.dropCard1()
  Runtiming.dropCard(1)
end

-- 试炼岛放卡位置2
function Runtiming.dropCard2()
  Runtiming.dropCard(2)
end

-- 试炼岛放卡位置3
function Runtiming.dropCard3()
  Runtiming.dropCard(3)
end

-- 试炼岛放卡位置4
function Runtiming.dropCard4()
  Runtiming.dropCard(4)
end

-- 试炼岛放卡位置5
function Runtiming.dropCard5()
  Runtiming.dropCard(5)
end

-- 试炼岛-自动放卡
function Runtiming.autoDropCard(cd, needEscape)
  cd = (type(cd) == "number") and { 5100, 5300 } or cd
  needEscape = needEscape or false
  local endTime = Runtiming.endTime or 0;
  if GetRunningTime() - endTime < 500 then
    -- 防止多次点击多次触发重复操作
    return false
  end
  local n = 2
  while n < Runtiming.maxCount do
    if Utils.isKeyPressed(2) then
      n = Runtiming.maxCount
      break
    end
    -- first -> 放卡
    Runtiming.dropCard()
    if Utils.isKeyPressed(2) then
      n = Runtiming.maxCount
      break
    end
    -- 放卡过后5s会召唤怪物，等待5s
    Sleep(Utils.random(4500, 5000))
    if needEscape then
      Utils.handleKeyClick('h')
      Sleep(Utils.random(30, 50))
      Utils.handleKeyClick('h')
      Sleep(Utils.random(30, 50))
    end
    -- second -> 攻击
    Runtiming.continueAttack()
    Sleep(Utils.random(Runtiming.autoDropTime + 100, Runtiming.autoDropTime + 500))
    Runtiming.continueAttack()
    if Utils.isKeyPressed(2) then
      n = Runtiming.maxCount
      break
    end
    n = n + 1
    -- 自动放卡间隔时间，一般怪物死亡后会有5s的冷却时间，所以这里设置5s
    -- 寒霜巨兽死亡后无冷却时间，所以设置为500ms
    Sleep(Utils.random(cd[1], cd[2]))
  end
  Runtiming.endTime = GetRunningTime()
end

-- 试炼岛-自动放卡(寒霜巨兽)
function Runtiming.autoDropCardHS()
  Runtiming.autoDropCard({ 500, 700 }, true)
end

-- 试炼岛-增加自动放卡时间
function Runtiming.increaseAutoDropTime()
  Runtiming.autoDropTime = Runtiming.autoDropTime + 1000
end

-- 试炼岛-减少自动放卡时间
function Runtiming.decreaseAutoDropTime()
  if Runtiming.autoDropTime <= 1500 then
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
    Sleep(Utils.random(640, 690))
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
  Sleep(Utils.random(30, 50))
  Utils.handleKeyClick('q')
  Sleep(Utils.random(30, 50))
  Utils.handleKeyClick('q')
  Runtiming.spyEndTime = GetRunningTime()
end

-- 连续蹲下
function Runtiming.nonStopSquat(key)
  repeat
    Utils.handleKeyClick('lctrl')
    Sleep(Utils.random(40, 70))
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

-- 试炼岛-1*小黄刷卡点
function Runtiming.autoArriveHs()
  -- 初始化起始位置
  Runtiming.autoArriveInit()
  -- -- 向右移动
  Utils.move('d', 6450, 6550)
  if (Utils.isOpenMacro() ~= true) then
    return
  end
  -- -- 向左移动
  Utils.move('a', 1900, 1950)
  if (Utils.isOpenMacro() ~= true) then
    return
  end
  -- 向前移动
  Utils.move('w', 8500, 8700)
  if (Utils.isOpenMacro() ~= true) then
    return
  end
  -- 向右移动
  Utils.move('d', 4400, 4500)
  if (Utils.isOpenMacro() ~= true) then
    return
  end
  -- 向前移动
  Utils.handleKeyDown('w')
  Sleep(Utils.random(8400, 8500))
  Utils.handleKeyClick('spacebar')
  if (Utils.isOpenMacro() ~= true) then
    return
  end
  Sleep(Utils.random(20200, 20400))
  Utils.handleKeyUp('w')
  Sleep(Utils.random(100, 150))
  if (Utils.isOpenMacro() ~= true) then
    return
  end
  -- 向右移动
  Utils.move('d', 6600, 6650)
  if (Utils.isOpenMacro() ~= true) then
    return
  end
  -- 向后移动
  Utils.move('s', 3850, 3950)
  if (Utils.isOpenMacro() ~= true) then
    return
  end
  -- 向右移动
  Utils.move('d', 1100, 1200)
  if (Utils.isOpenMacro() ~= true) then
    return
  end
  -- 向后移动
  Utils.move('s', 1700, 2400)
end

-- 试炼岛-boss点位
function Runtiming.autoArriveBoss()
  -- 初始化起始位置
  Runtiming.autoArriveInit()
  -- 向右移动
  Utils.move('d', 6450, 6500)
  if (Utils.isOpenMacro() ~= true) then
    return
  end
  -- 向左移动
  Utils.move('a', 1900, 1950)
  if (Utils.isOpenMacro() ~= true) then
    return
  end
  -- 向前移动
  Utils.move('w', 8500, 8700)
  if (Utils.isOpenMacro() ~= true) then
    return
  end
  -- 向右移动
  Utils.move('d', 5170, 5270)
  if (Utils.isOpenMacro() ~= true) then
    return
  end
  -- 向前移动
  Utils.move('w', 320, 340)
  if (Utils.isOpenMacro() ~= true) then
    return
  end
  -- 向右移动
  Utils.move('d', 3000, 3100)
  if (Utils.isOpenMacro() ~= true) then
    return
  end
  -- 向后移动
  Utils.move('s', 400, 430)
  if (Utils.isOpenMacro() ~= true) then
    return
  end
  -- 向右移动
  Utils.move('d', 900, 1000)
  if (Utils.isOpenMacro() ~= true) then
    return
  end
  -- 向前移动
  Utils.move('w', 2600, 2700)
  if (Utils.isOpenMacro() ~= true) then
    return
  end
  -- 向右移动
  Utils.move('d', 1600, 1700)
  if (Utils.isOpenMacro() ~= true) then
    return
  end
  -- 向前移动
  Utils.move('w', 1700, 1800)
  if (Utils.isOpenMacro() ~= true) then
    return
  end
  -- 向右移动
  Utils.move('d', 3800, 3900)
  if (Utils.isOpenMacro() ~= true) then
    return
  end
  -- 向后移动
  Utils.move('s', 3600, 3700)
  if (Utils.isOpenMacro() ~= true) then
    return
  end
  -- 向右移动
  Utils.handleKeyDown('d')
  Sleep(Utils.random(4700, 4800))
  Utils.handleKeyClick('spacebar')
  Sleep(Utils.random(1000, 1100))
  Utils.handleKeyUp('d')
  Sleep(Utils.random(1500, 1600))
  if (Utils.isOpenMacro() ~= true) then
    return
  end
  -- 鼠标旋转180
  MoveMouseRelative(960 * 4 - 570, 0)
  Sleep(Utils.random(100, 150))
  -- 向前移动
  Utils.move('w', 1000, 1100)
end

-- 试炼岛-初始化点位
function Runtiming.autoArriveInit()
  -- 初始化起始位置
  local randomFn = Utils.generateRandomNumber()
  local scale = Config.scale
  Utils.handleKeyClick('tilde')
  Sleep(Utils.random(150, 170))
  MoveMouseRelative(Utils.round(randomFn(-144, -154) / scale), Utils.round(randomFn(230, 236) / scale))
  Sleep(Utils.random(150, 170))
  Utils.handleKeyClick(1)
  Sleep(Utils.random(150, 170))
  Utils.smoothMove(0, 0, Utils.round(randomFn(60, 110) / scale), Utils.round(randomFn(-135, -145) / scale),
    randomFn(100, 120))
  Sleep(Utils.random(150, 170))
  Utils.handleKeyClick(1, 100)
  Sleep(Utils.random(300, 400))
  Utils.handleKeyClick('tilde')
  Sleep(Utils.random(150, 170))
  Utils.handleKeyClick('3')
  Sleep(Utils.random(150, 170))
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
  return unpack(result)
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
    Sleep(delay or Utils.random(40, 86))
    ReleaseMouseButton(key)
  else
    PressKey(key)
    Sleep(delay or Utils.random(40, 86))
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

-- 触发移动
function Utils.move(vk, minDelay, maxDelay)
  Utils.handleKeyDown(vk)
  Sleep(Utils.random(minDelay, maxDelay))
  Utils.handleKeyUp(vk)
  Sleep(Utils.random(150, 170))
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

-- 鼠标平滑移动
function Utils.smoothMove(startX, startY, endX, endY, durationMs)
  -- 参数校验
  if durationMs <= 0 then return end

  -- 亚像素累积桶
  local accNumX, accNumY = 0, 0

  -- 移动参数
  local steps = math.max(10, durationMs / 10)
  local stepInterval = durationMs / steps
  local randomFn = Utils.generateRandomNumber()

  -- 贝塞尔曲线控制点
  local ctrlX1 = startX + randomFn(-15, 15)
  local ctrlY1 = startY + randomFn(-15, 15)
  local ctrlX2 = endX + randomFn(-15, 15)
  local ctrlY2 = endY + randomFn(-15, 15)

  -- 记录当前位置（绝对坐标）
  local currentX, currentY = startX, startY

  for t = 0, 1, 1 / steps do
    -- 三阶贝塞尔曲线计算
    local targetX = (1 - t) ^ 3 * startX +
        3 * (1 - t) ^ 2 * t * ctrlX1 +
        3 * (1 - t) * t ^ 2 * ctrlX2 +
        t ^ 3 * endX

    local targetY = (1 - t) ^ 3 * startY +
        3 * (1 - t) ^ 2 * t * ctrlY1 +
        3 * (1 - t) * t ^ 2 * ctrlY2 +
        t ^ 3 * endY

    -- 计算理论偏移量（可能是亚像素）
    local deltaX = targetX - currentX
    local deltaY = targetY - currentY

    -- 累积亚像素偏移
    accNumX = accNumX + deltaX
    accNumY = accNumY + deltaY

    -- 计算实际应移动的整像素值
    local moveX = math.floor(accNumX)
    local moveY = math.floor(accNumY)

    -- 执行移动（仅当累积量≥1像素）
    if moveX ~= 0 or moveY ~= 0 then
      MoveMouseRelative(moveX, moveY)
      -- 更新当前位置和剩余累积量
      currentX = currentX + moveX
      currentY = currentY + moveY
      accNumX = accNumX - moveX
      accNumY = accNumY - moveY
    end

    -- 随机间隔（添加微抖动）
    Sleep(stepInterval + randomFn(-3, 5))
  end

  -- 最终校正（确保到达终点）
  local finalX = endX - currentX
  local finalY = endY - currentY
  if finalX ~= 0 or finalY ~= 0 then
    MoveMouseRelative(finalX, finalY)
  end
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
  OutputLogMessage('\t' ..
    Utf8Char(24403, 21069, 28216, 25103, 27169, 24335) .. ': ' .. ChineseTextMap[curGameMode] .. '\n\n')
end

-- 打印事件绑定信息
function Main.printEventInfo()
  local curGameMode = Config.gameModeList[Runtiming.curModeIndex]
  local eventList = Utils.getTableSort(Config[curGameMode])
  -- 打印表头
  OutputLogMessage('\t' .. Utf8Char(25353, 38190) .. '\t\t%s\t\t' .. Utf8Char(20013, 25991) .. '\n',
    Utils.completeStr(Utf8Char(26041, 27861, 21517), 20))
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
    -- local isChange = string.find(modifier, '+')
    if Utils.isOpenMacro() then
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
    Main.mouseButtonListener(arg, event == 'MOUSE_BUTTON_PRESSED')
  end
end
