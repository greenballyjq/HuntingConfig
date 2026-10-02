# HuntingConfig

《我给全家打肉吃》的配表工程。用 Luban 把 Excel 中的表定义与数据编译成 C# 代码和二进制数据，供游戏工程 [HuntingClient](https://github.com/greenballyjq/HuntingClient) 读取。

## 目录结构

| 路径 | 内容 |
|---|---|
| `Datas/` | 配表源文件。20 张数据表，外加 3 张 schema 表：`__tables__.xlsx`、`__beans__.xlsx`、`__enums__.xlsx` |
| `Defines/` | `builtin.xml`，声明 `vector2`、`vector3`、`vector4` 三个内建结构 |
| `Tools/Luban/` | Luban 4.2.1 的发行文件。只保留 C# 二进制输出所需的模板与依赖（`Templates/cs-bin`、`Templates/common/cs`） |
| `output/code/` | 生成结果：C# 代码，66 个 `.cs` |
| `output/bytes/` | 生成结果：二进制数据，每张表一个 `.bytes`，共 20 个 |
| `luban.conf` | Luban 配置：schema 文件、数据目录、导出目标与分组 |
| `gen.bat` | 生成脚本，Windows |
| `gen.sh` | 生成脚本，Linux 与 macOS |

## 环境要求

| 项 | 要求 |
|---|---|
| .NET 运行时 | `Microsoft.NETCore.App` 8.0。见 `Tools/Luban/Luban.runtimeconfig.json`（`tfm` 为 `net8.0`） |
| Luban | 已随仓库提供于 `Tools/Luban`，版本 4.2.1，无需另行安装 |
| Excel | 仅修改 `Datas/` 下的表时需要 |

## 生成

在仓库根目录执行。两个脚本内的 `CONF_ROOT` 都是 `.`，换目录执行会找不到配置。

Windows：

```
gen.bat
```

Linux、macOS：

```bash
bash gen.sh
```

两个脚本等价于：

```bash
dotnet Tools/Luban/Luban.dll -t all -c cs-bin -d bin --conf luban.conf -x outputCodeDir=output/code -x outputDataDir=output/bytes
```

参数含义（摘自 `Luban.dll --help`）：

| 参数 | 含义 |
|---|---|
| `--conf` | 配置文件路径 |
| `-t` | 导出目标名。`all` 是 `luban.conf` 中定义的三个目标之一，另有 `server` 与 `client` |
| `-c` | 代码目标，此处为 `cs-bin` |
| `-d` | 数据目标，此处为 `bin` |
| `-x` | 附加参数，此处用于指定代码与数据的输出目录 |

## 表

数据表在 `Datas/__tables__.xlsx` 中登记，源文件放在 `Datas/` 下。程序集名为 `HuntingConfig`，代码顶层模块为 `cfg`。

| 源文件 | 生成类型 | 输出文件 |
|---|---|---|
| `Global.xlsx` | `cfg.HuntingConfig.TbGlobal` | `huntingconfig_tbglobal.bytes` |
| `Bullet.xlsx` | `cfg.HuntingConfig.TbBullet` | `huntingconfig_tbbullet.bytes` |
| `Specie.xlsx` | `cfg.HuntingConfig.TbSpecie` | `huntingconfig_tbspecie.bytes` |
| `Map.xlsx` | `cfg.HuntingConfig.TbMap` | `huntingconfig_tbmap.bytes` |
| `Role.xlsx` | `cfg.HuntingConfig.TbRole` | `huntingconfig_tbrole.bytes` |
| `MeatProgress.xlsx` | `cfg.HuntingConfig.TbMeatProgress` | `huntingconfig_tbmeatprogress.bytes` |
| `EnergyProgress.xlsx` | `cfg.HuntingConfig.TbEnergyProgress` | `huntingconfig_tbenergyprogress.bytes` |
| `Quest.xlsx` | `cfg.HuntingConfig.TbQuest` | `huntingconfig_tbquest.bytes` |
| `Skill.xlsx` | `cfg.HuntingConfig.Skill.TbSkill` | `huntingconfig_skill_tbskill.bytes` |
| `Skill3KP.xlsx` | `cfg.HuntingConfig.Skill.TbSkill3KP` | `huntingconfig_skill_tbskill3kp.bytes` |
| `SkillZiWei.xlsx` | `cfg.HuntingConfig.Skill.TbSkillZiWei` | `huntingconfig_skill_tbskillziwei.bytes` |
| `SkillDaMeiLi.xlsx` | `cfg.HuntingConfig.Skill.TbSkillDaMeiLi` | `huntingconfig_skill_tbskilldameili.bytes` |
| `SkillJinZhuangYuan.xlsx` | `cfg.HuntingConfig.Skill.TbSkillJinZhuangYuan` | `huntingconfig_skill_tbskilljinzhuangyuan.bytes` |
| `SkillYaKeDong.xlsx` | `cfg.HuntingConfig.Skill.TbSkillYaKeDong` | `huntingconfig_skill_tbskillyakedong.bytes` |
| `LuckyBuff.xlsx` | `cfg.HuntingConfig.TbLuckyBuff` | `huntingconfig_tbluckybuff.bytes` |
| `LuckyGift.xlsx` | `cfg.HuntingConfig.TbLuckyGift` | `huntingconfig_tbluckygift.bytes` |
| `Prop.xlsx` | `cfg.HuntingConfig.Prop.TbProp` | `huntingconfig_prop_tbprop.bytes` |
| `PropBombardment.xlsx` | `cfg.HuntingConfig.Prop.TbPropBombardment` | `huntingconfig_prop_tbpropbombardment.bytes` |
| `PropAimAssist.xlsx` | `cfg.HuntingConfig.Prop.TbPropAimAssist` | `huntingconfig_prop_tbpropaimassist.bytes` |
| `PropTrap.xlsx` | `cfg.HuntingConfig.Prop.TbPropTrap` | `huntingconfig_prop_tbproptrap.bytes` |

输出文件名默认为 `<module>_<name>`（见 `__tables__.xlsx` 中 `output` 列的说明），本工程未逐表指定，实际文件名如上表。

## 枚举

枚举在 `Datas/__enums__.xlsx` 中定义，生成到 `output/code/HuntingConfig/Enum/`，命名空间为 `cfg.HuntingConfig.Enum`。

| 类型 | 取值 |
|---|---|
| `ERoleType` | 小蓝人、小红人、紫薇、大美丽、金状元、亚克东 |
| `EMapType` | 皇家猎场森林、海滨沙滩度假村、金状元私家花园、新疆大草原、远古雪山 |
| `ESpecieType` | 小型动物、中型动物、大型动物、弹药动物、3KP金币动物、Boss动物 |
| `EDropType` | 肉、子弹、3KP金币、丰收能量 |
| `EBulletType` | 普通子弹、爆炸子弹、高伤子弹、高速子弹 |
| `EBulletDamageRangeType` | 单体伤害、范围伤害 |
| `ESkillType` | 色块人技能、紫薇技能、大美丽技能、金状元技能、亚克东技能 |
| `ELuckyBuffType` | 更多大肉、开局丰收能量、伤害提升、高阶派发 |
| `ELuckyBuffStrengthType` | 弱档、中档、强档 |
| `ELuckyGiftType` | 初级礼包、中级礼包、高级礼包、特殊礼包 |
| `EQuestType` | 狩猎、收集、消耗 |
| `EPropType` | 炮火轰炸、指哪打哪、智能诱捕陷阱 |
| `EBossType` | 无、北极熊、猛犸象、雪猩猩、三角龙 |

## 与 HuntingClient 的关系

生成结果需要复制到游戏工程的两个目录：

| 本仓库 | HuntingClient |
|---|---|
| `output/code/` | `Assets/Scripts/GameConfig/gen/` |
| `output/bytes/` | `Assets/Resources/Bundle/Raw/Configs/bytes/` |

游戏侧由 `HuntingConfigManager` 用 Unity 的 `Resources.Load` 读取二进制数据。

## 常见问题

### Windows 提示 `'dotnet' 不是内部或外部命令`

原因：`PATH` 中没有 `dotnet`，或未安装 .NET。

解决：安装 .NET 8 运行时，然后新开一个终端。用 `dotnet --version` 确认能输出版本号。

### 提示缺少 `Microsoft.NETCore.App`

现象：

```
You must install or update .NET to run this application.
Framework: 'Microsoft.NETCore.App', version '8.0.0'
```

原因：`Tools/Luban/Luban.runtimeconfig.json` 要求 `Microsoft.NETCore.App` 8.0，本机未安装该版本。

解决：安装 .NET 8 运行时。用 `dotnet --list-runtimes` 查看已安装版本。

### 生成出错时看不到原因

原因：Luban 的日志配置在 `Tools/Luban/nlog.xml`，只有一个 `ColoredConsole` 目标，级别 `Info` 起，不写日志文件。错误只出现在执行生成的那个终端里。

解决：在命令行中执行 `gen.bat` 或 `bash gen.sh`，不要双击。

### Linux、macOS 上 `./gen.sh` 提示 Permission denied

原因：`gen.sh` 在仓库中的权限位是 `100644`，没有可执行权限。

解决：用 `bash gen.sh` 执行，或先 `chmod +x gen.sh`。

### 改了表，游戏里数值没变化

原因：生成结果只写到本仓库的 `output/`，游戏工程读的是自己目录下的副本。

解决：按"与 HuntingClient 的关系"一节复制到游戏工程的两个目录，再重新运行游戏。

### 新增了一张表，但生成结果里没有

原因：数据表需要在 `Datas/__tables__.xlsx` 中登记后才会被导出。

解决：在 `__tables__.xlsx` 中补一行，填 `full_name`、`value_type`、`input` 等列。
