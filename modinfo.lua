local lang = locale
local function translate(String)  -- use this fn can be automatically translated according to the language in the table
	String.zhr = String.zh
	String.zht = String.zht or String.zh
	return String[lang] or String.en
end

--The name of the mod displayed in the 'mods' screen.
name = translate({en = "better wanda", zh = "更强的旺达"})

--A description of the mod.
description = translate({
    en = "version v1.1.6\n1.Alarming clock can be upgraded by possessed shadow atrium,and then gain planar damage\n2.Wanda takes 10% less damage from lunar aligne,Wanda gains 5 planar defense\n3.Wanda can unlock a watch bin at the alchemy engine for storing watches and watch tools\n4.You can rename the Backtrek Watch and Rift Watch with feather pencil",
    zh = "版本 v1.1.6\n1.使用附身暗影心房升级警告表，可以让警告表获得位面伤害\n2.旺达受到月亮阵营的伤害降低10%,旺达获得5位面防御\n3.旺达可以在炼金引擎处解锁一个用于储存表和钟表工具的钟表罐\n4.可以用羽毛笔重命名溯源表和裂隙表"
})

--Who wrote this awesome mod?
author = "TUTU"

--A version number so you can ask people if they are running an old version of your mod.
version = "v1.1.6"

--This lets other players know if your mod is out of date. This typically needs to be updated every time there's a new game update.
api_version = 10

dst_compatible = true

--This lets clients know if they need to get the mod from the Steam Workshop to join the game
all_clients_require_mod = true

--This determines whether it causes a server to be marked as modded (and shows in the mod list)
client_only_mod = false

--This lets people search for servers with this mod by these tags
server_filter_tags = {}


priority = 0  --模组优先级0-10 mod 加载的顺序   0最后载入  覆盖大值

configuration_options={ --模组变量配置
	{
		name = "LANGUAGE",--modmain脚本里调用变量
		--hover = "解释",
		label = translate({en = "language", zh = "语言"}),--游戏里显示的名字
		options ={	
					{description = translate({en = "Default", zh = "默认"}), data = translate({en = "EN", zh = "CN", jp = "JP", ru = "RU", vi = "VI"})},
					{description = "English", data = "EN"},
					{description = "中文", data = "CN"},
					{description = "日本語", data = "JP"},
					{description = "русск", data = "RU"},
					{description = "Việt nam", data = "VI"},
				},
		default = translate({en = "EN", zh = "CN", jp = "JP", ru = "RU", vi = "VI"})
	},
}

mod_dependencies = {

}

icon_atlas = "Wanda.xml"
icon = "Wanda.tex"
