---@diagnostic disable: duplicate-set-field
-- 测试压枪
---@diagnostic disable: undefined-global

-- 自定义函数
-- 合并table，返回新table
function table.assign(table1, table2)
  -- 合并两张表，返回新表
  local result = {}
  for key, value in pairs(table1) do
    result[key] = value
  end
  for key, value in pairs(table2) do
    result[key] = value
  end
  return result
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

-- 伽马随机分布
function GenerateRandomNumber(min, max)
  local shape = 2 -- 伽马分布形状参数
  -- 逆变换生成伽马分布随机数
  local randomNum = (min + (max - min) * math.random()) ^ (1 / shape)
  return math.round(randomNum)
end

Config = {
  -- 灵敏度
  sensitivity = {
    -- 开镜 | sighting mirror
    scopeX1 = 1,
    -- 腰射 | take aim
    Aim = 0.55,
    -- 二倍 | twice scope
    scopeX2 = 1.71,
    -- 三倍 | trebling scope
    scopeX3 = 2.62,
    -- 四倍 | quadruple scope
    scopeX4 = 3.63,
    -- 六倍 | sixfold scope
    scopeX6 = 2.3,
  },
  cpuLoad = 1,
  -- 启用脚本(capslock | numlock)
  startScript = 'capslock',
  G_bind = {
    -- G
    ['G3'] = '',
    ['G4'] = '',
    ['G5'] = 'next',
    ['G6'] = '9mm',
    ['G7'] = '.45',
    ['G8'] = '',
    ['G9'] = '',
    ['G10'] = '5.56',
    ['G11'] = '7.62',
    -- lalt + G
    ['lalt + G3'] = '',
    ['lalt + G4'] = 'scopeX1',
    ['lalt + G5'] = 'scopeX2',
    ['lalt + G6'] = 'scopeX4',
    ['lalt + G7'] = 'scopeX3',
    ['lalt + G8'] = 'scopeX6',
    ['lalt + G9'] = '',
    ['lalt + G10'] = '',
    ['lalt + G11'] = '',
    -- lctrl + G
    ['lctrl + G3'] = '',
    ['lctrl + G4'] = '',
    ['lctrl + G5'] = 'fast_pickup',
    ['lctrl + G6'] = 'fast_lick_box',
    ['lctrl + G7'] = '',
    ['lctrl + G8'] = '',
    ['lctrl + G9'] = '',
    ['lctrl + G10'] = '',
    ['lctrl + G11'] = '',
    -- lshift + G		
    ['lshift + G3'] = '',
    ['lshift + G4'] = '',
    ['lshift + G5'] = '',
    ['lshift + G6'] = '',
    ['lshift + G7'] = '',
    ['lshift + G8'] = '',
    ['lshift + G9'] = '',
    ['lshift + G10'] = '',
    ['lshift + G11'] = '',
    -- ralt + G
    ['ralt + G3'] = '',
    ['ralt + G4'] = '',
    ['ralt + G5'] = '',
    ['ralt + G6'] = '',
    ['ralt + G7'] = '',
    ['ralt + G8'] = '',
    ['ralt + G9'] = '',
    ['ralt + G10'] = '',
    ['ralt + G11'] = '',
    -- rctrl + G
    ['rctrl + G3'] = '',
    ['rctrl + G4'] = '',
    ['rctrl + G5'] = '',
    ['rctrl + G6'] = '',
    ['rctrl + G7'] = '',
    ['rctrl + G8'] = '',
    ['rctrl + G9'] = '',
    ['rctrl + G10'] = '',
    ['rctrl + G11'] = '',
    -- rshift + G		
    ['rshift + G3'] = '',
    ['rshift + G4'] = '',
    ['rshift + G5'] = '',
    ['rshift + G6'] = 'fast_discard',
    ['rshift + G7'] = '',
    ['rshift + G8'] = '',
    ['rshift + G9'] = '',
    ['rshift + G10'] = '',
    ['rshift + G11'] = '',
    -- 非鼠标G键，可以使键盘或者耳机上的G键，默认使用键盘G键，请确保你使用的是可编程的罗技键盘 | F1~12 (Non-mouse G-key)		
    ['F1'] = '',
    ['F2'] = '',
    ['F3'] = '',
    ['F4'] = '',
    ['F5'] = '',
    ['F6'] = '',
    ['F7'] = '',
    ['F8'] = '',
    ['F9'] = '',
    ['F10'] = '',
    ['F11'] = '',
    ['F12'] = '',
  },
}

-- 子弹类型列表
BulletTypeList = { '5.56', '7.62', '.45', '9mm' }

-- 可用修饰符列表
ModifierList = { 'lalt', 'lctrl', 'lshift', 'ralt', 'rctrl', 'rshift' }

-- 枪械后坐力系数
WeaponsRecoil = {
  ['.45'] = {
    -- 枪械，模式，系数，下蹲系数
    { 'UMP45',     1, 1, 0.8 }, -- 基础镜 + 扩容，Bizon (基础镜即可)，Vector (补偿 + 基础镜 + 扩容) | Reddot + Mag，Bizon (Reddot)，Vector (Komp + Reddot + Mag)
    { 'Tommy_Gun', 1, 1, 0.8 }, -- 扩容 | Mag
  },
  -- 枪械，模式，系数，下蹲系数
  ['9mm'] = {
    { 'Vector',    1, 1, 0.8 }, -- 基础镜 + 扩容 | Reddot + Mag
    { 'Micro_UZI', 1, 1, 0.8 }, -- 扩容 | Mag
  },
  ['5.56'] = {
    -- 枪械，模式，系数，下蹲系数
    { 'M416',   1, 1, 0.8749 }, -- 补偿 + 基础镜 + 直角 + 枪托 + 扩容 | Komp + Reddot + Triangular grip + Gunstock + Mag
    { 'AUG',    1, 1, 0.8 },    -- 补偿 + 基础镜 + 直角 + 扩容 | Komp + Reddot + Triangular grip + Mag
    { 'QBZ',    1, 1, 0.8 },    -- 补偿 + 基础镜 + 直角 + 扩容 | Komp + Reddot + Triangular grip + Mag
    { 'M16A4',  2, 1, 0.8 },    -- 补偿 + 基础镜 + 枪托 + 扩容 | Komp + Reddot + Gunstock + Mag
    { 'SCAR_L', 0, 1, 0.8 },    -- 补偿 + 基础镜 + 直角 + 扩容 | Komp + Reddot + Triangular grip + Mag
    { 'G36C',   0, 1, 0.8 },    -- 补偿 + 基础镜 + 直角 + 扩容 | Komp + Reddot + Triangular grip + Mag
  },
  ['7.62'] = {
    -- 枪械，模式，系数，下蹲系数
    { 'Beryl_M762', 1, 1, 0.8 }, -- 补偿 + 基础镜 + 直角 + 扩容 | Komp + Reddot + Triangular grip + Mag
    { 'ACE32',      1, 1, 0.8 }, -- 补偿 + 基础镜 + 直角 + 扩容 | Komp + Reddot + Triangular grip + Mag
    { 'AKM',        1, 1, 0.8 }, -- 补偿 + 基础镜 + 扩容 | Komp + Reddot + Mag
    { 'DP_28',      0, 1, 0.8 }, -- 基础镜 | Reddot
  },
}

-- 运行配置
RunConfig = {
  -- 开枪开始时间
  startTime = 0,
  -- 频率设置 (这里不能设置成0，调试会出BUG)
  sleep = Config.cpuLoad,
  -- 垂直偏移量
  verticalOffset = 0,
  -- 水平偏移量
  horizontalOffset = 0,
  -- 防检测随机延迟
  sleepRandom = { Config.cpuLoad, Config.cpuLoad + 5 },
  -- 当前弹药模式
  bulletType = '5.56',
  -- 当前弹药下，枪械索引
  weaponIndex = 1,
  -- 当前枪械第几颗子弹
  bulletIndex = 1,
  -- 枪械名称集合
  weaponNames = {
    ['5.56'] = {},
    ['7.62'] = {},
    ['.45'] = {},
    ['9mm'] = {}
  },
  -- 枪械对应数据(弹道信息)
  weaponInfos = {
    ['5.56'] = {},
    ['7.62'] = {},
    ['.45'] = {},
    ['9mm'] = {}
  },
  -- 当前倍镜
  currentScope = 'scopeX1',
  scopeX1 = Config.sensitivity.scopeX1,
  scopeX2 = Config.sensitivity.scopeX2,
  scopeX3 = Config.sensitivity.scopeX3,
  scopeX4 = Config.sensitivity.scopeX4,
  scopeX6 = Config.sensitivity.scopeX6,
}

-- 弹道配置
TrajectoryConfig = {
  ['M416'] = { interval = 85,
    bulletType = '5.56',
    trajectory = {
      { 1,  0 },
      { 2,  35 },
      { 3,  12.5 },
      { 4,  15.5 },
      { 7,  23 },
      { 8,  20 },
      { 15, 24 },
      { 20, 24 },
      { 25, 28.5 },
      { 30, 23.5 },
      { 35, 27 },
      { 40, 29 },
    } },
  ['AUG'] = { interval = 84,
    bulletType = '5.56',
    trajectory = {
      { 1,  0 },
      { 2,  35 },
      { 3,  12.5 },
      { 4,  15.5 },
      { 7,  23 },
      { 8,  20 },
      { 15, 25 },
      { 20, 33 },
      { 25, 28.5 },
      { 35, 27 },
      { 40, 29.5 },
    } },
  ['M16A4'] = { interval = 108,
    bulletType = '5.56',
    trajectory = {
      { 1,  0 },
      { 5,  20 },
      { 40, 24 },
    } },
  ['QBZ'] = { interval = 92,
    bulletType = '5.56',
    trajectory = {
      { 1,  0 },
      { 2,  28 },
      { 5,  18 },
      { 10, 22 },
      { 15, 24 },
      { 20, 33 },
      { 25, 26 },
      { 40, 27 },
    } },
  ['SCAR_L'] = { interval = 96,
    bulletType = '5.56',
    trajectory = {
      { 1,  0 },
      { 2,  30 },
      { 5,  20 },
      { 10, 24 },
      { 15, 28 },
      { 40, 32 },
    } },
  ['G36C'] = { interval = 86,
    bulletType = '5.56',
    trajectory = {
      { 1,  0 },
      { 2,  40 },
      { 5,  16 },
      { 10, 26 },
      { 15, 30 },
      { 20, 34 },
      { 40, 36 },
    } },
  ['AKM'] = { interval = 99,
    bulletType = '7.62',
    trajectory = {
      { 1,  0 },
      { 2,  42 },
      { 5,  24 },
      { 10, 32 },
      { 20, 38 },
      { 30, 40.5 },
      { 40, 41 },
    } },
  ['Beryl_M762'] = { interval = 86,
    bulletType = '7.62',
    trajectory = {
      { 1,  0 },
      { 2,  42 },
      { 5,  25 },
      { 10, 28 },
      { 15, 30 },
      { 30, 38 },
      { 40, 39 },
    } },
  ['ACE32'] = { interval = 87,
    bulletType = '7.62',
    trajectory = {
      { 1,  0 },
      { 2,  38 },
      { 5,  19 },
      { 10, 24 },
      { 15, 24 },
      { 20, 28 },
      { 23, 30 },
      { 25, 34 },
      { 30, 28 },
      { 40, 31 },
    } },
  ['DP_28'] = { interval = 100,
    bulletType = '7.62',
    trajectory = {
      { 1,  0 },
      { 2,  30 },
      { 5,  20 },
      { 47, 30 },
    } },
  ['UMP45'] = { interval = 94,
    bulletType = '.45',
    trajectory = {
      { 1,  0 },
      { 5,  18 },
      { 15, 30 },
      { 35, 34 },
    } },
  ['Tommy_Gun'] = { interval = 84,
    bulletType = '.45',
    trajectory = {
      { 1,  0 },
      { 3,  20 },
      { 6,  21 },
      { 8,  24 },
      { 10, 30 },
      { 15, 40 },
      { 50, 44 },
    } },
  ['Vector'] = { interval = 55,
    bulletType = '9mm',
    trajectory = {
      { 1,  0 },
      { 6,  16 },
      { 10, 20 },
      { 13, 24 },
      { 15, 28 },
      { 20, 32 },
      { 33, 34 },
    } },
  ['Micro_UZI'] = { interval = 46,
    bulletType = '9mm',
    trajectory = {
      { 1,  0 },
      { 2,  13 },
      { 10, 12 },
      { 15, 20 },
      { 35, 30 },
    } }
}

-- 初始化弹道数据函数
RunConfig.initTraFn = function()
  local trajectoryData = {}
  for key, value in pairs(TrajectoryConfig) do
    trajectoryData[key] = RunConfig.generateTrajectoryData(key, value)
  end
  RunConfig = table.assign(RunConfig, trajectoryData)
end

-- 生成弹道数据
RunConfig.generateTrajectoryData = function(weaponName, weaponInfo)
  local curBulletTypeWeapons = WeaponsRecoil[weaponInfo.bulletType]
  local curWeaponRecoil
  local bulletIndex = 1
  for _, value in ipairs(curBulletTypeWeapons) do
    if (value[1] == weaponName) then
      curWeaponRecoil = value
    end
  end
  -- 生成弹道数据
  local trajectoryData = {}
  local trajectoryData2 = {}
  for i = 1, #weaponInfo.trajectory do
    local bulletNum = weaponInfo.trajectory[i][1]
    if (i ~= 1) then
      bulletNum = weaponInfo.trajectory[i][1] - weaponInfo.trajectory[i - 1][1]
    end
    for j = 1, bulletNum do
      trajectoryData[bulletIndex] = weaponInfo.trajectory[i][2]
      bulletIndex = bulletIndex + 1
    end
  end
  for i = 1, #trajectoryData do
    if (i == 1) then
      trajectoryData2[i] = trajectoryData[i]
    else
      trajectoryData2[i] = trajectoryData[i] + trajectoryData2[i - 1]
    end
  end
  return {
    duration = weaponInfo.interval * #trajectoryData, -- 总耗时
    amount = #trajectoryData,                         -- 子弹数
    interval = weaponInfo.interval,                   -- 每颗子弹耗时
    trajectoryData = trajectoryData2,                 --  弹道数据
    crouchFactor = curWeaponRecoil[4]                 -- 下蹲系数
  }
end

-- 设置随机数种子
RunConfig.setRandomseed = function()
  math.randomseed(GetRunningTime())
end

-- 初始化
RunConfig.init = function()
  for i = 1, #BulletTypeList do
    local type = BulletTypeList[i]
    local index = 1
    if (RunConfig.bulletType == '') then
      -- 设置子弹类型默认值
      RunConfig.bulletType = type
    end
    for j = 1, #WeaponsRecoil[type] do
      local weaponName = WeaponsRecoil[type][j][1]
      local weaponState = WeaponsRecoil[type][j][2]
      if (weaponState ~= 0) then
        -- 代表枪械启用
        RunConfig.weaponNames[type][index] = weaponName
        RunConfig.weaponInfos[type][index] = RunConfig[weaponName]
        index = index + 1
      end
    end
  end
  RunConfig.setRandomseed()
end

-- 输出当前枪械信息
RunConfig.outputWeaponInfo = function()
  local curType = RunConfig.bulletType
  local curIndex = RunConfig.weaponIndex
  local curScope = RunConfig.currentScope
  ClearLog()
  OutputLogMessage(' -------------------------------------------------------------------------------------------- ')
  OutputLogMessage('\n')
  OutputLogMessage('| current bulletType: ' .. RunConfig.bulletType .. '         current weapon: ' ..
    RunConfig.weaponNames[curType][curIndex] .. '         current scope: ' .. curScope)
  OutputLogMessage('\n')
  OutputLogMessage(' -------------------------------------------------------------------------------------------- ')
end

-- 设置子弹类型
RunConfig.setBulletType = function(type)
  RunConfig.bulletType = type
  -- 重置枪械index
  RunConfig.weaponIndex = 1
  -- 重置倍镜
  RunConfig.currentScope = 'scopeX1'
end

-- 设置倍镜
RunConfig.setScope = function(scope)
  RunConfig.currentScope = scope
end

-- 找到枪
RunConfig.findWeapon = function(cmd)
  local realIndex = 1
  if (cmd == 'next') then
    -- 当前弹药类型下枪械循环
    local len = #RunConfig.weaponNames[RunConfig.bulletType]
    local nextIndex = (RunConfig.weaponIndex + 1) % (len + 1)
    realIndex = nextIndex == 0 and 1 or nextIndex
  elseif cmd == 'last' then
    realIndex = #RunConfig.weaponNames[RunConfig.bulletType]
  else
  end
  RunConfig.weaponIndex = realIndex
end

-- 根据指令运行相应的代码
RunConfig.runCmd = function(cmd)
  local cmdSet = {
    ['5.56'] = RunConfig.setBulletType,
    ['7.62'] = RunConfig.setBulletType,
    ['.45'] = RunConfig.setBulletType,
    ['9mm'] = RunConfig.setBulletType,
    ['scopeX1'] = RunConfig.setScope,
    ['scopeX2'] = RunConfig.setScope,
    ['scopeX3'] = RunConfig.setScope,
    ['scopeX4'] = RunConfig.setScope,
    ['scopeX6'] = RunConfig.setScope,
    ['next'] = RunConfig.findWeapon,
    ['last'] = RunConfig.findWeapon
  }
  local cmdGroup = string.split(cmd, '|')
  for i = 1, #cmdGroup do
    local _cmd = cmdGroup[i]
    if (cmdSet[_cmd]) then
      cmdSet[_cmd](_cmd)
    end
  end
end

-- 按键处理
RunConfig.modifierHandle = function(comboKey)
  local cmd = Config.G_bind[comboKey]
  if (cmd) then
    RunConfig.runCmd(cmd)
  end
  RunConfig.outputWeaponInfo()
end

-- 是否开启脚本
RunConfig.isStartScript = function()
  return IsKeyLockOn(Config.startScript)
end

-- 获取真实的y轴偏移
RunConfig.getRealY = function(crouchFactor, y)
  local realY = 0
  if (IsModifierPressed('lctrl') and IsMouseButtonPressed(3)) then
    -- 下蹲瞄准
    realY = y * RunConfig[RunConfig.currentScope] * crouchFactor
  elseif (IsMouseButtonPressed(3)) then
    realY = y * RunConfig[RunConfig.currentScope]
  end
  return math.round(realY)
end

-- 开枪
RunConfig.Shoot = function()
  local type = RunConfig.bulletType
  local index = RunConfig.weaponIndex
  repeat
    local weaponInfo = RunConfig.weaponInfos[type][index]
    local curDuration = GetRunningTime() - RunConfig.startTime
    -- 当前时间处于第几颗子弹
    local bulletIndex = math.ceil((curDuration == 0 and 1 or curDuration) / weaponInfo.interval) + 1
    if (bulletIndex > weaponInfo.amount) then
      return
    end
    RunConfig.bulletIndex = bulletIndex
    local x = 0
    local y = math.ceil(curDuration / (weaponInfo.interval * (bulletIndex - 1)) * weaponInfo.trajectoryData[bulletIndex]) -
        RunConfig.verticalOffset
    local realY = RunConfig.getRealY(weaponInfo.crouchFactor, y)
    MoveMouseRelative(x, realY)
    RunConfig.verticalOffset = RunConfig.verticalOffset + y
    Sleep(GenerateRandomNumber(RunConfig.sleepRandom[1], RunConfig.sleepRandom[2]))
  until not IsMouseButtonPressed(1)
end

EnablePrimaryMouseButtonEvents(true)
RunConfig.initTraFn()
RunConfig.init()
RunConfig.outputWeaponInfo()

function OnEvent(event, arg, family)
  -- 监听
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
    RunConfig.modifierHandle(modifier)
  end

  -- 点击鼠标左键开枪
  if (event == 'MOUSE_BUTTON_PRESSED' and arg == 1 and family == 'mouse') then
    if (not RunConfig.isStartScript() or not IsMouseButtonPressed(3)) then
      return
    end
    RunConfig.startTime = GetRunningTime()
    RunConfig.Shoot()
  end
  -- 释放鼠标左键
  if (event == 'MOUSE_BUTTON_RELEASED' and arg == 1 and family == 'mouse') then
    RunConfig.setRandomseed()
    RunConfig.bulletIndex = 1
    RunConfig.verticalOffset = 0
    RunConfig.horizontalOffset = 0
  end
  -- 脚本退出
  if event == 'PROFILE_DEACTIVATED' then
    EnablePrimaryMouseButtonEvents(false)
    ReleaseKey('lshift')
    ReleaseKey('lctrl')
    ReleaseKey('lalt')
    ReleaseKey('rshift')
    ReleaseKey('rctrl')
    ReleaseKey('ralt')
    ClearLog()
  end
end
