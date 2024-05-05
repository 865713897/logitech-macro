---@diagnostic disable: duplicate-set-field, undefined-global, param-type-mismatch

-- [[ 用户配置 ]]
Config = {
    openMacroKey = 'capslock', -- scrolllock | capslock | numlock
}

-- [[ 枪械弹道配置 ]]
GunConfig = {
    ['Beryl_M762'] = {
        interval = 86,
        bulletType = '7.62',
        trajectory = {
            { 1,  0 },
            { 2,  42 },
            { 5,  25 },
            { 10, 28 },
            { 15, 30 },
            { 30, 38 },
            { 40, 39 },
        }
    }
}

-- [[  运行时函数及部分参数模块  ]]
Runtiming = {
    delayList = { 1, 6 },                              -- 延迟范围列表
    bulletModeList = { '5.56', '7.62', '.45', '9mm' }, -- 子弹模式列表
    bulletModeIndex = 1,                               -- 当前子弹模式下标
}

-- [[  主函数体  ]]
Main = {}

-- 初始化枪械弹道
function Main.initGunTrajectory()

end

-- 生成枪械弹道数据
function Main.generateTrajectory()
    
end