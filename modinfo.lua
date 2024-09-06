name = "小鸡/CustomChicken"
description = [[

一个自定义小鸡生物模块。
A custom chicken creature module.

做模组的可以看看一个简单的生物是怎么做的，相信会对你有所帮助。
自定义失效了/ Customed failed.
尽力了，能跑就行。
Be try best, run it.

]]
author = "y77"
version = "1.0.0"
api_version = 10
dst_compatible = true
dont_starve_compatible = false
reign_of_giants_compatible = false
all_clients_require_mod = true
icon_atlas = "modicon.xml"
icon = "modicon.tex"

configuration_options =
{

	{
		name = "henhouse_regions",
		label = "henhouse_regions",
		hover = "测试/选择鸡窝刷新区域",
		options =
		{
			{description = "只有蜜蜂牛群和鸭子群", data = 0},
			{description = "额外石头+恶地", data = 1},
			{description = "额外石头恶地+沼泽", data = 2},
			{description = "额外石头恶地+沼泽+森林", data = 3},
			{description = "几乎任何地方", data = 4},
		},
		default = 0,
	},

	{
		name = "henhouse_rate",
		label = "henhouse_rate",
		hover = "测试/选择鸡窝刷新速率",
		options =
		{
			{description = "超级稀有", data = 0.3},
			{description = "稀有", data = 0.6},
			{description = "默认", data = 1.5},
			{description = "比默认多一点", data = 1.8},
			{description = "很多", data = 2.0},
			{description = "超级多", data = 3.0},
		},
		default = 1.5,
	},

}