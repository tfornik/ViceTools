script_author('tfornik')

require 'lib.moonloader'
require "luairc"

local imgui = require 'imgui'
local encoding = require "encoding"
local memory = require 'memory'
local requests = require('requests')
local mem = require 'memory'
local ffi = require 'ffi'
local binderMenu = true
local as_action = require('moonloader').audiostream_state
local imguiad = require 'lib.imgui_addons'
local samp = require 'lib.samp.events'
local CPed_SetModelIndex = ffi.cast('void(__thiscall *)(void*, unsigned int)', 0x5E4880)
local inicfg = require 'inicfg'
local GK = require 'game.keys'
local targetSync = -1
local logConnect = {}
local repLog = {}
local otvLog = {}
local aloginLog = {}
local achatLog = {}
local nakazLog = {}
local adminLog = {}
local adminsList = {}
local checkadmins = false
local vkeys = require 'vkeys'
local dialogArr1 = {"Red", "MediumStateBlue", "ForestGreen", "Gold", "BlueViolet"}
local dialogStr1 = ""


lang = {
	["ю"] = ".",
	["й"] = "q",
	["ц"] = "w",
	["у"] = "e",
	["к"] = "r",
	["е"] = "t",
	["н"] = "y",
	["г"] = "u",
	["ш"] = "i",
	["щ"] = "o",
	["з"] = "p",

	["ф"] = "a",
	["ы"] = "s",
	["і"] = "s",
	["в"] = "d",
	["а"] = "f",
	["п"] = "g",
	["р"] = "h",
	["о"] = "j",
	["л"] = "k",
	["д"] = "l",

	["я"] = "z",
	["ч"] = "x",
	["с"] = "c",
	["м"] = "v",
	["и"] = "b",
	["т"] = "n",
	["ь"] = "m",

	["Ю"] = ".",
	["Й"] = "Q",
	["Ц"] = "W",
	["У"] = "E",
	["К"] = "R",
	["Е"] = "T",
	["Н"] = "Y",
	["Г"] = "U",
	["Ш"] = "I",
	["Щ"] = "O",
	["З"] = "P",

	["Ф"] = "A",
	["Ы"] = "S",
	["І"] = "S",
	["В"] = "D",
	["А"] = "F",
	["П"] = "G",
	["Р"] = "H",
	["О"] = "J",
	["Л"] = "K",
	["Д"] = "L",

	["Я"] = "Z",
	["Ч"] = "X",
	["С"] = "C",
	["М"] = "V",
	["И"] = "B",
	["Т"] = "N",
	["Ь"] = "M",
}

for _, str in ipairs(dialogArr1) do
    dialogStr1 = dialogStr1 .. str .. "\n"
end

local rkeys = require 'rkeys'

imgui.HotKey = require('imgui_addons').HotKey
local bindPath = "moonloader\\ViceTools\\Binder\\binder.ini";
local bindPathShort = "moonloader\\ViceTools\\Binder";



local bind_slot = 3 -- кол-во слотов биндера

if not doesDirectoryExist(bindPathShort) then
	createDirectory(bindPathShort)
end

if not doesFileExist(bindPath) then
	f = io.open(bindPath, 'a')
	for i=1, bind_slot do
		f:write("[".. i .."]\n")
	end
	f:write("1=")
	f:close()
end

local mainBind = inicfg.load(nil, bindPath)
local binder_window = imgui.ImBool(false)
local sw, sh = getScreenResolution()
local wmine = 700

about_bind = {}
binder_text = {}
binder_vars = {}
binder_text[1] = imgui.ImBuffer(1024) -- multiline
binder_text[2] = imgui.ImBuffer(192) -- активация команда
binder_text[3] = imgui.ImBuffer(16) -- задержка
selected_item_binder = imgui.ImInt(0)

cb_render_in_menu = imgui.ImBool(imgui.RenderInMenu)
cb_lock_player = imgui.ImBool(imgui.LockPlayer)
cb_show_cursor = imgui.ImBool(imgui.ShowCursor)

local adminText = ""
reasons = {
    [0] = 'Краш',
    [1] = '/q',
    [2] = 'Кикнут сервером'
}
notf = "moonloader\\imgui_notf.lua"
if not doesFileExist(notf) then
downloadUrlToFile("https://drive.google.com/u/0/uc?id=1caXBkGHFeatn8C5aXEHMBN943-peurDH&export=download", "moonloader\\imgui_notf.lua", "")
end
if doesFileExist(notf) then
	notify = import 'imgui_notf.lua'
end
local SE = require 'lib.samp.events'
local dlstatus = require('moonloader').download_status
local Matrix3X3 = require "matrix3x3"



local Vector3D = require "vector3d"
local fa = require 'fAwesome5'
encoding.default = 'CP1251'
u8 = encoding.UTF8
local AhelpArr = {u8("1 уровень"), u8"2 уровень", u8"3 уровень", u8"4 уровень", u8"5 уровень", u8"6 уровень", u8"7 уровень", u8"8 уровень", u8"9 уровень", u8"10 уровень", u8"11 уровень", u8"12 уровень", u8"13 уровень"}
local AhelpStr = ""


for _, str in ipairs(AhelpArr) do
    AhelpStr = AhelpStr .. str .. "\n"
end
vcd = "moonloader\\ViceTools"
vcd1 = "moonloader\\ViceTools\\image"
vcd3 = "moonloader\\ViceTools\\other"
vcd4 = "moonloader\\ViceTools\\logs"
if not doesDirectoryExist(vcd1) then
    createDirectory(vcd1)
end
if not doesDirectoryExist(vcd4) then
    createDirectory(vcd4)
end
if not doesDirectoryExist(vcd) then
	createDirectory(vcd)
	createDirectory(vcd1)

end
if not doesDirectoryExist(vcd3) then
	createDirectory(vcd3)
end
yesj = "moonloader\\ViceTools\\image\\fon.jpg"
if not doesFileExist(yesj) then
	downloadUrlToFile("https://drive.google.com/u/0/uc?id=1Lv_6DVi4JmTtNef6DA665FdkU1-1V6ol&export=download", "moonloader\\ViceTools\\image\\fon.jpg", function(id, status)
        if status == dlstatus.STATUS_ENDDOWNLOADDATA then
            thisScript():reload()
        end
    
    
    
    end)
    
end

local key = require 'vkeys'
local effil = require 'effil' -- для ассинхронных запросов
local td_Id = 1931
local url = 'https://discord.com/api/webhooks/1056311273840721940/H4PedlU3AljM6bGuUbnAnKM-8EMUGpHfY-vrXg-lPoWtemYHPXPWr870TDk7KyHpMEOE'
local url2 = 'https://discord.com/api/webhooks/1058004735208214548/zbhBuvS-u3CaDpR5hOg1fJHnxcchZ39p2lOsdCN8f49-S5M0atPeC-dMcpIz5AL8M5kg'
local url3 = 'https://discord.com/api/webhooks/1058012028415000708/8fZ56DWjlUel69aIjSnQjX3fhEEo3LN34l9bS9MWu_5ZxqpxeL7hIAbStlmdPMZ9J_oc'
local url4 = 'https://discord.com/api/webhooks/1058068614575566999/8-nXJlG3ht1VLCnJXRrf8hC6YfXaq5iMov7r_huksorn3MT4WUmUky_WhOekO4GGjSnt'
local data = {
   ['content'] = 'joined the game', -- текст (меняется через команду, так что можно оставить пустым)
   ['username'] = 'Sended from .lua script!', -- ник отправителя
	 ['password'] = '',
   ['avatar_url'] = 'https://c.tenor.com/Z9mXH7-MlcsAAAAS/sexy-black-man-thirst-trap.gif', -- ссылка на аватарку (можно убрать, будет дефолтная)
   ['tts'] = false, -- tts - text to speech - читалка сообщений (true/false)
   -- так же можно сделать еще много чего, подробнее тут: https://discord.com/developers/docs/resources/webhook
}

ffi.cdef[[
struct stKillEntry
{
	char					szKiller[25];
	char					szVictim[25];
	uint32_t				clKillerColor; // D3DCOLOR
	uint32_t				clVictimColor; // D3DCOLOR
	uint8_t					byteType;
} __attribute__ ((packed));

struct stKillInfo
{
	int						iEnabled;
	struct stKillEntry		killEntry[5];
	int 					iLongestNickLength;
  	int 					iOffsetX;
  	int 					iOffsetY;
	void			    	*pD3DFont; // ID3DXFont
	void		    		*pWeaponFont1; // ID3DXFont
	void		   	    	*pWeaponFont2; // ID3DXFont
	void					*pSprite;
	void					*pD3DDevice;
	int 					iAuxFontInited;
    void 		    		*pAuxFont1; // ID3DXFont
    void 			    	*pAuxFont2; // ID3DXFont
} __attribute__ ((packed));
]]



local tCarsName = {"Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster", "Stretch", "Manana", "Infernus",
"Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam", "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BFInjection", "Hunter",
"Premier", "Enforcer", "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Trailer", "Previon", "Coach", "Cabbie", "Stallion", "Rumpo",
"RCBandit", "Romero","Packer", "Monster", "Admiral", "Squalo", "Seasparrow", "Pizzaboy", "Tram", "Trailer", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed",
"Yankee", "Caddy", "Solair", "Berkley'sRCVan", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RCBaron", "RCRaider", "Glendale", "Oceanic", "Sanchez", "Sparrow",
"Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton", "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage",
"Dozer", "Maverick", "NewsChopper", "Rancher", "FBIRancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "BlistaCompact", "PoliceMaverick",
"Boxvillde", "Benson", "Mesa", "RCGoblin", "HotringRacerA", "HotringRacerB", "BloodringBanger", "Rancher", "SuperGT", "Elegant", "Journey", "Bike",
"MountainBike", "Beagle", "Cropduster", "Stunt", "Tanker", "Roadtrain", "Nebula", "Majestic", "Buccaneer", "Shamal", "hydra", "FCR-900", "NRG-500", "HPV1000",
"CementTruck", "TowTruck", "Fortune", "Cadrona", "FBITruck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan", "Blade", "Freight",
"Streak", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder", "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada",
"Yosemite", "Windsor", "Monster", "Monster", "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RCTiger", "Flash", "Tahoma", "Savanna", "Bandito",
"FreightFlat", "StreakCarriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30", "Huntley", "Stafford", "BF-400", "NewsVan",
"Tug", "Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club", "FreightBox", "Trailer", "Andromada", "Dodo", "RCCam", "Launch", "PoliceCar", "PoliceCar",
"PoliceCar", "PoliceRanger", "Picador", "S.W.A.T", "Alpha", "Phoenix", "GlendaleShit", "SadlerShit", "Luggage A", "Luggage B", "Stairs", "Boxville", "Tiller",
"UtilityTrailer"}
local pong = false
local vec = {1, 1}
local ball = {}
local player = {}
local bot = {}
local state = 0
local player_score = 0
local bot_score = 0

local leaderList = {}
local leaderText = ""
local helperList = {}
local helperText = ""
local game_speed = 1
local bot_brain = 1
local dif = 1
local dif_colors = {
	0xFF03fcfc, 0xFF02f563, 0xFFFFFF00, 0xFFFF0000
}
local tCarsTypeName = {"Автомобиль", "Мотоцикл", "Вертолёт", "Самолёт", "Прицеп", "Лодка", "Другое", "Поезд", "Велосипед"}
local stategma = (u8'Выключен')
local tCarsSpeed = {43, 40, 51, 30, 36, 45, 30, 41, 27, 43, 36, 61, 46, 30, 29, 53, 42, 30, 32, 41, 40, 42, 38, 27, 37,
54, 48, 45, 43, 55, 51, 36, 26, 30, 46, 0, 41, 43, 39, 46, 37, 21, 38, 35, 30, 45, 60, 35, 30, 52, 0, 53, 43, 16, 33, 43,
29, 26, 43, 37, 48, 43, 30, 29, 14, 13, 40, 39, 40, 34, 43, 30, 34, 29, 41, 48, 69, 51, 32, 38, 51, 20, 43, 34, 18, 27,
17, 47, 40, 38, 43, 41, 39, 49, 59, 49, 45, 48, 29, 34, 39, 8, 58, 59, 48, 38, 49, 46, 29, 21, 27, 40, 36, 45, 33, 39, 43,
43, 45, 75, 75, 43, 48, 41, 36, 44, 43, 41, 48, 41, 16, 19, 30, 46, 46, 43, 47, -1, -1, 27, 41, 56, 45, 41, 41, 40, 41,
39, 37, 42, 40, 43, 33, 64, 39, 43, 30, 30, 43, 49, 46, 42, 49, 39, 24, 45, 44, 49, 40, -1, -1, 25, 22, 30, 30, 43, 43, 75,
36, 43, 42, 42, 37, 23, 0, 42, 38, 45, 29, 45, 0, 0, 75, 52, 17, 32, 48, 48, 48, 44, 41, 30, 47, 47, 40, 41, 0, 0, 0, 29, 0, 0
}

local tCarsType = {1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 3, 1, 1, 1, 1, 1, 1, 1,
3, 1, 1, 1, 1, 6, 1, 1, 1, 1, 5, 1, 1, 1, 1, 1, 7, 1, 1, 1, 1, 6, 3, 2, 8, 5, 1, 6, 6, 6, 1,
1, 1, 1, 1, 4, 2, 2, 2, 7, 7, 1, 1, 2, 3, 1, 7, 6, 6, 1, 1, 4, 1, 1, 1, 1, 9, 1, 1, 6, 1,
1, 3, 3, 1, 1, 1, 1, 6, 1, 1, 1, 3, 1, 1, 1, 7, 1, 1, 1, 1, 1, 1, 1, 9, 9, 4, 4, 4, 1, 1, 1,
1, 1, 4, 4, 2, 2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 7, 1, 1, 1, 1, 8, 8, 7, 1, 1, 1, 1, 1, 1, 1,
1, 3, 1, 1, 1, 1, 4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 7, 1, 1, 1, 1, 8, 8, 7, 1, 1, 1, 1, 1, 4,
1, 1, 1, 2, 1, 1, 5, 1, 2, 1, 1, 1, 7, 5, 4, 4, 7, 6, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 5, 5, 5, 1, 5, 5
}
local adminList = {}
local quitReason = {
	"Вылет / краш",
	"Вышел из игры",
	"Кик / бан"
}

local adminOnlineOffline = {
    u8"Онлайн",
    u8"Оффлайн"
}

local fdCommandsPlayer = {
	[1] = u8'/gzcolor',
	[2] = u8'/ghetto',
	[3] = u8'/makeleader',
	[4] = u8'/offleader',
	[5] = u8'/makeadmin',
	[6] = u8'/avig',
	[7] = u8'/aunvig',
	[8] = u8'/banip',
	[9] = u8'/makehelper',
	[10] = u8'/offhelper'
}

local changedStatis = {
  [1] = u8'[1] Уровень',
	[2] = u8'[2] Законка',
	[3] = u8'[3] Маты',
	[4] = u8'[4] Скин',
	[5] = u8'[5] Убийств',
	[6] = u8'[6] Номер',
	[7] = u8'[7] Exp',
	[8] = u8'[8] Ключ',
	[9] = u8'[9] Номер бизнеса',
	[10] = u8'[10] VIP [1-3]',
	[11] = u8'[11] Работа',
	[12] = u8'[12] Аптечки',
	[13] = u8'[13] Деньги в банке',
	[14] = u8'[14] Мобильный',
	[15] = u8'[15] Деньги',
	[16] = u8'[16] Варны',
	[17] = u8'[17] Аптечки',
	[18] = u8'[18] Член орг.',
	[19] = u8'[19] Скилл бокса',
	[20] = u8'[20] Время бокса',
	[21] = u8'[21] Бокс',
	[22] = u8'[22] Кунг-фу',
	[23] = u8'[23] КикБокс',
	[24] = u8'[24] Уважение',
	[25] = u8'[25] Бег',
	[26] = u8'[26] Машина',
	[27] = u8'[27] Машина[2]',
	[28] = u8'[28] Машина[3]',
	[29] = u8'[29] Машина[4]',
	[30] = u8'[30] Машина[5]',
	[31] = u8'[31] НаркЗавис',
	[32] = u8'[32] Фрак.Скин',
	[33] = u8'[33] Муж/Жена',
	[34] = u8'[34] Процы',
	[35] = u8'[35] Время банка',
	[36] = u8'[36] Доступ к /ban',
	[37] = u8'[37] Доступ к /warn'
}

local rInfo = {
	state = false,
    id = -1,
    nickname = ''
}

Mlvl = 'check'
update_state = false
local cross = imgui.CreateTextureFromFile(getWorkingDirectory() .. "\\resource\\krestikinoliki\\krestik.png")
local zero = imgui.CreateTextureFromFile(getWorkingDirectory() .. "\\resource\\krestikinoliki\\nolik.png")
local checkleaders = false
local gamestate = 1
local Font = {}
fontsize = nil
local winner = ""
local saving = true
local nearestList = {}
local checkAd = true
local checkLead = true
local checkHelper = true
local timers = os.clock()
local timersAdmin = os.clock()
local timersLeader = os.clock()
local timersHelper = os.clock()

local huPlayer = ""
local aiPlayer = ""
cheatsSelectable = 235
local field = {
    {{cell = nil}, {cell = nil}, {cell = nil}},
    {{cell = nil}, {cell = nil}, {cell = nil}},
    {{cell = nil}, {cell = nil}, {cell = nil}}
}
 avstria = 'Австрия'
  vena = 'Вена'
 albania = 'Албания'
 tirana = "Тирана"
 andorra = 'Андорра'
 andorralavelia = 'Андорра-ла-Велья'
 belgia = 'Бельгия'
 brusel = 'Брюссель'
 belarus = 'Беларусь'
 minsk = 'Минск'
 bolgaria = 'Болгария'
 sofia = 'София'
 bosnia = 'Босния'
 saraevo = 'Сараево'
 vatikan = 'Ватикан'
 uk = 'Великобритания'
 london = 'Лондон'
 vengria = 'Венгрия'
 budapesht = 'Будапешт'
 germany = 'Германия'
 berlin = 'Берлин'
 greece = 'Греция'
 aphenes = 'Афины'
 dania = 'Дания'
 kopengagen = 'Копенгаген'
 irlandia = 'Ирландия'
 dublin = 'Дублин'
 islandia = 'Исландия'
 reikiavik = 'Рейкьявик'
 spain = 'Испания'
 madrid = 'Мадрид'
 italia = 'Италия'
 rim = 'Рим'
 kosovo = 'Косово'
 prishtina = 'Приштина'
 latvia = 'Латвия'
 riga = 'Рига'
 litva = 'Литва'
 vilnus = 'Вильнюс'
 lihtenshtein = 'Лихтенштейн'
 vaduc = 'Вадуц'
 luxemburg = 'Люксембург'
 malta = 'Мальта'
 valetta = 'Валетта'
 moldavia = 'Молдавия'
 kishinev = 'Кишинев'
 monaco = 'Монако'
 niderlandi = 'Нидерланды'
 amsterdam = 'Амстердам'
 norvegia = 'Норвегия'
 oslo = 'Осло'
 polsha = 'Польша'
 varshava = 'Варшава'
 portugalia = 'Португалия'
 lissabon = 'Лиссабон'
 rf = 'Россия'
 msk = 'Москва'
 ruminia = 'Румыния'
 buharest = 'Бухарест'
 san_marino = 'Сан-Марино'
 makedonia = 'Македония'
 skopie = 'Скопье'
 serbia = 'Сербия'
 belgrad = 'Белград'
 slovakkia = 'Словакия'
 bratislava = 'Братислава'
 slovenia = 'Словения'
 lublana = 'Любляна'
 ukraine = 'Украина'
 kiev = 'Киев'
 finlandia = 'Финляндия'
 helsinki = 'Хельсинки'
 france = 'Франция'
 paris = 'Париж'
 horvatia = 'Хорватия'
 zagreb = 'Загреб'
 chernogoria = 'Черногория'
 podgorica = 'Подгорица'
 chehia = 'Чехия'
 praga = 'Прага'
 shveicaria = 'Швейцария'
 bern = 'Берн'
 shvecia = 'Швеция'
 stokholm = 'Стокгольм'
 estonia = 'Эстония'
 tallinn = 'Таллинн'
local strana_vopros1 = ' '
local stolica_otvet = ' '
local stolica = ' '
local strana_vopros = {avstria, albania, andorra, belarus, belgia, bolgaria, bosnia, vatikan, uk, vengria, germany, greece, dania, irlandia, islandia, spain, italia, latvia, litva, lihtenshtein, luxemburg, malta, moldavia, monaco, niderlandi, norvegia, polsha, portugalia, rf, ruminia, san_marino, makedonia, serbia, slovakkia, slovenia, ukraine, finlandia, france, horvatia, chernogoria, chehia, shveicaria, shvecia, estonia}
local board = {1, 2, 3, 4, 5, 6, 7, 8, 9}
local moonloader = require 'moonloader'
local step = "X"

soft_table = {
    'WallHack',
    'AirBrake',
    'SpeedHack',
    'Infinity Ammo',
    'AutoReconnect',
    'GM car',
    'No Fall Bike',
    'AntiEject Car',
    'InWater',
    'SlapVeh',
    'InfRun'
    
}
soft = imgui.ImInt(235)
local script_vers = 1
local script_vers_text = "1.0"

local update_url = "https://raw.githubusercontent.com/tfornik/ViceTools/main/update.ini"
local update_path = getWorkingDirectory() .. "/ViceTools/other/update.ini"

local script_url = "https://github.com/tfornik/admintools/blob/main/AdminTools.luac?raw=true"
local script_path = thisScript().path

math.randomseed(os.time())
math.random(); math.random(); math.random()
game = false
local mpsetArr = {u8"{ff0000}[MP]{ffffff} Установить время ожидания игроков", u8"{ff0000}[MP]{ffffff} Объявить победителя", u8"{ff0000}[MP]{ffffff} Правила для участников(/mp_rules)", "         ",  u8"{ff0000}[1]{ffffff} Дерби ", u8"{FF0000}[2]{ffffff} Король дигла", u8"{FF0000}[3]{ffffff} Русская Рулетка", u8"ТУЛС САМ НАЧИНАЕТ МП, ЕСЛИ ВЫ НЕ ЗАНЯЛИ AAD И МП НЕ НАЖИМАТЬ!"}
local mpsetStr = ""


for _, str in ipairs(mpsetArr) do
    mpsetStr = mpsetStr .. str .. "\n"
end
local rangArr = {u8"Заявление на должность SMM-Менеджера", u8"Заявление на должность работника тех.поддержки"}
local rangStr = ""


for _, str in ipairs(rangArr) do
    rangStr = rangStr .. str .. "\n"
end
chq1 = 'check'
chq2 = 'check'
chq3 = 'check'
local questArr = {u8"Квест 'Активный' ["..chq1.."]", u8"Квест 'Работяга' ["..chq2.."]"}
local questStr = ""


for _, str in ipairs(questArr) do
    questStr = questStr .. str .. "\n"
end

local acsArr = {
u8"{FF0000}[NW]{FFFFFF} Новогодняя шапка",
u8"{FF0000}[NW]{FFFFFF} Новогодний ранец",
u8"{FF0000}[NW]{FFFFFF} Олень на плечо",
u8"{FF0000}[NW]{FFFFFF} Уши эльфа",
u8"{FF0000}[NW]{FFFFFF} Серый щит на руку",
u8"{FF0000}[NW]{FFFFFF} Респиратор",
u8"{FF0000}[NW]{FFFFFF} Кейс < Диско >",
u8"{FF0000}[SETTINGS]{FFFFFF} Снять все аксессуары"
}
local acsStr = ""


for _, str in ipairs(acsArr) do
    acsStr = acsStr .. str .. "\n"
end

local nwArr = {
u8"{FF0000}[NW]{FFFFFF} Новогодняя музыка",
"--------------------------------------------",
u8"{FF0000}[NW]{FFFFFF} Новогодние аксессуары"
}
local nwStr = ""


for _, str in ipairs(nwArr) do
    nwStr = nwStr .. str .. "\n"
end
rlower = {"а", "б", "в", "г", "д", "е", "ё", "ж", "з", "и", "й", "к", "л", "м", "н", "о", "п", "р", "с", "т", "у", "ф", "х", "ц", "ч", "ш", "щ", "ъ", "ы", "ь", "э", "ю", "я", "[", "]"}

rupper = {"А", "Б", "В", "Г", "Д", "Е", "Ё", "Ж", "З", "И", "Й", "К", "Л", "М", "Н", "О", "П", "Р", "С", "Т", "У", "Ф", "Х", "Ц", "Ч", "Ш", "Щ", "Ъ", "Ы", "Ь", "Э", "Ю", "Я"}
local vehs = {
    {'HUSTLER', 545}
}
key = {
[65] = "Ф",
[66] = "И",
[67] = "С",
[68] = "В",
[69] = "У",
[70] = "А",
[71] = "П",
[72] = "Р",
[73] = "Ш",
[74] = "О",
[75] = "Л",
[76] = "Д",
[77] = "Ь",
[78] = "Т",
[79] = "Щ",
[80] = "З",
[81] = "Й",
[82] = "К",
[83] = "Ы",
[84] = "Е",
[85] = "Г",
[86] = "М",
[87] = "Ц",
[88] = "Ч",
[89] = "Н",
[90] = "Я",
[186] = "Ж",
[188] = "Б",
[190] = "Ю",
[219] = "Х",
[221] = "Ъ",
[222] = "Э"}
local st = 'moonloader\\config\\hangman.txt'
if not doesFileExist(st) then
downloadUrlToFile("https://drive.google.com/u/0/uc?id=1x-Uj2KKIhUsuM1j18Ddg8azfpXZF7WLs&export=download", "moonloader\\config\\hangman.txt", "")
end
local arrGuns = {
	[1] = 'Fist[0]',
	[2] = 'Brass knuckles[1]',
	[3] = 'Hockey stick[2]',
	[4] = 'Club[3]',
	[5] = 'Knife[4]',
	[6] = 'Bat[5]',
	[7] = 'Shovel[6]',
	[8] = 'Cue[7]',
	[9] = 'Katana[8]',
	[10] = 'Chainsaw[9]',
	[11] = 'Dildo[10]',
	[12] = 'Dildo[11]',
	[13] = 'Dildo[12]',
	[14] = 'Dildo[13]',
	[15] = 'Bouquet[14]',
	[16] = 'Cane[15]',
	[17] = 'Grenade[16]',
	[18] = 'Gas[17]',
	[19] = 'Molotov cocktail[18]',
	[20] = 'Unknown',
	[21] = 'Unknown',
	[22] = 'Unknown',
	[23] = '9MM[22]',
	[24] = '9mm with silencer[23]',
	[25] = 'Desert Eagle[24]',
	[26] = 'Shotgun[25]',
	[27] = 'Sawed-off[26]',
	[28] = 'Fast Shotgun[27]',
	[29] = 'Uzi[28]',
	[30] = 'MP5[29]',
	[31] = 'AK-47[30]',
	[32] = 'M4[31]',
	[33] = 'Tec-9[32]',
	[34] = 'Sniper rifle[33]',
	[35] = 'Sniper rifle[34]',
	[36] = 'RPG[35]',
	[37] = 'RPG[36]',
	[38] = 'Flamethrower[37]',
	[39] = 'Minigun[38]',
	[40] = 'TNT bag[39]',
	[41] = 'Detonator[40]',
	[42] = 'Spray can[41]',
	[43] = 'Fire extinguisher[42]',
	[44] = 'Camera[43]',
	[45] = 'Thermal imager[44]',
	[46] = 'Thermal imager[45]'	,
	[47] = 'Parachute[46]'
}
sybw = {'A'}
-- imgui
checkleaders = false
checkhelpers = false
invAdmin = false
imgui = require 'imgui'
XO_window,XO_window_pos = imgui.ImBool(false),nil
Server = imgui.ImBuffer('irc.ea.libera.chat',256)
Channel = imgui.ImBuffer('',256)
msgInChat = imgui.ImBool(false)
cursorEnable = false
waitAnimText = ''

------------------
Game = false
Move = false
XO = 'X' -- X O
xo_enemy,xo_enemy_nick = 'O','nil'

A1,A2,A3	= 'nil','nil','nil'
B1,B2,B3	= 'nil','nil','nil'
C1,C2,C3	= 'nil','nil','nil'
--
ffi.cdef[[
	int MessageBoxA(void *w, const char *txt, const char *cap, int type);
	bool Beep(unsigned long Freq, unsigned long Duration);
]]

--	A1	|	A2	|	A3 	  |
--------|-----------------|
--	B1	|	B2	|	B3 	  |
--------|-----------------|
--	C1	|	C2	|	C3    |

-- IRC
Nick = 'player'


s = irc.new{nick = 'PLAYER'}
connected,connectedServer = false,0

s:hook("OnChat", function(user, channel, message)

	if msgInChat.v then
		sampAddChatMessage('[ZeroGame]: '..user.nick..':{FFFFFF}'..message,0xffff00)
	end
	if message:find('cancel game') and user.nick:find(xo_enemy_nick) and Game and XO_window.v then
		sampAddChatMessage('[ZeroGame]: '..user.nick..':{FFFFFF}'..message,0xffff00)
		Game = false
		Move = false

		A1,A2,A3	= 'nil','nil','nil'
		B1,B2,B3	= 'nil','nil','nil'
		C1,C2,C3	= 'nil','nil','nil'

		xo_enemy_nick = 'nil'

	end

	if message:find('i\'m ready!') and Game and XO_window.v and xo_enemy_nick == 'nil' then
		xo_enemy_nick = user.nick
		send('mee to! Play!')
	end
	if message:find('mee to! Play!') and Game and XO_window.v and xo_enemy_nick == 'nil' then
		xo_enemy_nick = user.nick
	end
	if message:find('start game | ') and not Game and XO_window.v then
		send('i\'m ready!')

		sampAddChatMessage('[XO|IRC]'..user.nick..':{FFFFFF}'..message,0xffff00)
		xo = message:match('start game | (%S+)')
		xo_enemy = xo

		if xo_enemy == 'X' then
			XO = "O"
		elseif xo_enemy == 'O' then
			XO = "X"
		end
		Game = true
		Move = false
	end
	if message:find('A1=%S+%.A2=%S+%.A3=%S+%.B1=%S+%.B2=%S+%.B3=%S+%.C1=%S+%.C2=%S+%.C3=%S+%.') and user.nick:find(xo_enemy_nick) then
		Move = true
		local a1,a2,a3,b1,b2,b3,c1,c2,c3 = message:match('A1=(%a+)%.A2=(%a+)%.A3=(%a+)%.B1=(%a+)%.B2=(%a+)%.B3=(%a+)%.C1=(%a+)%.C2=(%a+)%.C3=(%a+)%.')

		A1,A2,A3	= a1,a2,a3
		B1,B2,B3	= b1,b2,b3
		C1,C2,C3	= c1,c2,c3
	end
end)
-- A1=
pensTable = [[
 >> БЛОКИРОВКА ЧАТА:
Метагейминг
Капс 
Флуд 
Неадекватное поведение.
Транслит
Оффтоп
Бред в /vad, /ad, /gov, /d
Оскорбления в Non-RP чат
Оскорбления в RP чат
Оскорбление администрации
Упоминание родных
Обман администрации
Отсутствие тэга /gov /d /vad /ad
Упоминание проектов
Клевета администрации
Расизм, нацизм,оскорбление чувств верующих
Злоупотребление откатами (!) в OOC чат

 >> БЛОКИРОВКА АККАУНТА:
Вред.читы
Оскорбление родных
Реклама проектов
Обход наказания
Неадекватный, оск ник
Оскорбление проекта
РП убийство

 >> ВЫДАЧА ДЕМОРГАНА:
ДМ
ДБ
ТК
СК
ПГ
nonRP
БагоЮз
DM in ZZ
Читы(не вредящие проекту)
ДМ при слете имущества
Многократный ДМ, НонРП действия
+C вне гетто
Сбив анимки
Коп в гетто(искл.FBI,SWAT,искл.2копа)
Срыв набора
Читы во фракции
Стрельба с пассажирки(дигл)
Уход в AFK во время РП

 >> ВЫДАЧА ВАРНА:
Отказ от проверки
Читы на проверке либо хранение
Неадекватное поведение при проверке
Офф от ареста
Выход из игры во время РП

 >> БЛОКИРОВКА РЕПОРТА:
Флуд
Транслит
Оффтоп
Оскорбление администрации
Упоминание родных
Обман администрации
Упоминание проектов
Клевета администрации
]]
textdrawID = nil
stateBot = false
timesTable = [[

5 минут
5 минут (искл /bc /sms)
5 минут
10-20 минут
5 минут (искл. гетто, /b)
5 минут
10 минут
20 минут
20 минут
30 минут
60 минут
20 минут
1 пред. (при повторном /mute 10)
60 минут
30 минут
60 минут или бан на 1 день
10 минут


7 дней + banip
бан 3 дня
бан 7 дней + banip
3 дня
14 дней (/sban)
бан 7 дней + banip
3 дня бан всех участников


10 минут (искл. гетто)
10 минут
10 минут
10 минут
10 минут(искл. гетто)
15 минут (/uval при повторном)
15 минут (искл.гетто)
15 минут
60 минут
20 минут
30 минут
15 минут
15 минут
15 минут(при повторном/uval+jail20)
/spawn (при повторном /jail 15)
если 7 ранг и выше варн,если с 1-6 jail 60 мин и /uval)
15 минут
20 минут


1 варн
1 варн
1 варн - (если лидер /warn +ЧС его структуры 30 дней)
1 варн
1 варн


5 минут
5 минут
5 минут
30 минут
60 минут
20 минут
60 минут
30 минут
]]

ffi.cdef[[
	short GetKeyState(int nVirtKey);
	bool GetKeyboardLayoutNameA(char* pwszKLID);
	int GetLocaleInfoA(int Locale, int LCType, char* lpLCData, int cchData);
]]
local BuffSize = 32
local KeyboardLayoutName = ffi.new("char[?]", BuffSize)
local LocalInfo = ffi.new("char[?]", BuffSize)
chars = {
	["й"] = "q", ["ц"] = "w", ["у"] = "e", ["к"] = "r", ["е"] = "t", ["н"] = "y", ["г"] = "u", ["ш"] = "i", ["щ"] = "o", ["з"] = "p", ["х"] = "[", ["ъ"] = "]", ["ф"] = "a",
	["ы"] = "s", ["в"] = "d", ["а"] = "f", ["п"] = "g", ["р"] = "h", ["о"] = "j", ["л"] = "k", ["д"] = "l", ["ж"] = ";", ["э"] = "'", ["я"] = "z", ["ч"] = "x", ["с"] = "c", ["м"] = "v",
	["и"] = "b", ["т"] = "n", ["ь"] = "m", ["б"] = ",", ["ю"] = ".", ["Й"] = "Q", ["Ц"] = "W", ["У"] = "E", ["К"] = "R", ["Е"] = "T", ["Н"] = "Y", ["Г"] = "U", ["Ш"] = "I",
	["Щ"] = "O", ["З"] = "P", ["Х"] = "{", ["Ъ"] = "}", ["Ф"] = "A", ["Ы"] = "S", ["В"] = "D", ["А"] = "F", ["П"] = "G", ["Р"] = "H", ["О"] = "J", ["Л"] = "K", ["Д"] = "L",
	["Ж"] = ":", ["Э"] = "\"", ["Я"] = "Z", ["Ч"] = "X", ["С"] = "C", ["М"] = "V", ["И"] = "B", ["Т"] = "N", ["Ь"] = "M", ["Б"] = "<", ["Ю"] = ">"
}

local allcmd = [[1 lvl
/mlist - Список игроков с баном чата.
/jlist - Список игроков в деморгане.
/skin - Выдать себе скин.
/togphone - Выключить/Включить телефон.
/pm - Ответить на репорт игрока.
/re - Начать слежку за игроком.
/agm - Включить режим бессмертия.
/tp - Выбор точки телепортации.
/gg - Пожелать приятной игры всем игрокам.
/kk - Ссылка на Свободную Группу.
/dadm - Ссылка на сайт доната.

2 lvl
/getstats - Игровая статистика игрока.
/freeze - Заморозить игрока.
/unfreeze - Разморозить игрока.
/ptp - Тп игрока к другому игроку.
/alock - Открыть любой автомобиль на сервере.
/goto - Телепорт к игроку.
/gethere - Телепорт игрока к себе.
/sp - Заспавнить игрока.
/conect - Отключить подключения игроков.
/mute - Выдать бан чата игроку.
/rmute - Выдать бан репорта игроку.

3 lvl
/slap - Слапнуть игрока.
/warehouse - Посмотреть материалы организаций.
/forceskin - Смена скина игрока в фракции.
/mark - Установить точку телепортации.
/gotomark - Телепорт на точку телепортации.
/сlear - Снять розыск с игрока.
/fuelcars - Заправить все автомобили на сервере.
/jail - Посадить игрока в деморган.
/unjail - Выпустить игрока из деморгана.

4 lvl
/spveh - Спавн автомобилей в выбранном диапазоне.
/iwep - Посмотреть список оружия у игрока.
/kick - Кикнуть игрока.
/сс - Очистить чат.
/kickpb - Кикнуть игрока с Пейнтбола.
/mp - Всё для МП.
/mpwin - Объявить победителя МП.

5 lvl
/warnmans - Получить список игроков с игровым предупреждением.
/givegun - Выдать оружие.
/gm - Проверить игрока на ГМ.
/amembers - Список игроков в какой либо фракции.
/balance - Посмотреть баланс организаций.

6 lvl
/hp - Выдать себе HP.
/ban - Выдать Бан игроку.
/warn - Выдать игровое предупреждение игроку.
/unwarn - Снять игровое предупреждение с игрока.

7 lvl
/iban - Вечный Бан
/offban - Заблокировать игрока в оффлайне.
/offwarn - Выдать игровое предупреждение в оффлайне.
/getoffstats - Статистика игрока в оффлайне.
/getban - Проверить наличие бана у игрока.
/sethp - Выдать HP игроку.
/skick - Тихо кикнуть игрока.


]]

allcmdTwo = [[
7 lvl
/iban - Вечный Бан
/offban - Заблокировать игрока в оффлайне.
/offwarn - Выдать игровое предупреждение в оффлайне.
/getoffstats - Статистика игрока в оффлайне.
/getban - Проверить наличие бана у игрока.
/sethp - Выдать HP игроку.
/skick - Тихо кикнуть игрока.

8 lvl
/getschet - Проверить баланс дома.
/veh - Создать Автомобиль.
/delveh - Удалить созданный автомобиль.
/afly - Читы для полёта.

9 lvl
/offgoto - Запретить телепортацию к вам.
/biz - Тп к бизнесу.
/house - ТП к дому.
/banip - Заблокировать ip игрока.
/getpick - Узнать результаты выборов.
/agl - Выдать комплект лицензий игроку.
/getbanip - Проверить наличие бана ip.
/o - Общий чат.

10 lvl
/setmats - Пополнить материал фракции.
/sdan - Тихий Бан.
/uval - Уволить игрока.
/chatsms - Читать смс игроков.
/agiverank - Повысить игрока в фракции.
/chat - Видеть все диалоги на сервере.
/givemedcard - Выдать мед карту.
/setbizmafia - Передать бизнес другой Мафии.
/aad - Общий чат.

11 lvl
/money - Выдать вирты игроку на банковский счёт.
/setskin - Выдать скин игроку.
/setbizprod - Пополнить материалы бизнеса.
/ahelpers - Список хелперов.
/hcheck - Количество ответов хелпера.

12 lvl
/givedonate - Выдать донат монеты игроку.
/election - Начать выборы.
/startpb - Запустить пейнтбол
/startrace - Запустить гонки.
/startbase - Запустить Бейсджампингу.]]
local scfg = inicfg.load({
    deutchland = {
        fontColor = 0xFFFFFFFF,
        snakeColor = 0xFF1E90FF,
        deadSnakeColor = 0xFF0000CD,
        bgColor = 0xC8000000,
        ceilColor = 0xFF696969,
        appleColor = 0xFFFF0000,
        wallColor = 0xFFC0C0C0,
        speed = 0.5,
        fieldSize = 12,
        hasWalls = false
    },
    data = {
        record = 0
    }
}, 'snake.ini')

-- РџРѕР»СѓС‡Р°РµРј СЂР°Р·СЂРµС€РµРЅРёРµ СЌРєСЂР°РЅР° Рё РЅР°С…РѕРґРёРј СЂР°Р·РјРµСЂ Рё РїРѕР·РёС†РёСЋ РѕРєРЅР° РёРіСЂС‹
local resX, resY = getScreenResolution()
local winSize = resY / 2
local winX = (resX - winSize) / 2
local winY = (resY - winSize) / 2
local fieldOffset = winSize * 0.15                      -- РћС‚СЃС‚СѓРї РґР»СЏ РїРѕР»СЏ
local ceilSize = winSize * 0.7 / scfg.deutchland.fieldSize   -- Р Р°Р·РјРµСЂ РѕРґРЅРѕР№ РєР»РµС‚РєРё
 ceilOffset = ceilSize * 0.1                       -- РћС‚СЃС‚СѓРї РґР»СЏ РєР»РµС‚РєРё
 realCeilSize = ceilSize * 0.8                     -- Р РµР°Р»СЊРЅС‹Р№ СЂР°Р·РјРµСЂ РєР»РµС‚РєРё
 padding = resX * 0.01                             -- РћС‚СЃС‚СѓРї РґР»СЏ С‚РµРєСЃС‚Р°

-- РЎРѕСЃС‚РѕСЏРЅРёРµ РёРіСЂС‹
isActivated = false
isStarted = false
 score = 0             -- РўРµРєСѓС‰РёР№ СЃС‡РµС‚
 lastUpdate = 0.0      -- Р’СЂРµРјСЏ РїСЂРѕС€Р»РѕРіРѕ РєР°РґСЂР°
 timeDelta = 0.0       -- Р Р°Р·РЅРёС†Р° РјРµР¶РґСѓ РїСЂРµРґС‹РґСѓС‰РёРј РєР°РґСЂРѕРј Рё С‚РµРєСѓС‰РёРј(СЃРµРєСѓРЅРґС‹)

-- РЁСЂРёС„С‚ РёРіСЂС‹
local fontSize = resY * 0.02
local font = renderCreateFont('Arial', fontSize, moonloader.font_flag.BOLD)

local snake = {}        -- РњР°СЃСЃРёРІ РІСЃРµС… РєР»РµС‚РѕРє Р·РјРµРё
local apple = {}        -- РљРѕРѕСЂРґРёРЅР°С‚Р° СЏР±Р»РѕРєР°
local moveSide = 0      -- РЎС‚РѕСЂРѕРЅР°, РІ РєРѕС‚РѕСЂСѓСЋ РґРІРёР¶РµС‚СЃСЏ Р·РјРµР№РєР°(0 - РІРІРµСЂС…, 1 - РІРїСЂР°РІРѕ, 2 - РІРЅРёР·, 3 - РІР»РµРІРѕ)
local nextMoveSide = 0  -- РЎС‚РѕСЂРѕРЅР° РґРІРёР¶РµРЅРёСЏ Р·РјРµР№РєРё РїСЂРё СЃР»РµРґСѓСЋС‰РµРј РѕР±РЅРѕРІР»РµРЅРёРё
 timer = 0.0       -- РўР°Р№РјРµСЂ РёРі
 tempLeaders = {
    [1] = u8'Полиция ЛС',
    [2] = u8'ФБР',
    [3] = u8'Армия Авианосец',
    [4] = u8'МЧС SF',
    [5] = u8'ЛКН',
    [6] = u8'Якудза',
    [7] = u8'Мэрия',
    [8] = u8'Недоступно',
    [9] = u8'Недоступно',
    [10] = u8'Полиция СФ',
    [11] = u8'Инструкторы',
    [12] = u8'Баллас',
    [13] = u8'Вагос',
    [14] = u8'Русская мафия',
    [15] = u8'Грув Стрит',
    [16] = u8'LS News',
    [17] = u8'Ацтеки',
    [18] = u8'Рифа',
    [19] = u8'Зона 51',
    [20] = u8'LV News',
    [21] = u8'Полиция LV',
    [22] = u8'Больница',
    [23] = u8'Хитманы',
    [24] = u8'Street Racer',
    [25] = u8'Сват',
    [26] = u8'АП',
    [27] = u8'Казино',
    [28] = u8'Казино'
}




local allForms = {"kick", "mute", "jail", "unjail", "ban", "warn", "skick", "unban", "unwarn", "banip", "offban", "offwarn", "sban", 'iban', 'rmute', 'sp', 'spawn', 'ptp', 'money', 'setskin', 'sethp', 'makehelper', 'sethelper', 'uval'}

local directory = getWorkingDirectory()..'\\config\\PlayersChecker.json'

if doesFileExist(directory) then
    local f = io.open(directory, "r")
    if f then
      playersList = decodeJson(f:read("a*"))
      f:close()
    end
else
    playersList = {
      [1] = 'I_Tfornik'
    }
end

local allCarsP = {
    ["487"] = "Maverick",
    ["411"] = "Infernus",
    ["560"] = "Sultan",
    ["522"] = "NRG",
    ["601"] = "SWAT",
    ["415"] = "Cheetah",
    ["451"] = "Turismo",
    ["510"] = "BMX"
}

local allGunsP = {
    ["24"] = "Desert Eagle",
    ["31"] = "M4",
    ["46"] = "Парашют",
    ["25"] = "Дробовик"
}

function deepcopy(orig)
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
  end

  filename_settings = getWorkingDirectory().."\\config\\hotKeys.txt"

  local Luacfg = {
      _version = "9"
  }
  setmetatable(Luacfg, {
      __call = function(self)
          return self.__init()
      end
  })
  function Luacfg.__init()
      local self = {}
      local lfs = require "lfs"
      local inspect = require "inspect"


      function self.mkpath(filename)
          local sep, pStr = package.config:sub(1, 1), ""
          local path = filename:match("(.+"..sep..").+$") or filename
          for dir in path:gmatch("[^" .. sep .. "]+") do
              pStr = pStr .. dir .. sep
              lfs.mkdir(pStr)
          end
      end


      function self.load(filename, tbl)
          local file = io.open(filename, "r")
          if file then
              local text = file:read("*all")
              file:close()

              local lua_code = loadstring("return "..text)
              if lua_code then
                  loaded_tbl = lua_code()

                  if type(loaded_tbl) == "table" then
                      for key, value in pairs(loaded_tbl) do
                          tbl[key] = value
                      end
                      return true
                  else
                      return false
                  end
              else
                  return false
              end
          else
              return false
          end
    end

      function self.save(filename, tbl)
          self.mkpath(filename)

          local file = io.open(filename, "w+")
          if file then
              file:write(inspect(tbl))
              file:close()
              return true
          else
              return false
          end
      end

    return self
end



local lastVisibleWorld = 0
local iniFile = "AdminTools.ini"

local HLcfg = inicfg.load({
    config = {
        airBrake = true,
        autoLang = false,
        fastHelp = true,
        stateWeather = false,
        lengthJump = 3,
        weather = 0,
        stateAdmin = false,
        stateTime = false,
        time = 0,
        speedHack = true,
        statetempskin = false,
        wallhack = false,
        informerFon = false,
        airStandart = true,
        reconTitleBar = true, 
        posX_Inf = 1695,
        tempSkin = 155,
        clickWarpPeople = true,
        posY_Inf = 510,
        informer = 1,
        stateLang = true,
        updateRkeys = false,
        bindWallHack = ('[18,50]'),
        bindAutoReport = ('[18,49]'),
        bindMenu = ('[18,51]'),
        bindChatBubble = ('[98]'),
        bindAirBrake = ('[96]'),
        bindTrueCommand = ('[75]'),
        bindFalseCommand = ('[80]'),
        vCar = false,
        bindCar = ('[66]'),
        infinityRun = true,
       
        clickWarp = true,
        inWater = false,
        gmCar = true,
        noBike = true,
        Achatcmd = "/achat",
        Atoolscmd = "/atools",
        keysyncer = true,
        keysyncerFon = false,
        Aavtorepcmd = "/ot", 
        autoCome = false,
        showKillerId = true,
        renderInfoCars = true,
				adminlvl = 0,
        bulletTracer = true,
				tname = 'User',
        leaveChecker = false,
        statistics = true,
        formsEnabled = true,
	
        fullDSuccesfuly = false,
				
			
				autorep = false,
				
        enableAutoReport = false,
			
				autouv = false,
        showMyBullets = true,
        invAdmin = false,
        enableCheckerPlayer = false,
        showAdminPassword = true,
        posX_H = 1500,
        posY_H = 500,
        antiEjectCar = false,
        areportclick = false,
        autoReconnect = true,
        cbEndMy = true,
        cbEnd = true,
        posX_L = 1000,
        posY_L = 500,
		kr1 = 0,
		kvest_rabota1 = false,
        infAmmo = false,
        printDvall = true,
        posX_M = 500,
        posY_M = 500,
        printSpawnCars = true,
        borderToFont = true,
        secondToCloseTwo = 5,
        timeOutForma = 10,
        intImGui = 0,
        widthRenderLineOne = 1,
        widthRenderLineTwo = 1,
        speed_airbrake = 1,
        intInfoCars = 30,
        sizeBuffer = 10,
        dayReports = 0,
        dayForms = 0,
        intGunCreate = 0,
        posX = 1000,
        posY = 800,
		
        posX1 = 1263,
        posY1 = 963, 
		
        posX_D = 904,
        posY_D = 1017,
				posXIn = 552,
        posYIn = 230,
				coloraa = ('0xFF0000'),
        limitPageSize = 13,
        posBubbleX = 10,
        posBubbleY = 250,
        posCheckerX = 500,
        posCheckerY = 500,
				posCheckerX1 = 500,
        posCheckerY1 = 500,
        maxPagesBubble = 500,
        secondToClose = 5,
        sizeOffPolygon = 1,
        sizeOffPolygonTwo = 1,
        polygonNumber = 1,
        infFon = 100,
        prozFon = 100,
        polygonNumberTwo = 1,
        rotationPolygonOne = 10,
        rotationPolygonTwo = 10,
        maxMyLines = 50,
        maxNotMyLines = 50,
        carColor1 = 0,
        carColor2 = 0,
        intComboCar = 0,
        numberGunCreate = 0,
        staticObjectMy = 2905604013,
        dinamicObjectMy = 9013962961,
        classicColor = 1397772781,
        pedPMy = 1862972872,
        carPMy = 6282572962,
        staticObject = 2905604013,
        dinamicObject = 9013962961,
        buttonColor = 1029151981,
     
        pedP = 1862972872,
        carP = 6282572962,
        adminPassword = "",
        fullDPassword = "",
        textFindAutoReport = "",
				textFindAutoReport2 = "",
				textFindAutoReport3 = "",
				textFindAutoReport4 = "",
				textFindAutoReport5 = "",
        answerAutoReport = "",
				answerAutoReport2 = "",
				answerAutoReport3 = "",
				answerAutoReport4 = "",
				answerAutoReport5 = "",

				nick1 = ("Свободно"),
				nick2 = ("Свободно"),
				nick3 = ("Свободно"),
				nick3 = ("Свободно"),
				nick4 = ("Свободно"),
				nick5 = ("Свободно"),
				nick6 = ("Свободно"),
				nick7 = ("Свободно"),
				nick8 = ("Свободно"),
				nick9 = ("Свободно"),
				nick10 = ("Свободно"),
    },
    statAdmin = {
        showId = true,
        showLVL = true, 
        showPing = false,
        showHealth = true,
        showFormDay = false,
        showFormSession = false,
				showInvis = true,
				showGM = true,
        showReportDay = false,
        showReportSession = false,
        showOnlineDay = true,
        showOnlineSession = true,
        showAfkDay = true,
        showAfkSession = true,
        showTime = true,
        centerText = true,
        showTopDate = true,
        showInterior = true,
        nameStatis = true
    },
    onDay = {
		today = os.date("%a"),
		online = 0,
		afk = 0,
		full = 0
	},
    chatSettings = {
        prefix = true,
        message = true,
        time = true,
        showId = false, 
    },
    monitoring = {
        leaders = false,
        admins = true,
        helpers = false,
        timeLeaders = '50',
        timeAdmins = '20',
        timeHelpers = '30',
    }
}, iniFile)
if not doesFileExist('moonloader/config/'..iniFile) then inicfg.save(HLcfg, iniFile) end


local tLastKeys = {} -- тут будут храниться предыдущие хоткеи при переактивации

local ActiveWallHack = {
		v = decodeJson(HLcfg.config.bindWallHack)
	}
local ActiveAutoReport = {
    v = decodeJson(HLcfg.config.bindAutoReport)
}
local ActiveMenu = {
    v = decodeJson(HLcfg.config.bindMenu)
}
local ActiveChatBubble = {
    v = decodeJson(HLcfg.config.bindChatBubble)
}
local ActiveAirBrake = {
    v = decodeJson(HLcfg.config.bindAirBrake)
}
local ActiveCar = {
    v = decodeJson(HLcfg.config.bindCar)
}
local ActiveFalse = {
    v = decodeJson(HLcfg.config.bindFalseCommand)
}
local ActiveTrue = {
    v = decodeJson(HLcfg.config.bindTrueCommand)
}


local gotoPlayer = false
local elements = {
    checkbox = {
        enableCheckerPlayer = imgui.ImBool(HLcfg.config.enableCheckerPlayer),
        formsEnabled = imgui.ImBool(HLcfg.config.formsEnabled),
        airBrake = imgui.ImBool(HLcfg.config.airBrake),
        speedHack = imgui.ImBool(HLcfg.config.speedHack),
        clickWarp = imgui.ImBool(HLcfg.config.clickWarp),
        stateAdmin = imgui.ImBool(HLcfg.config.stateAdmin),
        autoLang = imgui.ImBool(HLcfg.config.autoLang),
        gmCar = imgui.ImBool(HLcfg.config.gmCar),
        noBike = imgui.ImBool(HLcfg.config.noBike),
        autoCome = imgui.ImBool(HLcfg.config.autoCome),
        wallhack = imgui.ImBool(HLcfg.config.wallhack),
        showKillerId = imgui.ImBool(HLcfg.config.showKillerId),
        renderInfoCars = imgui.ImBool(HLcfg.config.renderInfoCars),
        leaveChecker = imgui.ImBool(HLcfg.config.leaveChecker),
       
        stateWeather = imgui.ImBool(HLcfg.config.stateWeather),
        stateTime = imgui.ImBool(HLcfg.config.stateTime),
        statistics = imgui.ImBool(HLcfg.config.statistics),
        bulletTracer = imgui.ImBool(HLcfg.config.bulletTracer),
        infinityRun = imgui.ImBool(HLcfg.config.infinityRun),
        vCar = imgui.ImBool(HLcfg.config.vCar),
        fullDSuccesfuly = imgui.ImBool(HLcfg.config.fullDSuccesfuly),
        clickWarpPeople = imgui.ImBool(HLcfg.config.clickWarpPeople),
        airStandart = imgui.ImBool(HLcfg.config.airStandart),
        enableAutoReport = imgui.ImBool(HLcfg.config.enableAutoReport),
        stateLang = imgui.ImBool(HLcfg.config.stateLang),
        showMyBullets = imgui.ImBool(HLcfg.config.showMyBullets),
        fastHelp = imgui.ImBool(HLcfg.config.fastHelp),
        inWater = imgui.ImBool(HLcfg.config.inWater),
        showAdminPassword = imgui.ImBool(HLcfg.config.showAdminPassword),
        statetempskin = imgui.ImBool(HLcfg.config.statetempskin),
        antiEjectCar = imgui.ImBool(HLcfg.config.antiEjectCar),
        informerFon = imgui.ImBool(HLcfg.config.informerFon),
        areportclick = imgui.ImBool(HLcfg.config.areportclick),
        autoReconnect = imgui.ImBool(HLcfg.config.autoReconnect),
        cbEndMy = imgui.ImBool(HLcfg.config.cbEndMy),
        cbEnd = imgui.ImBool(HLcfg.config.cbEnd),
        infAmmo = imgui.ImBool(HLcfg.config.infAmmo),
        reconTitleBar = imgui.ImBool(HLcfg.config.reconTitleBar),
        printDvall = imgui.ImBool(HLcfg.config.printDvall),
        printSpawnCars = imgui.ImBool(HLcfg.config.printSpawnCars),
        borderToFont = imgui.ImBool(HLcfg.config.borderToFont),
				autouv = imgui.ImBool(HLcfg.config.autouv),
				autorep = imgui.ImBool(HLcfg.config.autorep),
                keysyncer = imgui.ImBool(HLcfg.config.keysyncer),
                keysyncerFon = imgui.ImBool(HLcfg.config.keysyncerFon),


    },
    int = {
        intImGui = imgui.ImInt(HLcfg.config.intImGui),
        intInfoCars = imgui.ImInt(HLcfg.config.intInfoCars),
        sizeBuffer = imgui.ImInt(HLcfg.config.sizeBuffer),
        timeOutForma = imgui.ImInt(HLcfg.config.timeOutForma),
        limitPageSize = imgui.ImInt(HLcfg.config.limitPageSize),
        infFon = imgui.ImInt(HLcfg.config.infFon),
        prozFon = imgui.ImInt(HLcfg.config.prozFon),
        maxPagesBubble = imgui.ImInt(HLcfg.config.maxPagesBubble),
        informer = imgui.ImInt(HLcfg.config.informer),
        secondToClose = imgui.ImInt(HLcfg.config.secondToClose),
        tempSkin = imgui.ImInt(HLcfg.config.tempSkin),
        lengthJump = imgui.ImInt(HLcfg.config.lengthJump),
        secondToCloseTwo = imgui.ImInt(HLcfg.config.secondToCloseTwo),
        time = imgui.ImInt(HLcfg.config.time),
        weather = imgui.ImInt(HLcfg.config.weather),
        widthRenderLineOne = imgui.ImInt(HLcfg.config.widthRenderLineOne),
        widthRenderLineTwo = imgui.ImInt(HLcfg.config.widthRenderLineTwo),
        sizeOffPolygon = imgui.ImInt(HLcfg.config.sizeOffPolygon),
        sizeOffPolygonTwo = imgui.ImInt(HLcfg.config.sizeOffPolygonTwo),
        polygonNumber = imgui.ImInt(HLcfg.config.polygonNumber),
        polygonNumberTwo = imgui.ImInt(HLcfg.config.polygonNumberTwo),
        rotationPolygonOne = imgui.ImInt(HLcfg.config.rotationPolygonOne),
        rotationPolygonTwo = imgui.ImInt(HLcfg.config.rotationPolygonTwo),
        maxMyLines = imgui.ImInt(HLcfg.config.maxMyLines),
        maxNotMyLines = imgui.ImInt(HLcfg.config.maxNotMyLines)
    },
    input = {
        adminPassword = imgui.ImBuffer(tostring(HLcfg.config.adminPassword), 50),
        fullDPassword = imgui.ImBuffer(tostring(HLcfg.config.fullDPassword), 7),
        textFindAutoReport = imgui.ImBuffer(tostring(HLcfg.config.textFindAutoReport), 256),
				textFindAutoReport2 = imgui.ImBuffer(tostring(HLcfg.config.textFindAutoReport2), 256),
				textFindAutoReport3 = imgui.ImBuffer(tostring(HLcfg.config.textFindAutoReport3), 256),
				textFindAutoReport4 = imgui.ImBuffer(tostring(HLcfg.config.textFindAutoReport4), 256),
				textFindAutoReport5 = imgui.ImBuffer(tostring(HLcfg.config.textFindAutoReport5), 256),
        answerAutoReport = imgui.ImBuffer(tostring(HLcfg.config.answerAutoReport), 256),
				answerAutoReport2 = imgui.ImBuffer(tostring(HLcfg.config.answerAutoReport2), 256),
				answerAutoReport3 = imgui.ImBuffer(tostring(HLcfg.config.answerAutoReport3), 256),
				answerAutoReport4 = imgui.ImBuffer(tostring(HLcfg.config.answerAutoReport4), 256),
				answerAutoReport5 = imgui.ImBuffer(tostring(HLcfg.config.answerAutoReport5), 256),
                Achatcmd = imgui.ImBuffer(tostring(HLcfg.config.Achatcmd), 256),
                Atoolscmd = imgui.ImBuffer(tostring(HLcfg.config.Atoolscmd), 256),
                Aavtorepcmd = imgui.ImBuffer(tostring(HLcfg.config.Aavtorepcmd), 256)
    },
    putStatis = {
        nameStatis = imgui.ImBool(HLcfg.statAdmin.nameStatis),
        showId = imgui.ImBool(HLcfg.statAdmin.showId),
        showLVL = imgui.ImBool(HLcfg.statAdmin.showLVL),
        showPing = imgui.ImBool(HLcfg.statAdmin.showPing),
        showHealth = imgui.ImBool(HLcfg.statAdmin.showHealth),
        showFormDay = imgui.ImBool(HLcfg.statAdmin.showFormDay),
        showFormSession = imgui.ImBool(HLcfg.statAdmin.showFormSession),
				showInvis = imgui.ImBool(HLcfg.statAdmin.showInvis),
				showGM = imgui.ImBool(HLcfg.statAdmin.showGM),
        showReportDay = imgui.ImBool(HLcfg.statAdmin.showReportDay),
        showReportSession = imgui.ImBool(HLcfg.statAdmin.showReportSession),
        showOnlineDay = imgui.ImBool(HLcfg.statAdmin.showOnlineDay),
        showOnlineSession = imgui.ImBool(HLcfg.statAdmin.showOnlineSession),
        showAfkDay = imgui.ImBool(HLcfg.statAdmin.showAfkDay),
        showAfkSession = imgui.ImBool(HLcfg.statAdmin.showAfkSession),
        showTime = imgui.ImBool(HLcfg.statAdmin.showTime),
        centerText = imgui.ImBool(HLcfg.statAdmin.centerText),
        showTopDate = imgui.ImBool(HLcfg.statAdmin.showTopDate),
        showInterior = imgui.ImBool(HLcfg.statAdmin.showInterior)
    },
    chatSettings = {
        prefix = imgui.ImBool(HLcfg.chatSettings.prefix),
        message = imgui.ImBool(HLcfg.chatSettings.message),
        time = imgui.ImBool(HLcfg.chatSettings.time),
        showId = imgui.ImBool(HLcfg.chatSettings.showId)
    },
    monitoring = {
        leaders = imgui.ImBool(HLcfg.monitoring.leaders),
        admins = imgui.ImBool(HLcfg.monitoring.admins),
        helpers = imgui.ImBool(HLcfg.monitoring.helpers),
        timeLeaders = imgui.ImBuffer(tostring(HLcfg.monitoring.timeLeaders), 256),
        timeAdmins = imgui.ImBuffer(tostring(HLcfg.monitoring.timeAdmins), 256),
        timeHelpers = imgui.ImBuffer(tostring(HLcfg.monitoring.timeHelpers), 256),
    }
}

local ex, ey = getScreenResolution()
local ToScreen = convertGameScreenCoordsToWindowScreenCoords
local font_flag = require('moonloader').font_flag
if elements.checkbox.borderToFont.v then
    font = renderCreateFont("Arial", elements.int.sizeBuffer.v, font_flag.BOLD + font_flag.SHADOW + font_flag.BORDER)
else
    font = renderCreateFont("Arial", elements.int.sizeBuffer.v, font_flag.BOLD + font_flag.SHADOW)
end

 nowTime = os.date("%H:%M:%S", os.time())
 dayFull = imgui.ImInt(HLcfg.onDay.full)
 AdminTools = imgui.ImBool(false)
 AutoUpdate = imgui.ImBool(false)
 Log = imgui.ImBool(false)
 admin = imgui.ImBool(false)
 leaders = imgui.ImBool(false)
 helpers = imgui.ImBool(false)
 achat = imgui.ImBool(false)
 keywindow = imgui.ImBool(false)
 krest = imgui.ImBool(false)
 achat_buffer = imgui.ImBuffer(1000000)
 otv_buffer = imgui.ImBuffer(1000000)
 nakaz_buffer = imgui.ImBuffer(1000000)
 otv_buffer = imgui.ImBuffer(1000000)
 admin_buffer = imgui.ImBuffer(1000000)
 rep_buffer = imgui.ImBuffer(1000000)
 alogin_buffer = imgui.ImBuffer(1000000)
 connect_buffer = imgui.ImBuffer(1000000)


local tableOfNew = {
    tableRes = imgui.ImBool(false),
		FullPak = imgui.ImBool(false),
		HelperRules = imgui.ImBool(false),
    tempLeader = imgui.ImBool(false),
    AutoReport = imgui.ImBool(false),
    commandsAdmins = imgui.ImBool(false),
		commandAdmins = imgui.ImBool(false),
    addInBuffer = imgui.ImBuffer(128),
    carColor1 = imgui.ImInt(HLcfg.config.carColor1),
    carColor2 = imgui.ImInt(HLcfg.config.carColor2),
    givehp = imgui.ImInt(100),
    sms_buffer = imgui.ImBuffer(256), 
    selectGun = imgui.ImInt(0),
    numberGunCreate = imgui.ImInt(HLcfg.config.numberGunCreate),
    intComboCar = imgui.ImInt(HLcfg.config.intComboCar),
    findText = imgui.ImBuffer(256),
    intChangedStatis = imgui.ImInt(0),
    inputIntChangedStatis = imgui.ImBuffer(10),
    answer_report = imgui.ImBuffer(526),
    inputAmmoBullets = imgui.ImBuffer(5),
    fdOnlinePlayer = imgui.ImInt(0),
    inputAdminId = imgui.ImBuffer(4)
}

-- int
local sessionOnline = imgui.ImInt(0)
local sessionAfk = imgui.ImInt(0)
local sessionFull = imgui.ImInt(0)
local numberAmmo = imgui.ImInt(999)
local fdGiveCommand = imgui.ImInt(0)
--int
--buffer
local inputAdminNick = imgui.ImBuffer(50)
local inputIdChangedStatis = imgui.ImBuffer(4)
--buffer


 LsessionForma = 0
 LsessionReport = 0
 menuSelect = 0
 stColor = 0xFFFF0000
 active_forma = false
 allNotTrueBool = false
 stop_forma = false
 changePosition = false
 changePosition1 = false
 changePositionD = false
 changePositionIn = false
 changePositionM = false
 changePosiitonInf = false
 changePositionL = false
 changePositionH = false
 boolEnabled = false
 ainvisible = false
 pageState = false


 wh = false
 checkerCoords = false
 checkerCoords1 = false
local infoCar = {
    pcar = {
        idLastCar = -1
    }
}
local playersNotCheck = {}
local reports = {
    [0] = {
        nickname = '',
        id = -1,
        textP = ''
    }
}
 addBuffer = {}
 addBox    = {}
 addDelay  = {}
 tLastKeys = {}
 answer_flets = {}
local nickReport, idReport, otherReport = "", "", ""

local blacklist = {
	'SMS',
    'AFK',
    'На паузе:'
}

local fa_font = nil
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })
function imgui.BeforeDrawFrame()
    if fa_font == nil then
        local font_config = imgui.ImFontConfig()
        font_config.MergeMode = true

        fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fa-solid-900.ttf', 15.0, font_config, fa_glyph_ranges)
    end
    
    if fontsize == nil then
        fontsize = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 30.0, nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic()) -- вместо 30 любой нужный размер
    end
    if fontsizeForText == nil then
        fontsizeForText = imgui.GetIO().Fonts:AddFontFromFileTTF(getFolderPath(0x14) .. '\\trebucbd.ttf', 20.0, nil, imgui.GetIO().Fonts:GetGlyphRangesCyrillic()) -- вместо 30 любой нужный размер
    end
    if minifont == nil then
        local font_path = getFolderPath(0x14) .. '\\trebucbd.ttf'
        assert(doesFileExist(font_path), 'WTF: Font "' .. font_path .. '" doesn\'t exist')
        imgui.SwitchContext()
        local builder = imgui.ImFontAtlasGlyphRangesBuilder()
        builder:AddRanges(imgui.GetIO().Fonts:GetGlyphRangesCyrillic())
        builder:AddText(u8'‚„…†‡€‰‹‘’“”•–—™›№')
        glyph_ranges = builder:BuildRanges() --  сделай глобальным, чтобы сборщик мусора его не почистил, документация имгуи требует этого
        minifont = imgui.GetIO().Fonts:AddFontFromFileTTF(font_path, 15.0, nil, glyph_ranges)
           

        
    end
end

local bulletSyncMy = {lastId = 0, maxLines = elements.int.maxMyLines.v}
for i = 1, bulletSyncMy.maxLines do
    bulletSyncMy[i] = { my = {time = 0, t = {x,y,z}, o = {x,y,z}, type = 0, color = 0}}
end

local bulletSync = {lastId = 0, maxLines = elements.int.maxNotMyLines.v}
for i = 1, bulletSync.maxLines do
    bulletSync[i] = {other = {time = 0, t = {x,y,z}, o = {x,y,z}, type = 0, color = 0}}
end

function explode_argb(argb)
    local a = bit.band(bit.rshift(argb, 24), 0xFF)
    local r = bit.band(bit.rshift(argb, 16), 0xFF)
    local g = bit.band(bit.rshift(argb, 8), 0xFF)
    local b = bit.band(argb, 0xFF)
    return a, r, g, b
end

 staticObject = imgui.ImFloat4( imgui.ImColor( explode_argb(HLcfg.config.staticObject) ):GetFloat4() )
 dinamicObject = imgui.ImFloat4( imgui.ImColor( explode_argb(HLcfg.config.dinamicObject) ):GetFloat4() )
 pedP = imgui.ImFloat4( imgui.ImColor( explode_argb(HLcfg.config.pedP) ):GetFloat4() )
 carP = imgui.ImFloat4( imgui.ImColor( explode_argb(HLcfg.config.carP) ):GetFloat4() )
 staticObjectMy = imgui.ImFloat4( imgui.ImColor( explode_argb(HLcfg.config.staticObjectMy) ):GetFloat4() )
 dinamicObjectMy = imgui.ImFloat4( imgui.ImColor( explode_argb(HLcfg.config.dinamicObjectMy) ):GetFloat4() )
 classicColor = imgui.ImFloat4( imgui.ImColor( explode_argb(HLcfg.config.classicColor) ):GetFloat4() )
 buttonColor = imgui.ImFloat4( imgui.ImColor( explode_argb(HLcfg.config.buttonColor) ):GetFloat4() )

 pedPMy = imgui.ImFloat4( imgui.ImColor( explode_argb(HLcfg.config.pedPMy) ):GetFloat4() )
 carPMy = imgui.ImFloat4( imgui.ImColor( explode_argb(HLcfg.config.carPMy) ):GetFloat4() )

    function main()
    while not isSampAvailable() do wait(100) end

		if notify then
    notify.addNotification('[ViceTools]\nСкрипт успешно запущен\nАктивация: /rh, '..HLcfg.config.Atoolscmd..'\nКоманды: /apanel, /ahelp\nВерсия скрипта - ' .. script_vers_text, 5, 0, 1)
		
		
	else
		sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Скрипт был инициализирован.', stColor)
		sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Версия скрипта - ' .. script_vers_text, stColor)
		sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Меню - /rh', stColor)
		sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Лог обновлений: /log -- ВАЖНО! Обязательно прочтите', stColor)
	end
    repeat
        wait(0)
    until sampIsLocalPlayerSpawned()
    fixChatCoursor()
		if not doesDirectoryExist(isDirrectory) then
        createDirectory(isDirrectory)
    end
    lua_thread.create(time)
    lua_thread.create(autoSave)
    lua_thread.create(checklvlfortime)
 
    thread = lua_thread.create_suspended(thread_function)
    if HLcfg.onDay.today ~= os.date("%a") then
		HLcfg.onDay.today = os.date("%a")
		HLcfg.onDay.online = 0
        HLcfg.onDay.full = 0
		HLcfg.onDay.afk = 0
	
		HLcfg.config.dayReports = 0
		HLcfg.config.dayForms = 0
	  	dayFull.v = 0
		save()
    end
   
 
		downloadUrlToFile(update_url, update_path, function(id, status)
			 if status == dlstatus.STATUS_ENDDOWNLOADDATA then
					updateIni = inicfg.load(nil, update_path)
					if updateIni then
					if tonumber(updateIni.info.vers) > script_vers then
						 msg('Доступно обновление - '..tonumber(updateIni.info.vers_text))
                         update_state = true
					end
				
				end
					
			 end
		end)
	
		
 
    bindWallHack = rkeys.registerHotKey(ActiveWallHack.v, true, function()
        if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and not sampIsDialogActive() and not isPauseMenuActive() then
          wallhack()
          save()
        end
    end)
    bindAutoReport = rkeys.registerHotKey(ActiveAutoReport.v, true, function()
        if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and not sampIsDialogActive() and not isPauseMenuActive() then
            tableOfNew.AutoReport.v = not tableOfNew.AutoReport.v


        end
    
    end)
    bindMenu = rkeys.registerHotKey(ActiveMenu.v, true, function()
        if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and not sampIsDialogActive() and not isPauseMenuActive() then
            AdminTools.v = not AdminTools.v


        end
    
    end)
    bindTrueCommand = rkeys.registerHotKey(ActiveTrue.v, true, function()
        if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and not sampIsDialogActive() and not isPauseMenuActive() then
           if active_forma then
            printStyledString("Admin form accepted", 1000, 4)
            sampSendChat("/"..FormaCommand.." "..FormaText.." || "..FormaNick)
            wait(1000)
            sampSendChat('/a [Forma] - True. Сommand: /'..FormaCommand)
            LsessionForma = LsessionForma + 1
            HLcfg.config.dayForms = HLcfg.config.dayForms + 1
            save()
            FormaCommand = nil
            FormaText = nil
            FormaNick = nil
            active_forma = false
            stop_forma = true
           
           end


        end
    
    end)
    bindFalseCommand = rkeys.registerHotKey(ActiveFalse.v, true, function()
        if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and not sampIsDialogActive() and not isPauseMenuActive() then
           if active_forma then
            printStyledString('You missed the form', 1000, 4)
            sampSendChat('/a [Forma] - False. Сommand: /'..FormaCommand)
            FormaCommand = nil
            FormaText = nil
            FormaNick = nil
            active_forma = false
            stop_forma = true
           
           end


        end
    
    end)
    bindChatBubble = rkeys.registerHotKey(ActiveChatBubble.v, true, function()
        if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and not sampIsDialogActive() and not isPauseMenuActive() then
            bubbleBox:toggle(not bubbleBox.active)


        end
    
    end)
    bindCar = rkeys.registerHotKey(ActiveCar.v, true, function()
        if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and not sampIsDialogActive() and not isPauseMenuActive() then
            if elements.checkbox.vCar.v then
                if isCharInAnyCar(PLAYER_PED) then
                    local cVecX, cVecY, cVecZ = getCarSpeedVector(storeCarCharIsInNoSave(playerPed))
                    if cVecZ < 7.0 then applyForceToCar(storeCarCharIsInNoSave(playerPed), 0.0, 0.0, 0.1 + elements.int.lengthJump.v / 10, 0.0, 0.0, 0.0) end
                else
                    msg('Ошибка! Нужно находиться в автомобиле.')
                end
                
            end


        end
    
    end)
    bindAirBrake = rkeys.registerHotKey(ActiveAirBrake.v, true, function()
        if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and not sampIsDialogActive() and not isPauseMenuActive() then
         if not elements.checkbox.airStandart.v then
            if elements.checkbox.airBrake.v then
               
                    enAirBrake = not enAirBrake
                    if enAirBrake then
                        local posX, posY, posZ = getCharCoordinates(playerPed)
                        airBrkCoords = {posX, posY, posZ, 0.0, 0.0, getCharHeading(playerPed)}
                    end
                    
                
            end
           


        end
      end
    
    end)
    
   
 
   
   
    cmd('achat', function() achat.v = not achat.v end)
    cmd('rec', function() 
        cleanStreamMemory()
				sampDisconnectWithReason(quit)
				wait(1000)
				sampSetGamestate(1)
    end)
   
    cmd('setcurs', function(text)
        if text:find('(%d+)%s+(%d+)') then
            local id,id1 = text:match('(%d+)%s+(%d+)')
        HLcfg.config.posX_Inf = id 
        HLcfg.config.posY_Inf = id1 
        end
    end)
    
   

 
    
 

        
    

   
   
       cmd('g12d', doroga)
		sampRegisterChatCommand('log', function()
    Log.v = not Log.v
		end)
		sampRegisterChatCommand('mpset', function()
    sampShowDialog(1230, "MPset", u8:decode(mpsetStr), "Выбрать", "Не выбрать", 2)
		end)
		sampRegisterChatCommand('offcursor', function()
    imgui.ShowCursor = false
		end)
		sampRegisterChatCommand('templeader', function(arg)
			if #arg == 0 then
		tableOfNew.tempLeader.v = not tableOfNew.tempLeader.v
        if tableOfNew.tempLeader.v == false then
            imgui.ShowCursor = false
        end
	else
		sampSendChat('/templeader '..arg)
	  end
	  end)
		sampRegisterChatCommand('nakaz', function()
		tableOfNew.tableRes.v = not tableOfNew.tableRes.v
	  end)
    fon = imgui.CreateTextureFromFile(getGameDirectory() .. "\\moonloader\\ViceTools\\image\\fon.jpg")
		
		
        checkfile = false



		
       
	

		------------------------------------------------------------------------------
			sampRegisterChatCommand('vcaz', vcaz)
			
	

		sampRegisterChatCommand('givedeer', givedeer)
		sampRegisterChatCommand('otziv', function(arg)
       data['username'] = sampGetPlayerNickname(select(2, sampGetPlayerIdByCharHandle(PLAYER_PED))) -- ник отправителя = ник в игре
       data['content'] = arg -- делаем что бы текст сообщения был равен тексту который мы ввели после команды
       -- отправляем запрос
       asyncHttpRequest('POST', url, {headers = {['content-type'] = 'application/json'}, data = u8(encodeJson(data))},
       function(response)
          sampAddChatMessage('[ViceTools] {ffffff}Ваш отзыв успешно отправлен!', stColor)
       end,
       function(err)
        
       end)
    end)
	

	
		sampRegisterChatCommand('ahelp', function()
			sampShowDialog(4000, "Команды", u8:decode(AhelpStr), "Выбрать", "Не выбрать", 2)
		end)
    sampRegisterChatCommand('wallhack', wallhack)

		sampRegisterChatCommand('givecar', givecar)
	
	
		sampRegisterChatCommand('repstats', repstat)
		sampRegisterChatCommand('gun', gun)
		sampRegisterChatCommand('car', car)
		sampRegisterChatCommand('mka', function(text)
					 if text ~= '' then
							 if text:find('%d+%s+.*') then
									 local id, reason = text:match('(%d+)%s+(.*)')
									 local nick = sampGetPlayerNickname(id)
									 if sampIsPlayerConnected(id) then
											 sampSendChat('/makeadmin '..nick..' '..reason)
									 else
											 sampAddChatMessage('{FF0000}[Ошибка] {FFFFFF}Игрок не в сети.', stColor)
									 end
							 else
									 sampAddChatMessage('{FF0000}[Ошибка] {FFFFFF}Вы указали некорректный [id] и [lvl].', stColor)
							 end
					 else
							 sampAddChatMessage('{FFFFFF}Введите: /mka [id] [lvl].', stColor)
					 end
			 end)

		
		checkgm = false
        adminAlogin = false
        if Mlvl == 'check' and HLcfg.config.adminlvl ~= nil then
            Mlvl = HLcfg.config.adminlvl
        end

       
	







       MPtimeS = 60
		MPtimeMS = 60000
		gopref = false
		local font = renderCreateFont('Arial', 10, 5)
		local score_font = renderCreateFont('Arial', 40, 1)
        lua_thread.create(checkAA)
        lua_thread.create(checkAA1)

    HLcfg.config.invAdmin = false
		imgui.ShowCursor = false
		showCursor(false)
		lua_thread.create(irc_ping)
       

		lua_thread.create(waitAnim)
		sampRegisterChatCommand('zerogame', function() XO_window.v = not XO_window.v end)



				volume = 75

                

     sampRegisterChatCommand('napak', function(id)
			 lua_thread.create(function()
			 if id ~= '' then
       if id:find('%d+') then

				 sampSendChat('/setskin '..id..' 230')
				 wait(1000)
				 sampSendChat('/givegun '..id..' 24 500')
				 wait(1000)
				 sampSendChat('/givegun '..id..' 31 500')
				 wait(1000)
				 sampSendChat('/givegun '..id..' 24 500')
				 wait(1500)
				 sampSendChat('/sethp '..id..' 900')
				 sampAddChatMessage('{ff0000}[ViceTools] {ffffff}Пак гангстера выдан.', stcolor)

			 else
							 sampAddChatMessage('{FF0000}[Ошибка] {FFFFFF}Вы указали некорректный [ID]', stColor)
					 end
			 else
					 sampAddChatMessage('{FFFFFF}Введите: /napak [id]', stColor)
			   end



	 end)
 end)
    sampRegisterChatCommand('otdaipak', function(id)
		 lua_thread.create(function()
 		 if id ~= '' then
 		 if id:find('%d+') then
			 sampAddChatMessage('{ff0000}[ViceTools] {ffffff} Процесс начат.')
			 sampSendChat('/iwep '..id)
			 sampAddChatMessage('{ff0000}[ViceTools] {ffffff} Процесс завершён')
		 else
						 sampAddChatMessage('{FF0000}[Ошибка] {FFFFFF}Вы указали некорректный [ID]', stColor)
				 end
		 else
				 sampAddChatMessage('{FFFFFF}Введите: /otdaipak [id]', stColor)
			 end
end)
end)

		sampRegisterChatCommand('aid', function(text)
	         if text ~= '' then
	             if text:find('%d+%s+.*') then
	                 local id, reason = text:match('(%d+)%s+(.*)')
	                 local nick = sampGetPlayerNickname(id)
	                 if sampIsPlayerConnected(id) then
	                     sampSendChat('/a '..nick..' '..reason)
	                 else
	                     sampAddChatMessage('{FF0000}[Ошибка] {FFFFFF}Игрок не в сети.', stColor)
	                 end
	             else
	                 sampAddChatMessage('{FF0000}[Ошибка] {FFFFFF}Вы указали некорректный [id] и [text].', stColor)
	             end
	         else
	             sampAddChatMessage('{FFFFFF}Введите: /aid [id] [text].', stColor)
	         end
	     end)
    sampRegisterChatCommand('az', function(id)
      lua_thread.create(function()
				if id == '' then
					sampSendChat('/tp')
					wait(200)
					sampSendDialogResponse(sampGetCurrentDialogId(), 1, 0, nil)
					sampCloseCurrentDialogWithButton(0)

				end
			if id ~= '' then
			if id:find('%d+') then
				sampSendChat('/tp')
				wait(200)
				sampSendDialogResponse(sampGetCurrentDialogId(), 1, 0, nil)
				sampCloseCurrentDialogWithButton(0)
				wait(1000)
				sampSendChat('/gethere '..id)
				sampAddChatMessage('Вы телепортировали ' .. sampGetPlayerNickname(id) .. ' в Админ-Зону', -1)

					 else
									 sampAddChatMessage('{FF0000}[Ошибка] {FFFFFF}Вы указали некорректный [ID]', stColor)
							 end

					 end
	 end)
 end)



		sampRegisterChatCommand('vred', function(id)
	 	    if id ~= '' then
	 		    if id:find('%d+') then
	 			       sampSendChat('/ban '..id..' 7 vred')
	             else
	                     sampAddChatMessage('{FF0000}[Ошибка] {FFFFFF}Вы указали некорректный [ID]', stColor)
	                 end
	             else
	                 sampAddChatMessage('{FFFFFF}Введите: /vred [id]', stColor)
	             end
	     end)
	 	sampRegisterChatCommand('cheat', function(id)
	 	    if id ~= '' then
	 		    if id:find('%d+') then
	 			       sampSendChat('/jail '..id..' 60 чит')
	             else
	                     sampAddChatMessage('{FF0000}[Ошибка] {FFFFFF}Вы указали некорректный [ID]', stColor)
	                 end
	             else
	                 sampAddChatMessage('{FFFFFF}Введите: /cheat [id]', stColor)
	             end
	     end)
	 	sampRegisterChatCommand('stats', function(id)
	 	    if id ~= '' then
	 		    if id:find('%d+') then
	 			       sampSendChat('/getstats '..id..' ')
	             else
	                     sampAddChatMessage('{FF0000}[Ошибка] {FFFFFF}Вы указали некорректный [ID]', stColor)
	                 end
	             else
	                 sampAddChatMessage('{FFFFFF}Введите: /stats [id]', stColor)
	             end
	     end)
	 	sampRegisterChatCommand('unfr', function(id)
	 	    if id ~= '' then
	 		    if id:find('%d+') then
	 			       sampSendChat('/unfreeze '..id..' ')
	             else
	                     sampAddChatMessage('{FF0000}[Ошибка] {FFFFFF}Вы указали некорректный [ID]', stColor)
	                 end
	             else
	                 sampAddChatMessage('{FFFFFF}Введите: /unfr [id]', stColor)
	             end
	     end)
	 	sampRegisterChatCommand('gdon', function(text)
	         if text ~= '' then
	             if text:find('%d+%s+.*') then
	                 local id, reason = text:match('(%d+)%s+(.*)')
	                 local nick = sampGetPlayerNickname(id)
	                 if sampIsPlayerConnected(id) then
	                     sampSendChat('/givedonate '..nick..' '..reason)
	                 else
	                     sampAddChatMessage('{FF0000}[Ошибка] {FFFFFF}Игрок не в сети.', stColor)
	                 end
	             else
	                 sampAddChatMessage('{FF0000}[Ошибка] {FFFFFF}Вы указали некорректный [id] и [donate].', stColor)
	             end
	         else
	             sampAddChatMessage('{FFFFFF}Введите: /gdon [id] [donate].', stColor)
	         end
	     end)
         keysync = false
			 sampRegisterChatCommand('dm', function(id)
						if id ~= '' then
								 if id:find('%d+') then
												sampSendChat('/jail '..id..' 10 DM')
								 else
												 sampAddChatMessage('{FF0000}[Ошибка] {FFFFFF}Вы указали некорректный [ID]', stColor)
										 end
								 else
										 sampAddChatMessage('{FFFFFF}Введите: /dm [id]', stColor)
								 end
				 end)
				 sampRegisterChatCommand('tk', function(id)
						if id ~= '' then
								 if id:find('%d+') then
												sampSendChat('/jail '..id..' 10 TK')
								 else
												 sampAddChatMessage('{FF0000}[Ошибка] {FFFFFF}Вы указали некорректный [ID]', stColor)
										 end
								 else
										 sampAddChatMessage('{FFFFFF}Введите: /tk [id]', stColor)
								 end
				 end)
			 sampRegisterChatCommand('frz', function(id)
					if id ~= '' then
						if id:find('%d+') then
								 sampSendChat('/freeze '..id..' ')
								 else
												 sampAddChatMessage('{FF0000}[Ошибка] {FFFFFF}Вы указали некорректный [ID]', stColor)
										 end
								 else
										 sampAddChatMessage('{FFFFFF}Введите: /frz [id]', stColor)
								 end
				 end)
			 sampRegisterChatCommand('adunvig', function(text)
	         if text ~= '' then
	             if text:find('%d+%s+.*') then
	                 local id, reason = text:match('(%d+)%s+(.*)')
	                 local nick = sampGetPlayerNickname(id)
	                 if sampIsPlayerConnected(id) then
	                     sampSendChat('/aunvig '..nick..' '..reason)
	                 else
	                     sampAddChatMessage('{FF0000}[Ошибка] {FFFFFF}Администратор не в сети.', stColor)
	                 end
	             else
	                 sampAddChatMessage('{FF0000}[Ошибка] {FFFFFF}Вы указали некорректный [ID] и [Reason].', stColor)
	             end
	         else
	             sampAddChatMessage('{FFFFFF}Введите: /adunvig [id] [Причина].', stColor)
	         end
	     end)
	     sampRegisterChatCommand('mp_rules', function()
	 		sampShowDialog(3910, 'Выберите пункт', '{FF0000}[1] {FFFFFF}Король Дигла\n{FF0000}[2] {FFFFFF}Русская Рулетка\n{FF0000}[3] {FFFFFF}Дерби\n{FF0000}[4] {FFFFFF}Паркур\n{FF0000}[5] {FFFFFF}Поливалка\n{FF0000}[6] {FFFFFF}Снайпер\n{FF0000}[7] {FFFFFF}Прятки\n{FF0000}[8] {FFFFFF}Мясорубка\n{FF0000}[9] {FFFFFF}Отбор', "Выбрать", "Назад", 2)
	     end)
	 	sampRegisterChatCommand('apanel', function()
	 		sampShowDialog(3911, 'Админ панель', '{FF0000}[1]{FFFFFF} Моя статистика.\n{FF0000}[2]{FFFFFF} Телепорт меню.\n{FF0000}[3]{FFFFFF} Администраторы онлайн.\n{FF0000}[4]{FFFFFF} Неотвеченные репорты.\n{FF0000}[5]{FFFFFF} Лидеры онлайн.\n{FF0000}[6]{FFFFFF} Все лидеры.\n{FF0000}[7]{FFFFFF} Команды администраторов.\n{FF0000}[8]{FFFFFF} Хелперы онлайн.\n{FF0000}[9]{FFFFFF} Ответы хелперов\n{FF0000}[10]{FFFFFF} Команды Admin tools.\n{FF0000}[11]{FFFFFF} Очистка чата\n{FF0000}[12]{FFFFFF} Правила администрации 1 часть\n{FF0000}[13]{FFFFFF} Правила администрации 2 часть\n{FF0000}[14]{FFFFFF} Все администраторы (для ФД)\n{FF0000}[15]{FFFFFF} Оффлайн статистика игрока\n{FF0000}[16]{FFFFFF} Админ статистика игрока\n{FF0000}[17]{FFFFFF} Снять лидера\n{FF0000}[18]{FFFFFF} Снять хелпера в оффе\n{FF0000}[19]{FFFFFF} Выдать лвл хелперу в оффе\n{FF0000}[20]{FFFFFF} Заблокировать игрока в оффе\n{FF0000}[21]{FFFFFF} Заблокировать игрока с причиной ЧС\n{FF0000}[22]{FFFFFF} Заблокировать IP\n{FF0000}[23]{FFFFFF} Заблокировать IP с причиной ЧС', "Выбрать", "Назад", 2)
	     end)
	 	


		sampRegisterChatCommand('hp', function()
        if isCharInAnyCar(playerPed) then
            if elements.checkbox.gmCar.v then
                lua_thread.create(function()
                    boolEnabled = true
                    wait(100)
                    sampSendChat('/hp')
                    wait(100)
                    boolEnabled = false
                end)
            else
                sampSendChat('/hp')
            end
        else
            sampAddChatMessage('Жизни выданы!', 0xFFFFFF)
            sampSendChat('/hp')
        end
    end)
    sampRegisterChatCommand('copynick', function(arg)
        if #arg == 0 then
            sampAddChatMessage('{FF0000}/copynick [id]', stColor)
        else
					local nick = sampGetPlayerNickname(arg)
					setClipboardText(nick)
					sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Никнейм скопирован в буфер обмена.', stColor)

        end
    end) 
    sampRegisterChatCommand('invis', function()
        ainvisible = not ainvisible
        printStringNow('INVISIBLE' .. (ainvisible and ' HACKED' or ' OFF'), 1000)

    end)
    sampRegisterChatCommand('rh', function()
        AdminTools.v = not AdminTools.v
    end)
		
		
    sampRegisterChatCommand('reoff', function()
		sampSendChat('/re off')
	end)
	sampRegisterChatCommand('jp', function()
		taskJetpack(playerPed)
	end)
    sampRegisterChatCommand('unrmute', function(id)
        if id ~= '' then
            if id:find('%d+') then
                sampSendChat('/rmute '..id..' 0 0')
            else
                sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Вы указали некорректный [ID]', stColor)
            end
        else
            sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Вы не ввели [ID]', stColor)
        end
    end)
    sampRegisterChatCommand('unmute', function(id)
        if id ~= '' then
            if id:find('%d+') then
                sampSendChat('/mute '..id..' 0 0')
            else
                sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Вы указали некорректный [ID]', stColor)
            end
        else
            sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Вы не ввели [ID]', stColor)
        end
    end)

    sampRegisterChatCommand('spawncars', function(value)
        if value ~= '' then
            if value:find('%d+') then
                local value = tonumber(value)
                if value == 0 then
                    sampSendChat('/spawncars')
                end
                if value > 9 and value < 61 then
                    lua_thread.create(function()
                        if elements.checkbox.printSpawnCars.v then
                            isSpawnerFor(value)
                        end
                        sampSendChat(string.format('/aad [Info] Доброго времени суток, через %s секунд будут заспавнено все незанятое т/с.', value))
                        wait(1000)
                        sampSendChat('/aad [Info] Убедительная просьба, если вам нужна ваша машина, сядьте в нее и ожидайте...')
                        wait(1000)
                        sampSendChat('/aad [Info] Окончания спавна, в противном случае она пропадет.')
                        wait(value*1000)
                        sampSendChat('/spawncars')
                        wait(1000)
                        sampSendChat('/aad [Info] Все незанятые машины были заспавнены, приятной игры!')
                    end)
                else
                    sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Секунды не могут быть меньше 10 и больше 60.', stColor)
                end
            else
                sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Вы ввели некорректное значение.', stColor)
            end
        else
            sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Вы не ввели секунды.', stColor)
        end
    end)
		sampRegisterChatCommand('dvall', function(value)
        if value ~= '' then
            if value:find('%d+') then
                local value = tonumber(value)
                if value == 0 then
                    sampSendChat('/dvall')
                end
                if value > 9 and value < 61 then
                    lua_thread.create(function()
                        if elements.checkbox.printDvall.v then
                            isSpawnerFor(value)
                        end
                        sampSendChat(string.format('/a [Admin] Через %s секунд все созданные административные машины будут заспавнены', value))
                        wait(value*1000)
                        sampSendChat('/dvall')
                        wait(1000)
                        sampSendChat('/a [Admin] Удаление транспорта прошло успешно.')
                    end)
                else
                    sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Секунды не могут быть меньше 10 и больше 60.', stColor)
                end
            else
                sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Вы ввели некорректное значение.', stColor)
            end
        else
            sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Вы не ввели секунды.', stColor)
        end
    end)
    sampRegisterChatCommand('stmp', function(text)
        if text ~= '' then
            sampSendChat(string.format("/aad [MP] Сейчас пройдет мероприятие под названием '%s', желающие >> /gomp", text))


        else
            sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Вы не ввели название мероприятия.', stColor)
        end
    end)
    
    sampRegisterChatCommand('getherecar', function(idCar)
        if idCar ~= '' then
            if idCar:find('%d+') then
                local id = idCar:match('(%d+)')
                local result, vehicleHandle = sampGetCarHandleBySampVehicleId(id)
				if result then
					my_pos = {getCharCoordinates(playerPed)}
					setCarCoordinates(vehicleHandle, my_pos[1] + 4, my_pos[2], my_pos[3])
				end
            else
                sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Вы ввели некорректынй [idCar]', stColor)
            end
        else
            sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Вы не ввели [idCar]', stColor)
        end
    end)
		sampRegisterChatCommand('gotocar', function(idCar)
			if idCar ~= '' then
					if idCar:find('%d+') then
							local id = idCar:match('(%d+)')
							local result, vehicleHandle = sampGetCarHandleBySampVehicleId(id)

						if result then
							car_pos = {getCarCoordinates(vehicleHandle)}
							setCharCoordinates(PLAYER_PED, car_pos[1] + 4, car_pos[2], car_pos[3])
						end

		            else
		                sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Вы ввели некорректынй [idCar]', stColor)
		            end
		        else
		            sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Вы не ввели [idCar]', stColor)
		        end

		end) 
		sampRegisterChatCommand('carvpizdu',  function(idCar)
        if idCar ~= '' then
            if idCar:find('%d+') then
                local id = idCar:match('(%d+)')
                local result, vehicleHandle = sampGetCarHandleBySampVehicleId(id)
				if result then
					my_pos = {getCharCoordinates(playerPed)}
					setCarCoordinates(vehicleHandle, 1000, 1000, 1000)
				end
            else
                sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Вы ввели некорректынй [idCar]', stColor)
            end
        else
            sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Вы не ввели [idCar]', stColor)
        end
    end)
    sampRegisterChatCommand('advig', function(text)
        if text ~= '' then
            if text:find('%d+%s+.*') then
                local id, reason = text:match('(%d+)%s+(.*)')
                local nick = sampGetPlayerNickname(id)
                if sampIsPlayerConnected(id) then
                    sampSendChat('/avig '..nick..' '..reason)
                else
                    sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Администратор не в сети.', stColor)
                end
            else
                sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Вы указали некорректный [ID] и [Reason].', stColor)
            end
        else
            sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Вы не указали [ID] и [Reason].', stColor)
        end
    end)
    sampRegisterChatCommand('adunvig', function(text)
        if text ~= '' then
            if text:find('%d+%s+.*') then
                local id, reason = text:match('(%d+)%s+(.*)')
                local nick = sampGetPlayerNickname(id)
                if sampIsPlayerConnected(id) then
                    sampSendChat('/aunvig '..nick..' '..reason)
                else
                    sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Администратор не в сети.', stColor)
                end
            else
                sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Вы указали некорректный [ID] и [Reason].', stColor)
            end
        else
            sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Вы не указали [ID] и [Reason].', stColor)
        end
    end)
    sampRegisterChatCommand('mp_rules', function()
		sampShowDialog(3910, 'Выберите мероприятие', 'Король Дигла\nРусская Рулетка\nДерби\nПаркур\nПоливалка\nСнайпер\nПрятки\nМясорубка', "Выбрать", "Назад", 2)
    end)
    setPlayerNeverGetsTired(playerHandle, true)
    kill = ffi.cast('struct stKillInfo*', sampGetKillInfoPtr())
    pm_timer = os.clock()
    bubbleBox = ChatBox(elements.int.limitPageSize.v, blacklist)
		checknotf = true

		
		
		while true do
            if elements.checkbox.fastHelp.v and not rInfo.state then
                weap = getweaponname(getCurrentCharWeapon(playerPed))
                if weap == 'Fist' then
            if isKeyDown(VK_RBUTTON) and not sampIsChatInputActive() and not sampIsDialogActive()  then
                local X, Y = getScreenResolution()
                renderFigure2D(X/2, Y/2, 50, 200, 0xe96bffAA)
                local x, y, z = getCharCoordinates(PLAYER_PED)
                local posX, posY = convert3DCoordsToScreen(x, y, z)
                renderDrawPolygon(X/2, Y/2, 7, 7, 40, 0, -1)
                local player = getNearCharToCenter(200)
                if player then
                    local playerId = select(2, sampGetPlayerIdByCharHandle(player))
                    local playerNick = sampGetPlayerNickname(playerId)
                    local x2, y2, z2 = getCharCoordinates(player)
                    local isScreen = isPointOnScreen(x2, y2, z2, 200)
                    if isScreen then
                        local posX2, posY2 = convert3DCoordsToScreen(x2, y2, z2)
                        renderDrawLine(posX, posY - 50, posX2, posY2, 2.0, 0xe96bffAA)
                        renderDrawPolygon(posX2, posY2, 10, 10, 40, 0, 0xe96bffAA)
                        local distance = math.floor(getDistanceBetweenCoords3d(x, y, z, x2, y2, z2))
                        renderFontDrawTextAlign(font, string.format('%s[%d]', playerNick, playerId),posX2, posY2-30, 0xe96bffAA, 2)
                        renderFontDrawTextAlign(font, string.format('Дистанция: %s', distance),X/2, Y/2+210, 0xe96bffAA, 2)
                        renderFontDrawTextAlign(font, '{e96bff}1 - Перейти в слежку\n2 - Заспавнить\n3 - Выдать 100 HP\n4 - Телепортировать к себе\n5 - Телепорт игрока на дорогу',X/2+210, Y/2-30, -1, 1)
                        if isKeyJustPressed(VK_1) then
                            sampSendChat('/re '..playerId)
                        end
                        if isKeyJustPressed(VK_2) then
                            sampSendChat('/spawn '..playerId)
                        end
                        if isKeyJustPressed(VK_3) then
                            sampSendChat('/sethp '..playerId..' 100')
                        end
                        if isKeyJustPressed(VK_4) then
                            sampSendChat('/gethere '..playerId)
                        end
                        if isKeyJustPressed(VK_5) then
                            doroga(playerId)
                        end
                       
                    end
                end
            end
        end
    end
            
           
            
            if setTimes then
                if elements.int.time.v >= 0 then
                    setTimeOfDay(setTimes, 0)
                end
            end
            
            
            if elements.checkbox.statetempskin.v then
                if elements.int.tempSkin.v >= 0 then
                    local model = getCharModel(PLAYER_PED)
                    if model ~= elements.int.tempSkin.v then
                        local _, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
                        setCharModel(PLAYER_PED, elements.int.tempSkin.v)
                        
                    end
                end
            end 
            if elements.checkbox.airStandart.v then
                if isKeyJustPressed(VK_RSHIFT) and is_key_check_available() then
                    enAirBrake = not enAirBrake
                    if enAirBrake then
                        local posX, posY, posZ = getCharCoordinates(playerPed)
                        airBrkCoords = {posX, posY, posZ, 0.0, 0.0, getCharHeading(playerPed)}
                    end
                end
            end 
           
            if Mlvl == 0 then
                Mlvl = HLcfg.config.adminlvl 
            end
            if elements.checkbox.autoLang.v then
                if sampIsChatInputActive() then
                    local getInput = sampGetChatInputText()
                    if oldText ~= getInput and #getInput > 0 then
                        local firstChar = string.sub(getInput, 1, 1)
                        if firstChar == "." or firstChar == "/" then
                            local cmd, text = string.match(getInput, "^([^ ]+)(.*)")
                            local nText = "/" .. translite(string.sub(cmd, 2)) .. text
                            local chatInfoPtr = sampGetInputInfoPtr()
                            local chatBoxInfo = getStructElement(chatInfoPtr, 0x8, 4)
                            local lastPos = mem.getint8(chatBoxInfo + 0x11E)
                            sampSetChatInputText(nText)
                            mem.setint8(chatBoxInfo + 0x11E, lastPos)
                            mem.setint8(chatBoxInfo + 0x119, lastPos)
                            oldText = nText
                        end
                    end
                    
                end
            end
            if elements.checkbox.stateLang.v then
                local in1 = sampGetInputInfoPtr()
			    local in1 = getStructElement(in1, 0x8, 4)
			    local in2 = getStructElement(in1, 0x8, 4)
			    local in3 = getStructElement(in1, 0xC, 4)
			    local fib = in3 + 11
			    local fib2 = in2 + -33
                local capsState = ffi.C.GetKeyState(20)
			    local success = ffi.C.GetKeyboardLayoutNameA(KeyboardLayoutName)
			    local errorCode = ffi.C.GetLocaleInfoA(tonumber(ffi.string(KeyboardLayoutName), 16), 0x00000003, LocalInfo, BuffSize)
			    local localName = ffi.string(LocalInfo)
                local toprint = ""
                local capsStating = nil
		        if capsState == 1 or capsState == -127 then
                    capsStating = 'Yes'
                    local lang = capitalize(localName:sub(1, 2):upper())
                  if lang == 'RU' then
                    toprint = 'RU'
                  elseif lang == 'EN' then
                    toprint = 'EN'
                  end
                end

            if capsState == 0 or capsState == -128 then
            capsStating = 'No'
            local lang = capitalize(localName:sub(1, 2):lower())
            if lang == 'Ru' then
                toprint = 'Ru'
            elseif lang == 'En' then
                toprint = 'En'
            end
            end
            if capsStating == 'Yes' and sampIsChatInputActive() then

            renderFontDrawText(font, toprint, fib2, fib, stColor)
            elseif capsStating == 'No' and sampIsChatInputActive() then
                renderFontDrawText(font, toprint, fib2, fib, -1)
            
            end
            end
            
		
            if not rInfo.state then
                keywindow.v = false
            end
            if elements.monitoring.admins.v then
            if #adminList > 0 then
           
              local xSaves, ySaves = HLcfg.config.posX_M, HLcfg.config.posY_M
              renderFontDrawText(font, 'Администрация online:', xSaves, ySaves - 20, stColor)
              for k,v in pairs(adminList) do
                adminText = v.aNick..'['..v.aId..'] - '..v.aLvl..' lvl\n'
               
               
                
                renderFontDrawText(font, adminText, xSaves, ySaves, -1)
                ySaves = ySaves + 20
                
            

                

              end
            end
            end
         
            if isKeyJustPressed(13) and achat.v and not isSampfuncsConsoleActive() and not isPauseMenuActive() and not sampIsDialogActive() and not sampIsChatInputActive() then
                if tableOfNew.sms_buffer.v ~= '' then
                    sampSendChat('/a '..u8:decode(tableOfNew.sms_buffer.v))
                    tableOfNew.sms_buffer.v = ''
                end
            end
           
            if rInfo.state then
            if not elements.checkbox.keysyncer.v then
                keywindow.v = false
            else
                keywindow.v = true
            end
        end

         
          
			
			

			
 


 

            
            if elements.monitoring.admins.v then

                
               
                    if os.clock() - timersAdmin >= tonumber(HLcfg.monitoring.timeAdmins) then -- 5 min
                      
                        checkingadmins()
                      
                        
                        timersAdmin = os.clock()
                    end
                
            end
            if not checkadmins then
            if os.clock() - timersLeader >= 120 then 
                      
                checkadminsforlist()
              
                
                timersLeader = os.clock()
            end
           end
          
                
      
     
		





			

			if elements.checkbox.autouv.v then
				if #reports < 0 and tableOfNew.answer_report.v == u8('Уважаемый игрок, ') then
					tableOfNew.answer_report.v = ''

				end

			end
     

     
    
			local result, button, list, input = sampHasDialogRespond(1230) -- /dialog2 (ListBox)

			if result then -- если диалог открыт
				 if button == 1 then -- если нажата первая кнопка (Выбрать)
					 if list == 0 then

            sampShowDialog(1330, 'Время', 'Укажите время ожидания игроков в секундах\nНынешнее значение: {ff0000}'..MPtimeS..' секунд{ffffff}\nПример: 60 секунд = 1 минута, 120 секунд = 2 минуты и так далее.\n{ff0000}ВАЖНО!{ffffff} Не ставьте меньше {ff0000}60 секунд!', 'Указать', 'Отмена', 1)

					elseif list == 1 then
						  sampShowDialog(1453, 'Время', 'Укажите ID победителя', 'Указать', 'Отмена', 1)
						elseif list == 2 then
							 sampShowDialog(3910, 'Выберите пункт', '{FF0000}[1] {FFFFFF}Король Дигла\n{FF0000}[2] {FFFFFF}Русская Рулетка\n{FF0000}[3] {FFFFFF}Дерби\n{FF0000}[4] {FFFFFF}Паркур\n{FF0000}[5] {FFFFFF}Поливалка\n{FF0000}[6] {FFFFFF}Снайпер\n{FF0000}[7] {FFFFFF}Прятки\n{FF0000}[8] {FFFFFF}Мясорубка\n{FF0000}[9] {FFFFFF}Отбор', "Выбрать", "Назад", 2)
						elseif list == 3 then
							sampAddChatMessage('Просто пустая кнопка, шо ещё надо', -1)

					elseif list == 4 then
							 sampShowDialog(1331, 'MPset', 'Введите приз', 'Окей', 'Отмена', 1)
							 checkmp = 1

						 elseif list == 5 then
							 sampShowDialog(1331, 'MPset', 'Введите приз', 'Окей', 'Отмена', 1)
							 checkmp = 2
						 elseif list == 6 then
							 sampShowDialog(1331, 'MPset', 'Введите приз', 'Окей', 'Отмена', 1)
							 checkmp = 3








			end
			end
		  end
			local result, button, list, input = sampHasDialogRespond(1453)
			if result then
				MPid = input
				MPnick = sampGetPlayerNickname(MPid)
				if button == 1 then
         sampSendChat('/aad [MP] Победителем мероприятия становится - '..MPnick..'['..MPid..'].')



			end

			end
			local result, button, list, input = sampHasDialogRespond(1331)
			if result then
				if button == 1 then
					MPpriz = input
				if checkmp == 1 then

					sampSendChat('/tp')
					wait(200)
				 sampSendDialogResponse(sampGetCurrentDialogId(), 1, 1, nil)
				 sampCloseCurrentDialogWithButton(0)
				 wait(200)
				 sampSendDialogResponse(sampGetCurrentDialogId(), 1, 0, nil)
				 sampCloseCurrentDialogWithButton(0)
				 wait(100)
				 setCharCoordinates(PLAYER_PED, -1375.1268, 1060.7052, 1038.5018)
				 wait(1000)
				 sampSendChat('/aad [MP] Сейчас пройдёт МП "Дерби". Приз: '..MPpriz)
				 wait(1500)
				 sampSendChat('/mp')
				 wait(200)
				 sampSendDialogResponse(sampGetCurrentDialogId(), 1, 0, nil)
				 sampCloseCurrentDialogWithButton(0)
				 wait(1500)
				 sampSendChat('/aad [MP] После ТП сразу строй!')
				 wait(2000)
				 sampSendChat('/aad [MP] Желающие /gomp')
				 setCharCoordinates(PLAYER_PED, -1374.6588, 1056.2712, 1038.4291)

				 isTimesFor(tonumber(MPtimeS))
				 wait(MPtimeMS)
				 sampSendChat('/mp')
				wait(200)
				sampSendDialogResponse(sampGetCurrentDialogId(), 1, 0, nil)
				sampCloseCurrentDialogWithButton(0)
			 end
			 if checkmp == 2 then
				 sampSendChat('/tp')
				 wait(200)
				sampSendDialogResponse(sampGetCurrentDialogId(), 1, 1, nil)
				sampCloseCurrentDialogWithButton(0)
				wait(100)
				sampSendDialogResponse(sampGetCurrentDialogId(), 1, 3, nil)
				sampCloseCurrentDialogWithButton(0)
				wait(1000)
				setCharCoordinates(PLAYER_PED, 1547.7028, -1361.6960, 329.4600)
				wait(1000)
				sampSendChat('/aad [MP] Сейчас пройдёт МП "Король дигла". Приз: '..MPpriz)
				wait(1500)
				sampSendChat('/mp')
				wait(200)
				sampSendDialogResponse(sampGetCurrentDialogId(), 1, 0, nil)
				sampCloseCurrentDialogWithButton(0)
				wait(1500)
				sampSendChat('/aad [MP] После ТП сразу строй')
				wait(1000)
				sampSendChat('/aad [MP] Желающие /gomp')
				setCharCoordinates(PLAYER_PED, 1545.6885, -1357.8143, 329.4666)
				isTimesFor(tonumber(MPtimeS))
				wait(MPtimeMS)
				sampSendChat('/mp')
				wait(200)
				sampSendDialogResponse(sampGetCurrentDialogId(), 1, 0, nil)
				sampCloseCurrentDialogWithButton(0)


			 end
			 if checkmp == 3 then
				 sampSendChat('/tp')
				 wait(200)
				sampSendDialogResponse(sampGetCurrentDialogId(), 1, 1, nil)
				sampCloseCurrentDialogWithButton(0)
				wait(200)
				sampSendDialogResponse(sampGetCurrentDialogId(), 1, 3, nil)
				sampCloseCurrentDialogWithButton(0)
				wait(1000)
				setCharCoordinates(PLAYER_PED, 1547.7028, -1361.6960, 329.4600)
				wait(1000)
				sampSendChat('/aad [MP] Сейчас пройдёт МП "Русская Рулетка". Приз: '..MPpriz)
				wait(1500)
				sampSendChat('/mp')
				wait(200)
				sampSendDialogResponse(sampGetCurrentDialogId(), 1, 0, nil)
				sampCloseCurrentDialogWithButton(0)
				wait(1500)
				sampSendChat('/aad [MP] После ТП сразу строй')
				wait(1000)
				sampSendChat('/aad [MP] Желающие /gomp')
				setCharCoordinates(PLAYER_PED, 1545.6885, -1357.8143, 329.4666)
				isTimesFor(tonumber(MPtimeS))
				wait(MPtimeMS)
				sampSendChat('/mp')
				wait(200)
				sampSendDialogResponse(sampGetCurrentDialogId(), 1, 0, nil)
				sampCloseCurrentDialogWithButton(0)


			 end
		 end
	 end
		 local result, button, list, input = sampHasDialogRespond(1330)
		 if result then
			 if button == 1 then
			 MPtimeS = input
			 MPtimeMS = input*1000
		   end

		 end
			local result, button, list, input = sampHasDialogRespond(4000)
			if result then
			if list == 0 and button == 1 then
				sampShowDialog(4001, '1 уровень', '{FFFFFF}/define - неотвеченные репорты\n/tp - тп меню\n/astats - моя статистика\n/pm [id] [ответ] - отвечать на репорты\n/agm - режим бессмертия\n/a [text] - админ чат\n/gg - пожелать приятной игры всему серверу (раз в PayDay можно)\n/setleader [id] - выдать лидерку. {FF0000}Команда выдается с ЗГС Госс/Мафий/Гетто, либо покупается с 12 уровня адм.\n{FFFFFF}/offleader [nick] - снять лидерку. {FF0000} Команда выдается с ЗГС Госс/Мафий/Гетто либо покупается на 12 уровне адм.\n{FFFFFF}/gzcolor [id фракции) - выдать территорию одной банды другой. {FF0000}Выдается с ЗГС Гетто, либо покупается на 12 уровне адм.\n{FFFFFF}/sethelper [id] [lvl] - выдать/снять хелперку. {FF0000}Выдается с ЗГС Хелперов, либо покупается на 12 уровне адм.\n{FFFFFF}/offhelper [nick] [lvl] - выдать хелперку в оффлайне. {FF0000}Выдается с ЗГС Хелперов, либо покупается на 12 уровне адм.\n{FFFFFF}/avig [nick] [причина] - выдать выговор администратору. {FF0000}Команда выдается с ЗГА, либо покупается на 12 уровне адм.\n{FFFFFF}/aunvig [nick] [причина] - снять выговор администратору. {FF0000}Выдается команда с ЗГА, либо покупается на 12 уровне адм.\n{FFFFFF}/banip [IP] [дни] [причина] - выдать бан айпи. {FF0000}Команда выдается с ЗГА, либо покупается на 12 уровне адм.\n{FFFFFF}/setadmin [nick] [lvl 1-12] - выдать админку. {FF0000}Команда выдается с Помощника Основателя, либо покупается на 12 уровне адм.', "Выбрать", "Закрыть", 0)
			elseif list == 1 and button == 1 then
				sampShowDialog(4002, '2 уровень', '{FFFFFF}/mute [id] [минуты] [причина] - выдать блокировку чата\n/getstats [id] - посмотреть статистику игрока\n/freeze [id] - заморозить игрока\n/unfreeze [id] - разморозить игрока\n/goto [id] - телепортироваться к игроку\n/gethere [id] - телепортировать игрока к себе\n/rmute [id] [минуты] [причина] - выдать блокировку репорта.\n/alock - открыть/закрыть любую машину\n/connect - выключить/включить подключения игроков\n/sp [id] - зареспавнить игрока.', "Выбрать", "Закрыть", 0)
			elseif list == 2 and button == 1 then
				sampShowDialog(4003, '3 уровень', '{FFFFFF}/jail [id] [минуты] [причина] - выдать деморган\n/unjail [id] - выпустить из деморгана\n/slap [id] - подкинуть (слапнуть) игрока\n/mark - поставить собственную телепортацию на месте, где стоите\n/gotomark - телепортироваться к поставленному месту\n/clear [id] - очистить розыск.', "Выбрать", "Закрыть", 0)
			elseif list == 3 and button == 1 then
				sampShowDialog(4004, '4 уровень', '{FFFFFF}/spveh [радиус] - заспавнить транспорт в указанном радиусе\n/iwep [id] - проверить игрока на наличие каких-либо оружий и патронов\n/cc - очистка чата для всех игроков\n/kickpb [id] [причина] - кикнуть игрока с ПБ\n/mp - пвнель для создания МП\n/mpwin [id] [кол-во очков] - выдать игроку донат-очки (максимум 50)', "Выбрать", "Закрыть", 0)
			elseif list == 4 and button == 1 then
				sampShowDialog(4005, '5 уровень', '{FFFFFF}/kick [id] [причина] - кикнуть игрока\n/warnmans - проверить игроков на наличине игрового предупреждения\n/givegun [id] [id оружия] [кол-во патронов] - выдать оружие\n/gm - проверить игрока на наличие GodMode(бессмертия)\n/amembers [id фракции] - проверить игроков онлайн в указанной фракции', "Выбрать", "Закрыть", 0)
			elseif list == 5 and button == 1 then
				sampShowDialog(4006, '6 уровень', '{FFFFFF}/balance - проверить баланс счетов всех фракций\n/ban [id] [дни] [причина] - выдать блокировку аккаунта (максимум 7 дней)(для тех, кому выдали)\n/warn [id] [причина] - выдать игровое предупреждение игроку(для тех, кому выдали её)\n/unwarn [id] - снять игровое предупрждение(для тех, кому выдали команду /warn)\n/hp - выдать себе полное ХП\n/banip [ip] [дни] [причина] - выдать блокировку IP.', "Выбрать", "Закрыть", 0)
			elseif list == 6 and button == 1 then
				sampShowDialog(4007, '7 уровень', '{FFFFFF}/iban [id] [причина] - выдать блокировку аккаунта навсегда(для тех, у кого есть команда /ban)\n/offban [nick] [дни] [причина] - выдать блокировку аккаунта в оффлайне(для тех, у кого есть команда /ban)\n/offwarn [nick] [причина] - выдать игровое предупреждение игроку в оффлайне(для тех, у кого есть команда /warn)\n/getoffstats [nick] - статистика игрока в оффлайне\n/sethp [id] [кол-во ХП] - выдать ХП игроку\n/getban [nick] - проверить аккаунт на наличие бана.', "Выбрать", "Закрыть", 0)
			elseif list == 7 and button == 1 then
				sampShowDialog(4008, '8 уровень', '{FFFFFF}/offgoto - запретить/разрешить телепортацию к себе\n/getschet [id house] - проверить сколько осталось на счете дома денег\n/skick [id] [причина] - тихо кикнуть игрока\n/veh [id транспорта] [id цвета] [id цвета] - создать транспорт\n/delveh - удалить созданный транспорт.', "Выбрать", "Закрыть", 0)
			elseif list == 8 and button == 1 then
				sampShowDialog(4009, '9 уровень', '{FFFFFF}/o [text] - OOC-админ объявление\n/biz [id бизнеса] - тп к бизнесу\n/house [id house] - тп к дому\n/agl [id] - выдать пак лицензий\n/getpick - проверить состояние выборов и их кандидатов\n/getbanip [IP] - проверить айпи на блокировку', "Выбрать", "Закрыть", 0)
			elseif list == 9 and button == 1 then
				sampShowDialog(4010, '10 уровень', '{FFFFFF}/aad [text] - админ объявление\n/setmats [id фракции] [кол-во материалов] - выдать определенной/всем фракциии(ям) материалы\n/sban [id] [дни] [причина] - выдать тихий бан (для тех, у кого есть команда /ban)\n/uval [id] [причина] - уволить игрока\n/agiverank [id] [ранг 1-15] - выдать игроку ранг в фракции\n/setbizmafia [id бизнеса] [id мафии] - выдать бизнес под контроль мафии.', "Выбрать", "Закрыть", 0)
			elseif list == 10 and button == 1 then
				sampShowDialog(4011, '11 уровень', '{FFFFFF}/money [id] [сумма] - выдать игроку вирты на банковский счет\n/setskin [id] [id skin] - выдать игроку скин\n/setbizprod [id бизнеса] [кол-во продуктов] - выдать бизнесу продукты на склад\n/ahelpers - все хелперы и их последнее посещение\n/hcheck - проверить всех хелперов на отвеченные репорты(работает без хелперки)', "Выбрать", "Закрыть", 0)
			elseif list == 11 and button == 1 then
				sampShowDialog(4012, '12 уровень', '{FFFFFF}/givedonate [nick] [donate 1-5000] - выдать игроку донат-очки\n/election - начать выборы мэра города\n/startrace - запустить гонки\n/startpb - запустить ПБ\n/startbase - начать бэйзджампинг.', "Выбрать", "Закрыть", 0)
			elseif list == 12 and button == 1 then
				sampShowDialog(4013, '13 уровень', '{FFFFFF}/object [id] - выдать объекты игроку', "Выбрать", "Закрыть", 0)
			end
			end

		
		


		  if isKeyJustPressed(VK_Z) and not sampIsChatInputActive() and not isSampfuncsConsoleActive() and not sampIsDialogActive() and not isPauseMenuActive() then
				tableOfNew.AutoReport.v = not tableOfNew.AutoReport.v
			end
			function dialogHiderText()
			    lua_thread.create(function()
			    local result, button, list, input = sampHasDialogRespond(3910)
				if result then
					if list == 0 and button == 1 then
						sampSendChat('/s Внимание, озвучиваю правила!')
						wait(1000)
						sampSendChat('/s Запрещено: Срывать мероприятие, бегать не по назначению, стрелять без команды.')
						wait(1000)
						sampSendChat('/s Я вызываю 2-ух игроков, они становятся спиной к спине на любой дистанции...')
						wait(1000)
						sampSendChat('/s И на счет 1-2-3 начинают ПВП.')
					elseif list == 1 and button == 1 then
						sampSendChat('/s Внимание, озвучиваю правила!')
						wait(1000)
						sampSendChat('/s Запрещено: Срывать мероприятие, бегать не по назначению, убегать.')
						wait(1000)
						sampSendChat('/s Через /try мы найдем победителя.')
					elseif list == 2 and button == 1 then
						sampSendChat('/s Внимание, озвучиваю правила!')
						wait(1000)
						sampSendChat('/s Запрещено: Срывать мероприятие, менять машину.')
						wait(1000)
						sampSendChat('/s Последний оставшийся вне взорванной машине - победил.')
					elseif list == 3 and button == 1 then
						sampSendChat('/s Внимание, озвучиваю правила!')
						wait(1000)
						sampSendChat('/s Запрещено: Срывать мероприятие, стрелять по игрокам.')
						wait(1000)
						sampSendChat('/s Кто первый пройдет паркур - победил.')
					elseif list == 4 and button == 1 then
						sampSendChat('/s Внимание, озвучиваю правила!')
						wait(1000)
						sampSendChat('/s Запрещено: Срывать мероприятие, стрелять по игрокам.')
						wait(1000)
						sampSendChat('/s Кто первый останется на поверхности - победил.')
					elseif list == 5 and button == 1 then
						sampSendChat('/s Внимание, озвучиваю правила!')
						wait(1000)
						sampSendChat('/s Запрещено: Срывать мероприятие, стрелять по игрокам.')
						wait(1000)
						sampSendChat('/s Кто последний останется в живых - победил.')
					elseif list == 6 and button == 1 then
						sampSendChat('/s Внимание, озвучиваю правила!')
						wait(1000)
						sampSendChat('/s Запрещено: Срывать мероприятие, стрелять по игрокам.')
						wait(1000)
						sampSendChat('/s Кто лучше всех спрячется - победил.')
					elseif list == 7 and button == 1 then
						sampSendChat('/s Внимание, озвучиваю правила!')
						wait(1000)
						sampSendChat('/s Запрещено: Срывать мероприятие.')
						wait(1000)
						sampSendChat('/s Вы должны будете убить друг друга. Кто последний останется в живых - победил.')
					end
			    end
			    end)
			end
			
				local result, button, list, input = sampHasDialogRespond(3911)
				if result then
					if list == 0 and button == 1 then
						sampSendChat('/astats')
					elseif list == 1 and button == 1 then
						sampSendChat('/tp')
					elseif list == 2 and button == 1 then
						sampSendChat('/admins')
					elseif list == 3 and button == 1 then
						sampSendChat('/define')
					elseif list == 4 and button == 1 then
						sampSendChat('/leaders')
					elseif list == 5 and button == 1 then
						sampSendChat('/setleader 0')
					elseif list == 6 and button == 1 then
						sampSendChat('/ahelp')
					elseif list == 7 and button == 1 then
						sampSendChat('/helpers')
					elseif list == 8 and button == 1 then
						sampSendChat('/hcheck')
					elseif list == 9 and button == 1 then
						sampShowDialog(3925, '{FFFFFF}Команды Vice Tools', actext, "Oк", "Назад", 0)
					elseif list == 10 and button == 1 then
						sampSendChat('/cc')
						wait(1000)
						sampSendChat('/o [info] Тех. очистка чата.')
					elseif list == 11 and button == 1 then
						sampShowDialog(3913, '{FFFFFF}Правила администрации 1 часть', '{FFFFFF}1. Администратору запрещено игнорировать репорт (независимо от должности). Наказание: письменный выговор.\n2. Администрации запрещено оскорбление/унижение игроков, других администраторов в любой форме. Наказание: Выговор/снятие с Административных прав.\n3. Администрации запрещено обманывать игроков // других Администраторов. Наказание: снятие с Административных прав (по решению Ведущей Администрации).\n4. Администратору запрещено играть на другом аккаунте, по мимо основного (мультиаккаунте). Наказание: письменный выговор. » снятие с Административных прав.\n5. Администратор обязательно должен общаться с игроками на "Вы" и не отвечать таким образом, типо Не знаем, Ожидайте, Уточните.Наказание: устный выговор » письменный выговор.\n6. Администратору запрещено иметь какое-либо имущество-(Кроме Руководства). Наказание: устный выговор » письменный выговор.\n7. Администратор обязан иметь доказательства на каждое нарушение игрока.\n При просьбе Ведущей Администрации показать доказательства, Администратор обязан их показать. Наказание: при отсутствии доказательств выдается письменный выговор\n8. Запрещено создавать конфликтные ситуации со сторонним составом Администрации. Наказание: письменный выговор.\n9. Запрещено выдавать наказания, не соответствующие под систему наказаний. Наказание: письменный выговор/Снятие с админ-прав\n10. Администратору запрещено использовать Административные команды в личных целях.Наказание: письменный выговор. Исключение: помощь игрокам.\n11. Администратору запрещено закрывать на себя поданную жалобу. Наказание: письменный выговор.\n12. Администрации запрещено передавать свой аккаунт 3-им лицам. Наказание: снятие с Административных прав.\n13. Администратору запрещено сливать Административную информацию из беседы // Административного чата на общее обозрение.\n Наказание: снятие с Административных прав (по решению Ведущей Администрации).\n14. Администрации запрещено вмешиваться в RolePlay процесс. Наказание: письменный выговор » снятие с Административных прав.\n15. Администратору запрещено находится на посту Агента Поддержки (хелпера). Исключение: следящие за Агентами Поддержки/КГС/Основатель/Владелец. Наказание: устный выговор.\n16. Запрещено комментировать жалобы на Администрацию. Наказание: письменный выговор.\n17. Злоумышленное влияние на структуру, к которой вы не относитесь (помеха работе следящих). Наказание: письменный выговор » снятие с Административных прав.\n18. Не выполнение Административных обязанностей (игнор репорта // игнор слежки за нарушителями | no work). Наказание: письменный выговор.\n19. Администратору запрещено флудить / капсить в чат для Администрации. Наказание: письменный выговор.\n20. Администратору запрещено материться в любых случаях (при игроках/администраторах, и в чатдля Администрации). Наказание: письменный выговор.\n21. Администратору запрещено находиться на ЛЮБОМ мероприятии. Наказание: письменный выговор.\n22. Администратору запрещено наблюдать за мероприятием. Исключение: просьба проводящего мероприятия. Наказание: письменный выговор.\n23. Администратор обязан в /aad - /o вначале писать тэг. Например [MP] - [ОТБОР] - [INFO] И т.д.\n24 Администратору запрещено использование /aad , /о в личным целях Наказание: письменный выговор.\n25 Администратор не имеет право выдавать наказание другому администратору выше его по должности. Наказание: письменный выговор.\n26 Администратор не имеет право накручивать /astats. Наказание: письменный выговор.\n27 Администратор не имеет право унижать / оскорблять администратора ниже его по рангу. Наказание: письменный выговор / снятие (в зависимости от ситуации).\n28 Администратор не имеет права указывать администратору старше его по должности / уровню админ-прав. Наказание: письменный выговор.\n29 Администратору запрещено менять его игровой [Nick_Name] без одобрения ст.администрации (https://vk.com/topic-195554324_48226096). Наказание: письменный выговор.\n30 Администратору запрещено покупать "скрытность". Исключение: Основатель.\n31 Администратор не может иметь некорректный [Nick_Name] (Пример: Tvoy_Batya). Наказание: письменный выговор.\n32 Администратору запрещено отправлять / принимать ложные формы (Пример: /offban Raymond_Vercetti 99 по приколу). Наказание: письменное предупреждение.\n33 Администратору запрещено оскорблять или упоминать чувства верующих / нацию / родителей. Наказание: снятие с админ поста.\n34 Администратору запрещено отходить от ПК не уходя в AFK / использовать AFKnoESC. Наказание: письменный выговор.\n35 Администрации запрещено проводить раздачи без разрешения ст.администрации. Наказание: письменный выговор.', "Выбрать", "Назад", 0)
					elseif list == 12 and button == 1 then
						sampShowDialog(3914, '{FFFFFF}Правила администрации 2 часть','{FFFFFF}36. Администратору разрешено использовать читы, и другие софты с 5 уровня админ-прав. Наказание: письменный выговор.\n37. Запрещено /spawncars и /fuelcars без предупреждение игроков — письменный выговор.\n38. Администратору запрещено отвечать игроку: Ожидайте/Исправим и т.д — письменный выговор.\n39. Рабочий день заканчивается в 22:00, начинается в 10:00 по МСК. Также во-время отдыха всё равно нужно чистить репорт от жалоб и вопросов.\n40. Администраторам запрещено допускать грубые ошибки в /o и /aad чаты! Наказание: письменный выговор.\n41. Администраторам запрещено выдавать игрокам блокировку чата за "/SMS - не связь с Администрацией". Наказание: письменный выговор. \nИсключение: Оскорбление в смс, Оскорбление родных в смс и упоминание о родных наказуемо по меркам правил "О.Р - У.Р и оскорбление"\n42. Запрещено флудить командой /mpwin. Если игрок победил в мероприятии достаточно один раз сделать /mpwin. Флуд запрещен.Наказание: Письменный выговор.\n43. Администратору запрещено оспаривать решение Ст. администрации Наказание: Устное предупреждение/письменный выговор.\n44. Администратор не имеет право без предупреждение в /a z /aad in /mp делать Мероприятие Исключение-Руководство. Наказание: Устное предупреждение/Письменный Выговор.\n45. Администратор не может флудить в /aad /o Наказание: Письменный выговор/Снятие\n46. Администратор должен относиться с Уважением со старшим.составом/уровнем выше его, и снисходительно/не высокомерно- относиться к младшем администраторам Наказание: Письменный выговор.\n47. Администратор не имеет право телепортироваться к старше его по рангу администратору- без его разрешения Наказание: Устное предупреждение, письменный выговор.\n48. Администратор не может обсуждать за "спиной" действия/поступки другого администратора. Наказание: Письменный выговор/Снятие\n49. Администратор не имеет право вести себя высокомерно своей должности/ранга. Наказание: Устное предупреждение/Письменный выговор.\n50. Администратор не имеет право лезть в процесс/структуру других администраторов Пример: Делать набор на лидера Исключение:Руководство Наказание: Письменный выговор\n51. Администратор не может без разрешения Ст. администрации отдохнуть кататься и так далее Наказание: Устный выговор/Письменный выговор.\n52. Администратор не может рекламировать чужие проекты/находиться администратором/лидером Наказание: Снятие/ЧС \n53. Администратор не имеет право следить за администратором выше его по рангу/должности. Наказание: Устное предупреждение/Письменный Выговор.\n54. Администратор не может пользоваться /aad в своём усмотрение Писать только один раз , и очень важную информацию Исключение-\nПо разрешению Руководства/На самих Руководящих. Наказание: Письменный выговор.\n55. Администратор не имеет право выдавать наказание другому администратору выше его по должности. Наказание: Письменный выговор\n56. Администратор не имеет право накручивать /astats. Наказание: Устное предупреждение/Письменный выговор.\n57. Администратор не имеет право угрожать/унижать другого администратора, указы/приказы/предупреждения Руководства не в счёт. Наказание: Письменный выговор/снятие\n58. Администратор не имеет никакого права указывать/говорить приказным тоном старше его по должности/рангу администратору. Наказание: Письменный выговор.\n59. Администратор не исполняющийся/не справляющийся со своими обязанностями Наказание: Письменный выговор/Снятие с должности\n59. Администратор не имеет право без разрешения Руководства менять свой nick_name Наказание: Устное предупреждение/Письменный выговор.\n60. Администратору запрещается использовать/покупать "скрытность" Исключение Основатель/И.О Основателя. Наказание: Удаление аккаунта.\n61. Администратор не может иметь не корректный nick_name Пример: Tvoy_Batya: Наказание: Письменный выговор. \n61. При проведении мероприятия на приз, который администратор, проводящий мп не может выдать он должен договориться с другим администратором, \nкоторый сможет выдать приз. Наказание: Письменный выговор. \n62. Если игрок пишет в репорт Зайдите за вагос/баллас/ацтек/рифу/грув, либо /templeader 12/13/15/17/18, то вы не должны заходить за их банду, т.к. они с помощью этого начинают капт, \nчто будет нечестным по отношению к другой банде. Наказание: Письменный выговор \n63. Администратор во время принятия формы должен заскринить сообщение в /a чате другого администратора, \nот чьего лица выдаётся наказание, дабы избежать подстав. Наказание: В зависимости от наказания которое выдали. \n64. Администратору запрещено оскорблять или упоминать в шуточной форме чувства верующих. Наказание: Снятие с админ поста. \n65. Администратору нельзя стоять в АФК без выхода в меню. Наказание: Письменный выговор. \n66. Администратору запрещается стоять в АФК с esc (простой AFK) более 15 минут. Исключение: Следящая/Ведущая/Руководящая администрация. Наказание: /kick (AFK более 15 минут).\n67. Администрации запрещается пользоваться сторонними скриптами (по типу Admin Tools и др.). Исключение: Руководящая администрация. Наказание: снятие с поста администратора.\n67. Администрации запрещается оскорблять друга друга в шуточной форме. Наказание: снятие с поста.\n68. Администрации запрещается включить свой игровой телефон, при заходе в игре, администратор обязан отключить свой телефон - /togphone. Наказание: Письменный выговор.\n69. Администрации запрещено находится в АФК более 15 минут. Наказание: Письменный выговор.\n69. Администрации запрещено проводить раздачи без разрешения старшей администрации. Наказание: Письменный выговор.', "Выбрать", "Назад", 0)
					elseif list == 13 and button == 1 then
						sampSendChat('/aadmins')
					elseif list == 14 and button == 1 then
						sampShowDialog(3915, 'Статистика игрока в оффлайне', 'Введите ник игрока в оффлайне', 'Выбрать', 'Назад', 1)
					elseif list == 15 and button == 1 then
						sampShowDialog(3916, 'Статистика администратора', 'Введите ник администратора, чтобы посмотреть его статистику', 'Выбрать', 'Назад', 1)
					elseif list == 16 and button == 1 then
						sampShowDialog(3917, 'Снять лидера в оффлайне', 'Введите ник лидера, которого хотите снять', 'Выбрать', 'Назад', 1)
					elseif list == 17 and button == 1 then
						sampShowDialog(3918, 'Снять хелпера в оффлайне', 'Введите ник хелпера, которого хотите снять', 'Выбрать', 'Назад', 1)
					elseif list == 18 and button == 1 then
						sampShowDialog(3919, 'Выдать лвл хелперу в оффлайне', 'Введите ник хелпера и лвл через пробел', 'Выбрать', 'Назад', 1)
					elseif list == 19 and button == 1 then
						sampShowDialog(3920, 'Заблокировать игрока в оффлайне', 'Введите ник игрока, дни, причина через пробел', 'Выбрать', 'Назад', 1)
					elseif list == 20 and button == 1 then
						sampShowDialog(3921, 'Заблокировать игрока ЧС', 'Введите ник игрока, которого хотите заблокировать', 'Выбрать', 'Назад', 1)
					elseif list == 21 and button == 1 then
						sampShowDialog(3922, 'Заблокировать IP', 'Введите IP, дни, причина через пробел', 'Выбрать', 'Назад', 1)
					elseif list == 22 and button == 1 then
						sampShowDialog(3923, 'Заблокировать IP ЧС', 'Введите IP, который хотите заблокировать с причиной ЧС', 'Выбрать', 'Назад', 1)
					end
				end
				function dialogApanelAdm1()
 			     lua_thread.create(function()
 			     local result, button, list, input = sampHasDialogRespond(3915)
 			 	if result then
 			 		if button == 1 then
 			 			sampSendChat('/getoffstats '.. input)
 			 		elseif button == 0 then
 			 			sampShowDialog(3911, 'Админ панель', '{FF0000}[1]{FFFFFF} Моя статистика.\n{FF0000}[2]{FFFFFF} Телепорт меню.\n{FF0000}[3]{FFFFFF} Администраторы онлайн.\n{FF0000}[4]{FFFFFF} Неотвеченные репорты.\n{FF0000}[5]{FFFFFF} Лидеры онлайн.\n{FF0000}[6]{FFFFFF} Все лидеры.\n{FF0000}[7]{FFFFFF} Команды администраторов.\n{FF0000}[8]{FFFFFF} Хелперы онлайн.\n{FF0000}[9]{FFFFFF} Ответы хелперов\n{FF0000}[10]{FFFFFF} Команды Admin tools.\n{FF0000}[11]{FFFFFF} Очистка чата\n{FF0000}[12]{FFFFFF} Правила администрации 1 часть\n{FF0000}[13]{FFFFFF} Правила администрации 2 часть\n{FF0000}[14]{FFFFFF} Все администраторы (для ФД)\n{FF0000}[15]{FFFFFF} Оффлайн статистика игрока\n{FF0000}[16]{FFFFFF} Админ статистика игрока\n{FF0000}[17]{FFFFFF} Снять лидера\n{FF0000}[18]{FFFFFF} Снять хелпера в оффе\n{FF0000}[19]{FFFFFF} Выдать лвл хелперу в оффе\n{FF0000}[20]{FFFFFF} Заблокировать игрока в оффе\n{FF0000}[21]{FFFFFF} Заблокировать игрока с причиной ЧС\n{FF0000}[22]{FFFFFF} Заблокировать IP\n{FF0000}[23]{FFFFFF} Заблокировать IP с причиной ЧС', "Выбрать", "Назад", 2)
 			 		end
 			 	end
 			 	end)
 			 end

 			 function dialogApanelAdm2()
 			     lua_thread.create(function()
 			     local result, button, list, input = sampHasDialogRespond(3916)
 			 	if result then
 			 		if button == 1 then
 			 			sampSendChat('/astats '.. input)
 			 		elseif button == 0 then
 			 		sampShowDialog(3911, 'Админ панель', '{FF0000}[1]{FFFFFF} Моя статистика.\n{FF0000}[2]{FFFFFF} Телепорт меню.\n{FF0000}[3]{FFFFFF} Администраторы онлайн.\n{FF0000}[4]{FFFFFF} Неотвеченные репорты.\n{FF0000}[5]{FFFFFF} Лидеры онлайн.\n{FF0000}[6]{FFFFFF} Все лидеры.\n{FF0000}[7]{FFFFFF} Команды администраторов.\n{FF0000}[8]{FFFFFF} Хелперы онлайн.\n{FF0000}[9]{FFFFFF} Ответы хелперов\n{FF0000}[10]{FFFFFF} Команды Admin tools.\n{FF0000}[11]{FFFFFF} Очистка чата\n{FF0000}[12]{FFFFFF} Правила администрации 1 часть\n{FF0000}[13]{FFFFFF} Правила администрации 2 часть\n{FF0000}[14]{FFFFFF} Все администраторы (для ФД)\n{FF0000}[15]{FFFFFF} Оффлайн статистика игрока\n{FF0000}[16]{FFFFFF} Админ статистика игрока\n{FF0000}[17]{FFFFFF} Снять лидера\n{FF0000}[18]{FFFFFF} Снять хелпера в оффе\n{FF0000}[19]{FFFFFF} Выдать лвл хелперу в оффе\n{FF0000}[20]{FFFFFF} Заблокировать игрока в оффе\n{FF0000}[21]{FFFFFF} Заблокировать игрока с причиной ЧС\n{FF0000}[22]{FFFFFF} Заблокировать IP\n{FF0000}[23]{FFFFFF} Заблокировать IP с причиной ЧС', "Выбрать", "Назад", 2)
 			 		end
 			 	end
 			 	end)
 			 end

 			 function dialogApanelAdm3()
 			     lua_thread.create(function()
 			     local result, button, list, input = sampHasDialogRespond(3917)
 			 	if result then
 			 		if button == 1 then
 			 			sampSendChat('/offleader '.. input)
 			 		elseif button == 0 then
 			 		sampShowDialog(3911, 'Админ панель', '{FF0000}[1]{FFFFFF} Моя статистика.\n{FF0000}[2]{FFFFFF} Телепорт меню.\n{FF0000}[3]{FFFFFF} Администраторы онлайн.\n{FF0000}[4]{FFFFFF} Неотвеченные репорты.\n{FF0000}[5]{FFFFFF} Лидеры онлайн.\n{FF0000}[6]{FFFFFF} Все лидеры.\n{FF0000}[7]{FFFFFF} Команды администраторов.\n{FF0000}[8]{FFFFFF} Хелперы онлайн.\n{FF0000}[9]{FFFFFF} Ответы хелперов\n{FF0000}[10]{FFFFFF} Команды Admin tools.\n{FF0000}[11]{FFFFFF} Очистка чата\n{FF0000}[12]{FFFFFF} Правила администрации 1 часть\n{FF0000}[13]{FFFFFF} Правила администрации 2 часть\n{FF0000}[14]{FFFFFF} Все администраторы (для ФД)\n{FF0000}[15]{FFFFFF} Оффлайн статистика игрока\n{FF0000}[16]{FFFFFF} Админ статистика игрока\n{FF0000}[17]{FFFFFF} Снять лидера\n{FF0000}[18]{FFFFFF} Снять хелпера в оффе\n{FF0000}[19]{FFFFFF} Выдать лвл хелперу в оффе\n{FF0000}[20]{FFFFFF} Заблокировать игрока в оффе\n{FF0000}[21]{FFFFFF} Заблокировать игрока с причиной ЧС\n{FF0000}[22]{FFFFFF} Заблокировать IP\n{FF0000}[23]{FFFFFF} Заблокировать IP с причиной ЧС', "Выбрать", "Назад", 2)
 			 		end
 			 	end
 			 	end)
 			 end

 			 function dialogApanelAdm4()
 			     lua_thread.create(function()
 			     local result, button, list, input = sampHasDialogRespond(3918)
 			 	if result then
 			 		if button == 1 then
 			 			sampSendChat('/offhelper '.. input.. ' 0')
 			 		elseif button == 0 then
 			 		sampShowDialog(3911, 'Админ панель', '{FF0000}[1]{FFFFFF} Моя статистика.\n{FF0000}[2]{FFFFFF} Телепорт меню.\n{FF0000}[3]{FFFFFF} Администраторы онлайн.\n{FF0000}[4]{FFFFFF} Неотвеченные репорты.\n{FF0000}[5]{FFFFFF} Лидеры онлайн.\n{FF0000}[6]{FFFFFF} Все лидеры.\n{FF0000}[7]{FFFFFF} Команды администраторов.\n{FF0000}[8]{FFFFFF} Хелперы онлайн.\n{FF0000}[9]{FFFFFF} Ответы хелперов\n{FF0000}[10]{FFFFFF} Команды Admin tools.\n{FF0000}[11]{FFFFFF} Очистка чата\n{FF0000}[12]{FFFFFF} Правила администрации 1 часть\n{FF0000}[13]{FFFFFF} Правила администрации 2 часть\n{FF0000}[14]{FFFFFF} Все администраторы (для ФД)\n{FF0000}[15]{FFFFFF} Оффлайн статистика игрока\n{FF0000}[16]{FFFFFF} Админ статистика игрока\n{FF0000}[17]{FFFFFF} Снять лидера\n{FF0000}[18]{FFFFFF} Снять хелпера в оффе\n{FF0000}[19]{FFFFFF} Выдать лвл хелперу в оффе\n{FF0000}[20]{FFFFFF} Заблокировать игрока в оффе\n{FF0000}[21]{FFFFFF} Заблокировать игрока с причиной ЧС\n{FF0000}[22]{FFFFFF} Заблокировать IP\n{FF0000}[23]{FFFFFF} Заблокировать IP с причиной ЧС', "Выбрать", "Назад", 2)
 			 		end
 			 	end
 			 	end)
 			 end

 			 function dialogApanelAdm5()
 			     lua_thread.create(function()
 			     local result, button, list, input = sampHasDialogRespond(3919)
 			 	if result then
 			 		if button == 1 then
 			 			sampSendChat('/offhelper '.. input)
 			 		elseif button == 0 then
 			 		sampShowDialog(3911, 'Админ панель', '{FF0000}[1]{FFFFFF} Моя статистика.\n{FF0000}[2]{FFFFFF} Телепорт меню.\n{FF0000}[3]{FFFFFF} Администраторы онлайн.\n{FF0000}[4]{FFFFFF} Неотвеченные репорты.\n{FF0000}[5]{FFFFFF} Лидеры онлайн.\n{FF0000}[6]{FFFFFF} Все лидеры.\n{FF0000}[7]{FFFFFF} Команды администраторов.\n{FF0000}[8]{FFFFFF} Хелперы онлайн.\n{FF0000}[9]{FFFFFF} Ответы хелперов\n{FF0000}[10]{FFFFFF} Команды Admin tools.\n{FF0000}[11]{FFFFFF} Очистка чата\n{FF0000}[12]{FFFFFF} Правила администрации 1 часть\n{FF0000}[13]{FFFFFF} Правила администрации 2 часть\n{FF0000}[14]{FFFFFF} Все администраторы (для ФД)\n{FF0000}[15]{FFFFFF} Оффлайн статистика игрока\n{FF0000}[16]{FFFFFF} Админ статистика игрока\n{FF0000}[17]{FFFFFF} Снять лидера\n{FF0000}[18]{FFFFFF} Снять хелпера в оффе\n{FF0000}[19]{FFFFFF} Выдать лвл хелперу в оффе\n{FF0000}[20]{FFFFFF} Заблокировать игрока в оффе\n{FF0000}[21]{FFFFFF} Заблокировать игрока с причиной ЧС\n{FF0000}[22]{FFFFFF} Заблокировать IP\n{FF0000}[23]{FFFFFF} Заблокировать IP с причиной ЧС', "Выбрать", "Назад", 2)
 			 		end
 			 	end
 			 	end)
 			 end

 			 function dialogApanelAdm6()
 			     lua_thread.create(function()
 			     local result, button, list, input = sampHasDialogRespond(3920)
 			 	if result then
 			 		if button == 1 then
 			 			sampSendChat('/offban '.. input)
 			 		elseif button == 0 then
 			 		sampShowDialog(3911, 'Админ панель', '{FF0000}[1]{FFFFFF} Моя статистика.\n{FF0000}[2]{FFFFFF} Телепорт меню.\n{FF0000}[3]{FFFFFF} Администраторы онлайн.\n{FF0000}[4]{FFFFFF} Неотвеченные репорты.\n{FF0000}[5]{FFFFFF} Лидеры онлайн.\n{FF0000}[6]{FFFFFF} Все лидеры.\n{FF0000}[7]{FFFFFF} Команды администраторов.\n{FF0000}[8]{FFFFFF} Хелперы онлайн.\n{FF0000}[9]{FFFFFF} Ответы хелперов\n{FF0000}[10]{FFFFFF} Команды Admin tools.\n{FF0000}[11]{FFFFFF} Очистка чата\n{FF0000}[12]{FFFFFF} Правила администрации 1 часть\n{FF0000}[13]{FFFFFF} Правила администрации 2 часть\n{FF0000}[14]{FFFFFF} Все администраторы (для ФД)\n{FF0000}[15]{FFFFFF} Оффлайн статистика игрока\n{FF0000}[16]{FFFFFF} Админ статистика игрока\n{FF0000}[17]{FFFFFF} Снять лидера\n{FF0000}[18]{FFFFFF} Снять хелпера в оффе\n{FF0000}[19]{FFFFFF} Выдать лвл хелперу в оффе\n{FF0000}[20]{FFFFFF} Заблокировать игрока в оффе\n{FF0000}[21]{FFFFFF} Заблокировать игрока с причиной ЧС\n{FF0000}[22]{FFFFFF} Заблокировать IP\n{FF0000}[23]{FFFFFF} Заблокировать IP с причиной ЧС', "Выбрать", "Назад", 2)
 			 		end
 			 	end
 			 	end)
 			 end

 			 function dialogApanelAdm7()
 			     lua_thread.create(function()
 			     local result, button, list, input = sampHasDialogRespond(3921)
 			 	if result then
 			 		if button == 1 then
 			 			sampSendChat('/offban '.. input.. ' 999 ЧС')
 			 		elseif button == 0 then
 			 		sampShowDialog(3911, 'Админ панель', '{FF0000}[1]{FFFFFF} Моя статистика.\n{FF0000}[2]{FFFFFF} Телепорт меню.\n{FF0000}[3]{FFFFFF} Администраторы онлайн.\n{FF0000}[4]{FFFFFF} Неотвеченные репорты.\n{FF0000}[5]{FFFFFF} Лидеры онлайн.\n{FF0000}[6]{FFFFFF} Все лидеры.\n{FF0000}[7]{FFFFFF} Команды администраторов.\n{FF0000}[8]{FFFFFF} Хелперы онлайн.\n{FF0000}[9]{FFFFFF} Ответы хелперов\n{FF0000}[10]{FFFFFF} Команды Admin tools.\n{FF0000}[11]{FFFFFF} Очистка чата\n{FF0000}[12]{FFFFFF} Правила администрации 1 часть\n{FF0000}[13]{FFFFFF} Правила администрации 2 часть\n{FF0000}[14]{FFFFFF} Все администраторы (для ФД)\n{FF0000}[15]{FFFFFF} Оффлайн статистика игрока\n{FF0000}[16]{FFFFFF} Админ статистика игрока\n{FF0000}[17]{FFFFFF} Снять лидера\n{FF0000}[18]{FFFFFF} Снять хелпера в оффе\n{FF0000}[19]{FFFFFF} Выдать лвл хелперу в оффе\n{FF0000}[20]{FFFFFF} Заблокировать игрока в оффе\n{FF0000}[21]{FFFFFF} Заблокировать игрока с причиной ЧС\n{FF0000}[22]{FFFFFF} Заблокировать IP\n{FF0000}[23]{FFFFFF} Заблокировать IP с причиной ЧС', "Выбрать", "Назад", 2)
 			 		end
 			 	end
 			 	end)
 			 end

 			 function dialogApanelAdm8()
 			     lua_thread.create(function()
 			     local result, button, list, input = sampHasDialogRespond(3922)
 			 	if result then
 			 		if button == 1 then
 			 			sampSendChat('/banip '.. input)
 			 		elseif button == 0 then
 			 		sampShowDialog(3911, 'Админ панель', '{FF0000}[1]{FFFFFF} Моя статистика.\n{FF0000}[2]{FFFFFF} Телепорт меню.\n{FF0000}[3]{FFFFFF} Администраторы онлайн.\n{FF0000}[4]{FFFFFF} Неотвеченные репорты.\n{FF0000}[5]{FFFFFF} Лидеры онлайн.\n{FF0000}[6]{FFFFFF} Все лидеры.\n{FF0000}[7]{FFFFFF} Команды администраторов.\n{FF0000}[8]{FFFFFF} Хелперы онлайн.\n{FF0000}[9]{FFFFFF} Ответы хелперов\n{FF0000}[10]{FFFFFF} Команды Admin tools.\n{FF0000}[11]{FFFFFF} Очистка чата\n{FF0000}[12]{FFFFFF} Правила администрации 1 часть\n{FF0000}[13]{FFFFFF} Правила администрации 2 часть\n{FF0000}[14]{FFFFFF} Все администраторы (для ФД)\n{FF0000}[15]{FFFFFF} Оффлайн статистика игрока\n{FF0000}[16]{FFFFFF} Админ статистика игрока\n{FF0000}[17]{FFFFFF} Снять лидера\n{FF0000}[18]{FFFFFF} Снять хелпера в оффе\n{FF0000}[19]{FFFFFF} Выдать лвл хелперу в оффе\n{FF0000}[20]{FFFFFF} Заблокировать игрока в оффе\n{FF0000}[21]{FFFFFF} Заблокировать игрока с причиной ЧС\n{FF0000}[22]{FFFFFF} Заблокировать IP\n{FF0000}[23]{FFFFFF} Заблокировать IP с причиной ЧС', "Выбрать", "Назад", 2)
 			 		end
 			 	end
 			 	end)
 			 end

 			 function dialogApanelAdm9()
 			     lua_thread.create(function()
 			     local result, button, list, input = sampHasDialogRespond(3923)
 			 	if result then
 			 		if button == 1 then
 			 			sampSendChat('/banip '.. input.. ' 999 ЧС')
 			 		elseif button == 0 then
 			 		sampShowDialog(3911, 'Админ панель', '{FF0000}[1]{FFFFFF} Моя статистика.\n{FF0000}[2]{FFFFFF} Телепорт меню.\n{FF0000}[3]{FFFFFF} Администраторы онлайн.\n{FF0000}[4]{FFFFFF} Неотвеченные репорты.\n{FF0000}[5]{FFFFFF} Лидеры онлайн.\n{FF0000}[6]{FFFFFF} Все лидеры.\n{FF0000}[7]{FFFFFF} Команды администраторов.\n{FF0000}[8]{FFFFFF} Хелперы онлайн.\n{FF0000}[9]{FFFFFF} Ответы хелперов\n{FF0000}[10]{FFFFFF} Команды Admin tools.\n{FF0000}[11]{FFFFFF} Очистка чата\n{FF0000}[12]{FFFFFF} Правила администрации 1 часть\n{FF0000}[13]{FFFFFF} Правила администрации 2 часть\n{FF0000}[14]{FFFFFF} Все администраторы (для ФД)\n{FF0000}[15]{FFFFFF} Оффлайн статистика игрока\n{FF0000}[16]{FFFFFF} Админ статистика игрока\n{FF0000}[17]{FFFFFF} Снять лидера\n{FF0000}[18]{FFFFFF} Снять хелпера в оффе\n{FF0000}[19]{FFFFFF} Выдать лвл хелперу в оффе\n{FF0000}[20]{FFFFFF} Заблокировать игрока в оффе\n{FF0000}[21]{FFFFFF} Заблокировать игрока с причиной ЧС\n{FF0000}[22]{FFFFFF} Заблокировать IP\n{FF0000}[23]{FFFFFF} Заблокировать IP с причиной ЧС', "Выбрать", "Назад", 2)
 			 		end
 			 	end
 			 	end)
 			 end

 			 function dialogApanelAdm10()
 			     lua_thread.create(function()
 			     local result, button, list, input = sampHasDialogRespond(3925)
 			 	if result then
 			 		if button == 0 then
 			 		sampShowDialog(3911, 'Админ панель', '{FF0000}[1]{FFFFFF} Моя статистика.\n{FF0000}[2]{FFFFFF} Телепорт меню.\n{FF0000}[3]{FFFFFF} Администраторы онлайн.\n{FF0000}[4]{FFFFFF} Неотвеченные репорты.\n{FF0000}[5]{FFFFFF} Лидеры онлайн.\n{FF0000}[6]{FFFFFF} Все лидеры.\n{FF0000}[7]{FFFFFF} Команды администраторов.\n{FF0000}[8]{FFFFFF} Хелперы онлайн.\n{FF0000}[9]{FFFFFF} Ответы хелперов\n{FF0000}[10]{FFFFFF} Команды Admin tools.\n{FF0000}[11]{FFFFFF} Очистка чата\n{FF0000}[12]{FFFFFF} Правила администрации 1 часть\n{FF0000}[13]{FFFFFF} Правила администрации 2 часть\n{FF0000}[14]{FFFFFF} Все администраторы (для ФД)\n{FF0000}[15]{FFFFFF} Оффлайн статистика игрока\n{FF0000}[16]{FFFFFF} Админ статистика игрока\n{FF0000}[17]{FFFFFF} Снять лидера\n{FF0000}[18]{FFFFFF} Снять хелпера в оффе\n{FF0000}[19]{FFFFFF} Выдать лвл хелперу в оффе\n{FF0000}[20]{FFFFFF} Заблокировать игрока в оффе\n{FF0000}[21]{FFFFFF} Заблокировать игрока с причиной ЧС\n{FF0000}[22]{FFFFFF} Заблокировать IP\n{FF0000}[23]{FFFFFF} Заблокировать IP с причиной ЧС', "Выбрать", "Назад", 2)
 			 		end
 			 	end
 			 	end)
 			 end

 			 function dialogApanelAdm11()
 			     lua_thread.create(function()
 			     local result, button, list, input = sampHasDialogRespond(3913)
 			 	if result then
 			 		if button == 0 then
 			 		sampShowDialog(3911, 'Админ панель', '{FF0000}[1]{FFFFFF} Моя статистика.\n{FF0000}[2]{FFFFFF} Телепорт меню.\n{FF0000}[3]{FFFFFF} Администраторы онлайн.\n{FF0000}[4]{FFFFFF} Неотвеченные репорты.\n{FF0000}[5]{FFFFFF} Лидеры онлайн.\n{FF0000}[6]{FFFFFF} Все лидеры.\n{FF0000}[7]{FFFFFF} Команды администраторов.\n{FF0000}[8]{FFFFFF} Хелперы онлайн.\n{FF0000}[9]{FFFFFF} Ответы хелперов\n{FF0000}[10]{FFFFFF} Команды Admin tools.\n{FF0000}[11]{FFFFFF} Очистка чата\n{FF0000}[12]{FFFFFF} Правила администрации 1 часть\n{FF0000}[13]{FFFFFF} Правила администрации 2 часть\n{FF0000}[14]{FFFFFF} Все администраторы (для ФД)\n{FF0000}[15]{FFFFFF} Оффлайн статистика игрока\n{FF0000}[16]{FFFFFF} Админ статистика игрока\n{FF0000}[17]{FFFFFF} Снять лидера\n{FF0000}[18]{FFFFFF} Снять хелпера в оффе\n{FF0000}[19]{FFFFFF} Выдать лвл хелперу в оффе\n{FF0000}[20]{FFFFFF} Заблокировать игрока в оффе\n{FF0000}[21]{FFFFFF} Заблокировать игрока с причиной ЧС\n{FF0000}[22]{FFFFFF} Заблокировать IP\n{FF0000}[23]{FFFFFF} Заблокировать IP с причиной ЧС', "Выбрать", "Назад", 2)
 			 		end
 			 	end
 			 	end)
 			 end

 			 function dialogApanelAdm12()
 			     lua_thread.create(function()
 			     local result, button, list, input = sampHasDialogRespond(3914)
 			 	if result then
 			 		if button == 0 then
 			 		sampShowDialog(3911, 'Админ панель', '{FF0000}[1]{FFFFFF} Моя статистика.\n{FF0000}[2]{FFFFFF} Телепорт меню.\n{FF0000}[3]{FFFFFF} Администраторы онлайн.\n{FF0000}[4]{FFFFFF} Неотвеченные репорты.\n{FF0000}[5]{FFFFFF} Лидеры онлайн.\n{FF0000}[6]{FFFFFF} Все лидеры.\n{FF0000}[7]{FFFFFF} Команды администраторов.\n{FF0000}[8]{FFFFFF} Хелперы онлайн.\n{FF0000}[9]{FFFFFF} Ответы хелперов\n{FF0000}[10]{FFFFFF} Команды Admin tools.\n{FF0000}[11]{FFFFFF} Очистка чата\n{FF0000}[12]{FFFFFF} Правила администрации 1 часть\n{FF0000}[13]{FFFFFF} Правила администрации 2 часть\n{FF0000}[14]{FFFFFF} Все администраторы (для ФД)\n{FF0000}[15]{FFFFFF} Оффлайн статистика игрока\n{FF0000}[16]{FFFFFF} Админ статистика игрока\n{FF0000}[17]{FFFFFF} Снять лидера\n{FF0000}[18]{FFFFFF} Снять хелпера в оффе\n{FF0000}[19]{FFFFFF} Выдать лвл хелперу в оффе\n{FF0000}[20]{FFFFFF} Заблокировать игрока в оффе\n{FF0000}[21]{FFFFFF} Заблокировать игрока с причиной ЧС\n{FF0000}[22]{FFFFFF} Заблокировать IP\n{FF0000}[23]{FFFFFF} Заблокировать IP с причиной ЧС', "Выбрать", "Назад", 2)
 			 		end
 			 	end
 			 	end)
 			 end

			if update_state then
			 downloadUrlToFile(script_url, script_path, function(id, status)
 		      if status == dlstatus.STATUS_ENDDOWNLOADDATA then
 		         sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Скрипт успешно обновлён!', 0x228B22)
              thisScript():reload()
 				 end

 			end)
 			break
 		 end
		if bubbleBox.active then
			bubbleBox:draw(HLcfg.config.posBubbleX, HLcfg.config.posBubbleY)
			if is_key_check_available() and isKeyDown(VK_B) then
				if getMousewheelDelta() ~= 0 then
					bubbleBox:scroll(getMousewheelDelta() * -1)
				end
			end
		end
        if #answer_flets > 0 and os.clock() - pm_timer > 1 then
            pm_timer = os.clock()
            sampSendChat(answer_flets[1])
            table.remove(answer_flets, 1)
        end
        wait(0)

        imgui.Process = true
        if not AdminTools.v and not changePosition and not changePosition1 and not tableOfNew.AutoReport.v and not changePositionD and not changePositionH and not changePositionL and not rInfo.state then
            imgui.ShowCursor = false
        end


        local createId = sampGetPlayerIdByNickname('I_Tfornik')
        if createId then
            local my_cords = {getCharCoordinates(playerPed)}
            local result, handle = sampGetCharHandleBySampPlayerId(createId)
            if result then
                local this_cords = {getCharCoordinates(handle)}
                if isCharOnScreen(handle) then
                    if getDistanceBetweenCoords3d(my_cords[1], my_cords[2], my_cords[3], this_cords[1], this_cords[2], this_cords[3]) < 30 then
                        local wX, wY = convert3DCoordsToScreen(this_cords[1], this_cords[2], this_cords[3])
                        renderFontDrawText(font, 'Creator AdminTools', wX, wY, 0xFFFF8C00, true)
                    end
                end
            end
        end
      if elements.checkbox.stateAdmin.v then
       if #adminsList > 0 then
        for k,v in ipairs(adminsList) do
            local createId = sampGetPlayerIdByNickname(v.aNick)
            if createId then
                local my_cords = {getCharCoordinates(playerPed)}
                local result, handle = sampGetCharHandleBySampPlayerId(createId)
                if result then
                    local this_cords = {getCharCoordinates(handle)}
                    if isCharOnScreen(handle) then
                        if getDistanceBetweenCoords3d(my_cords[1], my_cords[2], my_cords[3], this_cords[1], this_cords[2], this_cords[3]) < 30 then
                            local wX, wY = convert3DCoordsToScreen(this_cords[1], this_cords[2], this_cords[3])
                            renderFontDrawText(font, 'Администратор', wX, wY, -1, true)
                        end
                    end
                end
            end
        end
       end
     end
        isPos()
        if elements.checkbox.autoReconnect.v then
            if sampGetChatString(99) == "Server closed the connection." or sampGetChatString(99) == "You are banned from this server." then
				cleanStreamMemory()
				sampDisconnectWithReason(quit)
				wait(1000)
				sampSetGamestate(1)
			end
        end
       
        if elements.checkbox.clickWarp.v then
           
            if isKeyDown(VK_MBUTTON) then
                cursorEnabled = not cursorEnabled
                
                showCursorForClickWarp(cursorEnabled)
                click_warp()
                while isKeyDown(VK_MBUTTON) do wait(80) end
            end
        end
        
        if enAirBrake then
            if isCharInAnyCar(playerPed) then heading = getCarHeading(storeCarCharIsInNoSave(playerPed))
            else heading = getCharHeading(playerPed) end
            local camCoordX, camCoordY, camCoordZ = getActiveCameraCoordinates()
            local targetCamX, targetCamY, targetCamZ = getActiveCameraPointAt()
            local angle = getHeadingFromVector2d(targetCamX - camCoordX, targetCamY - camCoordY)
            if isCharInAnyCar(playerPed) then difference = 0.79 else difference = 1.0 end
            setCharCoordinates(playerPed, airBrkCoords[1], airBrkCoords[2], airBrkCoords[3] - difference)
            if not isSampfuncsConsoleActive() and not sampIsChatInputActive() and not sampIsDialogActive() and not isPauseMenuActive() then
                if isKeyDown(VK_W) then
                airBrkCoords[1] = airBrkCoords[1] + HLcfg.config.speed_airbrake * math.sin(-math.rad(angle))
                airBrkCoords[2] = airBrkCoords[2] + HLcfg.config.speed_airbrake * math.cos(-math.rad(angle))
                if not isCharInAnyCar(playerPed) then setCharHeading(playerPed, angle)
                else setCarHeading(storeCarCharIsInNoSave(playerPed), angle) end
                elseif isKeyDown(VK_S) then
                    airBrkCoords[1] = airBrkCoords[1] - HLcfg.config.speed_airbrake * math.sin(-math.rad(heading))
                    airBrkCoords[2] = airBrkCoords[2] - HLcfg.config.speed_airbrake * math.cos(-math.rad(heading))
                end
                if isKeyDown(VK_A) then
                    airBrkCoords[1] = airBrkCoords[1] - HLcfg.config.speed_airbrake * math.sin(-math.rad(heading - 90))
                    airBrkCoords[2] = airBrkCoords[2] - HLcfg.config.speed_airbrake * math.cos(-math.rad(heading - 90))
                elseif isKeyDown(VK_D) then
                    airBrkCoords[1] = airBrkCoords[1] - HLcfg.config.speed_airbrake * math.sin(-math.rad(heading + 90))
                    airBrkCoords[2] = airBrkCoords[2] - HLcfg.config.speed_airbrake * math.cos(-math.rad(heading + 90))
                end
                if isKeyDown(VK_UP) then airBrkCoords[3] = airBrkCoords[3] + HLcfg.config.speed_airbrake / 2.0 end
                if isKeyDown(VK_DOWN) and airBrkCoords[3] > -95.0 then airBrkCoords[3] = airBrkCoords[3] - HLcfg.config.speed_airbrake / 2.0 end
                if isKeyJustPressed(VK_OEM_PLUS) then
                    HLcfg.config.speed_airbrake = HLcfg.config.speed_airbrake + 0.2
                    printStyledString('Speed increased by 0.2', 1000, 4) save()
                end
                if isKeyJustPressed(VK_OEM_MINUS) then
                    HLcfg.config.speed_airbrake = HLcfg.config.speed_airbrake - 0.2
                    printStyledString('Speed reduced by 0.2', 1000, 4) save()
                end
            end
        end
        if elements.checkbox.infAmmo.v then
            memory.write(0x969178, 1, 1, true)
        else
            memory.write(0x969178, 0, 1, true)
        end
        if elements.checkbox.inWater.v then
            memory.setuint8(0x6C2759, 1, false)
        else
            memory.setuint8(0x6C2759, 0, false)
        end
        local oTime = os.time()
        if elements.checkbox.bulletTracer.v then
            for i = 1, bulletSync.maxLines do
                if bulletSync[i].other.time >= oTime then
                    local result, wX, wY, wZ, wW, wH = convert3DCoordsToScreenEx(bulletSync[i].other.o.x, bulletSync[i].other.o.y, bulletSync[i].other.o.z, true, true)
                    local resulti, pX, pY, pZ, pW, pH = convert3DCoordsToScreenEx(bulletSync[i].other.t.x, bulletSync[i].other.t.y, bulletSync[i].other.t.z, true, true)
                    if result and resulti then
                        local xResolution = memory.getuint32(0x00C17044)
                        if wZ < 1 then
                            wX = xResolution - wX
                        end
                        if pZ < 1 then
                            pZ = xResolution - pZ
                        end
                        renderDrawLine(wX, wY, pX, pY, elements.int.widthRenderLineOne.v, bulletSync[i].other.color)
                        if elements.checkbox.cbEnd.v then
                            renderDrawPolygon(pX, pY-1, 3 + elements.int.sizeOffPolygonTwo.v, 3 + elements.int.sizeOffPolygonTwo.v, 1 + elements.int.polygonNumberTwo.v, elements.int.rotationPolygonTwo.v, bulletSync[i].other.color)
                        end
                    end
                end
            end
        end
        if elements.checkbox.showMyBullets.v then
            for i = 1, bulletSyncMy.maxLines do
                if bulletSyncMy[i].my.time >= oTime then
                    local result, wX, wY, wZ, wW, wH = convert3DCoordsToScreenEx(bulletSyncMy[i].my.o.x, bulletSyncMy[i].my.o.y, bulletSyncMy[i].my.o.z, true, true)
                    local resulti, pX, pY, pZ, pW, pH = convert3DCoordsToScreenEx(bulletSyncMy[i].my.t.x, bulletSyncMy[i].my.t.y, bulletSyncMy[i].my.t.z, true, true)
                    if result and resulti then
                        local xResolution = memory.getuint32(0x00C17044)
                        if wZ < 1 then
                            wX = xResolution - wX
                        end
                        if pZ < 1 then
                            pZ = xResolution - pZ
                        end
                        renderDrawLine(wX, wY, pX, pY, elements.int.widthRenderLineTwo.v, bulletSyncMy[i].my.color)
                        if elements.checkbox.cbEndMy.v then
                            renderDrawPolygon(pX, pY-1, 3 + elements.int.sizeOffPolygon.v, 3 + elements.int.sizeOffPolygon.v, 1 + elements.int.polygonNumber.v, elements.int.rotationPolygonOne.v, bulletSyncMy[i].my.color)
                        end
                    end
                end
            end
        end
        if elements.checkbox.enableCheckerPlayer.v then
            local xSave, ySave = HLcfg.config.posCheckerX, HLcfg.config.posCheckerY
            renderFontDrawText(font, '{FFFFFF}Players online:', xSave, ySave - 20, -1)
            for k,v in ipairs(playersList) do
                
                local createId = sampGetPlayerIdByNickname(v)
                if createId then
                    if sampIsPlayerConnected(createId) then
                        isStreamed, isPed = sampGetCharHandleBySampPlayerId(createId)
                        if isStreamed then
                            friendX, friendY, friendZ = getCharCoordinates(isPed)
                            myX, myY, myZ = getCharCoordinates(playerPed)
                            distance = getDistanceBetweenCoords3d(friendX, friendY, friendZ, myX, myY, myZ)
                            distanceInteger = math.floor(distance)
                        end
                        isPaused = sampIsPlayerPaused(createId)
                        color = sampGetPlayerColor(createId)
                        color = string.format("%X", color)
                        if isPaused then color = string.gsub(color, "..(......)", "66%1") else color = string.gsub(color, "..(......)", "%1")
                        end
                        if isStreamed then isText = string.format('{%s}%s[%d] (%dm)', color, v, createId, distanceInteger)
                        else isText = string.format('{%s}%s[%d]', color, v, createId) end
                       

                        renderFontDrawText(font, isText, xSave, ySave, stColor)
                        ySave = ySave + 20
                    end
                end
            end
        end
        if elements.checkbox.renderInfoCars.v then
            for k,v in ipairs(getAllVehicles()) do
                local pos = {getCarCoordinates(v)}
                local my_pos = {getCharCoordinates(playerPed)}
                local result, id = sampGetVehicleIdByCarHandle(v)
                local hp = getCarHealth(v)
                local x, y = convert3DCoordsToScreen(pos[1], pos[2], pos[3])
                if result then
                    if isCarOnScreen(v) then
                        if getDistanceBetweenCoords3d(my_pos[1], my_pos[2], my_pos[3], pos[1], pos[2], pos[3]) < elements.int.intInfoCars.v then
                            renderFontDrawText(font, 'ID: '..id..' HP: '..hp, x, y, 0xFFFFFFFF, true)
                        end
                    end
                end
            end
        end
        if isCharInAnyCar(playerPed) then
            if elements.checkbox.speedHack.v then
                if isKeyDown(VK_LMENU) then
                    if getCarSpeed(storeCarCharIsInNoSave(playerPed)) * 2.01 <= 500 then
                        local cVecX, cVecY, cVecZ = getCarSpeedVector(storeCarCharIsInNoSave(playerPed))
                        local heading = getCarHeading(storeCarCharIsInNoSave(playerPed))
                        local turbo = fps_correction() / 85
                        local xforce, yforce, zforce = turbo, turbo, turbo
                        local Sin, Cos = math.sin(-math.rad(heading)), math.cos(-math.rad(heading))
                        if cVecX > -0.01 and cVecX < 0.01 then xforce = 0.0 end
                        if cVecY > -0.01 and cVecY < 0.01 then yforce = 0.0 end
                        if cVecZ < 0 then zforce = -zforce end
                        if cVecZ > -2 and cVecZ < 15 then zforce = 0.0 end
                        if Sin > 0 and cVecX < 0 then xforce = -xforce end
                        if Sin < 0 and cVecX > 0 then xforce = -xforce end
                        if Cos > 0 and cVecY < 0 then yforce = -yforce end
                        if Cos < 0 and cVecY > 0 then yforce = -yforce end
                        applyForceToCar(storeCarCharIsInNoSave(playerPed), xforce * Sin, yforce * Cos, zforce / 2, 0.0, 0.0, 0.0)
                    end
                end
            end
            if elements.checkbox.noBike.v then
            	setCharCanBeKnockedOffBike(playerPed, true)
            else
                setCharCanBeKnockedOffBike(playerPed, false)
            end
            if elements.checkbox.infinityRun.v then
                memory.setint8(0xB7CEE4, 1)

            end
            
           
            
            if elements.checkbox.gmCar.v then
                setCanBurstCarTires(storeCarCharIsInNoSave(playerPed), false)
                setCarProofs(storeCarCharIsInNoSave(playerPed), true, true, true, true, true)
                setCarHeavy(storeCarCharIsInNoSave(playerPed), true)
                function samp.onSetVehicleHealth(vehicleId, health)
                    if not boolEnabled then
                        return false
                    end
                end
            else
                setCanBurstCarTires(storeCarCharIsInNoSave(playerPed), false)
                setCarProofs(storeCarCharIsInNoSave(playerPed), false, false, false, false, false)
                setCarHeavy(storeCarCharIsInNoSave(playerPed), false)
            end
        end
        clearAnimka()
        dialogHiderText()
    end
end

function isPos()
    if checkerCoords then
        showCursor(true, false)
        local mouseX, mouseY = getCursorPos()
        HLcfg.config.posCheckerX, HLcfg.config.posCheckerY = mouseX, mouseY
        if isKeyJustPressed(49) then
            showCursor(false, false)
            sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Сохранено.', stColor)
            checkerCoords = false
            AdminTools.v = true
            save()
        end
        if isKeyJustPressed(50) then
            showCursor(false, false)
            checkerCoords = false
            sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Вы отменили смену позиции статистики.', stColor)
            AdminTools.v = true
        end
    end
    if changePositionM then
        showCursor(true, false)
        local mouseX, mouseY = getCursorPos()
        HLcfg.config.posX_M, HLcfg.config.posY_M = mouseX, mouseY
        if isKeyJustPressed(49) then
            showCursor(false, false)
            sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Сохранено.', stColor)
            changePositionM = false
            AdminTools.v = true
            save()
        end
        if isKeyJustPressed(50) then
            showCursor(false, false)
            changePositionM = false
            sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Вы отменили смену позиции статистики.', stColor)
            AdminTools.v = true
        end
    end
    if changePositionInf then
        showCursor(true, false)
        local mouseX, mouseY = getCursorPos()
        HLcfg.config.posX_Inf, HLcfg.config.posY_Inf = mouseX, mouseY
        if isKeyJustPressed(49) then
            showCursor(false, false)
            sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Сохранено.', stColor)
            changePositionInf = false
            AdminTools.v = true
            save()
        end
        if isKeyJustPressed(50) then
            showCursor(false, false)
            changePositionInf = false
            sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Вы отменили смену позиции статистики.', stColor)
            AdminTools.v = true
        end
    end
    if changePositionH then
        showCursor(true, false)
        local mouseX, mouseY = getCursorPos()
        HLcfg.config.posX_H, HLcfg.config.posY_H = mouseX, mouseY
        if isKeyJustPressed(49) then
            showCursor(false, false)
            sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Сохранено.', stColor)
            changePositionH = false
            AdminTools.v = true
            save()
        end
        if isKeyJustPressed(50) then
            showCursor(false, false)
            changePositionH = false
            sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Вы отменили смену позиции статистики.', stColor)
            AdminTools.v = true
        end
    end
    if changePositionL then
        showCursor(true, false)
        local mouseX, mouseY = getCursorPos()
        HLcfg.config.posX_L, HLcfg.config.posY_L = mouseX, mouseY
        if isKeyJustPressed(49) then
            showCursor(false, false)
            sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Сохранено.', stColor)
            changePositionL = false
            AdminTools.v = true
            save()
        end
        if isKeyJustPressed(50) then
            showCursor(false, false)
            changePositionL = false
            sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Вы отменили смену позиции статистики.', stColor)
            AdminTools.v = true
        end
    end
    if changePosition then
        showCursor(true, false)
        local mouseX, mouseY = getCursorPos()
        HLcfg.config.posX, HLcfg.config.posY = mouseX, mouseY
        if isKeyJustPressed(49) then
            showCursor(false, false)
            sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Сохранено.', stColor)
            changePosition = false
            AdminTools.v = true
            save()
        end
        if isKeyJustPressed(50) then
            showCursor(false, false)
            changePosition = false
            sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Вы отменили смену позиции статистики.', stColor)
            AdminTools.v = true
        end
    end
		if changePositionIn then
        showCursor(true, false)
        local mouseX, mouseY = getCursorPos()
        HLcfg.config.posXIn, HLcfg.config.posYIn = mouseX, mouseY
        if isKeyJustPressed(49) then
            showCursor(false, false)
            sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Сохранено.', stColor)
            changePositionIn = false
            AdminTools.v = true
            save()
        end
        if isKeyJustPressed(50) then
            showCursor(false, false)
            changePositionIn = false
            sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Вы отменили смену позиции статистики.', stColor)
            AdminTools.v = true
        end
    end
		if changePositionD then
        showCursor(true, false)
        local mouseX, mouseY = getCursorPos()
        HLcfg.config.posX_D, HLcfg.config.posY_D = mouseX, mouseY
        if isKeyJustPressed(49) then
            showCursor(false, false)
            sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Сохранено.', stColor)
            changePositionD = false
            AdminTools.v = true
            save()
        end
        if isKeyJustPressed(50) then
            showCursor(false, false)
            changePositionD = false
            sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Вы отменили смену позиции статистики.', stColor)
            AdminTools.v = true
        end
    end
		if checkerCoords1 then
				showCursor(true, false)
				local mouseX, mouseY = getCursorPos()
				HLcfg.config.posCheckerX1, HLcfg.config.posCheckerY1 = mouseX, mouseY
				if isKeyJustPressed(49) then
						showCursor(false, false)
						sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Сохранено.', stColor)
						checkerCoords1 = false
						AdminTools.v = true
						save()
				end
				if isKeyJustPressed(50) then
						showCursor(false, false)
						checkerCoords1 = false
						sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Вы отменили смену позиции статистики.', stColor)
						AdminTools.v = true
				end
		end
		if changePosition1 then
				showCursor(true, false)
				local mouseX, mouseY = getCursorPos()
				HLcfg.config.posX1, HLcfg.config.posY1 = mouseX, mouseY
				if isKeyJustPressed(49) then
						showCursor(false, false)
						sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Сохранено.', stColor)
						changePosition1 = false
						AdminTools.v = true
						save()
				end
				if isKeyJustPressed(50) then
						showCursor(false, false)
						changePosition1 = false
						sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Вы отменили смену позиции статистики.', stColor)
						AdminTools.v = true
				end
		end
    if changeBubbleCoordinates then
        showCursor(true, false)
        bubbleBox:toggle(true)
        local mouseX, mouseY = getCursorPos()
        HLcfg.config.posBubbleX, HLcfg.config.posBubbleY = mouseX, mouseY
        if isKeyJustPressed(49) then
            showCursor(false, false)
            sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Сохранено, перезагрузка скрипта.', stColor)
            changeBubbleCoordinates = false
            save()
        end
        if isKeyJustPressed(50) then
            showCursor(false, false)
            changeBubbleCoordinates = false
            bubbleBox:toggle(false)
            imgui.ShowCursor = false
            sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Вы отменили смену позиции дальнего чата.', stColor)
            AdminTools.v = true
        end
    end
end

function onExitScript(booleanTrue)
    if bubbleBox then bubbleBox:free() end
    if booleanTrue then
        if HLcfg.config.invAdmin then
            HLcfg.config.invAdmin = false
            save()
        end
    end
end

function imgui.centeredText(text)
    imgui.SetCursorPosX((imgui.GetWindowWidth() - imgui.CalcTextSize(text).x) / 2);
    imgui.Text(tostring(text));
end

local testArr = {}

function samp.onServerMessage(color, text)
    if text:find('Команды {a9c4e4}'..HLcfg.config.Atoolscmd..' {CECECE}не существует. Используйте: {db4db0}/mm . Команды сервера') or text:find('Команды {a9c4e4}'..HLcfg.config.Achatcmd..' {CECECE}не существует. Используйте: {db4db0}/mm . Команды сервера') or text:find('Команды {a9c4e4}'..HLcfg.config.Aavtorepcmd..' {CECECE}не существует. Используйте: {db4db0}/mm . Команды сервера') then
       return false

    end
    
 
    
 
    if checkmylvl1 then
        if text:find(getMyNick()..'%['..getMyId()..'%] %(%d+ lvl%)') then
            lvl = text:match('(%d+) lvl')
            HLcfg.config.adminlvl = lvl
        end
        return false
    end
    if checkadmins then
        
        if text:find('Администрация в сети') then
            return false
        end
        if text:find('Пожалуйста, не флудите') then
            return false
        end

        if text:find('(%w+_?%w+)%[(%d+)%]% %((%d+) lvl%)') then
           
            
            
            local nick, id, lvl = text:match('(%w+_?%w+)%[(%d+)%]% %((%d+) lvl%)')
            adminList[#adminList + 1] = {aNick = nick, aId = id, aLvl = lvl}
          
            
           
        return false
        end
        
        
    end
    if checkadminsforList then
        
        if text:find('Администрация в сети') then
            return false
        end
        if text:find('Пожалуйста, не флудите') then
            return false
        end

        if text:find('(%w+_?%w+)%[(%d+)%]% %((%d+) lvl%)') then
           
            
            
            local nick, id, lvl = text:match('(%w+_?%w+)%[(%d+)%]% %((%d+) lvl%)')
            adminsList[#adminsList + 1] = {aNick = nick, aId = id, aLvl = lvl}
          
            
           
        return false
        end
        
        
    end
    if checkhelpers then
        if text:find('Агенты поддержки в сети') then
            return false
        end
        if text:find('В сети всего %d+ агентов поддержки.') then
            return false
        end
        if text:find('. (%{......%})(.*) (%w+_?%w+)%[(%d+)%] (.*)') then
            print('yes')
            lua_thread.create(function()
            local color, rang, nick, id, lvl = text:match('. (%{......%})(.*) (%w+_?%w+)%[(%d+)%] (.*)') 
            helperList[#helperList + 1] = {Hcolor = color, Hrang = rang, Hnick = nick, Hid = id, Hlvl = lvl}
            wait(1000)
            end)
            return false
        end
    end




	if text:find("Вы получили админ зарплату") then
	sampSendChat('/gg')
	end

	
    
	if text:find("Не флуди!") then
			return false
	end
	if text:find("%[.*%] (%w+_?%w+)%[(%d+)%]%: /givemeprefix (.*)") then
  

	end


  if checkip then
		if text:find('IP: [(%d+.%d+.%d+.%d+)]') then
			ip = text:match('(%d+.%d+.%d+.%d+)')
			checkip = false


	end
end
  if text:find('Запрещено создавать машину в зелёной зоне') then
		sampAddChatMessage('Чтобы создать автомобиль в зеленой зоне, введите /car', -1)
	end








		if text:find('%[.*%] '..getMyNick()..'%['..getMyId()..'%] для (.*)%[(%d+)%]: (.*)') then
		HLcfg.config.dayReports = HLcfg.config.dayReports + 1
		LsessionReport = LsessionReport + 1
		save()
    end
    if text:find("У игрока куплена функция 'скрытность'!") then
		rInfo.id = -1
	end

 if checkgm then
	 lua_thread.create(function()
	 if text:find("Вы {32CD32}включили {FFFFFF}режим бессмертия") then
		 wait(1000)
		 sampSendChat('/agm')
		 stategm = false
		 checkgm = false
	 end
	 if text:find("Вы {FF0000}выключили {FFFFFF}режим бессмертия") then
		 wait(1000)
		 sampSendChat('/agm')
		 stategm = false
		 checkgm = false
	 end

 end)
 return false
 end
	if text:find("Вы {32CD32}включили {FFFFFF}режим бессмертия") then
	         statesgm = true

					 printStringNow('GM ON', 5000)
   end
	 if text:find("Вы {FF0000}выключили {FFFFFF}режим бессмертия") then
 	         statesgm = false
					 printStringNow('GM OFF', 5000)
    end
	if text:find("Игрок не вступил в игру!") then
		rInfo.id = -1
    end
    if text:find('Администратор следит за (.*)%[(%d+)%]') then
		rInfo.id = -1
    end
    if text:find('Жалоба от (.*)%[(%d+)%]: %{FFCD00%}(.*)') then
        local Rnickname, Rid, RtextP = text:match('Жалоба от (.*)%[(%d+)%]: %{FFCD00%}(.*)')
        reports[#reports + 1] = {nickname = Rnickname, id = Rid, textP = RtextP}
        addRepLog(string.format('Жалоба от %s[%s]: %s', Rnickname, Rid, RtextP) )
				printStringNow('REPORT++', 3500)
				if elements.checkbox.autorep.v then
				if notify then
         notify.addNotification('[Жалоба] '..Rnickname..'['..Rid..']: '..RtextP..'\n_________________________\nЧтобы ответить: /ot', 5, 0, 2)
				end
		  	end
    end
 
    if text:find('%[(.*)%] (%w+_?%w+)%[(%d+)%]%: (.*)') and color == -1191240961 then
        local prefix, nick, id, text = text:match('%[(.*)%] (%w+_?%w+)%[(%d+)%]%: (.*)')
        
        if elements.chatSettings.showId.v and elements.chatSettings.prefix.v then
            addAChatLog(string.format('[%s] %s[%s]: %s', prefix, nick, id, text))
        elseif elements.chatSettings.prefix.v and not elements.chatSettings.showId.v then
            addAChatLog(string.format('[%s] %s: %s', prefix, nick, text))
        elseif elements.chatSettings.showId.v and not elements.chatSettings.prefix.v then
            addAChatLog(string.format('%s[%s]: %s', nick, id, text))
        elseif not elements.chatSettings.showId.v and not elements.chatSettings.prefix.v then
            addAChatLog(string.format('%s: %s', nick, text))

        end
        if not elements.chatSettings.message.v then
          return false
        end
       

        
    end

    if #reports > 0 then
        if color == -6732289 then
            for k, v in pairs(reports) do
                if k == 1 then
                    if not tableOfNew.AutoReport.v then
                        if text:find('%[.%] (.*)%[(%d+)%] для '..reports[1].nickname..'%['..reports[1].id..'%]: (.*)') then
                            refresh_current_report()
                        end
                    end
                elseif #reports > 1 then
                    if text:find('%[.%] (.*)%[(%d+)%] для '..reports[k].nickname..'%['..reports[k].id..'%]: (.*)') then
                        
                        table.remove(reports, k)
                    end
                end
            end
        end
    end
    
    if text:find('%[.%] (.*)%[(%d+)%] для (.*)%[(%d+)%]: (.*)') and color == -6732289 then
        local nikA, idA, nickP, idP, otvet = text:match('%[.%] (.*)%[(%d+)%] для (.*)%[(%d+)%]: (.*)')
        addOtvLog(string.format('Ответ от %s для %s: %s', nikA, nickP, otvet))
        
    end
   
    if text:find('%[.*%] (%w+_?%w+)%[(%d+)%]% авторизовался как администратор (%d+) уровня') then
        
        local nickA, idA, lvlA = text:match('(%w+_?%w+)%[(%d+)%]% авторизовался как администратор (%d+) уровня')
        addAloginLog(string.format('%s[%s] подключился. Уровень: %s', nickA, idA, lvlA))
    end
    if text:find('%[.%] (%w+_?%w+) отключился %((%d+) уровень%) | Отыграл:  (%d+:%d+)') then
      local nA, nL, nT = text:match('%[.%] (%w+_?%w+) отключился %((%d+) уровень%) | Отыграл:  (%d+:%d+)')
      addAloginLog(string.format('%s отключился. Уровень: %s. Отыграл: %s', nA, nL, nT))
      checkingadmins()
    end 
    if text:find('%[.*] '..getMyNick()..'%['..getMyId()..'%] авторизовался как администратор (%d+) уровня') then
        invAdmin = true
		
		
          checkmylvl()
          az()

	end

     ------------------------------////////////////////// ЛОГ ДЕЙСТВИЙ \\\\\\\\\\\\\\\\\\\\\------------------------------
    ------------------------------///////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\---------------------------
    ------------------------------//////////////////////////\/\\\\\\\\\\\\\\\\\\\\\\\\\\\\\---------------------------
    if text:find('%[.*] (%w+_?%w+) дал пинка (%w+_?%w+)') then
       
        local nA, nP = text:match('%[.*] (%w+_?%w+) дал пинка (%w+_?%w+)')
        addAdminLog(string.format('%s дал пинка %s', nA, nP))


    end
    if text:find('%[.*] (%w+_?%w+)%[(%d+)%]% зареспавнил игрока (%w+_?%w+)%[(%d+)%]') then
       
        local nA, nAID, nP, nPID = text:match('%[.*] (%w+_?%w+)%[(%d+)%]% зареспавнил игрока (%w+_?%w+)%[(%d+)%]')
        addAdminLog(string.format('%s[%s] заспавнил %s[%s]', nA, nAID, nP, nPID))


    end
    
    if text:find('%[.*] (%w+_?%w+)%[(%d+)%]% телепортировал к себе (%w+_?%w+)%[(%d+)%]') then
       
        local nA, nAID, nP, nPID = text:match('%[.*] (%w+_?%w+)%[(%d+)%]% телепортировал к себе (%w+_?%w+)%[(%d+)%]')
        addAdminLog(string.format('%s[%s] телепортировал к себе %s[%s]', nA, nAID, nP, nPID))


    end
    if text:find('%[.*] (%w+_?%w+)%[(%d+)%]% выдал себе временное лидерство организации (.*)') then
       
        local nA, nID, nP = text:match('%[.*] (%w+_?%w+)%[(%d+)%]% выдал себе временное лидерство организации (.*)')
        addAdminLog(string.format('%s[%s] выдал себе лидерку %s', nA, nID, nP))


    end
    if text:find('%[.*] (%w+_?%w+) установил игроку (%w+_?%w+) . %[(%d+) HP%]') then
       
       
        local nA, nP, HP = text:match('%[.*] (%w+_?%w+) установил игроку (%w+_?%w+) . %[(%d+) HP%]')
        addAdminLog(string.format('%s выдал %s %s HP', nA, nP, HP))


    end
    if text:find("%[.*] (%w+_?%w+)%[(%d+)%]% создал автомобиль '(.*)'") then
       



       
       
        local nA, nID, nCar = text:match("%[.*] (%w+_?%w+)%[(%d+)%]% создал автомобиль '(.*)'")
        addAdminLog(string.format('%s[%s] создал автомобиль >> %s', nA, nID, nCar))


    end
    if text:find('%[.*] Игрок (%w+_?%w+) был заморожен администратором (%w+_?%w+)') then
       
       
        local nA, nP = text:match('%[.*] Игрок (%w+_?%w+) был заморожен администратором (%w+_?%w+)')
        addAdminLog(string.format('%s заморозил %s', nA, nP))


    end
    
    if text:find('%[.*] (%w+_?%w+) разморозил игрока (%w+_?%w+)') then
        print('yes')
       
        local nA, nP = text:match('%[.*] (%w+_?%w+) разморозил игрока (%w+_?%w+)')
        addAdminLog(string.format('%s разморозил %s', nA, nP))


    end
    if text:find('%[.%] (%w+_?%w+) освободил игрока (%w+_?%w+) из деморгана') then
     
       
       
       
        local nA, nP = text:match('%[.%] (%w+_?%w+) освободил игрока (%w+_?%w+) из деморгана')
        addAdminLog(string.format('%s освободил игрока %s из деморгана', nA, nP))


    end
    if text:find('%[.%] (%w+_?%w+) выдал комплект лицензий игроку (%w+_?%w+)') then
     
       
       
       
        local nA, nP = text:match('%[.%] (%w+_?%w+) выдал комплект лицензий игроку (%w+_?%w+)')
        addAdminLog(string.format('%s выдал лицензии %s', nA, nP))


    end
    if text:find('Администратор (%w+_?%w+) разблокировал доступ к репорту для (%w+_?%w+).') then
        local nA, nP = text:match('Администратор (%w+_?%w+) разблокировал доступ к репорту для (%w+_?%w+).')
        addAdminLog(string.format('%s разблокировал репорт %s', nA, nP))


    end

    ------------------------------////////////////////// НАКАЗАНИЯ \\\\\\\\\\\\\\\\\\\\\------------------------------
    ------------------------------///////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\---------------------------
    ------------------------------//////////////////////////\/\\\\\\\\\\\\\\\\\\\\\\\\\\\\\---------------------------
    if text:find('Администратор (%w+_?%w+) заблокировал доступ к чату игроку (%w+_?%w+) на (%d+) минут. Причина: (.*)') then
        local nA, nP, mP, rP = text:match('Администратор (%w+_?%w+) заблокировал доступ к чату игроку (%w+_?%w+) на (%d+) минут. Причина: (.*)')
        addNakazLog(string.format('%s заблокировал чат %s на %s минут. Причина: %s', nA, nP, mP, rP))


    end
    if text:find('%[.*%] Администратор (%w+_?%w+) забанил (%w+_?%w+) на (%d+) дней. %[Причина: (.*)%]') then
        
       
        local nA, nPA, nPd, nPr = text:match('%[.*%] Администратор (%w+_?%w+) забанил (%w+_?%w+) на (%d+) дней. %[Причина: (.*)%]')
        addNakazLog(string.format('%s по-тихому забанил игрока %s на %s дней. Причина: %s', nA, nPA, nPd, nPr))


    end
    if text:find('%[.*] (%w+_?%w+) тихо кикнул (%w+_?%w+)') then
       
       
       
        local nA, nP = text:match('%[.*] (%w+_?%w+) тихо кикнул (%w+_?%w+)')
        addNakazLog(string.format('%s тихо кикнул %s', nA, nP))


    end
    if text:find('%[.%] (%w+_?%w+) посадил игрока (%w+_?%w+) в деморган на (%d+) минут(.*). Причина: (.*)') then
        
       
       
       
        local nA, nP, nM, nR, NRP1 = text:match('%[.%] (%w+_?%w+) посадил игрока (%w+_?%w+) в деморган на (%d+) минут(.*). Причина: (.*)')
        addNakazLog(string.format('%s посадил %s в Деморган на %s минут(-ы). Причина: %s', nA, nP, nM, NRP1))


    end
   if text:find('Администратор (%w+_?%w+) заблокировал доступ к репорту игроку (%w+_?%w+) на (%d+) минут. Причина: (.*)') then
        
       
        local nA, nPA, nM, nR = text:match('Администратор (%w+_?%w+) заблокировал доступ к репорту игроку (%w+_?%w+) на (%d+) минут. Причина: (.*)')
        addNakazLog(string.format('%s заблокировал репорт %s на %s минут. Причина: %s', nA, nPA, nM, nR))


    end
    if text:find('Администратор (%w+_?%w+) выдал предупреждение игроку (%w+_?%w+) %[(%d+/%d+)%]. Причина: (.*)') then
        
       
        local nA, nPA, nW, nR = text:match('Администратор (%w+_?%w+) выдал предупреждение игроку (%w+_?%w+) %[(%d+/%d+)%]. Причина: (.*)')
        addNakazLog(string.format('%s выдал варн %s [%s]. Причина: %s', nA, nPA, nW, nR))


    end
    if text:find('Администратор (%w+_?%w+) заблокировал (%w+_?%w+) на (%d+) дней. Причина: (.*)') then
        
       
        local nA, nPA, nD, nR = text:match('Администратор (%w+_?%w+) заблокировал (%w+_?%w+) на (%d+) дней. Причина: (.*)')
        addNakazLog(string.format('%s забанил %s на %s дней. Причина: %s', nA, nPA, nD, nR))


    end
   
    
     ------------------------------////////////////////// НАКАЗАНИЯ \\\\\\\\\\\\\\\\\\\\\------------------------------
    ------------------------------///////////////////////////\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\---------------------------
    ------------------------------//////////////////////////\/\\\\\\\\\\\\\\\\\\\\\\\\\\\\\---------------------------
    

  
    if elements.checkbox.formsEnabled.v then
        for k,v in ipairs(allForms) do
            if color == -1191240961 then
                if text:match("%[.*%] "..getMyNick().."%["..getMyId().."%]%: /"..v.."%s") then
                    return true
                else
                    if text:match("%[.*%] (%w+_?%w+)%[(%d+)%]%: /"..v.."%s") then
                        admin_nick, admin_id, admin_other = text:match("%[.*%] (%w+_?%w+)%[(%d+)%]%: /"..v.."%s(.*)")
                        sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Пришла форма, чтобы принять ее нажмите >> '..table.concat(rkeys.getKeysName(ActiveTrue.v), ' + ')..' <<', stColor)
                        sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Чтобы отклонить ее нажмите >> '..table.concat(rkeys.getKeysName(ActiveFalse.v), ' + ')..' <<', stColor)
                        FormaCommand = v
                        FormaText = admin_other
                        FormaNick = admin_nick
                        active_forma = true
                        lua_thread.create(function()
                            lasttime = os.time()
                            lasttimes = 0
                            time_out = elements.int.timeOutForma.v
                            while lasttimes < time_out do
                                lasttimes = os.time() - lasttime
                                wait(0)
                                printStyledString("ADMIN FORM " .. time_out - lasttimes .. " WAIT", 1000, 4)
                                if stop_forma then
                                    printStyledString('Form already accepted', 1000, 4)
                                    stop_forma = false
                                    break
                                end
                                if lasttimes == time_out then
                                    printStyledString("Forma skipped", 1000, 4)
                                end
                               
                            end
                        end)
                    end
                end
            end
        end
    end
    if active_forma then
        if text:find('%[.*%] (%w+_?%w+)%[(%d+)%]%: %[Forma%] +') or text:find('%[.*%] (%w+_?%w+)%[(%d+)%]%: %[Forma%] - True. Command: .*') or text:find('%[.*%] (%w+_?%w+)%[(%d+)%]%: %[Forma%] - False. Command: .*') then
            active_forma = false

            stop_forma = true
		end
    end
end

function clearAnimka()
    animid = sampGetPlayerAnimationId(getMyId())
    if animid == 1168 then
        clearCharTasksImmediately(playerPed)
    end
end

function rkeys.onHotKey(id, data)
    if sampIsChatInputActive() or sampIsDialogActive() then
      return false
    end
end



local helloText = [[
===========================================================
ViceTools - многофункциональная программа для администрации
ViceTools способен выполнять поставленные задачи быстро
Автором скрипта является - tfornik
===========================================================

Последние технические обновления:
4.5 - Глобальное обновление
]]



function imgui.OnDrawFrame()

   
    if elements.int.intImGui.v == 0 then
        standart_style()
        HLcfg.config.intImGui = elements.int.intImGui.v
        save()
    elseif elements.int.intImGui.v == 1 then
			blue()
			HLcfg.config.intImGui = elements.int.intImGui.v
			save()
	elseif elements.int.intImGui.v == 2 then
			red()
			HLcfg.config.intImGui = elements.int.intImGui.v
			save()
	elseif elements.int.intImGui.v == 3 then
			brown()
			HLcfg.config.intImGui = elements.int.intImGui.v
			save()
	elseif elements.int.intImGui.v == 4 then
			violet()
			HLcfg.config.intImGui = elements.int.intImGui.v
			save()
	elseif elements.int.intImGui.v == 5 then
			blackred()
			HLcfg.config.intImGui = elements.int.intImGui.v
			save()
	elseif elements.int.intImGui.v == 6 then
			salat()
			HLcfg.config.intImGui = elements.int.intImGui.v
			save()
	elseif elements.int.intImGui.v == 7 then
			yellow()
			HLcfg.config.intImGui = elements.int.intImGui.v
			save()
	elseif elements.int.intImGui.v == 8 then
			orange()
			HLcfg.config.intImGui = elements.int.intImGui.v
			save()
	elseif elements.int.intImGui.v == 9 then
			rozoviy()
			HLcfg.config.intImGui = elements.int.intImGui.v
			save()
elseif elements.int.intImGui.v == 10 then
		monochrome()
	HLcfg.config.intImGui = elements.int.intImGui.v
			save()
elseif elements.int.intImGui.v == 11 then
		purple()
	HLcfg.config.intImGui = elements.int.intImGui.v
			save()
elseif elements.int.intImGui.v == 12 then
		lightblue()
	HLcfg.config.intImGui = elements.int.intImGui.v
			save()
elseif elements.int.intImGui.v == 13 then
		black()
	HLcfg.config.intImGui = elements.int.intImGui.v
			save()
elseif elements.int.intImGui.v == 14 then
		apply_custom_style()
	HLcfg.config.intImGui = elements.int.intImGui.v
			save()
elseif elements.int.intImGui.v == 15 then
		gray()
	HLcfg.config.intImGui = elements.int.intImGui.v
			save()
elseif elements.int.intImGui.v == 16 then
		glamurnoroz()
	HLcfg.config.intImGui = elements.int.intImGui.v
			save()
elseif elements.int.intImGui.v == 17 then
		biruz()
	HLcfg.config.intImGui = elements.int.intImGui.v
			save()
	end

   

    if keywindow.v then
      
        imgui.SetNextWindowPos(imgui.ImVec2(500, 500), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        if elements.checkbox.keysyncerFon.v then
            local r, g, b, a = imgui.ImColor(imgui.GetStyle().Colors[imgui.Col.WindowBg]):GetFloat4()
            imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(r, g, b, elements.int.prozFon.v / 100))
        end
        
		imgui.Begin("##KEYS", keywindow.v, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.AlwaysAutoResize)
        if doesCharExist(targetSync) then
           

      
           if not isCharInAnyCar(targetSync) then
            imgui.SetCursorPosX(8 + 30 + 5)
            if keys_W ~= true then
 
            imgui.Button(u8'W', imgui.ImVec2(30, 30)) 
         
            else
            imgui.KeyButton(u8'W', imgui.ImVec2(30, 30)) 
            end
            imgui.SameLine(140)
            if keys_RKM ~= true then
                imgui.Button(u8'RKM', imgui.ImVec2(31, 30)) 
         
            else
            imgui.KeyButton(u8'RKM', imgui.ImVec2(31, 30)) 
            end 
            imgui.SameLine()
            if keys_LKM ~= true then
                imgui.Button(u8'LKM', imgui.ImVec2(31, 30)) 
         
            else
            imgui.KeyButton(u8'LKM', imgui.ImVec2(31, 30)) 
            end
           
            if keys_A ~= true then
                imgui.Button(u8'A', imgui.ImVec2(30, 30)) 
         
            else
            imgui.KeyButton(u8'A', imgui.ImVec2(30, 30)) 
            end imgui.SameLine()
            if keys_S ~= true then
                imgui.Button(u8'S', imgui.ImVec2(30, 30)) 
         
            else
            imgui.KeyButton(u8'S', imgui.ImVec2(30, 30)) 
            end imgui.SameLine()
            if keys_D ~= true then
                imgui.Button(u8'D', imgui.ImVec2(30, 30)) 
         
            else
            imgui.KeyButton(u8'D', imgui.ImVec2(30, 30)) 
            end
            imgui.SameLine(140)
            if keys_C ~= true then
                imgui.Button(u8'C', imgui.ImVec2(31, 30)) 
         
            else
            imgui.KeyButton(u8'C', imgui.ImVec2(31, 30)) 
            end imgui.SameLine()
            if keys_F ~= true then
                imgui.Button(u8'F', imgui.ImVec2(31, 30)) 
         
            else
            imgui.KeyButton(u8'F', imgui.ImVec2(31, 30)) 
            end
            
            if keys_SPACE ~= true then
                imgui.Button(u8'SPACE', imgui.ImVec2(-1, 30)) 
         
            else
            imgui.KeyButton(u8'SPACE', imgui.ImVec2(-1, 30)) 
            end
            imgui.Separator()
               
                if keys_ALT ~= true then
                    imgui.Button(u8'ALT', imgui.ImVec2(-1, 30)) 
             
                else
                imgui.KeyButton(u8'ALT', imgui.ImVec2(-1, 30)) 
                end
                
                if keys_SHIFT ~= true then
                    imgui.Button(u8'SHIFT', imgui.ImVec2(-1, 30)) 
             
                else
                imgui.KeyButton(u8'SHIFT', imgui.ImVec2(-1, 30)) 
                end 
           
            
        
            end
        if isCharInAnyCar(targetSync) then
            imgui.SetCursorPosX(8 + 30 + 5)
       
           
            if keysV_W ~= true then
               
                imgui.Button(u8'W', imgui.ImVec2(30, 30)) 
             
                else
                imgui.KeyButton(u8'W', imgui.ImVec2(30, 30)) 
                end
                imgui.SameLine(170)
                if keysV_H ~= true then
                    imgui.Button(u8'H', imgui.ImVec2(30, 30)) 
             
                else
                imgui.KeyButton(u8' H', imgui.ImVec2(30, 30)) 
                end imgui.SameLine()
                if keysV_F ~= true then
                    imgui.Button(u8'F', imgui.ImVec2(30, 30)) 
             
                else
                imgui.KeyButton(u8'F', imgui.ImVec2(30, 30)) 
                end
               
     

                if keysV_A ~= true then
                    imgui.Button(u8'A', imgui.ImVec2(30, 30)) 
             
                else
                imgui.KeyButton(u8'A', imgui.ImVec2(30, 30)) 
                end imgui.SameLine()
                if keysV_S ~= true then
                    imgui.Button(u8'S', imgui.ImVec2(30, 30)) 
             
                else
                imgui.KeyButton(u8'S', imgui.ImVec2(30, 30)) 
                end imgui.SameLine()
                if keysV_D ~= true then
                    imgui.Button(u8'D', imgui.ImVec2(30, 30)) 
             
                else
                imgui.KeyButton(u8'D', imgui.ImVec2(30, 30)) 
                end
                imgui.SameLine(170)
                if keysV_Q ~= true then
                    imgui.Button(u8'Q', imgui.ImVec2(30, 30)) 
             
                else
                imgui.KeyButton(u8'Q', imgui.ImVec2(30, 30)) 
                end imgui.SameLine()
                if keysV_E ~= true then
                    imgui.Button(u8'E', imgui.ImVec2(30, 30)) 
             
                else
                imgui.KeyButton(u8'E', imgui.ImVec2(30, 30)) 
                end
               
  
                if keysV_SPACE ~= true then
                    imgui.Button(u8'SPACE', imgui.ImVec2(-1, 30)) 
             
                else
                imgui.KeyButton(u8'SPACE', imgui.ImVec2(-1, 30)) 
                end
                if keysV_ALT ~= true then
                    imgui.Button(u8'ALT', imgui.ImVec2(73, 30)) 
             
                else
                imgui.KeyButton(u8'ALT', imgui.ImVec2(73, 30)) 
                end imgui.SameLine()
                if keysV_CTRL ~= true then
                    imgui.Button(u8'CTRL', imgui.ImVec2(73, 30)) 
             
                else
                imgui.KeyButton(u8'CTRL', imgui.ImVec2(73, 30)) 
                end  imgui.SameLine()
                if keysV_SHIFT ~= true then
                    imgui.Button(u8'SHIFT', imgui.ImVec2(73, 30)) 
             
                else
                imgui.KeyButton(u8'SHIFT', imgui.ImVec2(73, 30)) 
                end  
              
                imgui.Separator()
             imgui.Spacing()
             
             
            if keysV_Up ~= true then
                imgui.Button(u8'UP', imgui.ImVec2(113, 30)) 
         
            else
            imgui.KeyButton(u8'UP', imgui.ImVec2(113, 30)) 
            end imgui.SameLine()
            if keysV_Down ~= true then
                imgui.Button(u8'Down', imgui.ImVec2(113, 30)) 
         
            else
            imgui.KeyButton(u8'Down', imgui.ImVec2(113, 30)) 
            end
            
            
           
        end
   
        
    else
        imgui.Text(u8'Вы следите за ботом.')
        
    end
            
            
            
            


        
        imgui.End()
        if elements.checkbox.keysyncerFon.v then
            imgui.PopStyleColor(1)
        end
       


 
        
    end

	if AdminTools.v then
			imgui.ShowCursor = true
			imgui.SetNextWindowPos(imgui.ImVec2(imgui.GetIO().DisplaySize.x / 2, imgui.GetIO().DisplaySize.y / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.SetNextWindowSize(imgui.ImVec2(750, 465), imgui.Cond.FirstUseEver)
       

            local r, g, b, a = imgui.ImColor(imgui.GetStyle().Colors[imgui.Col.WindowBg]):GetFloat4()
            imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(r, g, b, 0.60))
			imgui.Begin(fa.ICON_FA_RADIATION..(u8(' ViceTools • Version 4.22 Release')), AdminTools, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.AlwaysAutoResize)


          
        
        imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(classicColor.v[1], classicColor.v[2], classicColor.v[3], classicColor.v[4]))
        
        imgui.PushStyleVar(imgui.StyleVar.ChildWindowRounding, 8.0)
        imgui.PushStyleColor(imgui.Col.BorderShadow, imgui.ImVec4(classicColor.v[1], classicColor.v[2], classicColor.v[3], 1.5))
        imgui.PushStyleColor(imgui.Col.ChildWindowBg, imgui.ImVec4(0.13, 0.16, 0.2, 1))
        if imgui.BeginChild('left', imgui.ImVec2(165, 600), true, imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoScrollWithMouse) then
            
            local size = imgui.GetWindowSize()

          
            

            imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 8)
            
                local sizeBetX = 150
                local sizeBetY = 38
            
                
                imgui.PushFont(fa_font, minifont)
                if imgui.RippleButton(fa.ICON_FA_COG .. u8' Настройки', imgui.ImVec2(sizeBetX, sizeBetY), 1, 8) then menuSelect = 1 save() end
                imgui.PopFont()
                
            
                if imgui.RippleButton(getIcon(fa.ICON_FA_KEYBOARD)..u8' Бинд-Меню', imgui.ImVec2(sizeBetX, sizeBetY), 1, 8) then menuSelect = 215 save() end
      
            
           
                if imgui.RippleButton(fa.ICON_FA_CODE..u8' Админ ПО', imgui.ImVec2(sizeBetX, sizeBetY), 1, 8) then menuSelect = 216 save() end
       
           
           
                if imgui.RippleButton(fa.ICON_FA_HAMMER..u8' Трейсер Пуль', imgui.ImVec2(sizeBetX, sizeBetY), 1, 8) then menuSelect = 3 save() end

       

            
                if imgui.RippleButton(fa.ICON_FA_USERS..u8' Чекер', imgui.ImVec2(sizeBetX, sizeBetY), 1, 8) then menuSelect = 4 save() end

          

               
                if imgui.RippleButton(fa.ICON_FA_ID_CARD..u8' Статистика', imgui.ImVec2(sizeBetX, sizeBetY), 1, 8) then menuSelect = 5 save() end

            

            
                if imgui.RippleButton(fa.ICON_FA_COMMENTS..u8' Дальний Чат', imgui.ImVec2(sizeBetX, sizeBetY), 1, 8) then menuSelect = 7 save() end

           

           
                if imgui.RippleButton(fa.ICON_FA_ARROW_DOWN..u8' Оружие', imgui.ImVec2(sizeBetX, sizeBetY), 1, 8) then menuSelect = 8 save() end

            

            
                if imgui.RippleButton(fa.ICON_FA_CAR..u8' Машины', imgui.ImVec2(sizeBetX, sizeBetY), 1, 8) then menuSelect = 9 save() end

            
            if tonumber(HLcfg.config.adminlvl) == 13 then
            
                if imgui.RippleButton(fa.ICON_FA_USER_SECRET..u8' ФД меню', imgui.ImVec2(sizeBetX, sizeBetY), 1, 8) then menuSelect = 10 save() end

            
        end
           
                    if imgui.RippleButton(fa.ICON_FA_SERVER..u8' Команды', imgui.ImVec2(sizeBetX, sizeBetY), 1, 8) then menuSelect = 110 save() end
    
               
               
                        if imgui.RippleButton(fa.ICON_FA_WIFI..u8' Лог', imgui.ImVec2(sizeBetX, sizeBetY), 1, 8) then menuSelect = 115 save() end
        
                   
                   
                            if imgui.RippleButton(fa.ICON_FA_BINOCULARS..u8' Мониторинг', imgui.ImVec2(sizeBetX, sizeBetY), 1, 8) then menuSelect = 191 save() end
            
                        
                       
                            if imgui.RippleButton(fa.ICON_FA_BINOCULARS..u8' Режим Слежки', imgui.ImVec2(sizeBetX, sizeBetY), 1, 8) then menuSelect = 201 save() end
                         
                          
            
                        
                       
                        
            imgui.PopStyleVar()
            imgui.EndChild()
        end
        imgui.PopStyleVar()
        imgui.PopStyleColor(3)
        
       
        
        imgui.SameLine()
    

  
        imgui.PushStyleColor(imgui.Col.ChildWindowBg, imgui.ImVec4(0.13, 0.16, 0.2, 1))
				imgui.BeginChild("##menuSelectable", imgui.ImVec2(650, 600), true, imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoScrollbar)
             
                if menuSelect == 216 then
                    imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(classicColor.v[1], classicColor.v[2], classicColor.v[3], classicColor.v[4]))		
                    imgui.BeginChild('##softMenu', imgui.ImVec2(-1, 300), true, imgui.WindowFlags.AlwaysAutoResize)
                    
                    for k,v in pairs(soft_table) do
                       local sels = k - 1
                       if cheatsSelectable ~= sels then
                        if imgui.Button(v, imgui.ImVec2(-1, 30)) then
                            cheatsSelectable = sels
                        end
                       else
                        if imgui.InvButton(v, imgui.ImVec2(-1, 30)) then
                            cheatsSelectable = sels
                        end
                      end
                    end
                 
                   
            imgui.EndChild() 
            imgui.PopStyleColor()
            imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(classicColor.v[1], classicColor.v[2], classicColor.v[3], classicColor.v[4]))	
            
            
            imgui.PushFont(minifont)
            imgui.BeginChild('##softSettingsMenu', imgui.ImVec2(-1, 290), true, imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoScrollbar)
            
            if cheatsSelectable == 0 then
                
              
                
                if imgui.HotKey("##f9ret0e9ruterut8ert", ActiveWallHack, tLastKeys, 100) then
                    rkeys.changeHotKey(bindWallHack, ActiveWallHack.v)
            
                    msg("Клавиша(-ши) срабатывания - {FFFFFF}" .. table.concat(rkeys.getKeysName(ActiveWallHack.v), ' + '), 0x228B22)
            
                    HLcfg.config.bindWallHack = encodeJson(ActiveWallHack.v)
                    save()
                end imgui.SameLine() imgui.Text(u8'Активация') imgui.SameLine() imgui.HelpMarker(u8"Включить/Выключить аирбрейк")
                
            end
            if cheatsSelectable == 1 then
                if imgui.ToggleButton(u8"[Вкл/выкл] AirBrake", elements.checkbox.airBrake) then
                  HLcfg.config.airBrake = elements.checkbox.airBrake.v
                  save()
                end imgui.SameLine() imgui.HelpMarker(u8'Быстрое перемещение, которое активируется на нажитие клавиша RSHIFT, регулируется при помощи + и -')
                imgui.InvText('Свободный полёт. Персонаж "быстро передвигается" по воздуху.')
                imgui.Separator()
                
                if imgui.HotKey("##fgokdo;iteroituert", ActiveAirBrake, tLastKeys, 100) then
                    rkeys.changeHotKey(bindAirBrake, ActiveAirBrake.v)
            
                    msg("Клавиша(-ши) срабатывания - {FFFFFF}" .. table.concat(rkeys.getKeysName(ActiveAirBrake.v), ' + '), 0x228B22)
            
                    HLcfg.config.bindAirBrake = encodeJson(ActiveAirBrake.v)
                    save()
                end imgui.SameLine() imgui.Text(u8'Активация') imgui.SameLine() imgui.HelpMarker(u8"Включить/Выключить аирбрейк")
                if imgui.ToggleButton(u8'По умолчанию (SHIFT)', elements.checkbox.airStandart) then
                    HLcfg.config.airStandart = elements.checkbox.airStandart.V
                    save()
                end
            end
            if cheatsSelectable == 2 then
                if imgui.ToggleButton(u8"[Вкл/выкл] Speed Hack", elements.checkbox.speedHack) then
                  HLcfg.config.speedHack = elements.checkbox.speedHack.v
                  save()
                end imgui.SameLine() imgui.HelpMarker(u8"Ускоряет ваш автомобиль при нажатии на ALT")
                
                imgui.InvText('Ускорение автомобиля при зажатии клавиши ALT')
                
                
               
            end
            if cheatsSelectable == 3 then
                if imgui.ToggleButton(u8"[Вкл/выкл] Infinity Ammo", elements.checkbox.infAmmo) then
                  HLcfg.config.infAmmo = elements.checkbox.infAmmo.v
                  save()
                end imgui.SameLine() imgui.HelpMarker(u8"Делает ваши патроны бесконечными")
                imgui.InvText('Не будет перезарядки при стрельбе.')
            end
           
            if cheatsSelectable == 4 then
                if imgui.ToggleButton(u8"[Вкл/выкл] Auto Reconnect", elements.checkbox.autoReconnect) then
                  HLcfg.config.autoReconnect = elements.checkbox.autoReconnect.v
                  save()
                end imgui.SameLine() imgui.HelpMarker(u8"Если сервер закроет соединение, скрипт за вас перезайдет на сервер")
                imgui.InvText('Перезаход на сервер')
            end
            if cheatsSelectable == 5 then
                if imgui.ToggleButton(u8"[Вкл/выкл] GM Car", elements.checkbox.gmCar) then
                  HLcfg.config.gmCar = elements.checkbox.gmCar.v
                  save()
                end imgui.SameLine() imgui.HelpMarker(u8"Не даст вашему транспорту сломаться")
                imgui.InvText('Ваш автомобиль невозможно сломать.')
            end
            if cheatsSelectable == 6 then
                if imgui.ToggleButton(u8"[Вкл/выкл] No Bike", elements.checkbox.noBike) then
                  HLcfg.config.noBike = elements.checkbox.noBike.v
                  save()
                end imgui.SameLine() imgui.HelpMarker(u8"Не даст вам упасть с мотоцикла")
                imgui.InvText('При столкновении с препятсвием на байке/велосипеде не упадёте')
            end
        
            if cheatsSelectable == 7 then
                if imgui.ToggleButton(u8"[Вкл/выкл] AntiEjectCar", elements.checkbox.antiEjectCar) then
                  HLcfg.config.antiEjectCar = elements.checkbox.antiEjectCar.v
                  save()
                end imgui.SameLine() imgui.HelpMarker(u8"Не даст другим игрокам выкинуть вас из вашего транспорта")
                imgui.InvText('Вас не смогут выкинуть с авто')
            end
        
            if cheatsSelectable == 8 then
                if imgui.ToggleButton(u8"[Вкл/выкл] Ходить/Ездить под водой", elements.checkbox.inWater) then
                  HLcfg.config.inWater = elements.checkbox.inWater.v
                  save()
                end imgui.SameLine() imgui.HelpMarker(u8"Можно ходить или ездить под водой")
                imgui.InvText('Вы не будете всплывать на поверхность воды')
            end
    
            if cheatsSelectable == 9 then
                if imgui.ToggleButton(u8"[Вкл/выкл] Прыжок в машине", elements.checkbox.vCar) then
                  HLcfg.config.vCar = elements.checkbox.vCar.v
                  save()
                end imgui.SameLine() imgui.HelpMarker(u8("При нажатии на "..table.concat(rkeys.getKeysName(ActiveCar.v), ' + ').." машина подпрыгнет вверх"))
                local metros = elements.int.lengthJump.v * 10
                imgui.InvText('Вас в авто подкинет вверх на '..metros..' метров')
                imgui.Text(u8'')
                imgui.Separator()
                
                imgui.InvText('Клавиша активации')
                if imgui.HotKey("##1dsfgdfgddgdfter", ActiveCar, tLastKeys, 100) then
                    rkeys.changeHotKey(bindCar, ActiveCar.v)
            
                    msg("Клавиша(-ши) срабатывания - {FFFFFF}" .. table.concat(rkeys.getKeysName(ActiveCar.v), ' + '), 0x228B22)
            
                    HLcfg.config.bindCar = encodeJson(ActiveCar.v)
                    save()
                end imgui.SameLine() imgui.Text(u8'Прыжок в машине вверх') 
                if imgui.SliderInt('####SLAPVEH', elements.int.lengthJump, 0, 5) then
                    HLcfg.config.lengthJump = elements.int.lengthJump.v
                    save()
                end imgui.SameLine() imgui.HelpMarker(u8'Высота прыжка')
            end
    
            if cheatsSelectable == 10 then
                if imgui.ToggleButton(u8"[Вкл/выкл] Бесконечный бег", elements.checkbox.infinityRun) then
                  HLcfg.config.infinityRun = elements.checkbox.infinityRun.v
                  save()
                end imgui.SameLine() imgui.HelpMarker(u8"Пропадет отдышка при беге")
                imgui.InvText('У вас полностью пропадёт отдышка')
            end
            
              


            

            imgui.EndChild()
            imgui.PopFont()
            imgui.PopStyleColor()
            

                end
                if menuSelect == 215 then
                    imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(classicColor.v[1], classicColor.v[2], classicColor.v[3], classicColor.v[4]))
                    imgui.PushFont(minifont)	
                    imgui.BeginChild('##bindMenu', imgui.ImVec2(300, 65), true, imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoScrollbar)
                    
                    if imgui.HotKey("##1dsfgdfgdfgdytreytrty", ActiveMenu, tLastKeys, 100) then
                        rkeys.changeHotKey(bindMenu, ActiveMenu.v)
                
                        msg("Клавиша(-ши) срабатывания - {FFFFFF}" .. table.concat(rkeys.getKeysName(ActiveMenu.v), ' + '), 0x228B22)
                
                        HLcfg.config.bindMenu = encodeJson(ActiveMenu.v)
                        save()
                    end imgui.SameLine() imgui.Text(u8'Меню скрипта') imgui.SameLine() imgui.HelpMarker(u8"Открыть меню скрипта")
                    if imgui.HotKey("##ewasdafrtfdgre", ActiveAutoReport, tLastKeys, 100) then
                        rkeys.changeHotKey(bindAutoReport, ActiveAutoReport.v)
                
                        msg("Клавиша(-ши) срабатывания - {FFFFFF}" .. table.concat(rkeys.getKeysName(ActiveAutoReport.v), ' + '), 0x228B22)
                
                        HLcfg.config.bindAutoReport = encodeJson(ActiveAutoReport.v)
                        save()
                    end imgui.SameLine() imgui.Text(u8'AutoReport') imgui.SameLine() imgui.HelpMarker(u8"Открыть AutoReport")
                    imgui.EndChild()
                     ---------------------------------------------------------
                     ----------
                     --------
                     -----
                    imgui.BeginChild('##bindMenuSS', imgui.ImVec2(300, 65), true, imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoScrollbar)
                    
                    if imgui.HotKey("##1dsfgddfgrtert", ActiveTrue, tLastKeys, 100) then
                        rkeys.changeHotKey(bindTrueCommand, ActiveTrue.v)
                
                        msg("Клавиша(-ши) срабатывания - {FFFFFF}" .. table.concat(rkeys.getKeysName(ActiveTrue.v), ' + '), 0x228B22)
                
                        HLcfg.config.bindTrueCommand = encodeJson(ActiveTrue.v)
                        save()
                    end imgui.SameLine() imgui.Text(u8'Принять форму( в /a )') imgui.SameLine() imgui.HelpMarker(u8"Если в админ-чате пришла форма\nПример: /ban id day reason\nСкрипт примет форму.")
                    if imgui.HotKey("##edfgrdgfdgdfgetee", ActiveFalse, tLastKeys, 100) then
                        rkeys.changeHotKey(bindFalseCommand, ActiveFalse.v)
                
                        msg("Клавиша(-ши) срабатывания - {FFFFFF}" .. table.concat(rkeys.getKeysName(ActiveAutoReport.v), ' + '), 0x228B22)
                
                        HLcfg.config.bindFalseCommand = encodeJson(ActiveFalse.v)
                        save()
                    end imgui.SameLine() imgui.Text(u8'Отклонить форму( в /a )') imgui.SameLine() imgui.HelpMarker(u8"Если в админ-чате пришла форма\nПример: /ban id day reason\nСкрипт отклонит форму")
                    imgui.EndChild()
                    imgui.PopStyleColor()
                    imgui.PopFont()
                    
                    
                    
                    
                   
                    
              

                   
                   
                   
                   
                  
                    
                  
               
                end
               
                
                if menuSelect == 201 then
                    imgui.PushFont(minifont)
                imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(classicColor.v[1], classicColor.v[2], classicColor.v[3], classicColor.v[4]))	
                imgui.BeginChild('##reconSettings', imgui.ImVec2(-1, 100), true)
                imgui.PushFont(fontsizeForText) imgui.Text(u8'Координаты окон') imgui.PopFont()
                imgui.Separator()
                if imgui.Button(u8"Изменить координаты быстрых действий(в реконе)", imgui.ImVec2(-1, 0)) then
                    AdminTools.v = false
                    if not rInfo.state then
                   sampSendChat('/re 5')
                 end
                        changePositionD = true

                        AdminTools.v = false
                        sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Чтобы подтвердить сохранение - нажмите 1, чтобы отменить сохранение - нажмите 2.', stColor)
                end
            if imgui.Button(u8"Изменить координаты наказаний", imgui.ImVec2(-1, 0)) then
                AdminTools.v = false
                if not rInfo.state then
                 sampSendChat('/re 5')
             end
                    changePosition1 = true
                    sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Чтобы подтвердить сохранение - нажмите 1, чтобы отменить сохранение - нажмите 2.', stColor)
            end


                imgui.EndChild()
                if elements.checkbox.keysyncer.v then
                    
                if elements.checkbox.keysyncerFon.v then
                imgui.BeginChild('##KeyLogger', imgui.ImVec2(-1, 125), true)
                else 
                imgui.BeginChild('##KeyLogger', imgui.ImVec2(-1, 105), true)
                end 
                else
                    imgui.BeginChild('##KeyLogger', imgui.ImVec2(-1, 75), true)
                end


                imgui.PushFont(fontsizeForText) imgui.Text(u8'KeyLogger') imgui.PopFont()
                imgui.Separator()
                imgui.SetCursorPosY(43)
               
                if imgui.ToggleButton(u8"[Вкл/выкл] Key Logger", elements.checkbox.keysyncer) then
                    HLcfg.config.keysyncer = elements.checkbox.keysyncer.v
                    save()
                end imgui.SameLine() imgui.HelpMarker(u8"Окно показывающее что нажимает игрок")
                if elements.checkbox.keysyncer.v then
                if imgui.Checkbox(u8"[Вкл/выкл] Регулируемая прозрачность фона", elements.checkbox.keysyncerFon) then
                    HLcfg.config.keysyncerFon = elements.checkbox.keysyncerFon.v
                    save()
                end imgui.SameLine() imgui.HelpMarker(u8"Сделайте прозрачность Key Logger`a на свой вкус!")
                if elements.checkbox.keysyncerFon.v then
                    imgui.PushItemWidth(300) imgui.SliderInt('##fonSlider', elements.int.prozFon, 0.00, 100.00) imgui.PopItemWidth()
                end
                end
            
                imgui.EndChild()
                imgui.BeginChild('##Obyasneniydlyaloxov', imgui.ImVec2(-1, 190), true) 
                imgui.PushFont(fontsizeForText) imgui.Text(u8'Обозначения кнопок') imgui.PopFont()
                imgui.Separator()
                imgui.InvText('Что значат каждая из кнопок режима слежки.')
                imgui.InvText('Чтобы узнать информацию - наведитесь на кнопку.')
                imgui.Separator()
                imgui.BorderButton('              ')
                imgui.SameLine()
                imgui.HelpButton('ReconOFF', 'Выходит из режима слежки')
                imgui.SameLine()
                imgui.HelpButton('SETHP', 'Изменить состояние ХП')
                imgui.SameLine()
                imgui.HelpButton('FREEZE', 'Зафризит игрока, за которым идёт слежка.')
                imgui.SameLine()
                imgui.HelpButton('UNFREEZE', 'Введёт /unfreeze id.\nid игрока за которым идёт слежка')
                imgui.SameLine()
                imgui.HelpButton('AZ', 'Телепортирует вас и игрока в админ-зону')

                imgui.HelpButton('<< BACK', 'Перейдет на предыдущего игрока')
                imgui.SameLine()
                
                imgui.HelpButton('AGL', 'Выдаст комплект лицензий игроку')
                imgui.SameLine()
                imgui.HelpButton('GETHERE', 'Телепортирует игрока к вам\nПеред этим выйдет из режима слежки')
                imgui.SameLine()
                imgui.HelpButton('OFFSTATS', 'Оффлайн статистика.\n/getoffstats id')
                imgui.SameLine()
                imgui.HelpButton('МАШИНА', 'Выдать авто игроку')
                imgui.SameLine()
                imgui.HelpButton('ОРУЖИЕ', 'Выдать игроку оружие')
                imgui.SameLine()
                imgui.HelpButton('NEXT >>', 'Перейдёт на следующего игрока')

                imgui.BorderButton('              ')
                imgui.SameLine()
                imgui.HelpButton('GETSTATS', 'Получить статистику игрока')
                imgui.SameLine()
                imgui.HelpButton('GOTO', 'Телепортироваться к игроку')
                imgui.SameLine()
                imgui.HelpButton('SLAP', 'Подбросить игрока')
                
                imgui.SameLine()
                imgui.HelpButton('SPAWN', 'Заспавнит игрока')
                imgui.SameLine()
                imgui.HelpButton('CHECKGM', 'Проверка игрока на ГМ')






                imgui.EndChild()
                imgui.BeginChild("##SettingsRecon", imgui.ImVec2(-1, 170), true)
                imgui.PushFont(fontsizeForText) imgui.Text(u8'Информация об игроке') imgui.PopFont()
                imgui.Separator()
                if imgui.Button(u8"Изменить координаты окна информации", imgui.ImVec2(475, 0)) then
                    changePositionInf = true
                    AdminTools.v = false
                    sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Чтобы подтвердить сохранение - нажмите 1, чтобы отменить сохранение - нажмите 2.', stColor)
                end
                if imgui.RadioButton(u8'Отображение по вертикали', elements.int.informer, 1) then
                    HLcfg.config.informer = elements.int.informer.v
                    save()


                end
                imgui.SameLine()
                if imgui.RadioButton(u8'Отображение по горизонтали', elements.int.informer, 2) then
                    HLcfg.config.informer = elements.int.informer.v
                    save()


                end
                if imgui.Checkbox(u8'[Вкл/Выкл] Title Bar', elements.checkbox.reconTitleBar) then
                    HLcfg.config.reconTitleBar = elements.checkbox.reconTitleBar.v
                    save()
                end imgui.SameLine() imgui.HelpMarker(u8'Текст над информацией')
                if imgui.Checkbox(u8"[Вкл/выкл] Регулируемая прозрачность фона", elements.checkbox.informerFon) then
                    HLcfg.config.informerFon = elements.checkbox.informerFon.v
                    save()
                end imgui.SameLine() imgui.HelpMarker(u8"Сделайте прозрачность информера на свой вкус!")
                if elements.checkbox.informerFon.v then
                    imgui.PushItemWidth(300) imgui.SliderInt('##fonSliderS', elements.int.infFon, 0.00, 100.00) imgui.PopItemWidth()
                end


                imgui.EndChild()
                imgui.PopStyleColor()
                imgui.PopFont()

                

                
                


                end
                if menuSelect == 191 then
                    imgui.PushFont(minifont)
                    imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(classicColor.v[1], classicColor.v[2], classicColor.v[3], classicColor.v[4]))	
                    imgui.BeginChild("MonitoringLeader", imgui.ImVec2(-1, 175), true)
                    imgui.TextColoredRGB('{ff0000}Мониторинг админов')
                    
                    
                    if imgui.ToggleButton(u8"[Вкл/выкл] Мониторинг Администрации", elements.monitoring.admins) then
                        HLcfg.monitoring.admins = elements.monitoring.admins.v
                        save()
                    end imgui.SameLine() imgui.HelpMarker(u8"На экран будет выводиться /admins")
                    if imgui.Button(u8"Изменить координаты окна Мониторинга Админов", imgui.ImVec2(475, 0)) then
                        changePositionM = true
                        AdminTools.v = false
                        sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Чтобы подтвердить сохранение - нажмите 1, чтобы отменить сохранение - нажмите 2.', stColor)
                    end
                   
                    imgui.PushItemWidth(130)
                    imgui.Text(u8'Введите кд, с которым будет обновляться Мониторинг')
                    imgui.TextColoredRGB('{ff0000}ВАЖНО! Рекомендательный КД: 60')
					imgui.InputText(u8"####ADMINAMOGUS", elements.monitoring.timeAdmins)
                        if imgui.Button(u8'Сохранить') then
                            HLcfg.monitoring.timeAdmins = elements.monitoring.timeAdmins.v 
                            save()
                        end
                    imgui.PopItemWidth()
                    


                  
                    


                    imgui.EndChild()
                    imgui.PopStyleColor()
                    imgui.PopFont()
                    
              
                  
                 
                    


                 




                end
                imgui.PushStyleColor(imgui.Col.Border, imgui.ImVec4(classicColor.v[1], classicColor.v[2], classicColor.v[3], classicColor.v[4]))	
                if menuSelect == 120 then
                   
                   
                        imgui.centeredText(fa.ICON_FA_LINK..u8' Лог подключений/отключений')
                        imgui.BeginChild("##504UYAGUFVCVGHGH", imgui.ImVec2(-1, 200), true)
                        if #logConnect > 0 then
                            local fCount = 0
                            for k, v in ipairs(logConnect) do
                                    imgui.TextWrapped(u8(v)) 
                                    imgui.SetScrollHere()
                            end
                            end
                            if checkfile then
                               
                                checkfile = false
                            end
                            if connect_buffer.v ~= '' then
                                if connect_buffer.v ~= nil then
                                imgui.Sep()
                                imgui.TextWrapped(connect_buffer.v)
                                imgui.SetScrollHere()
                                end


                            end
                        imgui.EndChild()
                        if imgui.Button(u8"Очистить лог", imgui.ImVec2(325, 20)) then
                            logConnect = {}
                            if connect_buffer.v ~= nil or '' then
                                logConnect = {}
                                connect_buffer.v = ''
                            end
                            
                        end
                        imgui.SameLine()
                        if imgui.Button(u8"Копировать лог", imgui.ImVec2(325, 20)) then
                            local t = ""
                            for k, v in ipairs(logConnect) do
                                t = t .. (tostring(t):len() > 0 and "\n" or "") .. v
                            end
                            imgui.LogToClipboard()
                            imgui.LogText(u8(t))
                            imgui.LogFinish()
                        end
                        if imgui.Button(u8'Сохранить лог', imgui.ImVec2(325, 20)) then
                            
                            f = io.open("moonloader\\ViceTools\\logs\\logConnect.txt","w")
                            f:close()
                           
                            

                            local t = ""
                            for k, v in ipairs(logConnect) do
                                t = t .. (tostring(t):len() > 0 and "\n" or "") .. v
                            end
                            if f ~= nil then
                            f = io.open("moonloader\\ViceTools\\logs\\logConnect.txt","r+")
                            f:write(u8(t))
                            f:close()
                            end
                        end imgui.SameLine()
                        if imgui.Button(u8'Вывести лог', imgui.ImVec2(325, 20)) then
                            checkfile = true
                            file = io.open(getGameDirectory().."//moonloader//ViceTools//logs//logConnect.txt", "r")
                            if file ~= nil then
                            print(file)
                            connect_buffer.v = file:read('*a')
                            file:close()
                            else
                                msg('Сначала сохраните лог.')
                            end
                        end
                        if imgui.Button(u8'Убрать выведенные логи', imgui.ImVec2(-1, 20)) then
                            connect_buffer.v = ''



                        end
                        imgui.centeredText(u8'Логи выводятся не полностью.')
                        imgui.centeredText(u8'Учтите. Сохраняется и выводится только последний лог.\nЧтобы убрать старые логи, нажмите: Очистить выведенные логи\nПоиск по логам в старых логах не работает.\nМесто сохранения логов: moonloader >> ViceTools >> logs')
                      
                        imgui.BeginChild('##createLog', imgui.ImVec2(-1, 150), true)
                        imgui.PushItemWidth(250)
                        
                        imgui.NewInputText(u8'##SearchLog', tableOfNew.findText, 615, "Поиск по логам", 2)
                        imgui.PopItemWidth()
                        imgui.Separator()
                        for k,v in pairs(logConnect) do
                            if tableOfNew.findText.v ~= '' then
                                if string.rlower(v):find(string.rlower(u8:decode(tableOfNew.findText.v))) then
                                    imgui.TextWrapped(u8(v))
                                end
                            end
                                    end
                        imgui.EndChild()
                   
    



                end
                if menuSelect == 121 then
                 
                        imgui.centeredText(fa.ICON_FA_LINK..u8' Лог подключений админов')
                        imgui.BeginChild("##504UYAGUWETSDGF", imgui.ImVec2(-1, 200), true)
                        if #aloginLog > 0 then
                            local fCount = 0
                            for k, v in ipairs(aloginLog) do
                                    imgui.TextWrapped(u8(v))
                                    imgui.SetScrollHere()
                            end
                            end
                            if checkfile then
                                
                                checkfile = false
                            end
                            if alogin_buffer.v ~= '' then
                                if alogin_buffer.v ~= nil then
                                imgui.Sep()
                                imgui.TextWrapped(alogin_buffer.v)
                                imgui.SetScrollHere()
                                end


                            end
                        imgui.EndChild()
                        if imgui.Button(u8"Очистить лог", imgui.ImVec2(325, 20)) then
                            aloginLog = {}
                            if alogin_buffer.v ~= nil or '' then
                                aloginLog = {}
                                alogin_buffer.v = ''
                            end
                        end
                        imgui.SameLine()
                        if imgui.Button(u8"Копировать лог", imgui.ImVec2(325, 20)) then
                            local t = ""
                            for k, v in ipairs(aloginLog) do
                                t = t .. (tostring(t):len() > 0 and "\n" or "") .. v
                            end
                            imgui.LogToClipboard()
                            imgui.LogText(u8(t))
                            imgui.LogFinish()
                        end
                        if imgui.Button(u8'Сохранить лог', imgui.ImVec2(325, 20)) then
                            
                            f = io.open("moonloader\\ViceTools\\logs\\logAlogin.txt","w")
                            f:close()
                           
                            

                            local t = ""
                            for k, v in ipairs(aloginLog) do
                                t = t .. (tostring(t):len() > 0 and "\n" or "") .. v
                            end
                            if f ~= nil then
                            f = io.open("moonloader\\ViceTools\\logs\\logAlogin.txt","r+")
                            f:write(u8(t))
                            f:close()
                            end
                        end imgui.SameLine()
                        if imgui.Button(u8'Вывести лог', imgui.ImVec2(325, 20)) then
                            checkfile = true
                            file = io.open(getGameDirectory().."//moonloader//ViceTools//logs//logAlogin.txt", "r")
                            if file ~= nil then
                            print(file)
                            alogin_buffer.v = file:read('*a')
                            file:close()
                            else
                                msg('Сначала сохраните лог.')
                            end
                        end
                        if imgui.Button(u8'Убрать выведенные логи', imgui.ImVec2(-1, 20)) then
                            alogin_buffer.v = ''



                        end
                        imgui.centeredText(u8'Логи выводятся не полностью.')
                                    imgui.centeredText(u8'Учтите. Сохраняется и выводится только последний лог.\nЧтобы убрать старые логи, нажмите: Очистить выведенные логи\nПоиск по логам в старых логах не работает.\nМесто сохранения логов: moonloader >> ViceTools >> logs')
                        imgui.BeginChild('##createLogK', imgui.ImVec2(-1, 150), true)
                        imgui.PushItemWidth(250)
                        imgui.NewInputText(u8'##SearchLogK', tableOfNew.findText, 615, "Поиск по логам", 2)
                        imgui.PopItemWidth()
                        imgui.Separator()
                        for k,v in pairs(aloginLog) do
                            if tableOfNew.findText.v ~= '' then
                                if string.rlower(v):find(string.rlower(u8:decode(tableOfNew.findText.v))) then
                                    imgui.TextWrapped(u8(v))
                                end
                            end
                                    end
                        imgui.EndChild()
                               
                            end
                            if menuSelect == 122 then
                             
                                    imgui.centeredText(fa.ICON_FA_LINK..u8' Лог поданных жалоб')
                                    imgui.BeginChild("##504UYAGUARTRET", imgui.ImVec2(-1, 200), true)
                                    if #repLog > 0 then
                                        local fCount = 0
                                        for k, v in ipairs(repLog) do 
                                                imgui.TextWrapped(u8(v))
                                                imgui.SetScrollHere()
                                        end
                                        end
                                        if checkfile then
                                            
                                            checkfile = false
                                        end
                                        if rep_buffer.v ~= '' then
                                            if rep_buffer.v ~= nil then
                                            imgui.Sep()
                                            imgui.TextWrapped(rep_buffer.v)
                                            imgui.SetScrollHere()
                                            end


                                        end
                                    imgui.EndChild()
                                    if imgui.Button(u8"Очистить лог", imgui.ImVec2(325, 20)) then
                                        repLog = {}
                                    
                                        if rep_buffer.v ~= nil or '' then
                                            repLog = {}
                                            rep_buffer.v = ''
                                        end
                                    end
                                    imgui.SameLine()
                                    if imgui.Button(u8"Копировать лог", imgui.ImVec2(325, 20)) then
                                        local t = ""
                                        for k, v in ipairs(repLog) do
                                            t = t .. (tostring(t):len() > 0 and "\n" or "") .. v
                                        end
                                        imgui.LogToClipboard()
                                        imgui.LogText(u8(t))
                                        imgui.LogFinish()
                                    end
                                    if imgui.Button(u8'Сохранить лог', imgui.ImVec2(325, 20)) then
                                        
                                        f = io.open("moonloader\\ViceTools\\logs\\logReportov.txt","w")
                                        f:close()
                                       
                                        

                                        local t = ""
                                        for k, v in ipairs(repLog) do
                                            t = t .. (tostring(t):len() > 0 and "\n" or "") .. v
                                        end
                                        if f ~= nil then
                                        f = io.open("moonloader\\ViceTools\\logs\\logReportov.txt","r+")
                                        f:write(u8(t))
                                        f:close()
                                        end
                                    end imgui.SameLine()
                                    if imgui.Button(u8'Вывести лог', imgui.ImVec2(325, 20)) then
                                        checkfile = true
                                        file = io.open(getGameDirectory().."//moonloader//ViceTools//logs//logReportov.txt", "r")
                                        if file ~= nil then
                                        print(file)
                                        rep_buffer.v = file:read('*a')
                                        file:close()
                                        else
                                            msg('Сначала сохраните лог.')
                                        end
                                    end
                                    if imgui.Button(u8'Убрать выведенные логи', imgui.ImVec2(-1, 20)) then
                                        rep_buffer.v = ''



                                    end
                                    imgui.centeredText(u8'Логи выводятся не полностью.')
                                    imgui.centeredText(u8'Учтите. Сохраняется и выводится только последний лог.\nЧтобы убрать старые логи, нажмите: Очистить выведенные логи\nПоиск по логам в старых логах не работает.\nМесто сохранения логов: moonloader >> ViceTools >> logs')
                                    imgui.BeginChild('##createLogR', imgui.ImVec2(-1, 150), true)
                                    imgui.PushItemWidth(250)
                                    imgui.NewInputText(u8'##SearchLogR', tableOfNew.findText, 615, "Поиск по логам", 2)
                                    imgui.PopItemWidth()
                                    imgui.Separator()
                                    for k,v in pairs(repLog) do
                                        if tableOfNew.findText.v ~= '' then
                                            if string.rlower(v):find(string.rlower(u8:decode(tableOfNew.findText.v))) then
                                                imgui.TextWrapped(u8(v))
                                            end
                                        end
                                                end
                                    imgui.EndChild()
                                          



                            end
                            if menuSelect == 123 then
                                
                                    imgui.centeredText(fa.ICON_FA_LINK..u8' Лог ответов администрации')
                                    imgui.BeginChild("##504UYAGUDFG", imgui.ImVec2(-1, 200), true)
                                    if #otvLog > 0 then
                                        local fCount = 0
                                        for k, v in ipairs(otvLog) do
                                                imgui.TextWrapped(u8(v))
                                                imgui.SetScrollHere()
                                        end
                                    end
                                        if checkfile then
                                            
                                            checkfile = false
                                        end
                                        if otv_buffer.v ~= '' then
                                            if otv_buffer.v ~= nil then
                                            imgui.Separator()
                                            imgui.TextWrapped(otv_buffer.v)
                                            imgui.SetScrollHere()
                                            end
            
            
                                        end
                                    
                                    imgui.EndChild()
                                    if imgui.Button(u8"Очистить лог", imgui.ImVec2(325, 20)) then
                                        otvLog = {}
                                        if otv_buffer.v ~= nil or '' then
                                            otvLog = {}
                                            otv_buffer.v = ''
                                        end
                                    end
                                    imgui.SameLine()
                                    if imgui.Button(u8"Копировать лог", imgui.ImVec2(325, 20)) then
                                        local t = ""
                                        for k, v in ipairs(otvLog) do
                                            t = t .. (tostring(t):len() > 0 and "\n" or "") .. v
                                        end
                                        imgui.LogToClipboard()
                                        imgui.LogText(u8(t))
                                        imgui.LogFinish()
                                    end
                                    if imgui.Button(u8'Сохранить лог', imgui.ImVec2(325, 20)) then
                                        
                                        f = io.open("moonloader\\ViceTools\\logs\\logOtvetov.txt","w")
                                        f:close()
                                       
                                        

                                        local t = ""
                                        for k, v in ipairs(otvLog) do
                                            t = t .. (tostring(t):len() > 0 and "\n" or "") .. v
                                        end
                                        if f ~= nil then
                                        f = io.open("moonloader\\ViceTools\\logs\\logOtvetov.txt","r+")
                                        f:write(u8(t))
                                        f:close()
                                        end
                                    end imgui.SameLine()
                                    if imgui.Button(u8'Вывести лог', imgui.ImVec2(325, 20)) then
                                        checkfile = true
                                        file = io.open(getGameDirectory().."//moonloader//ViceTools//logs//logOtvetov.txt", "r")
                                        if file ~= nil then
                                        print(file)
                                        otv_buffer.v = file:read('*a')
                                        file:close()
                                        else
                                            msg('Сначала сохраните лог.')
                                        end
                                    end
                                    if imgui.Button(u8'Убрать выведенные логи', imgui.ImVec2(-1, 20)) then
                                        otv_buffer.v = ''



                                    end
                                    imgui.centeredText(u8'Логи выводятся не полностью.')
                                    imgui.centeredText(u8'Учтите. Сохраняется и выводится только последний лог.\nЧтобы убрать старые логи, нажмите: Очистить выведенные логи\nПоиск по логам в старых логах не работает.\nМесто сохранения логов: moonloader >> ViceTools >> logs')
                                    imgui.BeginChild('##createLogO', imgui.ImVec2(-1, 150), true)
                                    imgui.PushItemWidth(250)
                                    imgui.NewInputText(u8'##SearchLogO', tableOfNew.findText, 615, "Поиск по логам", 2)
                                    imgui.PopItemWidth()
                                    imgui.Separator()
                                    for k,v in pairs(otvLog) do
                                        if tableOfNew.findText.v ~= '' then
                                            if string.rlower(v):find(string.rlower(u8:decode(tableOfNew.findText.v))) then
                                                imgui.TextWrapped(u8(v))
                                            end
                                        end
                                                end
                                    imgui.EndChild()
                                          


                            end
                            if menuSelect == 124 then
                              
                                    imgui.centeredText(fa.ICON_FA_LINK..u8' Лог админ-чата')
                                    imgui.BeginChild("##504UYAGUDFTY", imgui.ImVec2(-1, 200), true)
                                    if #achatLog > 0 then
                                        local fCount = 0
                                        for k, v in ipairs(achatLog) do
                                                imgui.TextWrapped(u8(v))
                                                imgui.SetScrollHere()
                                        end
                                        end
                                        if checkfile then
                                            
                                            checkfile = false
                                        end
                                        if achat_buffer.v ~= '' then
                                            if achat_buffer.v ~= nil then

                                                
                                            imgui.Separator()
                                            imgui.TextWrapped(achat_buffer.v)
                                            imgui.SetScrollHere()
                                            end
            
            
                                        end
                                    
                                    imgui.EndChild()
                                    if imgui.Button(u8"Очистить лог", imgui.ImVec2(325, 20)) then
                                        achatLog = {}
                                       
                                    end
                                    imgui.SameLine()
                                    if imgui.Button(u8"Копировать лог", imgui.ImVec2(325, 20)) then
                                        local t = ""
                                        for k, v in ipairs(achatLog) do
                                            t = t .. (tostring(t):len() > 0 and "\n" or "") .. v
                                        end
                                        imgui.LogToClipboard()
                                        imgui.LogText(u8(t))
                                        imgui.LogFinish()
                                    end
                                    if imgui.Button(u8'Сохранить лог', imgui.ImVec2(325, 20)) then
                                        
                                        f = io.open("moonloader\\ViceTools\\logs\\logAChat.txt","w")
                                        f:close()
                                       
                                        

                                        local t = ""
                                        for k, v in ipairs(achatLog) do
                                            t = t .. (tostring(t):len() > 0 and "\n" or "") .. v
                                        end
                                        if f ~= nil then
                                        f = io.open("moonloader\\ViceTools\\logs\\logAChat.txt","r+")
                                        f:write(u8(t))
                                        f:close()
                                        end
                                    end imgui.SameLine()
                                    
                                    if imgui.Button(u8'Вывести лог', imgui.ImVec2(325, 20)) then
                                        checkfile = true
                                        file = io.open(getGameDirectory().."//moonloader//ViceTools//logs//logAChat.txt", "r")
                                        if file ~= nil then
                                        print(file)
                                        achat_buffer.v = file:read('*a')
                                        file:close()
                                        else
                                            msg('Сначала сохраните лог')
                                        end
                                    end
                                    if imgui.Button(u8'Убрать выведенные логи', imgui.ImVec2(-1, 20)) then
                                        achat_buffer.v = ''



                                    end
                                    imgui.centeredText(u8'Логи выводятся не полностью.')
                                    imgui.centeredText(u8'Учтите. Сохраняется и выводится только последний лог.\nЧтобы убрать старые логи, нажмите: Очистить выведенные логи\nПоиск по логам в старых логах не работает.\nМесто сохранения логов: moonloader >> ViceTools >> logs')
                                
            
            
                                  
                                    imgui.BeginChild('##createLogA', imgui.ImVec2(-1, 150), true)
                                    imgui.PushItemWidth(250)
                                    imgui.NewInputText(u8'##SearchLogA', tableOfNew.findText, 615, "Поиск по логам", 2)
                                    imgui.PopItemWidth()
                                    imgui.Separator()
                                    for k,v in pairs(achatLog) do
                                        if tableOfNew.findText.v ~= '' then
                                            if string.rlower(v):find(string.rlower(u8:decode(tableOfNew.findText.v))) then
                                                imgui.TextWrapped(u8(v))
                                            end
                                        end
                                                end
                                    imgui.EndChild()
                                         



                            end
                            if menuSelect == 125 then
                                imgui.centeredText(fa.ICON_FA_LINK..u8' Лог наказаний')
                                imgui.BeginChild("##435RGDT45T54", imgui.ImVec2(-1, 200), true)
                                if #nakazLog > 0 then
                                    local fCount = 0
                                    for k, v in ipairs(nakazLog) do
                                            imgui.TextWrapped(u8(v))
                                            imgui.SetScrollHere()
                                    end
                                    end
                                    if checkfile then
                                        
                                        checkfile = false
                                    end
                                    if nakaz_buffer.v ~= '' then
                                        if nakaz_buffer.v ~= nil then
                                            imgui.Separator()
                                        imgui.TextWrapped(nakaz_buffer.v)
                                        imgui.SetScrollHere()
                                        end
        
        
                                    end
                                imgui.EndChild()
                                if imgui.Button(u8"Очистить лог", imgui.ImVec2(325, 20)) then
                                    nakazLog = {}
                                    
                                end
                                imgui.SameLine()
                                if imgui.Button(u8"Копировать лог", imgui.ImVec2(325, 20)) then
                                    local t = ""
                                    for k, v in ipairs(nakazLog) do
                                        t = t .. (tostring(t):len() > 0 and "\n" or "") .. v
                                    end
                                    imgui.LogToClipboard()
                                    imgui.LogText(u8(t))
                                    imgui.LogFinish()
                                end
                                if imgui.Button(u8'Сохранить лог', imgui.ImVec2(325, 20)) then
                                    
                                    f = io.open("moonloader\\ViceTools\\logs\\logNakaz.txt","w")
                                    f:close()
                                   
                                    
        
                                    local t = ""
                                    for k, v in ipairs(nakazLog) do
                                        t = t .. (tostring(t):len() > 0 and "\n" or "") .. v
                                    end
                                    if f ~= nil then
                                    f = io.open("moonloader\\ViceTools\\logs\\logNakaz.txt","r+")
                                    f:write(u8(t))
                                    f:close()
                                    end
                                end imgui.SameLine()
                                if imgui.Button(u8'Вывести лог', imgui.ImVec2(325, 20)) then
                                    checkfile = true
                                    file = io.open(getGameDirectory().."//moonloader//ViceTools//logs//logNakaz.txt", "r")
                                    if file ~= nil then
                                    print(file)
                                    nakaz_buffer.v = file:read('*a')
                                    file:close()
                                    else
                                        msg('Сначала сохраните лог.')
                                    end
                                end
                                if imgui.Button(u8'Убрать выведенные логи', imgui.ImVec2(-1, 20)) then
                                    nakaz_buffer.v = ''



                                end
                                imgui.centeredText(u8'Логи выводятся не полностью.')
                                imgui.centeredText(u8'Учтите. Сохраняется и выводится только последний лог.\nЧтобы убрать старые логи, нажмите: Очистить выведенные логи\nПоиск по логам в старых логах не работает.\nМесто сохранения логов: moonloader >> ViceTools >> logs')
                            
        
        
                              
                                imgui.BeginChild('##createLogN', imgui.ImVec2(-1, 150), true)
                                imgui.PushItemWidth(250)
                                imgui.NewInputText(u8'##SearchLogN', tableOfNew.findText, 615, "Поиск по логам", 2)
                                imgui.PopItemWidth()
                                imgui.Separator()
                                for k,v in pairs(nakazLog) do
                                    if tableOfNew.findText.v ~= '' then
                                        if string.rlower(v):find(string.rlower(u8:decode(tableOfNew.findText.v))) then
                                            imgui.TextWrapped(u8(v))
                                        end
                                    end
                                            end
                                imgui.EndChild()

                            end
                            if menuSelect == 126 then
                                imgui.centeredText(fa.ICON_FA_LINK..u8' Лог действий администрации')
                                imgui.BeginChild("##435RGDT45T54DGDFG", imgui.ImVec2(-1, 200), true)
                                if #adminLog > 0 then
                                    local fCount = 0
                                    for k, v in ipairs(adminLog) do
                                            imgui.TextWrapped(u8(v))
                                            imgui.SetScrollHere()
                                    end
                                    end
                                    if checkfile then
                                        
                                        checkfile = false
                                    end
                                    if admin_buffer.v ~= '' then
                                        if admin_buffer.v ~= nil then
                                        imgui.Separator()
                                        imgui.TextWrapped(admin_buffer.v)
                                        imgui.SetScrollHere()
                                        end
        
        
                                    end
                                imgui.EndChild()
                                if imgui.Button(u8"Очистить лог", imgui.ImVec2(325, 20)) then
                                    adminLog = {}
                                    
                                end
                                imgui.SameLine()
                                if imgui.Button(u8"Копировать лог", imgui.ImVec2(325, 20)) then
                                    local t = ""
                                    for k, v in ipairs(adminLog) do
                                        t = t .. (tostring(t):len() > 0 and "\n" or "") .. v
                                    end
                                    imgui.LogToClipboard()
                                    imgui.LogText(u8(t))
                                    imgui.LogFinish()
                                end
                                if imgui.Button(u8'Сохранить лог', imgui.ImVec2(325, 20)) then
                                    
                                    f = io.open("moonloader\\ViceTools\\logs\\logAdmin.txt","w")
                                    f:close()
                                   
                                    
        
                                    local t = ""
                                    for k, v in ipairs(adminLog) do
                                        t = t .. (tostring(t):len() > 0 and "\n" or "") .. v
                                    end
                                    if f ~= nil then
                                    f = io.open("moonloader\\ViceTools\\logs\\logAdmin.txt","r+")
                                    f:write(u8(t))
                                    f:close()
                                    end
                                end imgui.SameLine()
                                if imgui.Button(u8'Вывести лог', imgui.ImVec2(325, 20)) then
                                    checkfile = true
                                    file = io.open(getGameDirectory().."//moonloader//ViceTools//logs//logAdmin.txt", "r")
                                    if file ~= nil then
                                    print(file)
                                    admin_buffer.v = file:read('*a')
                                    file:close()
                                    else
                                        msg('Сначала сохраните лог.')
                                    end
                                end
                                if imgui.Button(u8'Убрать выведенные логи', imgui.ImVec2(-1, 20)) then
                                    admin_buffer.v = ''



                                end
                                imgui.centeredText(u8'Логи выводятся не полностью.')
                                    imgui.centeredText(u8'Учтите. Сохраняется и выводится только последний лог.\nЧтобы убрать старые логи, нажмите: Очистить выведенные логи\nПоиск по логам в старых логах не работает.\nМесто сохранения логов: moonloader >> ViceTools >> logs')
                            
        
        
                              
                                imgui.BeginChild('##createLogNDFG', imgui.ImVec2(-1, 150), true)
                                imgui.PushItemWidth(250)
                                imgui.NewInputText(u8'##SearchLogNDGDF', tableOfNew.findText, 615, "Поиск по логам", 2)
                                
                                imgui.PopItemWidth()
                                imgui.Separator()
                                for k,v in pairs(adminLog) do
                                    if tableOfNew.findText.v ~= '' then
                                        
                                            
                                        if string.rlower(v):find(string.rlower(u8:decode(tableOfNew.findText.v))) then
                                            imgui.TextWrapped(u8(v))
                                        end
                                    
                                    end
                             
                                            end
                                imgui.EndChild()



                            end
                            imgui.PopStyleColor()
                if menuSelect == 115 then
                    if imgui.InvButton(fa.ICON_FA_LINK..u8' ЛОГ ОТКЛЮЧЕНИЙ/ПОДКЛЮЧЕНИЙ', imgui.ImVec2(-1, 50)) then  
                        menuSelect = 120
                    end
                    
                    if imgui.InvButton(fa.ICON_FA_LINK..u8' ЛОГ ПОДАННЫХ ЖАЛОБ(/REPORT)', imgui.ImVec2(-1, 50)) then  
                        menuSelect = 122
                    end
                    
                    if imgui.InvButton(fa.ICON_FA_LINK..u8' ЛОГ АДМИН ЧАТА', imgui.ImVec2(-1, 50)) then  
                        menuSelect = 124
                    end
                    if tonumber(HLcfg.config.adminlvl) >= 12 then
                        if imgui.InvButton(fa.ICON_FA_LINK..u8' ЛОГ ПОДКЛЮЧЕНИЙ/ОТКЛЮЧЕНИЙ АДМИНИСТРАЦИИ', imgui.ImVec2(-1, 50)) then  
                            menuSelect = 121
                        end

                    if imgui.InvButton(fa.ICON_FA_LINK..u8' ЛОГ ОТВЕТОВ ОТ АДМИНИСТРАЦИИ', imgui.ImVec2(-1, 50)) then  
                         menuSelect = 123
                    end
                    if imgui.InvButton(fa.ICON_FA_LINK..u8' ЛОГ НАКАЗАНИЙ АДМИНИСТРАЦИИ', imgui.ImVec2(-1, 50)) then  
                        menuSelect = 125
                    end
                    if imgui.InvButton(fa.ICON_FA_LINK..u8' ЛОГ ДЕЙСТВИЙ АДМИНИСТРАЦИИ', imgui.ImVec2(-1, 50)) then  
                        menuSelect = 126
                    end
                    end  
                    
                  

             

                           
                                       
                                                   



                    


                end
               

        if menuSelect == 110 then
            if imgui.CollapsingHeader(u8'Основные команды') then
                local commandScope = 0
                imgui.BeginChild('commandL', imgui.ImVec2(-1, 340), true)
                
                commandLocalList = {
                    {cmd='{ff0000}(!){ffffff} /advig [id] [причина]', desp='Выдать выговор'},
                    {cmd='{ff0000}(!){ffffff} /adunvig [id] [причина]', desp='Снять выговор'},
                    {cmd='{ff0000}(!){ffffff} /mka [id] [lvl]', desp='Выдать админ-права'},
                    {cmd='/stmp [Название]', desp='Оповещение в /aad о начале мероприятия'},
                    {cmd='/apanel', desp='Админ-Панель'},
                    {cmd='{ff0000}(!){ffffff} /dvall [sec]', desp='Спавн админ-транспорта'},
                    {cmd='{ff0000}(!){ffffff} /spawncars [sec]', desp='Спавн незанятого т/с'},
                    {cmd='/gun | Equivalent to /givegun', desp='Выдать себе оружие.'},
                    {cmd='/car', desp='Выдать себе оружие в ЗЗ'},
                    {cmd='/givecar [id] [id car]', desp='Выдать машину игроку'},
                    {cmd='/vred | /cheat | /dm | /tk', desp='Выдать наказание, соответствующему команде'},
                    {cmd='/frz | /unfr', desp='Заморозить / разморозить'},
                    {cmd='{ff0000}(!){ffffff} /gdon | Equivalent /givedonate', desp='Выдать донат'}
                }
            
            imgui.Columns(2, "CommanSd", true)
            imgui.Separator()
            for k,v in pairs(commandLocalList) do
                imgui.TextColoredRGB(v.cmd)
                imgui.NextColumn()
                imgui.TextWrapped(u8(v.desp))
                imgui.Separator()
                imgui.NextColumn()
                commandScope = commandScope + 1
                

            end
            
           
            imgui.Columns(1)
            imgui.PushFont(minifont)
           
                imgui.TextColoredRGB('{ff0000}(!){ffffff} - Для старшей администрации')
              
            imgui.Text(u8'Всего команд: '..commandScope)
            imgui.PopFont()
            imgui.EndChild()
            end
            if imgui.CollapsingHeader(u8'Команды скрипта') then
                local commandScope = 0
                imgui.BeginChild('command', imgui.ImVec2(-1, 380), true)
                commandScriptList = {
                    {cmd=HLcfg.config.Atoolscmd, desp='Открывает меню Тулса'},
                    {cmd=HLcfg.config.Achatcmd, desp='Открывает Универсальный админ-чат'},
                    {cmd=HLcfg.config.Aavtorepcmd, desp='Открывает авто-репорт'},
                    {cmd='/jp', desp='Получить Джет-Пак'},
                    {cmd='/mpset', desp='Провести мероприятие'},
                    {cmd='/offcursor', desp='Выключить курсор на экране'},
                    {cmd='/nakaz', desp='Таблица наказаний'},
                    {cmd='/vcaz', desp='Телепорт в Админ-Зону ВайсТулса'},
                    {cmd='/otziv', desp='Отзыв о скрипте'},
                    {cmd='/napak', desp='Выдать пак гангстера(900 хп, 500 гана)'},
                    {cmd='/otdaipak', desp='Забрать пак гангстера'},
                    {cmd='/aid [id] [text]', desp='Обращение к администратору в /a'},
                    {cmd='/az / /az [id]', desp='Телепорт в админ-зону'},
                    {cmd='/invis', desp='Невидимость'},
                    {cmd='/copynick [id]', desp='Скопировать ник-нейм'},
                    {cmd='/carvpizdu [ID car]', desp='Отправить автомобиль далеко и надолго'}
                }
                imgui.Columns(2, '#command', true)
              for k,v in pairs(commandScriptList) do
                imgui.Text(u8(v.cmd))
                imgui.NextColumn()
                imgui.TextWrapped(u8(v.desp))
                imgui.Separator()
                imgui.NextColumn()
                commandScope = commandScope + 1
              end
              imgui.Columns(1)
              imgui.PushFont(minifont)
              imgui.Text(u8'Всего команд: '..commandScope)
              imgui.PopFont()
              imgui.EndChild()
                


            end
            imgui.PushItemWidth(130)
                    imgui.Text(u8'Введите команду, который вы будете открывать админ-чат')
					if imgui.InputText(u8"####RHEAYRE346345", elements.input.Achatcmd) then
                        HLcfg.config.Achatcmd = elements.input.Achatcmd.v 
                        save()
                    end 
                    
                    imgui.Sep()
                    imgui.Text(u8'Введите команду, которая будет открывать основное меню Тулса.\nПервая команда - /rh\nСюда вы вводите дополнительную команду.')
                    if imgui.InputText(u8"####SRGUDIFGDYFG", elements.input.Atoolscmd) then
                        HLcfg.config.Atoolscmd = elements.input.Atoolscmd.v 
                        save()
                    end 
                    imgui.Sep()
                    imgui.Text(u8'Введите команду, которая будет открывать Авто-Репорт')
                    if imgui.InputText(u8"####IRUTERTFDUIGDFH", elements.input.Aavtorepcmd) then
                        HLcfg.config.Aavtorepcmd = elements.input.Aavtorepcmd.v 
                        save()
                    end 
                    

                    
                    
			imgui.PopItemWidth()



        end
      
			if menuSelect == 0 then
                imgui.SetCursorPos(imgui.ImVec2(0,0))
                imgui.Image(fon, imgui.ImVec2(650, 590))

          imgui.SetCursorPos(imgui.ImVec2(10, 10))
          imgui.TextColored(imgui.ImVec4(255/255,0,0,0.9), u8(helloText))
					
                    imgui.Text('')
                    imgui.SameLine()
                    imgui.Text('')
                    imgui.SameLine()
					if imgui.Button(u8'Лог обновлений') then
						AdminTools.v = false
						Log.v = true
					end
                   
					
					
                   
                  
                    
                 


			end
          
        
			if menuSelect == 1 then
					
                imgui.Text(fa.ICON_FA_COGS..u8" | Выберите стиль имгуи >> ") imgui.SameLine() imgui.PushItemWidth(130) imgui.Combo("##imguiStyles", elements.int.intImGui, {u8"Стандартный", u8"Синий", u8"Красный", u8"Коричневый", u8"Фиолетовый", u8"Темно-красный", u8"Блевотный", u8"Желтый", u8"Оранжевый", u8"Розовый", u8"Монохром", u8"Пурпурный", u8"Светло-синий", u8"Чёрный", u8"Красно-оранжевый", u8"Серый", u8"Гламурно-розовый", u8"Бирюзовый"}) imgui.PopItemWidth()
                if imgui.ColorEdit4("##classicColor", classicColor) then
                    HLcfg.config.classicColor = join_argb(classicColor.v[1] * 255, classicColor.v[2] * 255, classicColor.v[3] * 255, classicColor.v[4] * 255)
                    save()
                end imgui.SameLine() imgui.Text(u8"Стиль границ")
                if imgui.ColorEdit4("##buttonColor", buttonColor, imgui.ImVec2(-1,0)) then
                    HLcfg.config.buttonColor = join_argb(buttonColor.v[1] * 255, buttonColor.v[2] * 255, buttonColor.v[3] * 255, buttonColor.v[4] * 255)
                    save()
                end imgui.SameLine() imgui.Text(u8"Стиль кнопок")

                 imgui.Separator()
					
                   


                
					if imgui.Button(u8"Настроить команды для спавна машин", imgui.ImVec2(-1, 0)) then
							imgui.OpenPopup(u8"Настройка команд для спавна машин")
					end
					if imgui.BeginPopup(u8"Настройка команд для спавна машин") then
							if imgui.Checkbox(u8"[Вкл/выкл] Отображение секунд до окончания спавна машин [ /dvall ]", elements.checkbox.printDvall) then
									HLcfg.config.printDvall = elements.checkbox.printDvall.v
									save()
							end
							if imgui.Checkbox(u8"[Вкл/выкл] Отображение секунд до окончания спавна машин [ /spawncars ]", elements.checkbox.printSpawnCars) then
									HLcfg.config.printSpawnCars = elements.checkbox.printSpawnCars.v
									save()
							end
							imgui.EndPopup()
					end
					imgui.Separator()
                    imgui.Spacing()
                    imgui.PushFont(minifont)
					
                  
					if imgui.ToggleButton(u8"[Вкл/выкл] Автоматический ввод 'Уважаемый игрок,' в /ot", elements.checkbox.autouv) then
							HLcfg.config.autouv = elements.checkbox.autouv.v
							save()
					end imgui.SameLine() imgui.HelpMarker(u8"В поле для ответа будет сам вводить 'Уважаемый игрок, '")
                    imgui.Spacing()
					if imgui.ToggleButton(u8"[Вкл/выкл] Push-Уведомления при новом репорте", elements.checkbox.autorep) then
							HLcfg.config.autorep = elements.checkbox.autorep.v
							save()
					end imgui.SameLine() imgui.HelpMarker(u8"При новых репортах будет появляться оповещение")
                    
					
                    imgui.Spacing()
                    if imgui.ToggleButton(u8'[Вкл/выкл] Меню взаимодействие с игроком при наведении на него', elements.checkbox.fastHelp) then
                        HLcfg.config.fastHelp = elements.checkbox.fastHelp.v
                        save()
                    end 
                    imgui.Spacing()
                    if imgui.ToggleButton(u8"[Вкл/выкл] Команды на English", elements.checkbox.autoLang) then
                        HLcfg.config.autoLang = elements.checkbox.autoLang.v
                        save()
                    end imgui.SameLine() imgui.HelpMarker(u8"Если будете вводить команду на русском - скрипт заменит на английский\nПример: .мур >> /veh")
                    imgui.Spacing()
                    if imgui.ToggleButton(u8"[Вкл/выкл] Отображение языка при включенном чате", elements.checkbox.stateLang) then
                        HLcfg.config.stateLang = elements.checkbox.stateLang.v
                        save()
                    end imgui.SameLine() imgui.HelpMarker(u8"Появится индикатор языка возле строчки чата")
                    imgui.Spacing()
                    if imgui.ToggleButton(u8"[Вкл/выкл] Локальный скин", elements.checkbox.statetempskin) then
                        HLcfg.config.statetempskin = elements.checkbox.statetempskin.v
                        save()
                        if notify then
                            notify.addNotification('[ViceTools]\nЛокальный скин '..(elements.checkbox.statetempskin.v and 'включен' or 'выключен'), 3, 0, 1)
                        end
                    end imgui.SameLine() imgui.HelpMarker(u8"Скин локальный, видите его только вы\nУчтите, чтобы вернуть свой старый скин - вы должны отключить 'Локальный скин' и либо перезайти, либо сменить скин с помощью /skin | /setskin")
                    if elements.checkbox.statetempskin.v then
                        if imgui.InputInt('####tempSkin', elements.int.tempSkin) then
                            if elements.int.tempSkin.v > 311 then
                               
                                    elements.int.tempSkin.v = 311
                               
                            end
                            if elements.int.tempSkin.v < 0 then
                                elements.int.tempSkin.v = 0
                            end
                            HLcfg.config.tempSkin = elements.int.tempSkin.v
                            save()
                            local _, id = sampGetPlayerIdByCharHandle(PLAYER_PED)
                            setCharModel(PLAYER_PED, elements.int.tempSkin.v)
                            

                        end
                       



                    end
                    imgui.Spacing() 
                    if imgui.ToggleButton(u8"[Вкл/выкл] Погода", elements.checkbox.stateWeather) then
                        HLcfg.config.stateWeather = elements.checkbox.stateWeather.v
                        save()
                    end imgui.SameLine() imgui.HelpMarker(u8"Установка своей погоды")
                    if elements.checkbox.stateWeather.v then
                        if imgui.InputInt('####tempweather', elements.int.weather) then
                            if elements.int.weather.v > 45 then
                                elements.int.weather.v = 45
                            elseif elements.int.weather.v < 0 then
                                elements.int.weather.v = 0
                            end
                            setWeather(elements.int.weather)
                            HLcfg.config.weather = elements.int.weather.v
                            save()
                        end
                    end
                    imgui.Spacing()
                    if imgui.ToggleButton(u8"[Вкл/выкл] Время", elements.checkbox.stateTime) then
                        HLcfg.config.stateTime = elements.checkbox.stateTime.v
                        save()
                    end imgui.SameLine() imgui.HelpMarker(u8"Установка своего времени")
                    if elements.checkbox.stateTime.v then
                        if imgui.InputInt('####tempweatherti', elements.int.time) then
                            setTime(elements.int.time.v)
                            HLcfg.config.time = elements.int.time.v
                            save()
                            
                        end
                    end
                    imgui.Spacing()
                    if imgui.ToggleButton(u8"[Вкл/выкл] Надпись 'Администратор' у администрации", elements.checkbox.stateAdmin) then
                        HLcfg.config.stateAdmin = elements.checkbox.stateAdmin.v
                        save()
                    end imgui.SameLine() imgui.HelpMarker(u8"Появится надпись около каждого администратора")
                    imgui.Spacing()
                 
                   
                    
					
                
					if imgui.ToggleButton(u8"[Вкл/выкл] Показывать ИД при убийстве игрока", elements.checkbox.showKillerId) then
							HLcfg.config.showKillerId = elements.checkbox.showKillerId.v
							save()
					end imgui.SameLine() imgui.HelpMarker(u8"В Килл-Листе будет показан ИД.")
                    imgui.Spacing()
					if imgui.ToggleButton(u8"[Вкл/выкл] Click Warp", elements.checkbox.clickWarp) then
							HLcfg.config.clickWarp = elements.checkbox.clickWarp.v
							save()
					end imgui.SameLine() imgui.HelpMarker(u8"Телепорт по метке. Активация: колёсико мышки")
                    if elements.checkbox.clickWarp.v then
                       
                        if imgui.Checkbox(u8'При наведении на игрока отображать меню работы с игроком', elements.checkbox.clickWarpPeople) then
                            HLcfg.config.clickWarpPeople = elements.checkbox.clickWarpPeople.v 
                            save()
                        end imgui.SameLine() imgui.HelpMarker(u8'ЛКМ - телепорт к игроку, ПКМ - слежка за игроком')
                    end
                    imgui.Spacing()
					if imgui.ToggleButton(u8"[Вкл/выкл] Курсор Авто-репорт", elements.checkbox.areportclick) then
							HLcfg.config.areportclick = elements.checkbox.areportclick.v
							save()
					end imgui.SameLine() imgui.HelpMarker(u8"Настраивает, будет показываться мышь сразу после активации данного окна, или при нажатии клавиши U.")
                    imgui.Spacing()
					if imgui.ToggleButton(u8"[Вкл/выкл] Формы", elements.checkbox.formsEnabled) then
							HLcfg.config.formsEnabled = elements.checkbox.formsEnabled.v
							save()
					end imgui.SameLine() imgui.HelpMarker(u8"Принимает просьбу выдачи наказания от другого администратора")
                    imgui.Spacing()
					if imgui.ToggleButton(u8"[Вкл/выкл] Границу у шрифта", elements.checkbox.borderToFont) then
							if elements.checkbox.borderToFont.v then
									font = renderCreateFont("Arial", elements.int.sizeBuffer.v, font_flag.BOLD + font_flag.SHADOW + font_flag.BORDER)
							else
									font = renderCreateFont("Arial", elements.int.sizeBuffer.v, font_flag.BOLD + font_flag.SHADOW)
							end
							HLcfg.config.borderToFont = elements.checkbox.borderToFont.v
							save()
					end imgui.SameLine() imgui.HelpMarker(u8"Добавляет границу текста [ рендера ] на экране.")
                    imgui.Spacing()
					if imgui.ToggleButton(u8"[Вкл/выкл] Авто-вход как администратор", elements.checkbox.autoCome) then
							HLcfg.config.autoCome = elements.checkbox.autoCome.v
							save()
					end imgui.SameLine() imgui.HelpMarker(u8"Не надо вводить админ-пароль самому, скрипт сделает это за вас")
                    imgui.Spacing()
					if elements.checkbox.autoCome.v then
							imgui.Text(u8"Введите админ-пароль: ") imgui.SameLine() imgui.PushItemWidth(100)
							if imgui.InputText("##adminPassword", elements.input.adminPassword, (elements.checkbox.showAdminPassword.v and imgui.InputTextFlags.Password or nil)) then
									HLcfg.config.adminPassword = elements.input.adminPassword.v
									save()
							end imgui.PopItemWidth() imgui.SameLine() if imgui.ToggleButton('Админ Пароль', elements.checkbox.showAdminPassword) then
									HLcfg.config.showAdminPassword = elements.checkbox.showAdminPassword.v
									save()
							end imgui.SameLine() imgui.HelpMarker(u8"Настройка, которая будет показывать, отобразиться ваш админ-пароль, или нет")
					end
					imgui.Separator()
					if imgui.ToggleButton(u8"[Вкл/выкл] Рендер информации об автомобиле", elements.checkbox.renderInfoCars) then
							HLcfg.config.renderInfoCars = elements.checkbox.renderInfoCars.v
							save()
					end imgui.SameLine() imgui.HelpMarker(u8"На указанной дистанции вы будете видеть ХП и ИД машины, пример использования:\n /getherecar [IDCAR]")
					if elements.checkbox.renderInfoCars.v then
							imgui.Text(u8"Настройте дальность прорисовки информации об автомобиле:")
							if imgui.SliderInt("##longInfoCar", elements.int.intInfoCars, 30, 100) then
									HLcfg.config.intInfoCars = elements.int.intInfoCars.v
									save()
							end
					end
                    imgui.PopFont()
                    
					imgui.Separator()
					imgui.Text(u8"Изменить кол-во секунд ожидания формы >>")
					if imgui.SliderInt("##pForm", elements.int.timeOutForma, 5, 20) then
							HLcfg.config.timeOutForma = elements.int.timeOutForma.v
							save()
					end
					imgui.Text(u8"Изменить размер шрифта >>")
					if imgui.SliderInt("##sizeFont", elements.int.sizeBuffer, 10, 15) then
							if elements.checkbox.borderToFont.v then
									font = renderCreateFont("Arial", elements.int.sizeBuffer.v, font_flag.BOLD + font_flag.SHADOW + font_flag.BORDER)
							else
									font = renderCreateFont("Arial", elements.int.sizeBuffer.v, font_flag.BOLD + font_flag.SHADOW)
							end
							HLcfg.config.sizeBuffer = elements.int.sizeBuffer.v
							save()
					end
					imgui.Separator()
					if imgui.Button(u8"Перезагрузить скрипт", imgui.ImVec2(-1, 0)) then
							thisScript():reload()
					end
					if imgui.Button(u8"Очистить стрим-память", imgui.ImVec2(-1, 0)) then
							cleanStreamMemory()
					end
			end

			if menuSelect == 3 then
                imgui.PushFont(minifont)
                if imgui.ToggleButton(u8"[Вкл/выкл] Трейсер пуль", elements.checkbox.bulletTracer) then
                    HLcfg.config.bulletTracer = elements.checkbox.bulletTracer.v
                    save()
            end imgui.SameLine() imgui.HelpMarker(u8"Рендерит траекторию пули")
            imgui.PopFont()
					if imgui.Checkbox(u8"Отображать/Не отображать свои пули", elements.checkbox.showMyBullets) then
							HLcfg.config.showMyBullets = elements.checkbox.showMyBullets.v
							save()
					end
					imgui.Separator()
					if elements.checkbox.showMyBullets.v then
							if imgui.CollapsingHeader(u8"Настроить трейсер своих пуль") then


									imgui.Separator()
									imgui.PushItemWidth(175)
									if imgui.SliderInt("##bulletsMyTime", elements.int.secondToCloseTwo, 5, 15) then
											HLcfg.config.secondToCloseTwo = elements.int.secondToCloseTwo.v
											save()
									end imgui.SameLine() imgui.Text(u8"Время задержки трейсера")
									if imgui.SliderInt("##renderWidthLinesTwo", elements.int.widthRenderLineTwo, 1, 10) then
											HLcfg.config.widthRenderLineTwo = elements.int.widthRenderLineTwo.v
											save()
									end imgui.SameLine() imgui.Text(u8"Толщина линий")
									if imgui.SliderInt('##maxMyBullets', elements.int.maxMyLines, 10, 300) then
											bulletSyncMy.maxLines = elements.int.maxMyLines.v
											bulletSyncMy = {lastId = 0, maxLines = elements.int.maxMyLines.v}
											for i = 1, bulletSyncMy.maxLines do
													bulletSyncMy[i] = { my = {time = 0, t = {x,y,z}, o = {x,y,z}, type = 0, color = 0}}
											end
											HLcfg.config.maxMyLines = elements.int.maxMyLines.v
											save()
									end imgui.SameLine() imgui.Text(u8"Максимальное количество линий")

									imgui.Separator()

									if imgui.Checkbox(u8"[Вкл/выкл] Окончания у трейсеров##1", elements.checkbox.cbEndMy) then
											HLcfg.config.cbEndMy = elements.checkbox.cbEndMy.v
											save()
									end

									if imgui.SliderInt('##sizeTraicerEnd', elements.int.sizeOffPolygon, 1, 10) then
											HLcfg.config.sizeOffPolygon = elements.int.sizeOffPolygon.v
											save()
									end  imgui.SameLine() imgui.Text(u8"Размер окончания трейсера")
									if imgui.SliderInt('##endNumbers', elements.int.polygonNumber, 2, 10) then
											HLcfg.config.polygonNumber = elements.int.polygonNumber.v
											save()
									end imgui.SameLine() imgui.Text(u8"Количество углов на окончаниях")
									if imgui.SliderInt('##rotationOne', elements.int.rotationPolygonOne, 0, 360) then
											HLcfg.config.rotationPolygonOne = elements.int.rotationPolygonOne.v
											save()
									end imgui.SameLine() imgui.Text(u8"Градус поворота окончания")


									imgui.PopItemWidth()
									imgui.Separator()
									imgui.Text(u8"Укажите цвет трейсера, если вы попали в:")
									imgui.PushItemWidth(325)
									if imgui.ColorEdit4("##dinamicObjectMy", dinamicObjectMy) then
											HLcfg.config.dinamicObjectMy = join_argb(dinamicObjectMy.v[1] * 255, dinamicObjectMy.v[2] * 255, dinamicObjectMy.v[3] * 255, dinamicObjectMy.v[4] * 255)
											save()
									end imgui.SameLine() imgui.Text(u8"Динамический объект")
									if imgui.ColorEdit4("##staticObjectMy", staticObjectMy) then
											HLcfg.config.staticObjectMy = join_argb(staticObjectMy.v[1] * 255, staticObjectMy.v[2] * 255, staticObjectMy.v[3] * 255, staticObjectMy.v[4] * 255)
											save()
									end imgui.SameLine() imgui.Text(u8"Статический объект")
									if imgui.ColorEdit4("##pedMy", pedPMy) then
											HLcfg.config.pedPMy = join_argb(pedPMy.v[1] * 255, pedPMy.v[2] * 255, pedPMy.v[3] * 255, pedPMy.v[4] * 255)
											save()
									end imgui.SameLine() imgui.Text(u8"Игрока")
									if imgui.ColorEdit4("##carMy", carPMy) then
											HLcfg.config.carPMy = join_argb(carPMy.v[1] * 255, carPMy.v[2] * 255, carPMy.v[3] * 255, carPMy.v[4] * 255)
											save()
									end imgui.SameLine() imgui.Text(u8"Машину")
									imgui.PopItemWidth()
									imgui.Separator()
							end
					end
					if imgui.CollapsingHeader(u8"Настроить трейсер чужих пуль") then
							imgui.Separator()
							imgui.PushItemWidth(175)
							if imgui.SliderInt("##secondsBullets", elements.int.secondToClose, 5, 15) then
									HLcfg.config.secondToClose = elements.int.secondToClose.v
									save()
							end imgui.SameLine() imgui.Text(u8"Время задержки трейсера")
							if imgui.SliderInt("##renderWidthLinesOne", elements.int.widthRenderLineOne, 1, 10) then
									HLcfg.config.widthRenderLineOne = elements.int.widthRenderLineOne.v
									save()
							end imgui.SameLine() imgui.Text(u8"Толщина линий")
							if imgui.SliderInt('##numberNotMyBullet', elements.int.maxNotMyLines, 10, 300) then
									bulletSync.maxNotMyLines = elements.int.maxNotMyLines.v
									bulletSync = {lastId = 0, maxLines = elements.int.maxNotMyLines.v}
									for i = 1, bulletSync.maxLines do
											bulletSync[i] = { other = {time = 0, t = {x,y,z}, o = {x,y,z}, type = 0, color = 0}}
									end
									HLcfg.config.maxNotMyLines = elements.int.maxNotMyLines.v
									save()
							end imgui.SameLine() imgui.Text(u8"Максимальное количество линий")

							imgui.Separator()

							if imgui.Checkbox(u8"[Вкл/выкл] Окончания у трейсеров##2", elements.checkbox.cbEnd) then
									HLcfg.config.cbEnd = elements.checkbox.cbEnd.v
									save()
							end

							if imgui.SliderInt('##sizeTraicerEndTwo', elements.int.sizeOffPolygonTwo, 1, 10) then
									HLcfg.config.sizeOffPolygonTwo = elements.int.sizeOffPolygonTwo.v
									save()
							end imgui.SameLine() imgui.Text(u8"Размер окончания трейсера")

							if imgui.SliderInt('##endNumbersTwo', elements.int.polygonNumberTwo, 2, 10) then
									HLcfg.config.polygonNumberTwo = elements.int.polygonNumberTwo.v
									save()
							end imgui.SameLine() imgui.Text(u8"Количество углов на окончаниях")

							if imgui.SliderInt('##rotationTwo', elements.int.rotationPolygonTwo, 0, 360) then
									HLcfg.config.rotationPolygonTwo = elements.int.rotationPolygonTwo.v
									save()
							end imgui.SameLine() imgui.Text(u8"Градус поворота окончания")

							imgui.PopItemWidth()
							imgui.Separator()
							imgui.Text(u8"Укажите цвет трейсера, если игрок попал в: ")
							imgui.PushItemWidth(325)
							if imgui.ColorEdit4("##dinamicObject", dinamicObject) then
									HLcfg.config.dinamicObject = join_argb(dinamicObject.v[1] * 255, dinamicObject.v[2] * 255, dinamicObject.v[3] * 255, dinamicObject.v[4] * 255)
									save()
							end imgui.SameLine() imgui.Text(u8"Динамический объект")
							if imgui.ColorEdit4("##staticObject", staticObject) then
									HLcfg.config.staticObject = join_argb(staticObject.v[1] * 255, staticObject.v[2] * 255, staticObject.v[3] * 255, staticObject.v[4] * 255)
									save()
							end imgui.SameLine() imgui.Text(u8"Статический объект")
							if imgui.ColorEdit4("##ped", pedP) then
									HLcfg.config.pedP = join_argb(pedP.v[1] * 255, pedP.v[2] * 255, pedP.v[3] * 255, pedP.v[4] * 255)
									save()
							end imgui.SameLine() imgui.Text(u8"Игрока")
							if imgui.ColorEdit4("##car", carP) then
									HLcfg.config.carP = join_argb(carP.v[1] * 255, carP.v[2] * 255, carP.v[3] * 255, carP.v[4] * 255)
									save()
							end imgui.SameLine() imgui.Text(u8"Машину")
							imgui.PopItemWidth()
							imgui.Separator()
					end
			end
			if menuSelect == 4 then
					if elements.checkbox.enableCheckerPlayer.v then
							if imgui.Button(u8"Установить новые координаты чекера", imgui.ImVec2(495, 0)) then
									AdminTools.v = false
									checkerCoords = true
									sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Чтобы подтвердить сохранение - нажмите 1, чтобы отменить сохранение - нажмите 2.', stColor)
							end
					end
					if imgui.Checkbox(u8"[Вкл/выкл] Чекер", elements.checkbox.enableCheckerPlayer) then
							HLcfg.config.enableCheckerPlayer = elements.checkbox.enableCheckerPlayer.v
							save()
					end
					for k, v in ipairs(playersList) do
							imgui.Text(u8(v))
							imgui.SameLine()
							if imgui.Button(u8"Удалить##"..k) then
								table.remove(playersList, k)
							end
					end
					imgui.PushItemWidth(130)
					imgui.InputText(u8"Введите ник", tableOfNew.addInBuffer)
					imgui.PopItemWidth()
					imgui.SameLine()
					if imgui.Button(u8"Добавить") then
							table.insert(playersList, u8:decode(tableOfNew.addInBuffer.v))
					end
			end
			if menuSelect == 5 then
                if elements.checkbox.statistics.v then

                    if imgui.Button(u8"Изменить координаты статистики", imgui.ImVec2(-1, 0)) then
                            changePosition = true
                            AdminTools.v = false
                            sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Чтобы подтвердить сохранение - нажмите 1, чтобы отменить сохранение - нажмите 2.', stColor)
                    end


            end
            imgui.PushFont(minifont)
            if imgui.ToggleButton(u8"[Вкл/выкл] Статистика", elements.checkbox.statistics) then
                HLcfg.config.statistics = elements.checkbox.statistics.v
                save()
            end imgui.SameLine() imgui.HelpMarker(u8"Показывает ваш онлайн/ИД и т.д;\nРегулируется в меню")
            imgui.PopFont()
            imgui.Separator()
				if imgui.Checkbox(u8'[Вкл/выкл] Название', elements.putStatis.nameStatis) then
						HLcfg.statAdmin.nameStatis = elements.putStatis.nameStatis.v
						save()
				end
				if imgui.Checkbox(u8'[Вкл/выкл] Центрирование текста', elements.putStatis.centerText) then
							HLcfg.statAdmin.centerText = elements.putStatis.centerText.v
							save()
					end
					if imgui.Checkbox(u8'[Вкл/выкл] Показывать ник / ID', elements.putStatis.showId) then
							HLcfg.statAdmin.showId = elements.putStatis.showId.v
							save()
					end
                    if imgui.Checkbox(u8'[Вкл/выкл] Показывать ЛВЛ админки', elements.putStatis.showLVL) then
                        HLcfg.statAdmin.showLVL = elements.putStatis.showLVL.v
                        save()
                end
					if imgui.Checkbox(u8'[Вкл/выкл] Показывать пинг', elements.putStatis.showPing) then
							HLcfg.statAdmin.showPing = elements.putStatis.showPing.v
							save()
					end
					if imgui.Checkbox(u8'[Вкл/выкл] Показывать ХП', elements.putStatis.showHealth) then
							HLcfg.statAdmin.showHealth = elements.putStatis.showHealth.v
							save()
					end
					if imgui.Checkbox(u8'[Вкл/выкл] Показывать формы за день', elements.putStatis.showFormDay) then
							HLcfg.statAdmin.showFormDay = elements.putStatis.showFormDay.v
							save()
					end
					if imgui.Checkbox(u8'[Вкл/выкл] Показывать формы за сеанс', elements.putStatis.showFormSession) then
							HLcfg.statAdmin.showFormSession = elements.putStatis.showFormSession.v
							save()
					end
					if imgui.Checkbox(u8'[Вкл/выкл] Показывать состояние INVIS', elements.putStatis.showInvis) then
							HLcfg.statAdmin.showInvis = elements.putStatis.showInvis.v
							save()
					end
					if imgui.Checkbox(u8'[Вкл/выкл] Показывать состояние GM', elements.putStatis.showGM) then
							HLcfg.statAdmin.showGM = elements.putStatis.showGM.v
							save()
					end
					if imgui.Checkbox(u8'[Вкл/выкл] Показывать репорты за день', elements.putStatis.showReportDay) then
							HLcfg.statAdmin.showReportDay = elements.putStatis.showReportDay.v
							save()
					end
					if imgui.Checkbox(u8'[Вкл/выкл] Показывать репорты за сеанс', elements.putStatis.showReportSession) then
							HLcfg.statAdmin.showReportSession = elements.putStatis.showReportSession.v
							save()
					end
					if imgui.Checkbox(u8"[Вкл/выкл] Показывать интерьер", elements.putStatis.showInterior) then
						 HLcfg.statAdmin.showInterior = elements.putStatis.showInterior.v
						 save()
					end
					if imgui.Checkbox(u8'[Вкл/выкл] Показывать отыгранное время за день', elements.putStatis.showOnlineDay) then
							HLcfg.statAdmin.showOnlineDay = elements.putStatis.showOnlineDay.v
							save()
					end
					if imgui.Checkbox(u8'[Вкл/выкл] Показывать отыгранное время за сеанс', elements.putStatis.showOnlineSession) then
							HLcfg.statAdmin.showOnlineSession = elements.putStatis.showOnlineSession.v
							save()
					end
					if imgui.Checkbox(u8'[Вкл/выкл] Показывать АФК за день', elements.putStatis.showAfkDay) then
							HLcfg.statAdmin.showAfkDay = elements.putStatis.showAfkDay.v
							save()
					end
					if imgui.Checkbox(u8'[Вкл/выкл] Показывать АФК за сеанс', elements.putStatis.showAfkSession) then
							HLcfg.statAdmin.showAfkSession = elements.putStatis.showAfkSession.v
							save()
					end
					if imgui.Checkbox(u8'[Вкл/выкл] Показывать времени', elements.putStatis.showTime) then
							HLcfg.statAdmin.showTime = elements.putStatis.showTime.v
							save()
					end
					if imgui.Checkbox(u8'[Вкл/выкл] Показыть дату', elements.putStatis.showTopDate) then
							HLcfg.statAdmin.showTopDate = elements.putStatis.showTopDate.v
							save()
					end
			end

			if menuSelect == 7 then
					imgui.Text(u8"Чтобы листать чат, зажмите клавишу B, а затем крутите колесико мыши.")
                    if imgui.HotKey("##1dsfgdfgdfdfgdtreterrty", ActiveChatBubble, tLastKeys, 100) then
                        rkeys.changeHotKey(bindChatBubble, ActiveChatBubble.v)
                
                        msg("Клавиша(-ши) срабатывания - {FFFFFF}" .. table.concat(rkeys.getKeysName(ActiveChatBubble.v), ' + '), 0x228B22)
                
                        HLcfg.config.bindChatBubble = encodeJson(ActiveChatBubble.v)
                        save()
                    end imgui.SameLine() imgui.Text(u8'Включить/Выключить чат') 
				
		
					if imgui.Button(u8"Изменить местоположение дальнего чата", imgui.ImVec2(495, 0)) then
							changeBubbleCoordinates = true
							AdminTools.v = false
							sampAddChatMessage('{FF0000}[ViceTools] {FF8C00}Чтобы сохранить местоположение - нажмите "1", чтобы отменить смену - "2".', stColor)
					end
					imgui.Separator()
					imgui.Text(u8"Укажите максимальное количество строк в странице:")
					if imgui.SliderInt("##PrintInt", elements.int.limitPageSize, 5, 30) then
							HLcfg.config.limitPageSize = elements.int.limitPageSize.v
							save()
					end
					imgui.Text(u8"Укажите максимальное количество строк:")
					if imgui.SliderInt("##maxPages", elements.int.maxPagesBubble, 100, 1000) then
							HLcfg.config.maxPagesBubble = elements.int.maxPagesBubble.v
							save()
					end
					imgui.Separator()
			end
			if menuSelect == 8 then
					imgui.PushFont(fontsizeForText)
					imgui.Text(u8"Создать оружие:")
					imgui.PopFont()
					imgui.Separator()
					imgui.Text(u8'Выберите оружие:')
					imgui.PushItemWidth(142)
					if imgui.Combo("##gunCreateFov", tableOfNew.numberGunCreate, arrGuns) then
							HLcfg.config.numberGunCreate = tableOfNew.numberGunCreate.v
							save()
					end
					imgui.PopItemWidth()
					imgui.Text(u8'Выберите количество патронов:')
					imgui.SliderInt('##numberAmmo', numberAmmo, 1, 999)
					if imgui.Button(u8'Создать', imgui.ImVec2(100, 22)) then
							sampSendChat('/givegun '..getMyId()..' '..tableOfNew.numberGunCreate.v..' '..numberAmmo.v)
					end
					imgui.Separator()
					imgui.SetWindowFontScale(1.1)
					imgui.Text(u8"Частоиспользуемое оружие:")
					imgui.SetWindowFontScale(1.0)
					for k,v in pairs(allGunsP) do
							if imgui.Button(u8(v), imgui.ImVec2(100, 0)) then
									sampSendChat('/givegun '..getMyId()..' '..k..' '..numberAmmo.v)
							end imgui.SameLine()
					end
					imgui.NewLine()
					imgui.BeginChild('##createGuns', imgui.ImVec2(495, 280), true)
					imgui.PushItemWidth(250)
					imgui.NewInputText(u8'##SearchBarGun', tableOfNew.findText, 483, "Поиск по списку", 2)
					imgui.PopItemWidth()
					imgui.Separator()
					for k,v in pairs(arrGuns) do
						if tableOfNew.findText.v ~= '' then
							if string.rlower(v):find(string.rlower(u8:decode(tableOfNew.findText.v))) then
								if imgui.Button(u8(v)) then
									sampSendChat('/givegun '..getMyId()..' '.. k - 1 ..' '..numberAmmo.v)
								end
							end
						end
								end
					imgui.EndChild()
					
			end
			if menuSelect == 9 then
					local tt = 0
					imgui.SetWindowFontScale(1.1)
					imgui.Text(u8"Создать транспорт:")
					imgui.SetWindowFontScale(1.0)
					imgui.Separator()
					imgui.Columns(3, _, false)
					imgui.Text(u8"Выберите транспорт:")
					imgui.PushItemWidth(142)
					if imgui.Combo("##car", tableOfNew.intComboCar, tCarsName) then
							HLcfg.config.intComboCar = tableOfNew.intComboCar.v
							save()
					end
					imgui.PopItemWidth()
					if imgui.Button(u8"Создать", imgui.ImVec2(141, 22)) then
							sampSendChat("/veh " .. tableOfNew.intComboCar.v + 400 .. ' '..tableOfNew.carColor1.v..' '..tableOfNew.carColor2.v)
					end
					imgui.NextColumn()
					imgui.Text(u8"Выберите цвет:")
					imgui.AlignTextToFramePadding()
					imgui.Text("#1"); imgui.SameLine();
					imgui.PushItemWidth(80)
					if imgui.InputInt("##carColor1", tableOfNew.carColor1) then
							HLcfg.config.carColor1 = tableOfNew.carColor1.v
							save()
					end
					imgui.PopItemWidth()
					imgui.AlignTextToFramePadding()
					imgui.Text("#2"); imgui.SameLine();
					imgui.PushItemWidth(80)
					if imgui.InputInt("##carColor2", tableOfNew.carColor2) then
							HLcfg.config.carColor2 = tableOfNew.carColor2.v
							save()
					end
					imgui.PopItemWidth()
					imgui.NextColumn()
					imgui.PushStyleVar(imgui.StyleVar.ItemSpacing, imgui.ImVec2(1.0, 3.1))
					imgui.Text(u8("ID: " .. tableOfNew.intComboCar.v + 400))
					imgui.Text(u8("Транспорт: " .. tCarsName[tableOfNew.intComboCar.v + 1]))
					local carId = tableOfNew.intComboCar.v + 1
					local type = tCarsType[carId]
					imgui.Text(u8("Тип: " .. tCarsTypeName[type]))
					imgui.PopStyleVar()
					imgui.Columns(1)
					imgui.Separator()
					imgui.SetWindowFontScale(1.1)
					imgui.Text(u8"Частоиспользуемые машины:")
					imgui.SetWindowFontScale(1.0)
					imgui.Separator()
					for k, v in pairs(allCarsP) do
							tt = tt + 1
							if imgui.Button(u8(v), imgui.ImVec2(100, 0)) then
									sampSendChat('/veh '..k..' '..HLcfg.config.carColor1..' '..HLcfg.config.carColor2)
							end imgui.SameLine()
							if tt == 4 then
									imgui.NewLine()
							end
					end
					imgui.NewLine()
		imgui.BeginChild('##createCar', imgui.ImVec2(495, 280), true)
		imgui.PushItemWidth(250)
		imgui.NewInputText(u8'##SearchBar', tableOfNew.findText, 483, "Поиск по списку", 2)
		imgui.PopItemWidth()
		imgui.Separator()
		for k,v in pairs(tCarsName) do
			if tableOfNew.findText.v ~= '' then
				if string.rlower(v):find(string.rlower(u8:decode(tableOfNew.findText.v))) then
					if imgui.Button(u8(v)) then
						sampSendChat('/veh '.. k + 400 - 1 ..' '..HLcfg.config.carColor1..' '..HLcfg.config.carColor2)
					end
				end
			end
					end
		imgui.EndChild()
	
			end
			if menuSelect == 10 then
				
							imgui.Text(u8"Доброго времени суток, "..getMyNick():gsub("_", " "))
							if imgui.CollapsingHeader(u8"Выдать команды") then
									imgui.Text(u8"Выберите команду")
									imgui.Combo("##inputCommandfd", fdGiveCommand, fdCommandsPlayer)
									imgui.Text(u8"Выберите, администратор, котому вы выдаете команды, в сети, или нет")
									imgui.Combo("##checkOnline", tableOfNew.fdOnlinePlayer, adminOnlineOffline)
									if tableOfNew.fdOnlinePlayer.v == 0 then
											imgui.Text(u8"Введите ИД администратора") imgui.SameLine() imgui.PushItemWidth(100) imgui.InputText("##inputIdAdministration", tableOfNew.inputAdminId)
											if imgui.Button(u8"Выдать команду", imgui.ImVec2(150, 0)) then
													if tableOfNew.inputAdminId.v ~= "" then
															if tableOfNew.inputAdminId.v:find("%d+") then
																	if sampIsPlayerConnected(tonumber(tableOfNew.inputAdminId.v)) then
																			for k,v in ipairs(fdCommandsPlayer) do
																					if fdGiveCommand.v == k then
																							local nickname = sampGetPlayerNickname(tableOfNew.inputAdminId.v)
																							sampSendChat('/setcmd '..nickname..' '..v..' 1')
																					end
																			end
																	else
																			sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Администратор не в сети.', stColor)
																	end
															else
																	sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Вы указали некорректный [ID]', stColor)
															end
													else
															sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Вы не указали [ID]', stColor)
													end
											end
											if imgui.Button(u8"Забрать команду", imgui.ImVec2(150, 0)) then
													if tableOfNew.inputAdminId.v ~= "" then
															if tableOfNew.inputAdminId.v:find("%d+") then
																	if sampIsPlayerConnected(tonumber(tableOfNew.inputAdminId.v)) then
																			for k,v in ipairs(fdCommandsPlayer) do
																					if fdGiveCommand.v == k then
																							local nickname = sampGetPlayerNickname(tonumber(tableOfNew.inputAdminId.v))
																							sampSendChat('/setcmd '..nickname..' '..v..' 0')
																					end
																			end
																	else
																			sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Администратор не в сети.', stColor)
																	end
															else
																	sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Вы указали некорректный [ID]', stColor)
															end
													else
															sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Вы не указали [ID]', stColor)
													end
											end
									elseif tableOfNew.fdOnlinePlayer.v == 1 then
											imgui.Text(u8"Введите никнейм администратора") imgui.SameLine() imgui.PushItemWidth(100) imgui.InputText("##InputNicknameAdministration", inputAdminNick)
											if imgui.Button(u8"Выдать команду") then
													if inputAdminId.v ~= "" then
															for k,v in ipairs(fdCommandsPlayer) do
																	if fdGiveCommand.v == k then
																			sampSendChat('/setcmd '..inputAdminNick.v..' '..v..' 1')
																	end
															end
													else
															sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Вы не указали [ID]', stColor)
													end
											end
											if imgui.Button(u8"Забрать команду") then
													if inputAdminId.v ~= "" then
															for k,v in ipairs(fdCommandsPlayer) do
																	if fdGiveCommand.v == k then
																			sampSendChat('/setcmd '..inputAdminNick.v..' '..v..' 0')
																	end
															end
													else
															sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Вы не указали [ID]', stColor)
													end
											end
									end
							end
							if imgui.CollapsingHeader(u8"Выдача статистики") then
									imgui.Combo(u8'Выберите, что выдать', tableOfNew.intChangedStatis, changedStatis)
				imgui.PushItemWidth(100) imgui.InputText(u8'Введите ИД', inputIdChangedStatis) imgui.PopItemWidth()
									imgui.PushItemWidth(100) imgui.InputText(u8'Введите, сколько необходимо выдать', tableOfNew.inputIntChangedStatis) imgui.PopItemWidth()
									if imgui.Button(u8'Выдать', imgui.ImVec2(100, 0)) then
					if inputIdChangedStatis.v ~= '' then
						if inputIdChangedStatis.v:find('%d+') then
							if tableOfNew.inputIntChangedStatis.v ~= '' then
								if tableOfNew.inputIntChangedStatis.v:find('%d+') then
									for i = 0, 36 do
										if tableOfNew.intChangedStatis.v == i then
											sampSendChat('/setstat '..inputIdChangedStatis.v..' '..tableOfNew.intChangedStatis.v + tonumber(1)..' '..tableOfNew.inputIntChangedStatis.v)
										end
									end
								else
									sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Укажите корректное число.', stColor)
								end
							else
								sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Укажите необходимое количество.', stColor)
							end
						else
							sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Вы ввели некорректный [ID].', stColor)
						end
					else
						sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Вы не указали [ID].', stColor)
					end
				end
							end
					end
			 
			imgui.EndChild()
            imgui.PopStyleColor()
			imgui.End()
            imgui.PopStyleColor(1)

	end




	if tableOfNew.tableRes.v then
		imgui.ShowCursor = true
			local x, y = ToScreen(440, 0)
	local w, h = ToScreen(640, 448)
	imgui.SetNextWindowPos(imgui.ImVec2(x, y), imgui.Cond.FirstUseEver)
			imgui.SetNextWindowSize(imgui.ImVec2(w-x, h), imgui.Cond.FirstUseEver)
	imgui.Begin(u8"##pensBar", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar)
	imgui.SetWindowFontScale(1.1)
	imgui.Text(u8"Таблица наказаний:")
	imgui.SameLine()
	if imgui.Button(u8'>> ЗАКРЫТЬ <<') then
		tableOfNew.tableRes.v = false
	end
	imgui.SetWindowFontScale(1.0)
	imgui.Separator()
	local _, hb = ToScreen(_, 416)
	imgui.BeginChild("##pens", imgui.ImVec2(w-x-2, hb))
	imgui.Columns(2, _, false)
	imgui.SetColumnWidth(-1, 255)
	imgui.Text(u8(pensTable))
	imgui.NextColumn()
	imgui.Text(u8(timesTable))
	imgui.Columns(1)
	imgui.EndChild()
	imgui.End()
	end
	if tableOfNew.commandsAdmins.v then
			local x, y = ToScreen(440, 0)
	local w, h = ToScreen(640, 448)
	imgui.SetNextWindowPos(imgui.ImVec2(x, y), imgui.Cond.FirstUseEver)
			imgui.SetNextWindowSize(imgui.ImVec2(w-x, h), imgui.Cond.FirstUseEver)
	imgui.Begin(u8"##pensBar", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar)
	imgui.SetWindowFontScale(1.1)
	imgui.Text(u8"Адм.Команды(1):")
	imgui.SameLine()
	if imgui.Button(u8"Далее >>") then
		tableOfNew.commandsAdmins.v = false
		tableOfNew.commandAdmins.v = true
	end
	imgui.SameLine()
	if imgui.Button(u8"> Закрыть <") then
		tableOfNew.commandsAdmins.v = false

	end
	imgui.SetWindowFontScale(1.0)
	imgui.Separator()
	local _, hb = ToScreen(_, 416)
	imgui.BeginChild("##pens", imgui.ImVec2(w-x-2, hb))
	imgui.Columns(2, _, false)
	imgui.SetColumnWidth(-1, 255)
	imgui.Text(u8(allcmd))
	imgui.NextColumn()


	imgui.Columns(1)

	imgui.EndChild()

	imgui.End()
	end
	if tableOfNew.commandAdmins.v then

				local x, y = ToScreen(440, 0)
		local w, h = ToScreen(640, 448)
		imgui.SetNextWindowPos(imgui.ImVec2(x, y), imgui.Cond.FirstUseEver)
				imgui.SetNextWindowSize(imgui.ImVec2(w-x, h), imgui.Cond.FirstUseEver)
		imgui.Begin(u8"##pensBar", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoTitleBar)
		imgui.SetWindowFontScale(1.1)
		imgui.Text(u8"Адм.Команды(2):")
		imgui.SameLine()
		if imgui.Button(u8"<< Назад") then
			tableOfNew.commandAdmins.v = false
			tableOfNew.commandsAdmins.v = true
		end
		imgui.SameLine()
		if imgui.Button(u8"> Закрыть <") then
			tableOfNew.commandAdmins.v = false

		end
		imgui.SetWindowFontScale(1.0)
		imgui.Separator()
		local _, hb = ToScreen(_, 416)
		imgui.BeginChild("##pens", imgui.ImVec2(w-x-2, hb))
		imgui.Columns(2, _, false)
		imgui.SetColumnWidth(-1, 255)
		imgui.Text(u8(allcmdTwo))
		imgui.NextColumn()

		imgui.Columns(1)

		imgui.EndChild()

		imgui.End()
		end
	if tableOfNew.tempLeader.v then
		imgui.ShowCursor = true
			imgui.SetNextWindowSize(imgui.ImVec2(270, 400), imgui.Cond.FirstUseEver)
	imgui.SetNextWindowPos(imgui.ImVec2(ex / 2 - 600, ey / 2 - 50), imgui.Cond.FirstUseEver)
	imgui.Begin(u8'Выдача временного лидерства', tableOfNew.tempLeader, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
	if imgui.Button(u8'Покинуть организацию', imgui.ImVec2(225, 0)) then
		sampSendChat('/uval '..getMyId()..' Leave')
	end
	for k,v in ipairs(tempLeaders) do
		if imgui.Button(v..'['..k..']', imgui.ImVec2(225, 0)) then
			sampSendChat('/templeader '..k)
		end
	end
	imgui.End()
   
	end
	if XO_window.v then

	    imgui.SetNextWindowPos(imgui.ImVec2(select(1,getScreenResolution()) / 1.5, select(2,getScreenResolution()) / 2.8), imgui.Cond.FirstUseEver)
	    imgui.SetNextWindowSize(imgui.ImVec2(230,230), imgui.Cond.FirstUseEver)

	    imgui.Begin(u8'Крестики-Нолики', XO_window,2+32)
			imgui.ShowCursor = true
	    XO_window_pos = imgui.GetWindowPos()
	    if not Game then
	    	if connected and s.nick ~= 'PLAYER' then
					imgui.Text(u8'НАЧИНАЕТ ТОЛЬКО ОДИН ИГРОК!')
	    		if imgui.Button(u8'Старт') then
	    			xORo = {'X','O','X','O','X','O','X','O','X','O','X','O'}
	    			math.randomseed(os.time()-1)
	    			XO = xORo[math.random(1, #xORo)]
					if XO == 'X' then
						xo_enemy = "O"
					elseif XO == 'O' then
						xo_enemy = "X"
					end
	    			--

		    		Game = true;
		    		Move = true;
	    			send('start game | '..XO,false)
	    		end
	    		imgui.SameLine()
	    	elseif connected and s.nick == 'PLAYER' then
	    		imgui.TextColored(imgui.ImVec4(255/255,247/255,0,0.9), 'wait'..waitAnimText)
	    		imgui.SameLine()
	    	end
	    	if imgui.Button(u8'Настройки') then imgui.OpenPopup('settings'); end

	    	if imgui.BeginPopup('settings') then
	    		imgui.Checkbox(u8'Сообщения в чат',msgInChat)
	    		imgui.PushItemWidth(120)
		    		if connectedServer == 0 then imgui.InputText(u8'Сервер(не менять!)',Server) end
		    		imgui.Text('#') imgui.SameLine(15) imgui.InputText(u8'Канал',Channel)
		    		if #Channel.v < 1 then
		    			local letters = {"a","b","c","d","e","f","g","h","i","j","k","l","m","n","o","p","q","r","s","t","u","v","w","y","z"}
		    			local numbers = {1,2,3,4,5,6,7,8,9,0,10,11,12,12,13,14,15,16,17,18,19}
		    			lua_thread.create(function()
		    			for i = 1,4 do
			    			math.randomseed(os.time()-1)
			    			rand1 = math.random(i, #letters)
			    			math.randomseed(os.time()-1)
			    			rand2 = math.random(i, #numbers)
				    		Channel.v = Channel.v .. letters[rand1]
			    		wait(100)
				    		Channel.v = Channel.v .. numbers[rand2]
			    		wait(100)
				    	end
					    end)
		    		else
		    			imgui.SameLine() if imgui.SmallButton('copy') then setClipboardText(Channel.v) end
 				    end
		    		--imgui.InputText('Nick',Nick)
		    	imgui.PopItemWidth(2)
		    	imgui.Text(u8'Твой ник - '..s.nick)
		    	if #Server.v > 0 and #Channel.v > 0 and #Nick > 0 then
		    		if imgui.Button(connected and 'Disconnect' or 'Connect') then
		    			if connectedServer == 0 then connectedServer = 1; end
						if connectedServer == 1 then
							s:connect(Server.v)
							connectedServer = 2
						end
			    		if not connected then
			    			s:join('#'..Channel.v)
			    			connected = true;

			    			math.randomseed(os.time()-1)
			    			Nick = 'player' .. math.random(0, 100)
			    			s:send("Nick %s", Nick)
			    		else
			    			Nick = 'PLAYER'
			    			s:part('bb')
			    			connected = false
			    		end
			    	end
		    	else
		    		imgui.TextColored(imgui.ImVec4(255/255,0,0,0.9),'error!')
		    	end
		    imgui.EndPopup()
		    end
	    end


	    if Game and s.nick ~= 'PLAYER' and xo_enemy_nick ~= 'nil'  then
--[[
A1_text,A2_text,A3_text
B1_text,B2_text,B3_text
C1_text,C2_text,C3_text
]]

 			if A1 == XO and A2 == XO and A3 == XO then gameOver(XO)
 			elseif A2 == XO and B2 == XO and C2 == XO then gameOver(XO)
 			elseif A1 == XO and B2 == XO and C3 == XO then gameOver(XO)
 			elseif A1 == XO and B1 == XO and C1 == XO then gameOver(XO)
 			elseif A1 == XO and B2 == XO and C3 == XO then gameOver(XO)
 			elseif A3 == XO and B2 == XO and C1 == XO then gameOver(XO)
			--
 			elseif B1 == XO and B2 == XO and B3 == XO then gameOver(XO)
 			--
 			elseif C1 == XO and C2 == XO and C3 == XO then gameOver(XO)
 			elseif A3 == XO and B3 == XO and C3 == XO then gameOver(XO)
 			--------------------------
 			elseif A1 == xo_enemy and A2 == xo_enemy and A3 == xo_enemy then gameOver(xo_enemy)
 			elseif A2 == xo_enemy and B2 == xo_enemy and C2 == xo_enemy then gameOver(xo_enemy)
 			elseif A1 == xo_enemy and B2 == xo_enemy and C3 == xo_enemy then gameOver(xo_enemy)
 			elseif A1 == xo_enemy and B1 == xo_enemy and C1 == xo_enemy then gameOver(xo_enemy)
 			elseif A1 == xo_enemy and B2 == xo_enemy and C3 == xo_enemy then gameOver(xo_enemy)
 			elseif A3 == xo_enemy and B2 == xo_enemy and C1 == xo_enemy then gameOver(xo_enemy)
			--
 			elseif B1 == xo_enemy and B2 == xo_enemy and B3 == xo_enemy then gameOver(xo_enemy)
 			--
 			elseif C1 == xo_enemy and C2 == xo_enemy and C3 == xo_enemy then gameOver(xo_enemy)
 			elseif A3 == xo_enemy and B3 == xo_enemy and C3 == xo_enemy then gameOver(xo_enemy)
 			end

		    if imgui.hitbox(A1,true,5,25,50,50) then
		    	A1 = XO
		    	-- send(('A1=%s.A2=%s.A3=%s.B1=%s.B2=%s.B3=%s.C1=%s.C2=%s.C3=%s.'):format(A1,A2,A3,B1,B2,B3,C1,C2,C3))
		    	sendXO()
		    end

		    if imgui.hitbox(A2,true,65,25,50,50) then
		    	A2 = XO
		    	sendXO()
		    end

		    if imgui.hitbox(A3,true,125,25,50,50) then
		    	A3 = XO
		    	sendXO()
		    end

		    -----------
		    if imgui.hitbox(B1,true,5,85,50,50) then
		    	B1 = XO
		    	sendXO()
		    end

		    if imgui.hitbox(B2,true,65,85,50,50) then
		    	B2 = XO
		    	sendXO()
		    end

		    if imgui.hitbox(B3,true,125,85,50,50) then
		    	B3 = XO
		    	sendXO()
		    end

		    -----------
		    if imgui.hitbox(C1,true,5,145,50,50) then
		    	C1 = XO
		    	sendXO()
		    end

		    if imgui.hitbox(C2,true,65,145,50,50) then
		    	C2 = XO
		    	sendXO()
		    end

		    if imgui.hitbox(C3,true,125,145,50,50) then
		    	C3 = XO
		    	sendXO()
		    end

		    imgui.SetNextWindowPos(imgui.ImVec2(XO_window_pos.x+185,XO_window_pos.y+60), 1)
		    imgui.SetNextWindowSize(imgui.ImVec2(200, 90), imgui.Cond.FirstUseEver)
	        imgui.Begin('##info', nil, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoMove)

	        if imgui.Button(u8'Остановить игру', imgui.ImVec2(-1,20)) then
	        	send('cancel game',false)

				Game = false
				Move = false

				A1,A2,A3	= 'nil','nil','nil'
				B1,B2,B3	= 'nil','nil','nil'
				C1,C2,C3	= 'nil','nil','nil'

				xo_enemy_nick = 'nil'
	        end
	        imgui.Text(u8'Ты - '..XO..'('.. Nick .. ')')
	        imgui.Text(u8'Враг - '..xo_enemy..'('.. xo_enemy_nick .. ')')

	        --imgui.Text(Move and 'you\'r('..Nick..') move!' or 'wait'..waitAnimText )
	        if Move then
	        	imgui.TextColored(imgui.ImVec4(27/255,196/255,67/255,1.0),'Move!')
        	else
        		imgui.TextColored(imgui.ImVec4(207/255,0,0,1.0),'wait'..waitAnimText)
        	end

	        if imgui.GetWindowPos().x ~= XO_window_pos.x  or imgui.GetWindowPos().y ~= XO_window_pos.y then
	        	imgui.SetWindowPos(imgui.ImVec2(XO_window_pos.x+185,XO_window_pos.y+70), 2)
	        end

	        imgui.End()
	    elseif Game and s.nick ~= 'PLAYER' and xo_enemy_nick == 'nil'  then

	    	imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(1,0,0,0.2))
			imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(1,0,0,0.2))
			imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(1,0,0,0.2))

	    	if imgui.Button(u8'Ник игрока равен - nil!\nwait'..waitAnimText..'\n(click for cancel)',imgui.ImVec2(185,165)) then
	        	--send('cancel game',false)

				Game = false
				Move = false

				A1,A2,A3	= 'nil','nil','nil'
				B1,B2,B3	= 'nil','nil','nil'
				C1,C2,C3	= 'nil','nil','nil'

				xo_enemy_nick = 'nil'
	    	end

	    	imgui.PopStyleColor(3)

		end
	    -----

	    imgui.End()

	end

    if Log.v then
			imgui.ShowCursor = true
			imgui.SetNextWindowPos(imgui.ImVec2(imgui.GetIO().DisplaySize.x / 2, imgui.GetIO().DisplaySize.y / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
			imgui.SetNextWindowSize(imgui.ImVec2(1000, 400), imgui.Cond.FirstUseEver)

			imgui.Begin(fa.ICON_FA_TOOLBOX..(u8(' Log')), Log, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)
        if imgui.CollapsingHeader(u8'Все обновления, начинающиеся от 2.0') then
			if imgui.CollapsingHeader('2.0') then
				imgui.Text(u8'Изменён стиль скрипта, убраны некоторые системы и пофикшены баги.')

			end
			if imgui.CollapsingHeader('2.1') then
				imgui.Text(u8'-- Убрана система "Гангстер"')
				imgui.Text(u8'-- Теперь на МП можно выдать приз - пак гангстера(/napak id) - 500 дигла + м4, скин и 900 хп')
				imgui.Text(u8'-- В панельке рекона >> Машина >> Добавлен поиск по названию')
        imgui.Text(u8'-- В каждой таблице(Наказаний, команд) добавлены кнопки "Закрыть" "Далее" "Назад"')
				imgui.Text(u8'-- Оптимизировали скрипт, убрали баги / краши')
			end
			if imgui.CollapsingHeader('2.5') then
				imgui.Text(u8'-- Техническая часть.')
				imgui.Text(u8'Убраны "Авто-ответчик", "Спец.клавиши"')
				imgui.Text(u8'Пофикшены баги, в /rh >> Настройки добавлены кнопки изменения координат(В РЕКОНЕ)')
        imgui.Text(u8'-- Развлекательная часть"')
				imgui.Text(u8'Добавлены 4 мини-игры.')
				imgui.Text(u8'-- Виселица --\n/rh >> Игры >> Виселица(ИГРАТЬ). Угадай загаданное путём нажатия на буквы как мышкой, так и на клавиатуре')
				imgui.Text(u8'-- Столицы --\n/rh >> Игры >> Столицы(ИГРАТЬ). Сможешь набрать больше 10 правильных ответов подряд? Угадывай столицы')
				imgui.Text(u8'-- Змейк --\n/rh >> Игры >> Змейка(ИГРАТЬ). Нажимаешь на E - змейка запускается. Побей рекорд: 350 яблок и получи подарок!')
				imgui.Text(u8'-- ПИНГ-ПОНГ--\n/rh >> Игры >> Ping-Pong(ИГРАТЬ). Нажимаешь на кнопку (start). Управление > W,A,S,D! Не пропускай мяч!')
				if imgui.CollapsingHeader(u8'Крестики-нолики') then
					imgui.Text(u8'---------------- КРЕСТИКИ НОЛИКИ ПО СЕТИ!')
					imgui.Text(u8'Чтобы начать игру с другом, введи команду /zerogame >> Настройки.')
					imgui.Text(u8'Поле "Сервер" - менять не надо. В поле "Канал" - введи любое название для твоего канала')
					imgui.Text(u8'Подключись к каналу нажав на кнопку >> (Connect)')
					imgui.Text(u8'------------------- ЕСЛИ ТЫ ХОЧЕШЬ ПОДКЛЮЧИТЬСЯ К КАНАЛУ!')
					imgui.Text(u8'Введи /zerogame >> Настройки >> Введи в поле "Канал" название канала как у друга, затем нажми (Connect)')
					imgui.Text(u8'ВАЖНО! ТОЛЬКО ОДИН ИГРОК ДОЛЖЕН НАЧИНАТЬ ИГРУ >> (START GAME)')

				end
			  end

			if imgui.CollapsingHeader('2.7') then
				imgui.Text(u8'-- Техническая часть.\nДобавлены новые команды:\n/car [ID машины] [Цвет №1] [Цвет №2] - создать машину в зелёной зоне\n/gun [ID оружия] [Патроны] - создать ган\n/acmd - команды скрипта')
				imgui.Text(u8'-- ToolsChat.\nДобавлен чат тулса. Теперь пользователи могут общаться друг с другом\nОсновные команды: /tcmd')



			end
        end
        if imgui.CollapsingHeader(u8'Все обновления, начинающиеся от 3.0') then
			if imgui.CollapsingHeader('3.0') then
				imgui.Text('')
				imgui.SameLine()
				if imgui.CollapsingHeader(u8'Измененный дизайн') then
					imgui.Text(u8'-- /rh - Главное меню\nТеперь меню отображается на верху Imgui-Окна.\nТеперь можно изменить стиль скрипта, нажав на "Выбрать стиль Imgui"\nТаблица наказаний перенесена на команду: /nakaz')
					imgui.Text(u8'-- /ot - Авто-Репорт\nНемного изменили позицию кнопок, добавлены новые цвета')
				end
				imgui.Text('')
				imgui.SameLine()
				if imgui.CollapsingHeader(u8'Push-Уведомления') then
					imgui.Text(u8'Push-Оповещения/Уведомления теперь уберут лишний спам в чате.\nПри первом запуске обновления - Push-Уведомления не будут доступны. Они будут доступны только после перезапуска скрипта.')

				end
				imgui.Text('')
				imgui.SameLine()
				if imgui.CollapsingHeader(u8'Новые пункты в настройках') then
					imgui.Text(u8'-- /rh >> Настройки\n-- Автоматической ввод "Уважаемый игрок, " в /ot.\n Когда вам придёт репорт - в поле ввода ответа на этот репорт автоматически напишет "Уважаемый игрок, "')
					imgui.Text(u8'-- /rh >> Настройки\n-- Блокировать репорт при отсутвии жалоб\nЕсли жалоб нет, то вы не сможете открыть окно Авто-Репорта')

			end
			imgui.Text('')
			imgui.SameLine()
				if imgui.CollapsingHeader(u8'MPset') then
					imgui.Text(u8'-- /mpset\nБольше не нужно мучаться с началом мероприятий. Всё за вас сделает скрипт!\n/mpset >> Выбираете МП. Перед этим просмотрите пункт "Укажите время на ожидание игроков"')
				end


		end
		if imgui.CollapsingHeader('3.15') then
			imgui.Text(u8'-- Краши скрипта\nТеперь исправлены :)')
      imgui.Text(u8'-- Незначительные изменения в /mpset')
		end
		if imgui.CollapsingHeader('3.5') then
			if imgui.CollapsingHeader(u8'Новогодняя музыка') then
				imgui.Text(u8'-- Чтобы включить музыку >> /nw >> Новогодняя музыка')

			end
			if imgui.CollapsingHeader(u8'Новогодние аксессуары') then
				imgui.Text(u8'-- Чтобы надеть аксессуар >> /nw >> Новогодние аксессуары\nНо, не все так просто! Чтобы открыть данный раздел, вам придётся пройти новогодний квест.')

			end
			if imgui.CollapsingHeader(u8'Новогодний квест') then
				imgui.Text(u8'-- Чтобы начать прохождение квеста >> /rh >> Event#2023 >> Начать\nВсего 5 этапов.\n1 этап -- Нужно узнать у доставщика пиццы, где он последний раз видел Деда Мороза\n2 этап -- Нужно вернуть все украденные коробки Доставщику Пиццы\n3 этап -- Встреча с Дедом Морозом, отвезти подарки на почту\n4 этап -- Починить посох деда мороза\n5 этап - вернуть посох Деду Морозу\nУдачного прохождения!')

			end
		end
		if imgui.CollapsingHeader('3.7') then
			imgui.Text(u8'-- Работа доставщика помидоров\nДля начала работы зайдите в /rh >> Event#2023 >> Начать работу.\nСобери помидоры с поля, отнеси их в ангар, а затем отвези их на машине на базу.\nЗа работу вы получите 1050 VT-money')
			imgui.Text(u8'-- VT-money\nНовая валюта ViceTools-пользователей.\nТеперь вы можете зарабатывать деньги с игры.\nVT-money можно конвертировать в настоящие рубли.\nКошелёк: /vtwallet')
			imgui.Text(u8'-- Бан скрипта\nТеперь, в нашем скрипте присутствует система бана.\nЕсли вы были замечены в каких-либо махинациях - вы получаете ')
 

		end
    end
    if imgui.CollapsingHeader(u8'Все обновления, начинающиеся от 4.0') then
        if imgui.CollapsingHeader('4.0') then
            if imgui.CollapsingHeader(u8'Обновленное меню /rh') then
              imgui.Text(u8' -- Добавлены два раздела\nЛог отключений/подключений, Команды\nРаздел "ФД меню" теперь открывается с 13 уровня')
              imgui.Text(u8' -- Разделы\nРазделы теперь отображаются слева, т.к это удобнее.')
            
        
            end
            if imgui.CollapsingHeader(u8'Лог отключений/подключений') then
              imgui.Text(u8' -- Лог\nВ разделе логов теперь вы можете спокойно увидеть - кто отключился и кто подключился.\nДобавлены две функции для работы с логами\nСкопировать и Очистить')
            
            end
            if imgui.CollapsingHeader(u8'Измененный информер') then
                imgui.Text(u8'Добавлен LVL администратора\nНемного изменили дизайн')



            end
            if imgui.CollapsingHeader(u8'Key Syncer') then
                imgui.Text(u8' -- Клавиши\nТеперь можно легко вычислить как спидхакера, так и игрока с авто +С.\nВ реконе отображается нажатие клавиш игроком.')

            end
            if imgui.CollapsingHeader(u8'Раздел команды') then
              imgui.Text(u8'Все команды скрипта собраны в одном месте >> /rh >> Команды')

            end

        


        end
        if imgui.CollapsingHeader(u8'4.2') then
            imgui.Text('')
            imgui.SameLine()
            if imgui.CollapsingHeader(u8'Recon') then
                imgui.Text(u8' -- Раздел находится в /rh >> Recon')

            end
            imgui.Text('')
            imgui.SameLine()
            if imgui.CollapsingHeader(u8'Логи') then
               imgui.Text(u8' -- В разделе логов(/rh >> Лог) для администраторов ниже 13 лвла доступны определенный вид логов.\nДля 13+ лвлов логи уже соответствующие.')
            end
            imgui.Text('')
            imgui.SameLine()
            if imgui.CollapsingHeader(u8'Мониторинг') then
                imgui.Text(u8' -- Раздел Мониторинг(/rh >> Мониторинг)\nМожно как включить, так и выключить. Изменить позицию тоже можно\nОптимальный КД для прогрузки мониторинга: 60 секунд')


            end
            imgui.Text('')
            imgui.SameLine()
            if imgui.CollapsingHeader(u8'Работа с логами') then
                imgui.Text(u8'Для работы с логами добавлены кнопки.\nОчистить, сохранить, вывести, копировать и тд.\nВ поле "Поиск по логам" можно найти лог определенного типа')

            end
            imgui.Text('')
            imgui.SameLine()
            if imgui.CollapsingHeader(u8'Универсальный админ-чат') then
               imgui.Text(u8' -- Установить команду можно в /rh >> Команды\nНастраивайте, используйте смайлы и тд. Всё для комфотного общения.')
            end
            
            
        end
    end

			imgui.End()


		end

    if elements.checkbox.statistics.v then
       
        if not elements.putStatis.showId.v and not
        elements.putStatis.showPing.v and not
        elements.putStatis.showHealth.v and not
        elements.putStatis.showLVL.v and not
        elements.putStatis.showFormDay.v and not
        elements.putStatis.showFormSession.v and not
				elements.putStatis.showInvis.v and not
				elements.putStatis.showGM.v and not
        elements.putStatis.showReportDay.v and not
        elements.putStatis.showReportSession.v and not
        elements.putStatis.showOnlineSession.v and not
        elements.putStatis.showOnlineDay.v and not
        elements.putStatis.showAfkSession.v and not
        elements.putStatis.showAfkDay.v and not
        elements.putStatis.showTime.v and not
        elements.putStatis.showTopDate.v and not
        elements.putStatis.showInterior.v then
            allNotTrueBool = true
        else
            allNotTrueBool = false
        end
        if elements.putStatis.showTopDate.v and elements.putStatis.showTime.v then
            pageState = true
        else
            pageState = false
        end
        imgui.SetNextWindowPos(imgui.ImVec2(HLcfg.config.posX, HLcfg.config.posY), imgui.Cond.FirsUseEver, imgui.ImVec2(0.5, 0.5))
				imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(0.11, 0.15, 0.17, 0.65))
				if elements.putStatis.nameStatis.v then
				imgui.Begin(fa.ICON_FA_LIST..(u8' ViceInformer'), nil, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.AlwaysAutoResize)
				else
						imgui.Begin(fa.ICON_FA_LIST..(u8' ViceInformer'), nil, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.AlwaysAutoResize + imgui.WindowFlags.NoTitleBar)
				end




				if not allNotTrueBool then --[[Если все выключено то]]
                    if elements.putStatis.showId.v then
                    if elements.putStatis.centerText.v then
                        imgui.centeredText(fa.ICON_FA_ID_CARD..u8(' '..getMyNick()..' | '..getMyId()..' id'))
                    else
                        imgui.Text(fa.ICON_FA_ID_CARD..u8(' '..getMyNick()..' | '..getMyId()))
                    end
                end
                if elements.putStatis.showLVL.v then
                    if elements.putStatis.centerText.v then
                        imgui.centeredText(fa.ICON_FA_USER_COG..u8' LVL администратора: '..Mlvl)
                        
                        imgui.Separator()
                    else
                        imgui.Text(fa.ICON_FA_USER_COG..u8' LVL администратора: '..Mlvl)
                        
                        imgui.Separator()
                    end
                end
                if elements.putStatis.showHealth.v then 
                    if elements.putStatis.centerText.v then 
                        imgui.centeredText(fa.ICON_FA_HEART..u8' Health: '..sampGetPlayerHealth(getMyId()))
                        
                        imgui.centeredText(fa.ICON_FA_SHIELD_ALT..u8' Armour: '..sampGetPlayerArmor(getMyId()))
                    else 
                        imgui.Text(fa.ICON_FA_HEART..u8' Health: '..sampGetPlayerHealth(getMyId())) 
                        imgui.SameLine() imgui.Text(' | ') imgui.SameLine()
                        imgui.Text(fa.ICON_FA_SHIELD_ALT..u8' Armour: '..sampGetPlayerArmor(getMyId()))
                    end 
                end
                if elements.putStatis.showInvis.v then 
                    if elements.putStatis.centerText.v then 
                        imgui.centeredText(fa.ICON_FA_MAGIC..u8' Invisibility: ' ..(ainvisible and u8' Вы невидимка!' or u8' Вы видны всем')) 
                    else 
                        imgui.Text(fa.ICON_FA_MAGIC..u8' Invisibility: ' ..(ainvisible and u8' Вы невидимка!' or u8' Вы видны всем'))  
                    end 
                end 
			if elements.putStatis.showGM.v then 
                if elements.putStatis.centerText.v then 
                    imgui.centeredText(fa.ICON_FA_USER_SHIELD..u8' GM: '..(statesgm and u8' Включен' or u8' Выключен'))   
                else
                    imgui.Text(fa.ICON_FA_USER_SHIELD..u8' GM: '..(statesgm and u8' Включен' or u8' Выключен'))   
                end 
            end

                
           
           
                if elements.putStatis.showPing.v then 
                    if elements.putStatis.centerText.v then 
                        imgui.centeredText(u8'Пинг: '..sampGetPlayerPing(getMyId())) 
                    else 
                        imgui.Text(u8"Пинг: "..sampGetPlayerPing(getMyId())) 
                    end 
                end

            
            if elements.putStatis.showFormDay.v then if elements.putStatis.centerText.v then imgui.centeredText(u8'Форм за день: '..HLcfg.config.dayForms) else imgui.Text(u8"Форм за день: "..HLcfg.config.dayForms) end end
            if elements.putStatis.showFormSession.v then if elements.putStatis.centerText.v then imgui.centeredText(u8'Форм за сеанс: '..LsessionForma) else imgui.Text(u8'Форм за сеанс: '..LsessionForma) end end
           
			if elements.putStatis.showReportDay.v then if elements.putStatis.centerText.v then imgui.centeredText(u8'Репортов за день: '..HLcfg.config.dayReports) else imgui.Text(u8'Репортов за день: '..HLcfg.config.dayReports) end end
            if elements.putStatis.showReportSession.v then if elements.putStatis.centerText.v then imgui.centeredText(u8'Репортов за сеанс: '..LsessionReport) else imgui.Text(u8'Репортов за сеанс: '..LsessionReport) end end
            if elements.putStatis.showInterior.v then if elements.putStatis.centerText.v then imgui.centeredText(u8(getCharActiveInterior(playerPed) == 0 and 'Вы не в интерьере' or 'Интерьер: '..getCharActiveInterior(playerPed))) else imgui.Text(u8(getCharActiveInterior(playerPed) == 0 and 'Вы не в интерьере' or 'Интерьер: '..getCharActiveInterior(playerPed))) end end
            if elements.putStatis.showOnlineSession.v then if elements.putStatis.centerText.v then imgui.centeredText(u8'Онлайн за сеанс: '..get_clock(sessionOnline.v)) else imgui.Text(u8'Онлайн за сеанс: '..get_clock(sessionOnline.v)) end end
            if elements.putStatis.showOnlineDay.v then if elements.putStatis.centerText.v then imgui.centeredText(u8'Онлайн за день: '..get_clock(HLcfg.onDay.online)) else imgui.Text(u8'Онлайн за день: '..get_clock(HLcfg.onDay.online)) end end
            if elements.putStatis.showAfkSession.v then if elements.putStatis.centerText.v then imgui.centeredText(u8'АФК за сеанс: '..get_clock(sessionAfk.v)) else imgui.Text(u8'АФК за сеанс: '..get_clock(sessionAfk.v)) end end
            if elements.putStatis.showAfkDay.v then if elements.putStatis.centerText.v then imgui.centeredText(u8'АФК за день: '..get_clock(HLcfg.onDay.afk)) else imgui.Text(u8'АФК за день: '..get_clock(HLcfg.onDay.afk)) end end
            if not pageState then
                if elements.putStatis.showTime.v then if elements.putStatis.centerText.v then imgui.centeredText(u8(string.format(os.date("Время: %H:%M:%S", os.time())))) else imgui.Text(u8(string.format(os.date("Время: %H:%M:%S", os.time())))) end end
                if elements.putStatis.showTopDate.v then if elements.putStatis.centerText.v then imgui.centeredText(u8(string.format(os.date("Дата: %d.%m.%y")))) else imgui.Text(u8(string.format(os.date("Дата: %d.%m.%y")))) end end
            else
                if elements.putStatis.centerText.v then
                    imgui.centeredText(u8(os.date("%d.%m.%y | %H:%M:%S", os.time()))) else
                        imgui.Text(u8(os.date("%d.%m.%y | %H:%M:%S", os.time()))) end
            end
        else
            imgui.Text(u8"Ни одна функция не включена.")
        end
		imgui.End()
		imgui.PopStyleColor()
    end

    if tableOfNew.AutoReport.v then

        if elements.checkbox.areportclick.v then
            if isKeyJustPressed(VK_U) and is_key_check_available() then
                imgui.ShowCursor = not imgui.ShowCursor
            end
        else
            imgui.ShowCursor = true
        end
        imgui.SetNextWindowPos(imgui.ImVec2(imgui.GetIO().DisplaySize.x / 2, imgui.GetIO().DisplaySize.y / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(537, 450), imgui.Cond.FirstUseEver)
        imgui.Begin(u8'Жалоба/Вопрос', tableOfNew.AutoReport, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.AlwaysAutoResize)
				if #reports > 0 then
				imgui.Text(u8'Отправитель: '..(reports[1].nickname..'['..reports[1].id..']'))
				imgui.SameLine()
				imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 8)
				if imgui.Button(fa.ICON_FA_COPY, imgui.ImVec2(25, 25)) then


        setClipboardText(reports[1].nickname)


			  end
				imgui.SameLine()
				if imgui.Button(fa.ICON_FA_EYE, imgui.ImVec2(25, 25)) then

        sampSendChat('/re '..reports[1].id)
			  end
				imgui.PopStyleVar(1)
				if elements.checkbox.autouv.v then
				 if tableOfNew.answer_report.v == '' then
					tableOfNew.answer_report.v = u8('Уважаемый игрок, ')
				 end
				end




			  end
        imgui.BeginChild('##i_report', imgui.ImVec2(575, 40), true, imgui.WindowFlags.AlwaysAutoResize)
        if #reports > 0 then

            imgui.PushTextWrapPos(500)
            imgui.TextUnformatted(u8(reports[1].textP))
            imgui.PopTextWrapPos()


        end
        imgui.EndChild()

        imgui.PushItemWidth(540)

				imgui.NewInputText(u8'##answer_input_report', tableOfNew.answer_report, 575, "Введите свой ответ", 2)




				local clr = imgui.Col
				imgui.PushStyleColor(clr.Button, imgui.ImVec4(0,0,255,255))
				imgui.PushStyleColor(clr.ButtonHovered, imgui.ImVec4(0,0,255,255))
				imgui.PushStyleColor(clr.ButtonActive, imgui.ImVec4(0,0,255,255))
				imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 8)
				if imgui.Button(u8'Ответить', imgui.ImVec2(110, 0)) then
						if tableOfNew.answer_report.v == '' then
							if notify then
								 notify.addNotification('[Ошибка] Введите корректный ответ!', 3, 0, 1)
							else
								sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Введите корректный ответ.', stColor)
							end
						else
								if #reports > 0 then
										sampSendChat('/pm '..reports[1].id..' '..u8:decode(tableOfNew.answer_report.v))
										refresh_current_report()
										tableOfNew.answer_report.v = ''
								end
						end
				end imgui.PopStyleColor(3) imgui.PopStyleVar(1) imgui.SameLine()
				imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 8) -- 2 дефолт
--Кнопка

				if imgui.Button(u8'СП', imgui.ImVec2(110, 0)) then
						if #reports > 0 then
								lua_thread.create(function()



										sampSendChat('/pm '..reports[1].id..' Приятной игры на Vice City RP')
										wait(1000)
										sampSendChat('/spawn '..reports[1].id)
										refresh_current_report()



								end)
						end
				end imgui.PopStyleVar(1) imgui.SameLine()
				imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 8)
				if imgui.Button(u8'CleanReport', imgui.ImVec2(110, 0)) then
						reports = {
								[0] = {
										nickname = '',
										id = -1,
										textP = ''
								}
						}
				end imgui.PopStyleVar(1) imgui.SameLine()
				imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 8)
				if imgui.Button(u8'Выдать ХП', imgui.ImVec2(110, 0)) then
						if #reports > 0 then
								imgui.OpenPopup(u8'Выдача жизней')
						end
				end	 imgui.PopStyleVar(1) imgui.SameLine()
				local clr = imgui.Col
				imgui.PushStyleColor(clr.Button, imgui.ImVec4(0,0,255,255))
				imgui.PushStyleColor(clr.ButtonHovered, imgui.ImVec4(0,0,255,255))
				imgui.PushStyleColor(clr.ButtonActive, imgui.ImVec4(0,0,255,255))
				imgui.PushStyleVar(imgui.StyleVar.FrameRounding, 8)
				if imgui.Button(u8'Пропустить', imgui.ImVec2(110, 0)) then
					if #reports <= 0 then
						if notify then
							notify.addNotification('[Ошибка] Репортов нет!', 3, 0, 1)
						else
							sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Репортов нету!', stColor)
						end
					else
						refresh_current_report()

					end

				end
				imgui.PopStyleVar(1)
				imgui.PopStyleColor(3)
				imgui.Separator()
        if imgui.Button(u8'Работать по ID', imgui.ImVec2(110, 0)) then
            if #reports > 0 then
                if reports[1].textP:find('%d+') then
                    tableOfNew.AutoReport.v = false
                    imgui.ShowCursor = false
                    lua_thread.create(function()
                        local id = reports[1].textP:match('(%d+)')
                        sampSendChat('/pm '..reports[1].id..' Уважаемый игрок, начинаю работу по вашей жалобе!')
                        wait(1000)
                        sampSendChat('/re '..id)
                        refresh_current_report()
                    end)
                else
                    sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}В репорте отсутствует ИД.', stColor)
                end
            end
        end
        imgui.SameLine()
        if imgui.Button(u8'Помочь автору', imgui.ImVec2(110, 0)) then
            if #reports > 0 then
                lua_thread.create(function()
                    tableOfNew.AutoReport.v = false
                    imgui.ShowCursor = false
                    sampSendChat('/goto '..reports[1].id)
                    wait(1000)
                    sampSendChat('/pm '..reports[1].id..' Уважаемый игрок, сейчас попробую вам помочь!')
                    refresh_current_report()
                end)
            end
        end
        imgui.SameLine()
        if imgui.Button(u8'Следить', imgui.ImVec2(110, 0)) then
            if #reports > 0 then
                lua_thread.create(function()
                    tableOfNew.AutoReport.v = false
                    imgui.ShowCursor = false
                    sampSendChat('/re '..reports[1].id)
                    local pID = reports[1].id
                    wait(1000)
                    sampSendChat('/pm '..pID..' Уважаемый игрок, начинаю работу по вашей жалобе!')
                    refresh_current_report()
                end)
            end
        end
        imgui.SameLine()
        if imgui.Button(u8'Передать', imgui.ImVec2(110, 0)) then
            if #reports > 0 then
                lua_thread.create(function()
                    sampSendChat('/a << Жалоба от '..reports[1].nickname..'['..reports[1].id..'] >> : '..reports[1].textP, 80)
                    wait(1000)
                    sampSendChat('/pm '..reports[1].id..' Уважаемый игрок, передал вашу жалобу.')
										refresh_current_report()
                end)
            end
        end imgui.SameLine()

        imgui.SameLine()
        if imgui.Button(u8'ТП в AZ', imgui.ImVec2(110, 0)) then
            if #reports > 0 then
                lua_thread.create(function()
									sampSendChat('/tp')
									wait(200)
									sampSendDialogResponse(sampGetCurrentDialogId(), 1, 0, nil)
									sampCloseCurrentDialogWithButton(0)
									wait(1000)
									sampSendChat('/gethere '..reports[1].id)
									sampAddChatMessage('Вы телепортировали ' .. sampGetPlayerNickname(reports[1].id) .. ' в Админ-Зону', -1)
                                    refresh_current_report()
                end)
            end
        imgui.Separator()
        end
				if imgui.Button(u8'Выдать NRG', imgui.ImVec2(110, 0)) then
						if #reports > 0 then
								lua_thread.create(function()
									sampSendChat('/pm '..reports[1].id..' Уважаемый игрок, администратор летит к вам на НРГ!')
                                    
									local nrgid = reports[1].id
                                    refresh_current_report()
									tableOfNew.AutoReport.v = false
                                    wait(1000)
									sampSendChat('/tp')
									wait(200)
									sampSendDialogResponse(sampGetCurrentDialogId(), 1, 6, nil)
									sampCloseCurrentDialogWithButton(0)
									wait(1000)
									sampSendChat('/veh 522 0 0')
									wait(1000)
									sampSendChat('/goto '..nrgid)
									wait(1000)
									sampSendChat('/slap '..getMyId())
									wait(1000)
									sampSendChat('/tp')
									wait(200)
									sampSendDialogResponse(sampGetCurrentDialogId(), 1, 0, nil)
									sampCloseCurrentDialogWithButton(0)
                                 
								end)
						end
				end imgui.SameLine()
				if imgui.Button(u8'Приятной игры', imgui.ImVec2(110, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' • Отличной игры и настроения на Vice City <3 •')
                refresh_current_report()
            end
        end imgui.SameLine()
if imgui.Button(u8'Уточните', imgui.ImVec2(110, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' Уважаемый игрок, переформулируйте вашу жалобу так, чтобы была ясна ваша просьба/утверждение.')
                refresh_current_report()
            end
        end imgui.SameLine()
if imgui.Button(u8'Как спавниться', imgui.ImVec2(110, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /mm >> Личные настройки >> Спавн персонажа. Приятной игры <3')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'Лидерство', imgui.ImVec2(110, 0)) then
            if #reports > 0 then
               sampSendChat('/pm '..reports[1].id..' Подайте заявку на наш форум в раздел заявлений, либо /buylead')
               refresh_current_report()
            end
        end
        if imgui.Button(u8'Админка', imgui.ImVec2(110,0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' Подайте заявку на наш форум в раздел заявлений, либо /buyadm')
                refresh_current_report()
            end
        end


        
                
            
            
     

				imgui.Separator()

        if imgui.CollapsingHeader(u8'Наказания') then
        local clr = imgui.Col
        imgui.PushStyleColor(clr.Button, imgui.ImVec4(0.86, 0.09, 0.09, 0.65))
        imgui.PushStyleColor(clr.ButtonHovered, imgui.ImVec4(0.74, 0.04, 0.04, 0.65))
        imgui.PushStyleColor(clr.ButtonActive, imgui.ImVec4(0.96, 0.15, 0.15, 0.50))

        if imgui.Button(u8'Оффтоп', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                imgui.OpenPopup(u8'Оффтоп')
            end
        end
        imgui.SameLine()
        if imgui.Button(u8'Оск.Адм', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/rmute '..reports[1].id..' 30 Оскорбление администрации')
                refresh_current_report()
            end
        end
        imgui.SameLine()
        if imgui.Button(u8'Оск.Род', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/ban '..reports[1].id..' 3 osk rod')
                refresh_current_report()
            end
        end
        imgui.SameLine()
        if imgui.Button(u8'Капс', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/rmute '..reports[1].id..' 5 Капс')
                refresh_current_report()
            end
        end
        imgui.SameLine()
        if imgui.Button(u8'Обман Адм', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/rmute '..reports[1].id..' 20 Обман администрации')
                refresh_current_report()
            end
        end

        if imgui.Button(u8'Оск Проекта', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/ban '..reports[1].id..' 7 osk proekta')
								sampAddChatMessage('Чтобы забанить игрока по IP введите /ip', -1)
                checkip = true
								banipc = true
								refresh_current_report()



            end
        end imgui.SameLine()
        if imgui.Button(u8'Оск Игроков', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/rmute '..reports[1].id..' 20 Оскорбление игроков')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'Мат', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/rmute '..reports[1].id..' 10 Нецензурная лексика')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'Упом.Род', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/rmute '..reports[1].id..' 60 Упоминание родных')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'Слив', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/iban '..reports[1].id..' Слив')
                refresh_current_report()
            end
        end

        imgui.PopStyleColor(3)
			end
      if imgui.CollapsingHeader(u8'Важное') then

        if imgui.Button(u8'ЖБ на Ф.', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' Уважаемый игрок, вы можете оставить свою жалобу на нашем форуме.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'Очистка', imgui.ImVec2(100, 0)) then

                refresh_current_report()

        end imgui.SameLine()
       
        if imgui.Button(u8'Выпустить', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                lua_thread.create(function()
                    sampSendChat('/pm '..reports[1].id..' Уважаемый игрок, сейчас попробую вам помочь!')
                    wait(1000)
                    sampSendChat('/unjail '..reports[1].id)
                    refresh_current_report()
                end)
            end
        end imgui.SameLine()



        if imgui.Button(u8'Ожидайте', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' Уважаемый игрок, убедительная просьба проявить терпение.')
                refresh_current_report()
            end
        end imgui.SameLine()

        if imgui.Button(u8'Отказ', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' Уважаемый игрок, то, что вы просите - не может быть исполнено.')
                refresh_current_report()
            end
        end 
      

        if imgui.Button(u8'Да', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' Да.')
                refresh_current_report()
            end
        end  imgui.SameLine()
        if imgui.Button(u8'Нет', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' Нет.')
                refresh_current_report()
            end
        end

			end

				if imgui.CollapsingHeader(u8'Команды') then
        if imgui.Button(u8'/buybiz', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' Чтобы купить бизнес введите /buybiz около бизнеса')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/gps', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /gps.')
                refresh_current_report()
            end
        end imgui.SameLine()



        if imgui.Button(u8'/drecorder', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /drecorder.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/su', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /su [ID].')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/showudost', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /showudost.')
                refresh_current_report()
            end
        end


        if imgui.Button(u8'/clear', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /clear.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/call', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /call >> Вызвать таксиста')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/sms', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /sms [ID] [MESSAGE].')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/togphone', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' Чтобы выключить телефон введите - /togphone.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/business', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /business.')
                refresh_current_report()
            end
        end

        if imgui.Button(u8'/drag', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /drag [ID]')
                refresh_current_report()
            end
        end 
        imgui.SameLine()
        if imgui.Button(u8'/h', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /h.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/divorce', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' Для развода введите - /divorce.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/gov', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /gov.')
                refresh_current_report()
            end
        end

        if imgui.Button(u8'/recorder', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /recorder.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/find', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /find.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/mm', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /mm')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/unrent', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /unrent.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/selfie', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /selfie.')
                refresh_current_report()
            end
        end

        if imgui.Button(u8'/pgun', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /pgun.')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/sellhouse', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /sellhouse')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/sellcar', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /sellcar')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/buycar', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /buycar')
                refresh_current_report()
            end
        end imgui.SameLine()
        if imgui.Button(u8'/propose', imgui.ImVec2(100, 0)) then
            if #reports > 0 then
                sampSendChat('/pm '..reports[1].id..' /propose')
                refresh_current_report()
            end
        end
				if imgui.Button(u8'/fvig', imgui.ImVec2(100, 0)) then
						if #reports > 0 then
								sampSendChat('/pm '..reports[1].id..' /fvig.')
								refresh_current_report()
						end
				end imgui.SameLine()
				if imgui.Button(u8'/invite', imgui.ImVec2(100, 0)) then
						if #reports > 0 then
								sampSendChat('/pm '..reports[1].id..' /invite.')
								refresh_current_report()
						end
				end
			end


        if imgui.BeginPopupModal(u8"Оффтоп", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
            if imgui.Button(u8"Сделать предупреждение", imgui.ImVec2(175, 0)) then
                if #reports > 0 then
                    sampSendChat("/pm "..reports[1].id.." Уважаемый игрок, просьба не оффтопить и писать всё ясно и понятно")
                    refresh_current_report()
                    imgui.CloseCurrentPopup()
                end
            end
            if imgui.Button(u8"Наказать", imgui.ImVec2(175, 0)) then
                if #reports > 0 then
                    sampSendChat("/rmute "..reports[1].id.." 5 offtop")
                    refresh_current_report()
                    imgui.CloseCurrentPopup()
                end
            end
            if imgui.Button(u8'Закрыть', imgui.ImVec2(175, 0)) then
                imgui.CloseCurrentPopup()
            end
            imgui.EndPopup()
        end
        if imgui.BeginPopupModal(u8"Выдача жизней", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
            imgui.Text(u8'Выберите, сколько выдать ХП')
            imgui.PushItemWidth(175) imgui.SliderInt('##giveHpSlider', tableOfNew.givehp, 0, 100) imgui.PopItemWidth()
            if imgui.Button(u8'Выдать жизни', imgui.ImVec2(175, 0)) then
                if #reports > 0 then
                    lua_thread.create(function()
                        sampSendChat('/pm '..reports[1].id..' Уважаемый игрок, сейчас попробую вам помочь!')
                        wait(1000)
                        sampSendChat('/sethp '..reports[1].id..' '..tableOfNew.givehp.v)
                        refresh_current_report()
                        imgui.CloseCurrentPopup()
                    end)
                end
            end
            if imgui.Button(u8'Закрыть', imgui.ImVec2(175, 0)) then
                imgui.CloseCurrentPopup()
            end
            imgui.EndPopup()
        end
        imgui.End()


    end
    if sampIsPlayerConnected(rInfo.id) and rInfo.id ~= -1 and rInfo.state then
        local x, y = ToScreen(552, 230)
        local w, h = ToScreen(638, 330)
        if isKeyJustPressed(VK_RBUTTON) then
            imgui.ShowCursor = not imgui.ShowCursor
        end
        local m, a = ToScreen(200, 400)
        imgui.SetNextWindowPos(imgui.ImVec2(HLcfg.config.posX_D, HLcfg.config.posY_D), imgui.Cond.FirsUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(537, 90), imgui.Cond.FirstUseEver)
        imgui.Begin(u8"##DownPanel", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.AlwaysAutoResize)
        local bet = imgui.ImVec2(70, 0)
        if elements.checkbox.keysyncer.v then
    
        local playerId = tonumber(rInfo.id)
			if playerId ~= nil then
				local pedExist, ped = sampGetCharHandleBySampPlayerId(playerId)
				if pedExist then
					targetSync = ped
                end
            end
        keysync = true
        keywindow.v = true
        end
        

				if isKeyJustPressed(VK_SPACE) and not sampIsChatInputActive() and not isSampfuncsConsoleActive() and not sampIsDialogActive() and not isPauseMenuActive() and rInfo.state then
					sampSendChat('/re '..rInfo.id)
					printStringNow('UPDATE RECON', 5000)
				end
        imgui.SetCursorPos(imgui.ImVec2(83, 10))
				if imgui.Button(u8'ReconOFF', bet) then
             
                     
						sampSendChat('/re off')
                        
                        
                        
                        




				
        end imgui.SameLine()
        if imgui.Button(u8'SETHP', bet) then
            imgui.OpenPopup(u8"Выдача жизней")
        end imgui.SameLine()
        if imgui.Button(u8'FREEZE', bet) then
            sampSendChat('/freeze '..rInfo.id)
        end imgui.SameLine()
        if imgui.Button(u8'UNFREEZE', bet) then
            sampSendChat('/unfreeze '..rInfo.id)
        end imgui.SameLine()
				if imgui.Button(u8'AZ', bet) then
            lua_thread.create(function()
                AzId = rInfo.id
                sampSendChat('/re off')
                wait(1000)
                sampSendChat('/tp')
                wait(200)
                sampSendDialogResponse(sampGetCurrentDialogId(), 1, 0, nil)
                sampCloseCurrentDialogWithButton(0)
                wait(1000)
                sampSendChat('/gethere '..AzId)
            end)
        end
    

				if imgui.Button(u8'<< BACK', bet) then
            if rInfo.id == 0 then
                local onMaxId = sampGetMaxPlayerId(false)
                if not sampIsPlayerConnected(onMaxId) or sampGetPlayerScore(onMaxId) == 0 or sampGetPlayerColor(onMaxId) == 16510045 then
                    for i = sampGetMaxPlayerId(false), 0, -1 do
                        if sampIsPlayerConnected(i) and not sampIsPlayerNpc(i) and sampGetPlayerScore(i) > 0 and i ~= rInfo.id then
                            rInfo.id = i
                            sampSendChat('/re '..rInfo.id)
                            break
                        end
                    end
                else
                    sampSendChat('/re '..sampGetMaxPlayerId(false))
                end
            else
                for i = rInfo.id, 0, -1 do
					if sampIsPlayerConnected(i) and sampGetPlayerScore(i) ~= 0 and sampGetPlayerColor(i) ~= 16510045 and i ~= rInfo.id and not sampIsPlayerNpc(i) then
						sampSendChat('/re '..i)
						break
					end
				end
				  end
        end imgui.SameLine()


        if imgui.Button(u8'AGL', bet) then
          
                sampSendChat('/agl '..rInfo.id)
              
        end imgui.SameLine()
        if imgui.Button(u8'GETHERE', bet) then
            lua_thread.create(function()
                gethereId = rInfo.id
                sampSendChat('/re off')
                wait(1000)
                sampSendChat('/gethere '..gethereId)
            end)
        end imgui.SameLine()
        if imgui.Button(u8'OFFSTATS', bet) then
            local nick = sampGetPlayerNickname(rInfo.id)
            sampSendChat('/getoffstats '..nick)
        end imgui.SameLine()
       
        if imgui.Button(u8'VEH', bet) then
            imgui.OpenPopup(u8"Выдать машину")
        end imgui.SameLine()
        if imgui.Button(u8'GIVEGUN', bet) then
            imgui.OpenPopup(u8'Выберите оружие')
        end imgui.SameLine()
				if imgui.Button(u8'NEXT >>', bet) then
            if rInfo.id == sampGetMaxPlayerId(false) then
                if not sampIsPlayerConnected(0) or sampGetPlayerScore(0) == 0 or sampGetPlayerColor(0) == 16510045 then
                    for i = rInfo.id, sampGetMaxPlayerId(false) do
                        if sampIsPlayerConnected(i) and sampGetPlayerScore(i) > 0 and i ~= rInfo.id and not sampIsPlayerNpc(i) then
                            rInfo.id = i
                            sampSendChat('/re '..i)
                            break
                        end
                    end
                else
                    sampSendChat('/re 0')
                end
            else
                for i = rInfo.id, sampGetMaxPlayerId(false) do
                    if sampIsPlayerConnected(i) and sampGetPlayerScore(i) > 0 and i ~= rInfo.id and not sampIsPlayerNpc(i) then
                        rInfo.id = i
                        sampSendChat('/re '..i)
                        break
                    end
                end
            end
        end
        imgui.SetCursorPos(imgui.ImVec2(83, 61))
				if imgui.Button(u8'GETSTATS', bet) then
             sampSendChat('/getstats '..rInfo.id)
         end imgui.SameLine()
				 if imgui.Button(u8'GOTO', bet) then
					 local gotoid = rInfo.id
             lua_thread.create(function()
                 sampSendChat('/re off')
                 wait(1000)
                 sampSendChat('/goto '..gotoid)
             end)
         end imgui.SameLine()
         if imgui.Button(u8'SLAP', bet) then
            sampSendChat('/slap '..rInfo.id)
         end imgui.SameLine()
         if imgui.Button(u8'SPAWN', bet) then
            sampSendChat('/spawn '..rInfo.id)
         end imgui.SameLine()
         if imgui.Button(u8'CHECKGM', bet) then
            sampSendChat('/gm '..rInfo.id)
         end
         
        if imgui.BeginPopupModal(u8"Выдача жизней", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
            imgui.Text(u8'Выберите, сколько выдать ХП')
            imgui.PushItemWidth(175) imgui.SliderInt('##giveHpSlider', tableOfNew.givehp, 0, 100) imgui.PopItemWidth()
            if imgui.Button(u8'Выдать жизни', imgui.ImVec2(175, 0)) then
                sampSendChat('/sethp '..reports[1].id..' '..tableOfNew.givehp.v)
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Закрыть', imgui.ImVec2(175, 0)) then
                imgui.CloseCurrentPopup()
            end
            imgui.EndPopup()
        end
        if imgui.BeginPopupModal(u8"Выдать машину", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
            imgui.Text(u8"Выберите транспорт:")
            imgui.PushItemWidth(142)
            imgui.Combo("##createiscarrecon", tableOfNew.intComboCar, tCarsName)
            imgui.PopItemWidth()
            if imgui.Button(u8"Создать", imgui.ImVec2(175, 0)) then
                sampSendChat("/veh " .. tableOfNew.intComboCar.v + 400 .. " 1 1")
            end
            if imgui.Button(u8"Закрыть", imgui.ImVec2(175, 0)) then
                imgui.CloseCurrentPopup()
            end
						imgui.BeginChild('##createCar', imgui.ImVec2(463, 300), true)
						imgui.PushItemWidth(250)
						imgui.NewInputText(u8'##SearchBar', tableOfNew.findText, 444, "Поиск по списку", 2)
						imgui.PopItemWidth()
						imgui.Separator()
						for k,v in pairs(tCarsName) do
							if tableOfNew.findText.v ~= '' then
								if string.rlower(v):find(string.rlower(u8:decode(tableOfNew.findText.v))) then
									if imgui.Button(u8(v)) then
										sampSendChat('/veh '.. k + 400 - 1 ..' 1 1')
									end
								end
							end
			            end
						imgui.EndChild()
            imgui.EndPopup()
        end
        if imgui.BeginPopupModal(u8"Выберите оружие", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
            imgui.Text(u8'Введите кол-во патрон')
            imgui.InputText('##numbersAmmo', tableOfNew.inputAmmoBullets)
            imgui.Text(u8'Выберите оружие')
            imgui.Combo('##selecting', tableOfNew.selectGun, arrGuns)
            if imgui.Button(u8'Выдать', imgui.ImVec2(175, 0)) then
                if tableOfNew.inputAmmoBullets.v ~= '' then
                    sampSendChat('/givegun '..rInfo.id..' '..tonumber(tableOfNew.selectGun.v)..' '..tableOfNew.inputAmmoBullets.v)
                    imgui.CloseCurrentPopup()
                else
                    sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Введите кол-во патрон.', stColor)
                end
            end
            if imgui.Button(u8'Закрыть', imgui.ImVec2(175, 0)) then
                imgui.CloseCurrentPopup()
            end
            imgui.EndPopup()
        end
        imgui.End()
			  imgui.SetNextWindowPos(imgui.ImVec2(HLcfg.config.posX1, HLcfg.config.posY1), imgui.Cond.FirsUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(137, 162), imgui.Cond.FirstUseEver)
        imgui.Begin(u8"Наказания", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoResize + imgui.WindowFlags.AlwaysAutoResize)
        if imgui.Button(u8'KICK', imgui.ImVec2(120, 0)) then
            imgui.OpenPopup(u8'Выдать кик')
        end
        if imgui.Button(u8'JAIL', imgui.ImVec2(120, 0)) then
            imgui.OpenPopup(u8'Выдать джайл')
        end
        if imgui.Button(u8'WARN', imgui.ImVec2(120, 0)) then
            imgui.OpenPopup(u8'Выдать варн')
        end
        if imgui.Button(u8'MUTE', imgui.ImVec2(120, 0)) then
            imgui.OpenPopup(u8'Выдать мут')
        end
        if imgui.Button(u8'BAN', imgui.ImVec2(120, 0)) then
            imgui.OpenPopup(u8'Выдать бан')
        end
				if imgui.Button(u8'SLAP', imgui.ImVec2(120, 0)) then
            sampSendChat('/slap '..rInfo.id)
        end
        if imgui.BeginPopupModal(u8"Выдать кик", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
            bsize = imgui.ImVec2(130, 0)
            if imgui.Button(u8'Своя причина', bsize) then
                sampSetChatInputEnabled(true)
                sampSetChatInputText('/kick '..rInfo.id..' ')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'AFK w/o esc', bsize) then
                sampSendChat('/kick '..rInfo.id..' АФК без ESC')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Помеха', bsize) then
                sampSendChat('/kick '..rInfo.id..' Помеха')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Закрыть', bsize) then
                imgui.CloseCurrentPopup()
            end
            imgui.EndPopup()
        end
        if imgui.BeginPopupModal(u8"Выдать джайл", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
            bsize = imgui.ImVec2(125, 0)
            if imgui.Button(u8'Своя причина', bsize) then
                sampSetChatInputEnabled(true)
                sampSetChatInputText('/jail '..rInfo.id..' ')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'ДМ', bsize) then
                sampSendChat('/jail '..rInfo.id..' 10 ДМ')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'БагоЮз', bsize) then
                sampSendChat('/jail '..rInfo.id..' 15 БагоЮз')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'ДБ', bsize) then
                sampSendChat('/jail '..rInfo.id..' 10 ДБ')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'ДМ ЗЗ', bsize) then
                sampSendChat('/jail '..rInfo.id..' 10 ДМ ЗЗ')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'ПГ', bsize) then
                sampSendChat('/jail '..rInfo.id..' 10 ПГ')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'СК', bsize) then
                sampSendChat('/jail '..rInfo.id..' 15 СК')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'ТК', bsize) then
                sampSendChat('/jail '..rInfo.id..' 10 ТК')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Чит', bsize) then
                sampSendChat('/jail '..rInfo.id..' 30 Чит')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Коп Гетто', bsize) then
                sampSendChat('/jail '..rInfo.id..' 10 Коп в Гетто')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'НРП Коп', bsize) then
                lua_thread.create(function()
                    sampSendChat('/jail '..rInfo.id..' 10 НонРП коп')
                    wait(1000)
                    sampSendChat('/uval '..rInfo.id..' НонРП коп')
                    imgui.CloseCurrentPopup()
                end)
            end
            if imgui.Button(u8'НРП', bsize) then
                sampSendChat('/jail '..rInfo.id..' 15 НонРП')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'JetPack', bsize) then
                sampSendChat('/jail '..rInfo.id..' 30 JetPack')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Закрыть', bsize) then
                imgui.CloseCurrentPopup()
            end
            imgui.EndPopup()
        end
        if imgui.BeginPopupModal(u8"Выдать мут", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
            bsize = imgui.ImVec2(150, 0)
            if imgui.Button(u8'Своя причина', bsize) then
                sampSetChatInputEnabled(true)
                sampSetChatInputText('/mute '..rInfo.id..' ')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'МГ', bsize) then
                sampSendChat('/mute '..rInfo.id..' 5 MG')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Капс', bsize) then
                sampSendChat('/mute '..rInfo.id..' 5 caps')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Флуд', bsize) then
                sampSendChat('/mute '..rInfo.id..' 5 flood')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Оск.Игроков', bsize) then
                sampSendChat('/mute '..rInfo.id..' 20 osk players')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Оск. Адм', bsize) then
                sampSendChat('/mute '..rInfo.id..' 30 osk adm')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Упом Род', bsize) then
                sampSendChat('/mute '..rInfo.id..' 60 upom rod')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Клевета Адм', bsize) then
                sampSendChat('/mute '..rInfo.id..' 30 kleveta adm')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Транслит', bsize) then
                sampSendChat('/mute '..rInfo.id..' 5 translit')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Закрыть', bsize) then
                imgui.CloseCurrentPopup()
            end
            imgui.EndPopup()
        end
        if imgui.BeginPopupModal(u8"Выдать варн", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
            bsize = imgui.ImVec2(175, 0)
            if imgui.Button(u8'Своя причина', bsize) then
                sampSetChatInputEnabled(true)
                sampSetChatInputText('/warn '..rInfo.id..' ')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Отказ от проверки', bsize) then
                sampSendChat('/warn '..rInfo.id..' Отказ от проверки')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Читы при проверке', bsize) then
                sampSendChat('/warn '..rInfo.id..' Читы при проверке')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Неадекват при проверке', bsize) then
                sampSendChat('/warn '..rInfo.id..' Неадекват при проверке')
            end
            if imgui.Button(u8'Военная техника ЛС', bsize) then
                sampSendChat('/warn '..rInfo.id..' военная техника в ЛС')
            end
           
            if imgui.Button(u8'Закрыть', bsize) then
                imgui.CloseCurrentPopup()
            end
            imgui.EndPopup()
        end
        if imgui.BeginPopupModal(u8"Выдать бан", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove) then
            bsize = imgui.ImVec2(125, 0)
            if imgui.Button(u8'Своя причина', bsize) then
                sampSetChatInputEnabled(true)
                sampSetChatInputText('/ban '..rInfo.id..' ')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Вред.Читы', bsize) then
                sampSendChat('/ban '..rInfo.id..' 7 vred cheat')
                msg('Не забудьте забанить игрока по айпи.')
                imgui.CloseCurrentPopup()
            end
            if imgui.Button(u8'Оск.Проекта', bsize) then
                sampSendChat('/ban '..rInfo.id..' 7 osk proekta')
                msg('Не забудьте забанить по айпи')
                imgui.CloseCurrentPopup()
            end
           if imgui.Button(u8'Закрыть', bsize) then
                imgui.CloseCurrentPopup()
            end
            imgui.EndPopup()
        end
        imgui.End()
        imgui.SetNextWindowPos(imgui.ImVec2(HLcfg.config.posX_Inf, HLcfg.config.posY_Inf), imgui.Cond.FirsUseEver)
        if elements.int.informer.v == 1 then
        imgui.SetNextWindowSize(imgui.ImVec2(170, 250))

        elseif elements.int.informer.v == 2 then
            imgui.SetNextWindowSize(imgui.ImVec2(510, 130))
           
        end
        if elements.checkbox.informerFon.v then
            local r, g, b, a = imgui.ImColor(imgui.GetStyle().Colors[imgui.Col.WindowBg]):GetFloat4()
            imgui.PushStyleColor(imgui.Col.WindowBg, imgui.ImVec4(r, g, b, elements.int.infFon.v / 100))
        end
        if not elements.checkbox.reconTitleBar.v then
        imgui.Begin(u8"Информация##reconInfo", _, imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoBringToFrontOnFocus + imgui.WindowFlags.NoScrollWithMouse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoSavedSettings)
        else
            imgui.Begin(u8"Информация##reconInfo", _,imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoBringToFrontOnFocus + imgui.WindowFlags.NoScrollWithMouse + imgui.WindowFlags.NoScrollbar + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoSavedSettings)
        end
        
        local isPed, pPed = sampGetCharHandleBySampPlayerId(rInfo.id)
        local score, ping = sampGetPlayerScore(rInfo.id), sampGetPlayerPing(rInfo.id)
        local health, armor, ammo, orgActive = sampGetPlayerHealth(rInfo.id), sampGetPlayerArmor(rInfo.id), getAmmoRecon(), getActiveOrganization(rInfo.id)
        if ammo == 0 then
            ammo = u8'Нет'
        else
            ammo = getAmmoRecon()
        end
        if armor == 0 then
            armor = u8'Нет'
        else
            armor = sampGetPlayerArmor(rInfo.id)
        end
        rInfo.nickname = getNick(rInfo.id)
        if isPed and doesCharExist(pPed) then
            
            local speed, model, interior = getCharSpeed(pPed), getCharModel(pPed), getCharActiveInterior(playerPed)
            if elements.int.informer.v == 1 then
            imgui.centeredText(u8(getNick(rInfo.id)..'['..rInfo.id..']'))
           
            imgui.Columns(2, '###dfdgdfgdfgdfgdfgdfg', true)

            imgui.Text(u8'Жизни')
            imgui.NextColumn()
            imgui.Text(u8' '..health)
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8'Броня')
            imgui.NextColumn()
            imgui.Text(u8' '..armor)
            imgui.NextColumn()
            imgui.Separator()
        
            imgui.Text(u8'Уровень')
            imgui.NextColumn()
            imgui.Text(u8' '..score)
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8'Пинг')
            imgui.NextColumn()
            imgui.Text(u8' '..ping)
            imgui.NextColumn()
            imgui.Separator()

            if isCharInAnyCar(pPed) then
                imgui.Text(u8('Скорость'))
                imgui.NextColumn()
                imgui.Text(u8' В машине')
                imgui.NextColumn()
            else
                imgui.Text(u8('Скорость'))
                imgui.NextColumn()
                imgui.Text(u8' '..math.floor(speed))
                imgui.NextColumn()
            end
            imgui.Separator()
            
            imgui.Text(u8'Скин')
            imgui.NextColumn()
            imgui.Text(u8' '..model)
            imgui.NextColumn()
            imgui.Separator()

            if orgActive ~= nil then
                imgui.Text(u8'Организация')
                imgui.NextColumn()
                imgui.Text(u8' '..orgActive)
                imgui.NextColumn()
            elseif orgActive == nil then
                imgui.Text(u8'Организация')
                imgui.NextColumn()
                imgui.Text(u8' Нет')
                imgui.NextColumn()
            end
            imgui.Separator()
            
            imgui.Text(u8"Интерьер")
            imgui.NextColumn()
            imgui.Text(u8' '..interior)
            imgui.NextColumn()
            imgui.Separator()
            imgui.Text(u8"Патроны")
            imgui.NextColumn()
            imgui.Text(u8' '..ammo)
            imgui.Columns(1)
        elseif elements.int.informer.v == 2 then
            imgui.centeredText(u8(getNick(rInfo.id)..'['..rInfo.id..']'))
            imgui.Separator()
            
            
            imgui.Columns(6, '####informer1', true)
            imgui.Text(u8'Жизни')
            imgui.NextColumn()
            imgui.Text(u8' '..health..' HP')
            imgui.NextColumn()
            imgui.Text(u8'Броня')
            imgui.NextColumn()
            imgui.Text(u8' '..armor)
            imgui.NextColumn()
            imgui.Text(u8'Уровень')
            imgui.NextColumn()
            imgui.Text(u8' '..score)
            imgui.Columns(1)
            imgui.Separator()
            
            
            imgui.Columns(6, "###informer2", true)
            imgui.Text(u8'Пинг')
            imgui.NextColumn()
            imgui.Text(u8' '..ping)
            imgui.NextColumn()
            if isCharInAnyCar(pPed) then
                imgui.Text(u8('Скорость'))
                imgui.NextColumn()
                imgui.Text(u8' В машине')
                imgui.NextColumn()
            else
                imgui.Text(u8('Скорость'))
                imgui.NextColumn()
                imgui.Text(u8' '..math.floor(speed))
                imgui.NextColumn()
            end
            imgui.Text(u8'Скин')
            imgui.NextColumn()
            imgui.Text(u8' '..model)
            imgui.Columns(1)
            imgui.Separator()
            
            
            
            imgui.Columns(6, '###informer3', true)
            if orgActive ~= nil then
                imgui.Text(u8'Организация')
                imgui.NextColumn()
                imgui.Text(u8' '..orgActive)
                imgui.NextColumn()
            elseif orgActive == nil then
                imgui.Text(u8'Организация')
                imgui.NextColumn()
                imgui.Text(u8' Нет')
                imgui.NextColumn()
            end
            imgui.Text(u8"Интерьер:")
            imgui.NextColumn()
            imgui.Text(u8' '..interior)
            imgui.NextColumn()
           
            imgui.Text(u8"Патроны")
            imgui.NextColumn()
            imgui.Text(u8' '..ammo)
            imgui.Columns(1)
            imgui.Separator()
           
           




        end
            
         
            local y = y + 196
       
            
            if isCharInAnyCar(pPed) then
                local carHundle = storeCarCharIsInNoSave(pPed)
                local carSpeed = getCarSpeed(carHundle)
                local carModel = getCarModel(carHundle)
                local carHealth = getCarHealth(carHundle)
                local carEngine = isCarEngineOn(carHundle)
                if carEngine then
                    carEngine = u8'Включён'
                else
                    carEngine = u8'Выключен'
                end
                imgui.SetNextWindowPos(imgui.ImVec2(x, y), imgui.Cond.FirstUseEver, imgui.ImVec2(0.0, 0.0))
                imgui.SetNextWindowSize(imgui.ImVec2(w-x, 97), imgui.Cond.FirstUseEver)
                imgui.Begin(u8"##reconCarInfo", _, imgui.WindowFlags.NoCollapse + imgui.WindowFlags.NoResize + imgui.WindowFlags.NoMove + imgui.WindowFlags.NoBringToFrontOnFocus + imgui.WindowFlags.NoTitleBar + imgui.WindowFlags.NoSavedSettings)
                imgui.PushStyleVar(imgui.StyleVar.ItemSpacing, imgui.ImVec2(1.0, 2.5))
                imgui.Text(u8"Транспорт: "..tCarsName[carModel-399])
                imgui.Text(u8"Жизни: "..carHealth)
                imgui.Text(u8"Модель: "..carModel)
                imgui.Text(u8"Скорость: "..math.floor(carSpeed))
                imgui.Text(u8"Двигатель: "..carEngine)
                imgui.PopStyleVar()
                
               
                
             
				
                imgui.End()
                
            end
        else
          
            imgui.Text(u8"Вы следите за ботом\nПереключитесь на\nКорректный ИД игрока.")
            imgui.Text(u8'Переподключиться на:')
            if elements.int.informer.v == 2 then
            for _, pHandle in pairs(getAllChars()) do
                if doesCharExist(pHandle) and pHandle ~= PLAYER_PED then
                    local result, pId = sampGetPlayerIdByCharHandle(pHandle)
                    if result then
                        local pName = sampGetPlayerNickname(pId)
                        local ssc = sampGetPlayerScore(pId)
                        local hP = sampGetPlayerHealth(pId)
                        local pause = sampIsPlayerPaused(pId)
                  
                        if imgui.Button(u8(pName..'['..pId..']')) then
                            sampSendChat('/re '..pId)
                        end imgui.SameLine()
                    end
                end
            end
            elseif elements.int.informer.v == 1 then
                for _, pHandle in pairs(getAllChars()) do
                    if doesCharExist(pHandle) and pHandle ~= PLAYER_PED then
                        local result, pId = sampGetPlayerIdByCharHandle(pHandle)
                        if result then
                            local pName = sampGetPlayerNickname(pId)
                            local ssc = sampGetPlayerScore(pId)
                            local hP = sampGetPlayerHealth(pId)
                            local pause = sampIsPlayerPaused(pId)
                      
                            if imgui.Button(u8(pName..'['..pId..']')) then
                                sampSendChat('/re '..pId)
                            end 
                        end
                    end
                end
            end
           
            
            

            
            
            

           
            
            
           
            
            keysync = false
        
            
            

        
        end
        imgui.End()
        if elements.checkbox.informerFon.v then
            imgui.PopStyleColor(1)
        end
    end
    
   
end

function samp.onShowDialog(dialogId, style, title, button1, button2, text)
    if checkleaders then
       
        if text:find('(%{......%})(.*) . (.*) . (%w+_?%w+) . (%d+)') then
         
          
            local color, fraction, rang, nick, number = text:match('(%{......%})(.*) . (.*) . (%w+_?%w+) . (%d+)')
            
            leaderList[#leaderList + 1] = {Lcolor = color, Lfraction = fraction, Lrang = rang, Lnick = nick, Lnumber = number}
            
            return false
        else
        
            leaderList[#leaderList + 1] = {Lcolor = '{ffffff}', Lfraction = 'None', Lrang = 'None', Lnick = 'None', Lnumber = 'none'}
            return false
        end
    end

   
      

                
   
   
   
   
   
   
   
   


	


	if elements.checkbox.autoCome.v then
			if elements.input.adminPassword ~= '' then
		if dialogId == 2934 then
			sampSendDialogResponse(dialogId, 1, nil, elements.input.adminPassword.v)


			return false
		end
	end
end
if cdefine then
	if text:find('(.*)%[(%d+)%] | Жалоба: (.*)') then
	 local nick_d, id_d, rep_d = text:match('(.*)%[(%d+)%] | Жалоба: (.*)')
	 reports[#reports + 1] = {nickname = nick_d, id = id_d, textP = rep_d}
 end
 return false
end
end

function samp.onPlayerDeathNotification(killerId, killedId, reason)
	if elements.checkbox.showKillerId.v then
		local kill = ffi.cast('struct stKillInfo*', sampGetKillInfoPtr())
		local _, myid = sampGetPlayerIdByCharHandle(playerPed)

		local n_killer = ( sampIsPlayerConnected(killerId) or killerId == myid ) and sampGetPlayerNickname(killerId) or nil
		local n_killed = ( sampIsPlayerConnected(killedId) or killedId == myid ) and sampGetPlayerNickname(killedId) or nil
		lua_thread.create(function()
			wait(0)
			if n_killer then kill.killEntry[4].szKiller = ffi.new('char[25]', ( n_killer .. '[' .. killerId .. ']' ):sub(1, 24) ) end
			if n_killed then kill.killEntry[4].szVictim = ffi.new('char[25]', ( n_killed .. '[' .. killedId .. ']' ):sub(1, 24) ) end
		end)
	end
end

function imgui.HelpMarker(text)
    imgui.PushFont(fa_font)
	imgui.TextDisabled(fa.ICON_FA_QUESTION)
    imgui.PopFont()
	if imgui.IsItemHovered() then
		imgui.BeginTooltip()
		imgui.PushTextWrapPos(450)
		imgui.TextUnformatted(text)
		imgui.PopTextWrapPos()
		imgui.EndTooltip()
	end
end

function imgui.HelpButton(title, text)
	imgui.Button(u8(title))
	if imgui.IsItemHovered() then
		imgui.BeginTooltip()
		imgui.PushTextWrapPos(450)
		imgui.TextUnformatted(u8(text))
		imgui.PopTextWrapPos()
		imgui.EndTooltip()
	end
end

function getActiveOrganization(id)
	local color = sampGetPlayerColor(id)
	if color == 553648127 then
		organization = u8'Нет[0]'
	elseif color == 2854633982 then
		organization = u8'LSPD[1]'
	elseif color == 2855350577 then
		organization = u8'FBI[2]'
	elseif color == 2855512627 then
		organization = u8'Армия[3]'
	elseif color == 4289014314 then
		organization = u8'МЧС[4]'
	elseif color == 4292716289 then
		organization = u8'LCN[5]'
	elseif color == 2868838400 then
		organization = u8'Якудза[6]'
	elseif color == 4279324017 then
		organization = u8'Мэрия[7]'
	elseif color == 2854633982 then
		organization = u8'SFPD[10]'
	elseif color == 4279475180 then
		organization = u8'Инструкторы[11]'
	elseif color == 4287108071 then
		organization = u8'Баллас[12]'
	elseif color == 2866533892 then
		organization = u8'Вагос[13]'
	elseif color == 4290033079 then
		organization = u8'Мафия[14]'
	elseif color == 2852167424 then
		organization = u8'Грув[15]'
	elseif color == 2856354955 then
		organization = u8'Sa News[16]'
	elseif color == 3355573503 then
		organization = u8'Ацтеки[17]'
	elseif color == 2860761023 then
		organization = u8'Рифа[18]'
	elseif color == 2854633982 then
		organization = u8'LVPD[21]'
	elseif color == 4285563024 then
		organization = u8'Хитманы[22]'
	elseif color == 4294201344 then
		organization = u8'Стритрейсеры[23]'
	elseif color == 4281240407 then
		organization = u8'SWAT[24]'
	elseif color == 2859499664 then
		organization = u8'АП[25]'
	elseif color == 2868838400 then
		organization = u8'Казино[26]'
	elseif color == 2863280947 then
		organization = u8'ПБ Red[()]'
	elseif color == 4281576191 then
		organization = u8'ПБ Blue[()]'
	elseif color == 8025703 then
		organization = u8'В маске[()]'
	end
	return organization
end
function capitalize(str)
    return (str:gsub("^%l", string.upper))
end

function sampGetChatInputCursor()
    local chatInfoPtr = sampGetInputInfoPtr()
    local chatBoxInfo = getStructElement(chatInfoPtr, 0x8, 4)
	cursor_index = memory.getint8(chatBoxInfo + 0x119)
    tail_index = memory.getint8(chatBoxInfo + 0x11E)
	return cursor_index, tail_index
end
function nameTagOn()
	local pStSet = sampGetServerSettingsPtr();
	NTdist = mem.getfloat(pStSet + 39)
	NTwalls = mem.getint8(pStSet + 47)
	NTshow = mem.getint8(pStSet + 56)
	mem.setfloat(pStSet + 39, 1488.0)
	mem.setint8(pStSet + 47, 0)
	mem.setint8(pStSet + 56, 1)
	nameTag = true
end

function nameTagOff()
	local pStSet = sampGetServerSettingsPtr();
	mem.setfloat(pStSet + 39, NTdist)
	mem.setint8(pStSet + 47, NTwalls)
	mem.setint8(pStSet + 56, NTshow)
	nameTag = false
end
function save()
    inicfg.save(HLcfg, "AdminTools.ini")
end

function get_clock(time)
    local timezone_offset = 86400 - os.date('%H', 0) * 3600
    if tonumber(time) >= 86400 then onDay = true else onDay = false end
    return os.date((onDay and math.floor(time / 86400)..' ' or '')..'%H:%M:%S', time + timezone_offset)
end
function get_clock1(time)
    local timezone_offset = 86400 - os.date('%H', 0) * 3600
    if tonumber(time) >= 86400 then onDay = true else onDay = false end
    return os.date((onDay and math.floor(time / 86400)..' ' or '')..'%H', time + timezone_offset)
end

function samp.onShowMenu()
	if rInfo.id ~= -1 then
		return false
	end
end
function samp.onHideMenu()
	if rInfo.id ~= -1 then
		return false
	end
end

function getAmmoRecon()
	local result, recon_handle = sampGetCharHandleBySampPlayerId(rInfo.id)
	if result then
		local weapon = getCurrentCharWeapon(recon_handle)
		local struct = getCharPointer(recon_handle) + 0x5A0 + getWeapontypeSlot(weapon) * 0x1C
		return getStructElement(struct, 0x8, 4)
	end
end

function samp.onTogglePlayerSpectating(state)
	rInfo.state = state
	if not state then
		rInfo.id = -1
    end
end

function isSpawnerFor(number)
    local lasttime = os.time()
    local lasttimes = 0
    local time_out = number
    lua_thread.create(function()
        while lasttimes < time_out do
            local lasttimes = os.time() - lasttime
            wait(0)
            printStyledString("Cars will be spawned in >> "..time_out - lasttimes, 1000, 4)
            if lasttimes == time_out then
                break
            end
        end
    end)
end
function isTimesFor(number)
    local lasttime = os.time()
    local lasttimes = 0
    local time_out = number
    lua_thread.create(function()
        while lasttimes < time_out do
            local lasttimes = os.time() - lasttime
            wait(0)
            printStyledString(u8"/gomp will be closed in  >> "..time_out - lasttimes, 1000, 4)
            if lasttimes == time_out then
                break
            end
        end
    end)
end

function refresh_current_report()
	table.remove(reports, 1)
end


function samp.onShowTextDraw(id, data)
  
	if rInfo.id ~= -1 then
		lua_thread.create(function()
			while true do
				wait(0)
				if data.text:find('.*') then
                    
					sampTextdrawDelete(id)
                 
				end
			end
		end)
	end
end



function samp.onSendCommand(cmd)
 
    
    
    if cmd == HLcfg.config.Atoolscmd then
        AdminTools.v = not AdminTools.v

    end
    if cmd == HLcfg.config.Achatcmd then
        achat.v = not achat.v

    end
   
    if cmd == HLcfg.config.Aavtorepcmd then
        tableOfNew.AutoReport.v = not tableOfNew.AutoReport.v

    end
   
   
   

    
    if cmd:find('/re%s+(%d+)') then
        rID = cmd:match('/re%s+(%d+)')
    elseif cmd:find('/RE%s+(%d+)') then
        rID = cmd:match('/RE%s+(%d+)')
    end
 
    rGoto = cmd:match('/goto%s+(%d+)')
	if rID then
       
		if rID:len() > -1 and rID:len() < 4 then
            rInfo.id = tonumber(rID)
		else
			sampAddChatMessage('{FF0000}[Ошибка] {FF8C00}Укажите корректный ИД.', stColor)
		end
    end
    if rGoto or rID then
        enAirBrake = false
    end
   
end

function sampGetPlayerIdByNickname(nick)
    local _, myid = sampGetPlayerIdByCharHandle(playerPed)
    if tostring(nick) == sampGetPlayerNickname(myid) then return myid end
    for i = 0, 1000 do if sampIsPlayerConnected(i) and sampGetPlayerNickname(i) == tostring(nick) then return i end end
end

ChatBox = function(pagesize, blacklist)
    local obj = {
      pagesize = elements.int.limitPageSize.v,
          active = false,
          font = nil,
          messages = {},
          blacklist = blacklist,
          firstMessage = 0,
          currentMessage = 0,
    }

      function obj:initialize()
          if self.font == nil then
              self.font = renderCreateFont('Verdana', 8, FCR_BORDER + FCR_BOLD)
          end
      end

      function obj:free()
          if self.font ~= nil then
              renderReleaseFont(self.font)
              self.font = nil
          end
      end

      function obj:toggle(show)
          self:initialize()
          self.active = show
      end

    function obj:draw(x, y)
          local add_text_draw = function(text, color)
              renderFontDrawText(self.font, text, x, y, color)
              y = y + renderGetFontDrawHeight(self.font)
          end

          -- draw caption
      add_text_draw("Admin Chat", 0xFFE4D8CC)

          -- draw page indicator
          if #self.messages == 0 then return end
          local cur = self.currentMessage
          local to = cur + math.min(self.pagesize, #self.messages) - 1
          add_text_draw(string.format("%d/%d", to, #self.messages), 0xFFE4D8CC)

          -- draw messages
          x = x + 4
          for i = cur, to do
              local it = self.messages[i]
              add_text_draw(
                  string.format("{E4E4E4}[%s] (%.1fm) {%06X}%s{D4D4D4}({EEEEEE}%d{D4D4D4}): {%06X}%s",
                      it.time,
                      it.dist,
                      argb_to_rgb(it.playerColor),
                      it.nickname,
                      it.playerId,
                      argb_to_rgb(it.color),
                      it.text),
                  it.color)
          end
    end

      function obj:add_message(playerId, color, distance, text)
          -- ignore blacklisted messages
          if self:is_text_blacklisted(text) then return end

          -- process only streamed in players
          local dist = get_distance_to_player(playerId)
          if dist ~= nil then
              color = bgra_to_argb(color)
              if dist > distance then color = set_argb_alpha(color, 0xA0)
              else color = set_argb_alpha(color, 0xF0)
              end
              table.insert(self.messages, {
                  playerId = playerId,
                  nickname = sampGetPlayerNickname(playerId),
                  color = color,
                  playerColor = sampGetPlayerColor(playerId),
                  dist = dist,
                  distLimit = distance,
                  text = text,
                  time = os.date('%X')})

              -- limit message list
              if #self.messages > elements.int.maxPagesBubble.v then
                  self.messages[self.firstMessage] = nil
                  self.firstMessage = #self.messages - elements.int.maxPagesBubble.v
              else
                  self.firstMessage = 1
              end
              self:scroll(1)
          end
      end

      function obj:is_text_blacklisted(text)
          for _, t in pairs(self.blacklist) do
              if string.match(text, t) then
                  return true
              end
          end
          return false
      end

      function obj:scroll(n)
          self.currentMessage = self.currentMessage + n
          if self.currentMessage < self.firstMessage then
              self.currentMessage = self.firstMessage
          else
              local max = math.max(#self.messages, self.pagesize) + 1 - self.pagesize
              if self.currentMessage > max then
                  self.currentMessage = max
              end
          end
      end

    setmetatable(obj, {})
    return obj
end

function take_vehicle_back(vehicleId)
	sampSendExitVehicle(vehicleId)
	wait(0)
	sampForceOnfootSync()
	wait(0)
	sampSendEnterVehicle(vehicleId, false)
	wait(15)
	sampForceVehicleSync(vehicleId)
end

function samp.onVehicleSync(playerId, vehicleId, data)
    if elements.checkbox.antiEjectCar.v and is_player_stealing_my_vehicle(playerId, vehicleId) then
		if not warningMsgTick or gameClock() - warningMsgTick > 3 then
			warningMsgTick = gameClock()
		end
		lua_thread.create(take_vehicle_back, vehicleId)
		return false
    end
    infoCar.pcar.idLastCar = vehicleId
end

function samp.onPlayerEnterVehicle(playerId, vehicleId, passenger)
    if elements.checkbox.antiEjectCar.v and is_player_stealing_my_vehicle(playerId, vehicleId) then
		return false
    end
end

function is_player_stealing_my_vehicle(playerId, vehicleId)
	if isCharInAnyCar(playerPed) and sampIsPlayerConnected(playerId) then
		local _, myVehId = sampGetVehicleIdByCarHandle(storeCarCharIsInNoSave(playerPed))
		return myVehId == vehicleId
	end
	return false
end

function get_distance_to_player(playerId)
      if sampIsPlayerConnected(playerId) then
          local result, ped = sampGetCharHandleBySampPlayerId(playerId)
          if result and doesCharExist(ped) then
              local myX, myY, myZ = getCharCoordinates(playerPed)
              local playerX, playerY, playerZ = getCharCoordinates(ped)
              return getDistanceBetweenCoords3d(myX, myY, myZ, playerX, playerY, playerZ)
          end
      end
      return nil
end

function cleanStreamMemory()
	local huy = callFunction(0x53C500, 2, 2, true, true)
	local huy1 = callFunction(0x53C810, 1, 1, true)
	local huy2 = callFunction(0x40CF80, 0, 0)
	local huy3 = callFunction(0x4090A0, 0, 0)
	local huy4 = callFunction(0x5A18B0, 0, 0)
	local huy5 = callFunction(0x707770, 0, 0)

	local pX, pY, pZ = getCharCoordinates(PLAYER_PED)
	requestCollision(pX, pY)
	loadScene(pX, pY, pZ)
end

function is_key_check_available() 
    if not isSampfuncsLoaded() then
      return not isPauseMenuActive()
    end
    local result = not isSampfuncsConsoleActive() and not isPauseMenuActive()
    if isSampLoaded() and isSampAvailable() then
      result = result and not sampIsChatInputActive() and not sampIsDialogActive()
    end
    return result
end

function join_argb(a, r, g, b)
    local argb = b  -- b
    argb = bit.bor(argb, bit.lshift(g, 8))  -- g
    argb = bit.bor(argb, bit.lshift(r, 16)) -- r
    argb = bit.bor(argb, bit.lshift(a, 24)) -- a
    return argb
end

function imgui.NewInputText(lable, val, width, hint, hintpos)
    local hint = hint and hint or ''
    local hintpos = tonumber(hintpos) and tonumber(hintpos) or 1
    local cPos = imgui.GetCursorPos()
    imgui.PushItemWidth(width)
    local result = imgui.InputText(lable, val)
    if #val.v == 0 then
        local hintSize = imgui.CalcTextSize(hint)
        if hintpos == 2 then imgui.SameLine(cPos.x + (width - hintSize.x) / 2)
        elseif hintpos == 3 then imgui.SameLine(cPos.x + (width - hintSize.x - 5))
        else imgui.SameLine(cPos.x + 5) end
        imgui.TextColoredRGB(tostring('{000000}'..hint))
    end
    imgui.PopItemWidth()
    return result
end

function bgra_to_argb(bgra)
    local b, g, r, a = explode_argb(bgra)
    return join_argb(a, r, g, b)
end

function set_argb_alpha(color, alpha)
        local _, r, g, b = explode_argb(color)
          return join_argb(alpha, r, g, b)
end

function get_argb_alpha(color)
      local alpha = explode_argb(color)
      return alpha
end

function argb_to_rgb(argb)
      return bit.band(argb, 0xFFFFFF)
end

function onScriptTerminate(script)
    if script == thisScript() then
      if doesFileExist(directory) then
        os.remove(directory)
      end
      local f = io.open(directory, "w")
      if f then
        f:write(encodeJson(playersList))
        f:close()
      end
      if doesFileExist(fpath) then
        local f = io.open(fpath, 'w+')
        if f then
          f:write(encodeJson(defTable)):close()
        end
      end
    end
end

function samp.onPlayerChatBubble(playerId, color, distance, duration, message)
	if sampIsPlayerConnected(playerId) and bubbleBox then
		bubbleBox:add_message(playerId, color, distance, message)
	end
end

function luasave()
    luacfg.save(filename_settings, cfg)
end

function click_warp()
    lua_thread.create(function()
        while true do
        if cursorEnabled and not AdminTools.v and not changePosition and not rInfo.state and not tableOfNew.AutoReport.v then
          local mode = sampGetCursorMode()
          if mode == 0 then
            showCursorForClickWarp(cursorEnabled)
          end
          local sx, sy = getCursorPos()
          local sw, sh = getScreenResolution()
          if sx >= 0 and sy >= 0 and sx < sw and sy < sh then
            local posX, posY, posZ = convertScreenCoordsToWorld3D(sx, sy, 700.0)
            local camX, camY, camZ = getActiveCameraCoordinates()
         
            
                local result, colpoint = processLineOfSight(camX, camY, camZ, posX, posY, posZ, 
                true, true, true, true, false, false, false)
          
          
           

            if result and colpoint.entity ~= 0 then
              local normal = colpoint.normal
              local pos = Vector3D(colpoint.pos[1], colpoint.pos[2], colpoint.pos[3]) - (Vector3D(normal[1], normal[2], normal[3]) * 0.1)
              local zOffset = 300
              if normal[3] >= 0.5 then zOffset = 1 end
              
              local result, colpoint2 = processLineOfSight(pos.x, pos.y, pos.z + zOffset, pos.x, pos.y, pos.z - 0.3,
                true, true, true, true, false, false, false)
              if result then
                pos = Vector3D(colpoint2.pos[1], colpoint2.pos[2], colpoint2.pos[3] + 1)

                local curX, curY, curZ  = getCharCoordinates(playerPed)
                local dist              = getDistanceBetweenCoords3d(curX, curY, curZ, pos.x, pos.y, pos.z)
                local hoffs             = renderGetFontDrawHeight(font)

                sy = sy - 2
                sx = sx - 2
                renderFontDrawText(font, string.format("{FFFFFF}%0.2fm", dist), sx, sy - hoffs, 0xEEEEEEEE)

                local tpIntoCar = nil
                local gotp = nil
                local Handleid = nil
                local pedx, pedy, pedz = nil, nil, nil
                if elements.checkbox.clickWarpPeople.v then
                if colpoint.entityType == 3 then
                    local ped = getCharPointerHandle(colpoint.entity)
                    pedx, pedy, pedz = getCharCoordinates(ped)
         
                 
                    if doesCharExist(ped) and not isCharInAnyCar(playerPed) then
                     local result, id = sampGetPlayerIdByCharHandle(ped)
                     if id ~= getMyId() then
                     if result then
                     renderFontDrawText(font, "{FFFFFF}"..sampGetPlayerNickname(id)..'['..id..']\nPress ЛКМ to TP | ПКМ to Recon', sx, sy - hoffs * 3, -1)
                     Handleid = id
                     gotp = true
                     
                     end
                    end
                   end
                end
               end
              
                if colpoint.entityType == 2 then
                  local car = getVehiclePointerHandle(colpoint.entity)
                  if doesVehicleExist(car) and (not isCharInAnyCar(playerPed) or storeCarCharIsInNoSave(playerPed) ~= car) then
                    displayVehicleName(sx, sy - hoffs * 2, getNameOfVehicleModel(getCarModel(car)))
                    local color = 0xFFFFFFFF
                    if isKeyDown(VK_RBUTTON) then
                      tpIntoCar = car
                      color = 0xFFFFFFFF
                    end
                    renderFontDrawText(font, "{FFFFFF}Hold right mouse button to teleport into the car", sx, sy - hoffs * 3, color)
                  end
               


                end
                
             
               
            

                createPointMarker(pos.x, pos.y, pos.z)
                if gotp then
                    if isKeyDown(VK_LBUTTON) then
                        teleportPlayer(pedx + 5, pedy, pedz)
                        cursorEnabled = false
                     end
                        
                     if isKeyDown(VK_RBUTTON) then
                        sampSendChat('/re '..Handleid)
                        cursorEnabled = false
                        showCursorForClickWarp(cursorEnabled)
                       
                    
                     end
                     
                    end
                if isKeyDown(VK_LBUTTON) then
                  if tpIntoCar then
                    if not jumpIntoCar(tpIntoCar) then
                      teleportPlayer(pos.x, pos.y, pos.z)
                      local veh = storeCarCharIsInNoSave(playerPed)
                      local cordsVeh = {getCarCoordinates(veh)}
                      setCarCoordinates(veh, cordsVeh[1], cordsVeh[2], cordsVeh[3])
                      cursorEnabled = false
                    end
                  else
                    if isCharInAnyCar(playerPed) then
                      local norm = Vector3D(colpoint.normal[1], colpoint.normal[2], 0)
                      local norm2 = Vector3D(colpoint2.normal[1], colpoint2.normal[2], colpoint2.normal[3])
                      rotateCarAroundUpAxis(storeCarCharIsInNoSave(playerPed), norm2)
                      pos = pos - norm * 1.8
                      pos.z = pos.z - 1.1
                    end
                    teleportPlayer(pos.x, pos.y, pos.z)
                    cursorEnabled = false
                    
                  end
                  removePointMarker()


                  while isKeyDown(VK_LBUTTON) do wait(0) end
                  showCursorForClickWarp(cursorEnabled)


                end
              end
            end
          end
        end
        wait(0)
        removePointMarker()
        end
    end)
end

function cmd(cmd, func)
    return sampRegisterChatCommand(cmd, func)
end

function translite(text)
	for k, v in pairs(chars) do
		text = string.gsub(text, k, v)
	end
	return text
end


function aaid(text)
    if text ~= '' then
      if text:find('(%d+)%s+(.*)+%s+(%d+)') then
            local id, reason, raz = text:match('(%d+)%s+(.*)%s+(%d+)')
            msg(' '..id..' '..reason..' '..raz)
        end
    end
end
function imgui.CusTB(str_id, value)
    local ToU32 = imgui.ColorConvertFloat4ToU32
local ToVEC = imgui.ColorConvertU32ToFloat4
    local AI_TOGGLE = {}
    local function bringVec4To(from, to, start_time, duration)
        local timer = os.clock() - start_time
        if timer >= 0.00 and timer <= duration then
            local count = timer / (duration / 100)
            return imgui.ImVec4(
                from.x + (count * (to.x - from.x) / 100),
                from.y + (count * (to.y - from.y) / 100),
                from.z + (count * (to.z - from.z) / 100),
                from.w + (count * (to.w - from.w) / 100)
            ), true
        end
        return (timer > duration) and to or from, false
    end
    local function bringVec2To(from, to, start_time, duration)
        local timer = os.clock() - start_time
        if timer >= 0.00 and timer <= duration then
            local count = timer / (duration / 100)
            return imgui.ImVec2(
                from.x + (count * (to.x - from.x) / 100),
                from.y + (count * (to.y - from.y) / 100)
            ), true
        end
        return (timer > duration) and to or from, false
    end
   
    
	local duration = 0.3
	local p = imgui.GetCursorScreenPos()
    local DL = imgui.GetWindowDrawList()
	local size = imgui.ImVec2(40, 20)
    local title = str_id:gsub('##.*$', '')
    local ts = imgui.CalcTextSize(title)
    local cols = {
    	enable = imgui.GetStyle().Colors[imgui.Col.ButtonActive],
    	disable = imgui.GetStyle().Colors[imgui.Col.TextDisabled]	
    }
    local radius = 6
    local o = {
    	x = 4,
    	y = p.y + (size.y / 2)
    }
    local A = imgui.ImVec2(p.x + radius + o.x, o.y)
    local B = imgui.ImVec2(p.x + size.x - radius - o.x, o.y)

    if AI_TOGGLE[str_id] == nil then
        AI_TOGGLE[str_id] = {
        	clock = nil,
        	color = value and cols.enable or cols.disable,
        	pos = value and B or A
        }
    end
    local pool = AI_TOGGLE[str_id]
    
 
	    local pos = imgui.GetCursorPos()
	    if imgui.InvisibleButton(str_id, imgui.ImVec2(size.x, size.y)) then
	        value = not value
	        pool.clock = os.clock()
	    end
	    if #title > 0 then
		    local spc = imgui.GetStyle().ItemSpacing
		    imgui.SetCursorPos(imgui.ImVec2(pos.x + size.x + spc.x, pos.y + ((size.y - ts.y) / 2)))
	    	imgui.Text(title)
    	end


 	if pool.clock and os.clock() - pool.clock <= duration then
        pool.color = bringVec4To(
            imgui.ImVec4(pool.color),
            value and cols.enable or cols.disable,
            pool.clock,
            duration
        )

        pool.pos = bringVec2To(
        	imgui.ImVec2(pool.pos),
        	value and B or A,
        	pool.clock,
            duration
        )
    else
        pool.color = value and cols.enable or cols.disable
        pool.pos = value and B or A
    end

	DL:AddRect(p, imgui.ImVec2(p.x + size.x, p.y + size.y), ToU32(pool.color), 10, 15, 1)
	DL:AddCircleFilled(pool.pos, radius, ToU32(pool.color))

    if imgui.IsItemClicked() then
        value = not value
        pool.clock = os.clock()
        return true
    end


end
function imgui.RippleButton(text, size, duration, rounding, parent_color)
       
    local function CenterTextFor2Dims(text)
        local width = imgui.GetWindowWidth()
        local calc = imgui.CalcTextSize(text)
        local height = imgui.GetWindowHeight()
        imgui.SetCursorPosX( width / 2 - calc.x / 2 )
        imgui.SetCursorPosY(height / 2 - calc.y / 2)
        imgui.Text(text)
    end

    local function bringVec4To(from, to, start_time, duration)
        local timer = os.clock() - start_time
        if timer >= 0.00 and timer <= duration then
            local count = timer / (duration / 100)
            return imgui.ImVec4(
                from.x + (count * (to.x - from.x) / 100),
                from.y + (count * (to.y - from.y) / 100),
                from.z + (count * (to.z - from.z) / 100),
                from.w + (count * (to.w - from.w) / 100)
            ), true
        end
        return (timer > duration) and to or from, false
    end

    if UI_RIPPLEBUTTON == nil then
        UI_RIPPLEBUTTON = {}
    end
    if not UI_RIPPLEBUTTON[text] then
        UI_RIPPLEBUTTON[text] = {animation = nil, radius = 5, mouse_coor = nil, time = nil, color = nil}
    end
    local pool = UI_RIPPLEBUTTON[text]
    local radius
   
    if rounding == nil then
        rounding = 0
    end
    if parent_color == nil then
        parent_color = imgui.GetStyle().Colors[imgui.Col.WindowBg]
    end   
    if pool["color"] == nil then
        pool["color"] = imgui.ImVec4(parent_color.x, parent_color.y, parent_color.z, parent_color.w)
    end
    if size == nil then
        local text_size = imgui.CalcTextSize(text:match("(.+)##.+") or text)
        size = imgui.ImVec2(text_size.x + 20, text_size.y + 20)
    end
    if size.x > size.y then
        radius = size.x
        if duration == nil then duration = size.x / 64 end
    else
        radius = size.y
        if duration == nil then duration = size.y / 64 end
    end
    imgui.PushStyleColor(imgui.Col.ChildWindowBg, imgui.GetStyle().Colors[imgui.Col.Button])
    imgui.PushStyleVar(imgui.StyleVar.WindowPadding, imgui.ImVec2(0,0))
    imgui.PushStyleVar(imgui.StyleVar.ChildWindowRounding, rounding)
    imgui.BeginChild("##ripple effect" .. text, imgui.ImVec2(size.x, size.y), false, imgui.WindowFlags.NoScrollbar)
   
        local draw_list = imgui.GetWindowDrawList()
        if pool["animation"] and pool["radius"] <= radius * 2.8125 then
            draw_list:AddCircleFilled(pool["mouse_coor"], pool["radius"], imgui.GetColorU32(imgui.ImVec4(1, 1, 1, 0.6)), 64)
            pool["radius"] = pool["radius"] + (3 * duration)
            pool["time"] = os.clock()
        elseif pool["animation"] and pool["radius"] >= radius * 2.8125 then
            if bringVec4To(imgui.ImVec4(1, 1, 1, 0.6), imgui.ImVec4(1, 1, 1, 0), pool["time"], 1).w ~= 0 then                  
                draw_list:AddCircleFilled(pool["mouse_coor"], pool["radius"], imgui.GetColorU32(imgui.ImVec4(1, 1, 1, bringVec4To(imgui.ImVec4(1, 1, 1, 0.6), imgui.ImVec4(1, 1, 1, 0), pool["time"], 1).w)), 64)
            else
                pool["animation"] = false
            end
        elseif not pool["animation"] and pool["radius"] >= radius * 2.8125 then
            pool["animation"] = false
            pool["radius"] = 5
            pool["time"] = nil
        end
        if rounding ~= 0 then               
            draw_list:PathLineTo(imgui.ImVec2(imgui.GetCursorPos().x + imgui.GetWindowPos().x,
                imgui.GetCursorPos().y + imgui.GetWindowPos().y)
            )
            draw_list:PathLineTo(imgui.ImVec2(imgui.GetCursorPos().x + imgui.GetWindowPos().x,
                imgui.GetCursorPos().y + imgui.GetWindowPos().y + rounding)
            )
            draw_list:PathArcTo(imgui.ImVec2(imgui.GetCursorPos().x + imgui.GetWindowPos().x + rounding,
                imgui.GetCursorPos().y + imgui.GetWindowPos().y + rounding), rounding, -3, -1.5, 64
            )
           
            draw_list:PathFillConvex(imgui.GetColorU32(pool["color"]))
            draw_list:PathClear()
            draw_list:PathLineTo(imgui.ImVec2(imgui.GetCursorPos().x + imgui.GetWindowPos().x + size.x,
                imgui.GetCursorPos().y + imgui.GetWindowPos().y)
            )
            draw_list:PathLineTo(imgui.ImVec2(imgui.GetCursorPos().x + imgui.GetWindowPos().x + size.x - rounding,
                imgui.GetCursorPos().y + imgui.GetWindowPos().y)
            )
            draw_list:PathArcTo(imgui.ImVec2(imgui.GetCursorPos().x + imgui.GetWindowPos().x + size.x - rounding,
                imgui.GetCursorPos().y + imgui.GetWindowPos().y + rounding), rounding, -1.5, 0, 64
            )
            draw_list:PathFillConvex(imgui.GetColorU32(pool["color"]))
            draw_list:PathClear()
           
            draw_list:PathLineTo(imgui.ImVec2(imgui.GetCursorPos().x + imgui.GetWindowPos().x,
                imgui.GetCursorPos().y + imgui.GetWindowPos().y + size.y)
            )
            draw_list:PathLineTo(imgui.ImVec2(imgui.GetCursorPos().x + imgui.GetWindowPos().x,
                imgui.GetCursorPos().y + imgui.GetWindowPos().y + size.y - rounding)
            )
            draw_list:PathArcTo(imgui.ImVec2(imgui.GetCursorPos().x + imgui.GetWindowPos().x + rounding,
                imgui.GetCursorPos().y + imgui.GetWindowPos().y + size.y - rounding), rounding, 3, 1.5, 64
            )
            draw_list:PathFillConvex(imgui.GetColorU32(pool["color"]))
            draw_list:PathClear()
            draw_list:PathLineTo(imgui.ImVec2(imgui.GetCursorPos().x + imgui.GetWindowPos().x + size.x,
                imgui.GetCursorPos().y + imgui.GetWindowPos().y + size.y)
            )
            draw_list:PathLineTo(imgui.ImVec2(imgui.GetCursorPos().x + imgui.GetWindowPos().x + size.x,
                imgui.GetCursorPos().y + imgui.GetWindowPos().y + size.y - rounding)
            )
            draw_list:PathArcTo(imgui.ImVec2(imgui.GetCursorPos().x + imgui.GetWindowPos().x + size.x - rounding,
                imgui.GetCursorPos().y + imgui.GetWindowPos().y + size.y - rounding), rounding, 0, 1.5, 64
            )
            draw_list:PathFillConvex(imgui.GetColorU32(pool["color"]))
            draw_list:PathClear()
        end
        CenterTextFor2Dims(text:match("(.+)##.+") or text)
    imgui.EndChild()
    imgui.PopStyleColor()
    imgui.PopStyleVar(2)
   
   
    if imgui.IsItemClicked() then
            pool["animation"] = true
            pool["radius"] = 5
            pool["mouse_coor"] = imgui.GetMousePos()
            return true
    end
end           
function imgui.CloseButton(str_id, value, size, rounding)
    local ToU32 = imgui.ColorConvertFloat4ToU32
	size = size or 40
	rounding = rounding or 5
	local DL = imgui.GetWindowDrawList()
	local p = imgui.GetCursorScreenPos()
	
	local result = imgui.InvisibleButton(str_id, imgui.ImVec2(size, size))
	if result then
		value = false
	end
	local hovered = imgui.IsItemHovered()

	local col = ToU32(imgui.GetStyle().Colors[imgui.Col.Border])
	local col_bg = hovered and 0x50000000 or 0x30000000
	local offs = (size / 4)

	DL:AddRectFilled(p, imgui.ImVec2(p.x + size, p.y + size), col_bg, rounding, 15)
	DL:AddLine(
		imgui.ImVec2(p.x + offs, p.y + offs), 
		imgui.ImVec2(p.x + size - offs, p.y + size - offs), 
		col,
		size / 10
	)
	DL:AddLine(
		imgui.ImVec2(p.x + size - offs, p.y + offs), 
		imgui.ImVec2(p.x + offs, p.y + size - offs),
		col,
		size / 10
	)
	return result
end
function imgui.PageButton(bool, icon, name, but_wide)
    local AI_PAGE = {}
        but_wide = but_wide or 190
        local duration = 0.25
        local DL = imgui.GetWindowDrawList()
        local p1 = imgui.GetCursorScreenPos()
        local p2 = imgui.GetCursorPos()
        local col = imgui.GetStyle().Colors[imgui.Col.ButtonActive]
            
        if not AI_PAGE[name] then
            AI_PAGE[name] = { clock = nil }
        end
        local pool = AI_PAGE[name]
    
        imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
        imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
        imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.00, 0.00, 0.00, 0.00))
        local result = imgui.InvisibleButton(name, imgui.ImVec2(but_wide, 35))
        if result and not bool then 
            pool.clock = os.clock() 
        end
        local pressed = imgui.IsItemActive()
        imgui.PopStyleColor(3)
        if bool then
            if pool.clock and (os.clock() - pool.clock) < duration then
                local wide = (os.clock() - pool.clock) * (but_wide / duration)
                DL:AddRectFilled(imgui.ImVec2(p1.x, p1.y), imgui.ImVec2((p1.x + 190) - wide, p1.y + 35), 0x10FFFFFF, 15, 10)
                   DL:AddRectFilled(imgui.ImVec2(p1.x, p1.y), imgui.ImVec2(p1.x + 5, p1.y + 35), ToU32(col))
                DL:AddRectFilled(imgui.ImVec2(p1.x, p1.y), imgui.ImVec2(p1.x + wide, p1.y + 35), ToU32(imgui.ImVec4(col.x, col.y, col.z, 0.6)), 15, 10)
            else
                DL:AddRectFilled(imgui.ImVec2(p1.x, (pressed and p1.y + 3 or p1.y)), imgui.ImVec2(p1.x + 5, (pressed and p1.y + 32 or p1.y + 35)), ToU32(col))
                DL:AddRectFilled(imgui.ImVec2(p1.x, p1.y), imgui.ImVec2(p1.x + 190, p1.y + 35), ToU32(imgui.ImVec4(col.x, col.y, col.z, 0.6)), 15, 10)
            end
        else
            if imgui.IsItemHovered() then
                DL:AddRectFilled(imgui.ImVec2(p1.x, p1.y), imgui.ImVec2(p1.x + 190, p1.y + 35), 0x10FFFFFF, 15, 10)
            end
        end
        imgui.SameLine(10); imgui.SetCursorPosY(p2.y + 8)
        if bool then
            imgui.Text((' '):rep(3) .. icon)
            imgui.SameLine(60)
            imgui.Text(name)
        else
            imgui.TextColored(imgui.ImVec4(0.60, 0.60, 0.60, 1.00), (' '):rep(3) .. icon)
            imgui.SameLine(60)
            imgui.TextColored(imgui.ImVec4(0.60, 0.60, 0.60, 1.00), name)
        end
        imgui.SetCursorPosY(p2.y + 40)
        return result
end
function imgui.ToggleButton(str_id, bool, label)
    local rBool = false

    if LastActiveTime == nil then
        LastActiveTime = {}
    end
    if LastActive == nil then
        LastActive = {}
    end

    local function ImSaturate(f)
        return f < 0.0 and 0.0 or (f > 1.0 and 1.0 or f)
    end
    
    local p = imgui.GetCursorScreenPos()
    local draw_list = imgui.GetWindowDrawList()

    local height = 20--imgui.GetTextLineHeightWithSpacing()
    local width = 44--1.55
    local radius = 5*2--height * 0.50
    local rounding = 5.0
    local ANIM_SPEED = 0.15

    if imgui.InvisibleButton(str_id, imgui.ImVec2(width, height)) then
        bool.v = not bool.v
        rBool = true
        LastActiveTime[tostring(str_id)] = os.clock()
        LastActive[tostring(str_id)] = true
    end

    local t = bool.v and 1.0 or 0.0

    if LastActive[tostring(str_id)] then
        local time = os.clock() - LastActiveTime[tostring(str_id)]
        if time <= ANIM_SPEED then
            local t_anim = ImSaturate(time / ANIM_SPEED)
            t = bool.v and t_anim or 1.0 - t_anim
        else
            LastActive[tostring(str_id)] = false
        end
    end

    local col_bg
    local cir_bg
    if bool.v then
        col_bg = imgui.ImColor(204, 204, 204, 255):GetU32()
        cir_bg = imgui.ImColor(145, 32, 134):GetU32()
    else
        col_bg = imgui.ImColor(100, 100, 100, 255):GetU32()
        cir_bg = imgui.ImColor(204, 204, 204, 255):GetU32()
    end
    if bool.v then
        
        draw_list:AddRectFilled(imgui.ImVec2(p.x, p.y), imgui.ImVec2(p.x + width, p.y + (height)), col_bg, rounding)
    else
        draw_list:AddRectFilled(imgui.ImVec2(p.x, p.y), imgui.ImVec2(p.x + width, p.y + (height)), cir_bg, rounding) --out lines
        draw_list:AddRectFilled(imgui.ImVec2(p.x + 2, p.y + 2), imgui.ImVec2((p.x + width) - 2, (p.y + height) - 2), col_bg, rounding)
    end
    
    draw_list:AddCircleFilled(imgui.ImVec2(p.x + radius + t * (width - radius * 2.0), p.y + radius), radius - ((height - radius)/3), imgui.GetColorU32(bool.v and cir_bg or cir_bg))
    
    imgui.SameLine()
    imgui.Text(str_id)

 
    if label then
        imgui.SameLine()
        imgui.PushStyleVar(imgui.StyleVar.ItemSpacing, imgui.ImVec2(0.0, 3.0))
        imgui.BeginGroup()
            imgui.Spacing()
            if bool.v then
                imgui.Text('On')
            else
                imgui.Text('Off')
            end
            imgui.Spacing()
        imgui.EndGroup()
        imgui.PopStyleVar()
    end
    
    return rBool
end







local russian_characters = {
    [168] = 'Ё', [184] = 'ё', [192] = 'А', [193] = 'Б', [194] = 'В', [195] = 'Г', [196] = 'Д', [197] = 'Е', [198] = 'Ж', [199] = 'З', [200] = 'И', [201] = 'Й', [202] = 'К', [203] = 'Л', [204] = 'М', [205] = 'Н', [206] = 'О', [207] = 'П', [208] = 'Р', [209] = 'С', [210] = 'Т', [211] = 'У', [212] = 'Ф', [213] = 'Х', [214] = 'Ц', [215] = 'Ч', [216] = 'Ш', [217] = 'Щ', [218] = 'Ъ', [219] = 'Ы', [220] = 'Ь', [221] = 'Э', [222] = 'Ю', [223] = 'Я', [224] = 'а', [225] = 'б', [226] = 'в', [227] = 'г', [228] = 'д', [229] = 'е', [230] = 'ж', [231] = 'з', [232] = 'и', [233] = 'й', [234] = 'к', [235] = 'л', [236] = 'м', [237] = 'н', [238] = 'о', [239] = 'п', [240] = 'р', [241] = 'с', [242] = 'т', [243] = 'у', [244] = 'ф', [245] = 'х', [246] = 'ц', [247] = 'ч', [248] = 'ш', [249] = 'щ', [250] = 'ъ', [251] = 'ы', [252] = 'ь', [253] = 'э', [254] = 'ю', [255] = 'я',
}
function string.rlower(s)
    s = s:lower()
    local strlen = s:len()
    if strlen == 0 then return s end
    s = s:lower()
    local output = ''
    for i = 1, strlen do
        local ch = s:byte(i)
        if ch >= 192 and ch <= 223 then -- upper russian characters
            output = output .. russian_characters[ch + 32]
        elseif ch == 168 then -- Ё
            output = output .. russian_characters[184]
        else
            output = output .. string.char(ch)
        end
    end
    return output
end

function time()
	startTime = os.time()
    while true do
        wait(1000)
        if sampGetGamestate() == 3 then
	        nowTime = os.date("%H:%M:%S", os.time())

	        sessionOnline.v = sessionOnline.v + 1
	        sessionFull.v = os.time() - startTime
	        sessionAfk.v = sessionFull.v - sessionOnline.v

	        HLcfg.onDay.online = HLcfg.onDay.online + 1
	        HLcfg.onDay.full = dayFull.v + sessionFull.v
			HLcfg.onDay.afk = HLcfg.onDay.full - HLcfg.onDay.online

	    else
	    	startTime = startTime + 1
	    end
    end
end
function imgui.BetterInput(name, hint_text, buffer, color, text_color, width)

    ----==| Локальные фунцкии, использованные в этой функции. |==----

    local function bringVec4To(from, to, start_time, duration)
        local timer = os.clock() - start_time
        if timer >= 0.00 and timer <= duration then
            local count = timer / (duration / 100)
            return imgui.ImVec4(
                from.x + (count * (to.x - from.x) / 100),
                from.y + (count * (to.y - from.y) / 100),
                from.z + (count * (to.z - from.z) / 100),
                from.w + (count * (to.w - from.w) / 100)
            ), true
        end
        return (timer > duration) and to or from, false
    end

    local function bringFloatTo(from, to, start_time, duration)
        local timer = os.clock() - start_time
        if timer >= 0.00 and timer <= duration then
            local count = timer / (duration / 100)
            return from + (count * (to - from) / 100), true
        end
        return (timer > duration) and to or from, false
    end


    ----==| Изменение местоположения Imgui курсора, чтобы подсказка при анимации отображалась корректно. |==----

    imgui.SetCursorPosY(imgui.GetCursorPos().y + (imgui.CalcTextSize(hint_text).y * 0.7))


    ----==| Создание шаблона, для корректной работы нескольких таких виджетов. |==----

    if UI_BETTERINPUT == nil then
        UI_BETTERINPUT = {}
    end
    if not UI_BETTERINPUT[name] then
        UI_BETTERINPUT[name] = {buffer = buffer or imgui.ImBuffer(256), width = nil,
        hint = {
            pos = nil,
            old_pos = nil,
            scale = nil
        },
        color = imgui.GetStyle().Colors[imgui.Col.TextDisabled],
        old_color = imgui.GetStyle().Colors[imgui.Col.TextDisabled],
        active = {false, nil}, inactive = {true, nil}
    }
    end

    local pool = UI_BETTERINPUT[name] -- локальный список переменных для одного виджета


    ----==| Проверка и присваивание значений нужных переменных и аргументов. |==----
    
    if color == nil then
        color = imgui.GetStyle().Colors[imgui.Col.ButtonActive]
    end

    if width == nil then
        pool["width"] = imgui.CalcTextSize(hint_text).x + 50
        if pool["width"] < 150 then
            pool["width"] = 150
        end
    else
        pool["width"] = width
    end

    if pool["hint"]["scale"] == nil then
        pool["hint"]["scale"] = 1.0
    end

    if pool["hint"]["pos"] == nil then
        pool["hint"]["pos"] = imgui.ImVec2(imgui.GetCursorPos().x, imgui.GetCursorPos().y)
    end

    if pool["hint"]["old_pos"] == nil then
        pool["hint"]["old_pos"] = imgui.GetCursorPos().y
    end


    ----==| Изменение стилей под параметры виджета. |==----

    imgui.PushStyleColor(imgui.Col.FrameBg, imgui.ImVec4(1, 1, 1, 0))
    imgui.PushStyleColor(imgui.Col.Text, text_color or imgui.ImVec4(1, 1, 1, 1))
    imgui.PushStyleColor(imgui.Col.TextSelectedBg, color)
    imgui.PushStyleVar(imgui.StyleVar.FramePadding, imgui.ImVec2(0, imgui.GetStyle().FramePadding.y))
    imgui.PushItemWidth(pool["width"])


    ----==| Получение Imgui Draw List текущего окна. |==----

    local draw_list = imgui.GetWindowDrawList()


    ----==| Добавление декоративной линии под виджет. |==----

    draw_list:AddLine(imgui.ImVec2(imgui.GetCursorPos().x + imgui.GetWindowPos().x,
    imgui.GetCursorPos().y + imgui.GetWindowPos().y + (2 * imgui.GetStyle().FramePadding.y) + imgui.CalcTextSize(hint_text).y),
    imgui.ImVec2(imgui.GetCursorPos().x + imgui.GetWindowPos().x + pool["width"],
    imgui.GetCursorPos().y + imgui.GetWindowPos().y + (2 * imgui.GetStyle().FramePadding.y) + imgui.CalcTextSize(hint_text).y),
    imgui.GetColorU32(pool["color"]), 2.0)


    ----==| Само поле ввода. |==----

    imgui.InputText("##" .. name, pool["buffer"])


    ----==| Переключатель состояний виджета. |==----

    if not imgui.IsItemActive() then
        if pool["inactive"][2] == nil then pool["inactive"][2] = os.clock() end
        pool["inactive"][1] = true
        pool["active"][1] = false
        pool["active"][2] = nil

    elseif imgui.IsItemActive() or imgui.IsItemClicked() then
        pool["inactive"][1] = false
        pool["inactive"][2] = nil
        if pool["active"][2] == nil then pool["active"][2] = os.clock() end
        pool["active"][1] = true
    end
    
    ----==| Изменение цвета; размера и позиции подсказки по состоянию. |==----

    if pool["inactive"][1] and #pool["buffer"].v == 0 then
        pool["color"] = bringVec4To(pool["color"], pool["old_color"], pool["inactive"][2], 0.75)
        pool["hint"]["scale"] = bringFloatTo(pool["hint"]["scale"], 1.0, pool["inactive"][2], 0.25)
        pool["hint"]["pos"].y = bringFloatTo(pool["hint"]["pos"].y, pool["hint"]["old_pos"], pool["inactive"][2], 0.25)
        
    elseif pool["inactive"][1] and #pool["buffer"].v > 0 then
        pool["color"] = bringVec4To(pool["color"], pool["old_color"], pool["inactive"][2], 0.75)
        pool["hint"]["scale"] = bringFloatTo(pool["hint"]["scale"], 0.7, pool["inactive"][2], 0.25)
        pool["hint"]["pos"].y = bringFloatTo(pool["hint"]["pos"].y, pool["hint"]["old_pos"] - (imgui.GetFontSize() * 0.7) - 2,
        pool["inactive"][2], 0.25)

    elseif pool["active"][1] and #pool["buffer"].v == 0 then
        pool["color"] = bringVec4To(pool["color"], color, pool["active"][2], 0.75)
        pool["hint"]["scale"] = bringFloatTo(pool["hint"]["scale"], 0.7, pool["active"][2], 0.25)
        pool["hint"]["pos"].y = bringFloatTo(pool["hint"]["pos"].y, pool["hint"]["old_pos"] - (imgui.GetFontSize() * 0.7) - 2,
        pool["active"][2], 0.25)

    elseif pool["active"][1] and #pool["buffer"].v > 0 then
        pool["color"] = bringVec4To(pool["color"], color, pool["active"][2], 0.75)
        pool["hint"]["scale"] = bringFloatTo(pool["hint"]["scale"], 0.7, pool["active"][2], 0.25)
        pool["hint"]["pos"].y = bringFloatTo(pool["hint"]["pos"].y, pool["hint"]["old_pos"] - (imgui.GetFontSize() * 0.7) - 2,
        pool["active"][2], 0.25)
    end   
    imgui.SetWindowFontScale(pool["hint"]["scale"])
    
    
    ----==| Сама подсказка с анимацией. |==----

    draw_list:AddText(imgui.ImVec2(pool["hint"]["pos"].x + imgui.GetWindowPos().x + imgui.GetStyle().FramePadding.x,
    pool["hint"]["pos"].y + imgui.GetWindowPos().y + imgui.GetStyle().FramePadding.y),
    imgui.GetColorU32(pool["color"]),
    hint_text)


    ----==| Возвращение стилей в свой первоначальный вид. |==----

    imgui.SetWindowFontScale(1.0)
    imgui.PopItemWidth()
    imgui.PopStyleColor(3)
    imgui.PopStyleVar()
end
function autoSave()
	while true do
		wait(60000)
		save()
	end
end

function fixChatCoursor()
    lua_thread.create(function()
        sampSetChatInputEnabled(true)
        wait(100)
        sampSetChatInputEnabled(false)
    end)
end

function dialogHiderText()
    lua_thread.create(function()
    local result, button, list, input = sampHasDialogRespond(3910)
	if result then
		if list == 0 and button == 1 then
			sampSendChat('/s Внимание, озвучиваю правила!')
			wait(1000)
			sampSendChat('/s Запрещено: Срывать мероприятие, бегать не по назначению, стрелять без команды.')
			wait(1000)
			sampSendChat('/s Я вызываю 2-ух игроков, они становятся спиной к спине на любой дистанции...')
			wait(1000)
			sampSendChat('/s И на счет 1-2-3 начинают ПВП.')
		elseif list == 1 and button == 1 then
			sampSendChat('/s Внимание, озвучиваю правила!')
			wait(1000)
			sampSendChat('/s Запрещено: Срывать мероприятие, бегать не по назначению, убегать.')
			wait(1000)
			sampSendChat('/s Через /try мы найдем победителя.')
		elseif list == 2 and button == 1 then
			sampSendChat('/s Внимание, озвучиваю правила!')
			wait(1000)
			sampSendChat('/s Запрещено: Срывать мероприятие, менять машину.')
			wait(1000)
			sampSendChat('/s Последний оставшийся вне взорванной машине - победил.')
		elseif list == 3 and button == 1 then
			sampSendChat('/s Внимание, озвучиваю правила!')
			wait(1000)
			sampSendChat('/s Запрещено: Срывать мероприятие, стрелять по игрокам.')
			wait(1000)
			sampSendChat('/s Кто первый пройдет паркур - победил.')
		elseif list == 4 and button == 1 then
			sampSendChat('/s Внимание, озвучиваю правила!')
			wait(1000)
			sampSendChat('/s Запрещено: Срывать мероприятие, стрелять по игрокам.')
			wait(1000)
			sampSendChat('/s Кто первый останется на поверхности - победил.')
		elseif list == 5 and button == 1 then
			sampSendChat('/s Внимание, озвучиваю правила!')
			wait(1000)
			sampSendChat('/s Запрещено: Срывать мероприятие, стрелять по игрокам.')
			wait(1000)
			sampSendChat('/s Кто последний останется в живых - победил.')
		elseif list == 6 and button == 1 then
			sampSendChat('/s Внимание, озвучиваю правила!')
			wait(1000)
			sampSendChat('/s Запрещено: Срывать мероприятие, стрелять по игрокам.')
			wait(1000)
			sampSendChat('/s Кто лучше всех спрячется - победил.')
		elseif list == 7 and button == 1 then
			sampSendChat('/s Внимание, озвучиваю правила!')
			wait(1000)
			sampSendChat('/s Запрещено: Срывать мероприятие.')
			wait(1000)
			sampSendChat('/s Вы должны будете убить друг друга. Кто последний останется в живых - победил.')
		end
    end
    end)
end
function samp.onSendSpawn()
	_, myId = sampGetPlayerIdByCharHandle(PLAYER_PED)
	myNick = string.gsub(sampGetPlayerNickname(myId), "_", " ")
    if HLcfg.config.adminlvl == 0 then
        checkmylvl()
    end
end





function ShowHelpMarker(text)
	imgui.SameLine()
    imgui.TextDisabled("(?)")
    if (imgui.IsItemHovered()) then
        imgui.SetTooltip(u8(text))
    end
end

function ShowCenterTextColor(text, wsize, color)
	imgui.SetCursorPosX((wsize / 2) - (imgui.CalcTextSize(text).x / 2))
	imgui.TextColored(color, text)
end

function ShowCenterText(text, wsize)
	imgui.SetCursorPosX((wsize / 2) - (imgui.CalcTextSize(text).x / 2))
	imgui.TextColored(imgui.ImVec4(0.4, 0.8, 0.3, 1.0), text)
end

function getDownKeys()
    local curkeys = ""
    local bool = false
    for k, v in pairs(key) do
        if isKeyDown(v) and (v == VK_MENU or v == VK_CONTROL or v == VK_SHIFT or v == VK_LMENU or v == VK_RMENU or v == VK_RCONTROL or v == VK_LCONTROL or v == VK_LSHIFT or v == VK_RSHIFT) then
            if v ~= VK_MENU and v ~= VK_CONTROL and v ~= VK_SHIFT then
                curkeys = v
            end
        end
    end
    for k, v in pairs(key) do
        if isKeyDown(v) and (v ~= VK_MENU and v ~= VK_CONTROL and v ~= VK_SHIFT and v ~= VK_LMENU and v ~= VK_RMENU and v ~= VK_RCONTROL and v ~= VK_LCONTROL and v ~= VK_LSHIFT and v ~= VK_RSHIFT) then
            if tostring(curkeys):len() == 0 then
                curkeys = v
            else
                curkeys = curkeys .. " " .. v
            end
            bool = true
        end
    end
    return curkeys, bool
end

function getDownKeysText()
	tKeys = string.split(getDownKeys(), " ")
	if #tKeys ~= 0 then
		for i = 1, #tKeys do
			if i == 1 then
				str = key.id_to_name(tonumber(tKeys[i]))
			else
				str = str .. "+" .. key.id_to_name(tonumber(tKeys[i]))
			end
		end
		return str
	else
		return "None"
	end
end


function string.split(inputstr, sep)
    if sep == nil then
            sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            t[i] = str
            i = i + 1
    end
    return t
end

function strToIdKeys(str)
	tKeys = string.split(str, "+")
	if #tKeys ~= 0 then
		for i = 1, #tKeys do
			if i == 1 then
				str = key.name_to_id(tKeys[i], false)
			else
				str = str .. " " .. key.name_to_id(tKeys[i], false)
			end
		end
		return tostring(str)
	else
		return "(("
	end
end

function isKeysDown(keylist, pressed)
    local tKeys = string.split(keylist, " ")
    if pressed == nil then
        pressed = false
    end
    if tKeys[1] == nil then
        return false
    end
    local bool = false
    local key = #tKeys < 2 and tonumber(tKeys[1]) or tonumber(tKeys[2])
    local modified = tonumber(tKeys[1])
    if #tKeys < 2 then
        if not isKeyDown(VK_RMENU) and not isKeyDown(VK_LMENU) and not isKeyDown(VK_LSHIFT) and not isKeyDown(VK_RSHIFT) and not isKeyDown(VK_LCONTROL) and not isKeyDown(VK_RCONTROL) then
            if wasKeyPressed(key) and not pressed then
                bool = true
            elseif isKeyDown(key) and pressed then
                bool = true
            end
        end
    else
        if isKeyDown(modified) and not wasKeyReleased(modified) then
            if wasKeyPressed(key) and not pressed then
                bool = true
            elseif isKeyDown(key) and pressed then
                bool = true
            end
        end
    end
    if nextLockKey == keylist then
        if pressed and not wasKeyReleased(key) then
            bool = false
        else
            bool = false
            nextLockKey = ""
        end
    end
    return bool
end

function getClosestPlayerId()
    local minDist = 9999
    local closestId = -1
    local x, y, z = getCharCoordinates(PLAYER_PED)
    for i = 0, 999 do
        local streamed, pedID = sampGetCharHandleBySampPlayerId(i)
        if streamed then
            local xi, yi, zi = getCharCoordinates(pedID)
            local dist = math.sqrt( (xi - x) ^ 2 + (yi - y) ^ 2 + (zi - z) ^ 2 )
            if dist < minDist then
                minDist = dist
                closestId = i
            end
        end
    end
    return closestId
end
function samp.onSendPlayerSync(data)
    if gotoPlayer then
        print('yes')
        local result, x, y, z = getNearestRoadCoordinates()
        myX, myY, myZ = getCharCoordinates(PLAYER_PED)
        
        if result then
            
            data.position.x = x
			data.position.y = y
			data.position.z = z
            
        end
    end

    
    if ainvisible then
			local px, py, pz = getCharCoordinates(PLAYER_PED)
			data.position.x = px+5
			data.position.y = py+5
			data.position.z = pz-15
		end
		if gocar then
			car_px, car_py, car_pz = getCharCoordinates(PLAYER_PED)
			data.position.x = 1000
			data.position.y = 1000
			data.position.z = 1000

		end


end

function getNearestId()
    local closestId = -1
    mydist = 30
    local x, y, z = getCharCoordinates(PLAYER_PED)
    for i = 0, 999 do
        local streamed, pedID = sampGetCharHandleBySampPlayerId(i)
        if streamed and getCharHealth(pedID) > 0 and not sampIsPlayerPaused(pedID) then
            local xi, yi, zi = getCharCoordinates(pedID)
            local dist = getDistanceBetweenCoords3d(x, y, z, xi, yi, zi)
            if dist <= mydist then
                mydist = dist
                closestId = i
                
            end
        end
    end
    return closestId
end
function rotateCarAroundUpAxis(car, vec)
    local mat = Matrix3X3(getVehicleRotationMatrix(car))
    local rotAxis = Vector3D(mat.up:get())
    vec:normalize()
    rotAxis:normalize()
    local theta = math.acos(rotAxis:dotProduct(vec))
    if theta ~= 0 then
      rotAxis:crossProduct(vec)
      rotAxis:normalize()
      rotAxis:zeroNearZero()
      mat = mat:rotate(rotAxis, -theta)
    end
    setVehicleRotationMatrix(car, mat:get())
end

function readFloatArray(ptr, idx)
    return representIntAsFloat(readMemory(ptr + idx * 4, 4, false))
end

function writeFloatArray(ptr, idx, value)
    writeMemory(ptr + idx * 4, 4, representFloatAsInt(value), false)
end



function getVehicleRotationMatrix(car)
    local entityPtr = getCarPointer(car)
    if entityPtr ~= 0 then
      local mat = readMemory(entityPtr + 0x14, 4, false)
      if mat ~= 0 then
        local rx, ry, rz, fx, fy, fz, ux, uy, uz
        rx = readFloatArray(mat, 0)
        ry = readFloatArray(mat, 1)
        rz = readFloatArray(mat, 2)

        fx = readFloatArray(mat, 4)
        fy = readFloatArray(mat, 5)
        fz = readFloatArray(mat, 6)

        ux = readFloatArray(mat, 8)
        uy = readFloatArray(mat, 9)
        uz = readFloatArray(mat, 10)
        return rx, ry, rz, fx, fy, fz, ux, uy, uz
      end
    end
end

function getNick(id)
    local nick = sampGetPlayerNickname(id)
    return nick
end

function getMyNick()
    local result, id = sampGetPlayerIdByCharHandle(playerPed)
    if result then
        local nick = sampGetPlayerNickname(id)
        return nick
    end
end

function getMyId()
    local result, id = sampGetPlayerIdByCharHandle(playerPed)
    if result then
        return id
    end
end

function setVehicleRotationMatrix(car, rx, ry, rz, fx, fy, fz, ux, uy, uz)
    local entityPtr = getCarPointer(car)
    if entityPtr ~= 0 then
      local mat = readMemory(entityPtr + 0x14, 4, false)
      if mat ~= 0 then
        writeFloatArray(mat, 0, rx)
        writeFloatArray(mat, 1, ry)
        writeFloatArray(mat, 2, rz)

        writeFloatArray(mat, 4, fx)
        writeFloatArray(mat, 5, fy)
        writeFloatArray(mat, 6, fz)

        writeFloatArray(mat, 8, ux)
        writeFloatArray(mat, 9, uy)
        writeFloatArray(mat, 10, uz)
      end
    end
end

function displayVehicleName(x, y, gxt)
    x, y = convertWindowScreenCoordsToGameScreenCoords(x, y)
    useRenderCommands(true)
    setTextWrapx(640.0)
    setTextProportional(true)
    setTextJustify(false)
    setTextScale(0.33, 0.8)
    setTextDropshadow(0, 0, 0, 0, 0)
    setTextColour(255, 255, 255, 230)
    setTextEdge(1, 0, 0, 0, 100)
    setTextFont(1)
    displayText(x, y, gxt)
end

function createPointMarker(x, y, z)
    pointMarker = createUser3dMarker(x, y, z + 0.3, 4)
end
function createPointEvent(x, y, z)
	pointMarker = createUser3dMarker(x, y, z)
end

function removePointMarker()
    if pointMarker then
      removeUser3dMarker(pointMarker)
      pointMarker = nil
    end
end

function samp.onSendBulletSync(data)
    if elements.checkbox.showMyBullets.v and elements.checkbox.bulletTracer.v then
        if data.center.x ~= 0 then
            if data.center.y ~= 0 then
                if data.center.z ~= 0 then
                    bulletSyncMy.lastId = bulletSyncMy.lastId + 1
                    if bulletSyncMy.lastId < 1 or bulletSyncMy.lastId > bulletSyncMy.maxLines then
                        bulletSyncMy.lastId = 1
                    end
                    bulletSyncMy[bulletSyncMy.lastId].my.time = os.time() + elements.int.secondToCloseTwo.v
                    bulletSyncMy[bulletSyncMy.lastId].my.o.x, bulletSyncMy[bulletSyncMy.lastId].my.o.y, bulletSyncMy[bulletSyncMy.lastId].my.o.z = data.origin.x, data.origin.y, data.origin.z
                    bulletSyncMy[bulletSyncMy.lastId].my.t.x, bulletSyncMy[bulletSyncMy.lastId].my.t.y, bulletSyncMy[bulletSyncMy.lastId].my.t.z = data.target.x, data.target.y, data.target.z
                    if data.targetType == 0 then
                        bulletSyncMy[bulletSyncMy.lastId].my.color = join_argb(255, staticObjectMy.v[1]*255, staticObjectMy.v[2]*255, staticObjectMy.v[3]*255)
                    elseif data.targetType == 1 then
                        bulletSyncMy[bulletSyncMy.lastId].my.color = join_argb(255, pedPMy.v[1]*255, pedPMy.v[2]*255, pedPMy.v[3]*255)
                    elseif data.targetType == 2 then
                        bulletSyncMy[bulletSyncMy.lastId].my.color = join_argb(255, carPMy.v[1]*255, carPMy.v[2]*255, carPMy.v[3]*255)
                    elseif data.targetType == 3 then
                        bulletSyncMy[bulletSyncMy.lastId].my.color = join_argb(255, dinamicObjectMy.v[1]*255, dinamicObjectMy.v[2]*255, dinamicObjectMy.v[3]*255)
                    end
                end
            end
        end
    end
end

function samp.onBulletSync(playerid, data)
    if elements.checkbox.bulletTracer.v then
        if data.center.x ~= 0 then
            if data.center.y ~= 0 then
                if data.center.z ~= 0 then
                    bulletSync.lastId = bulletSync.lastId + 1
                    if bulletSync.lastId < 1 or bulletSync.lastId > bulletSync.maxLines then
                        bulletSync.lastId = 1
                    end
                    bulletSync[bulletSync.lastId].other.time = os.time() + elements.int.secondToClose.v
                    bulletSync[bulletSync.lastId].other.o.x, bulletSync[bulletSync.lastId].other.o.y, bulletSync[bulletSync.lastId].other.o.z = data.origin.x, data.origin.y, data.origin.z
                    bulletSync[bulletSync.lastId].other.t.x, bulletSync[bulletSync.lastId].other.t.y, bulletSync[bulletSync.lastId].other.t.z = data.target.x, data.target.y, data.target.z
                    if data.targetType == 0 then
                        bulletSync[bulletSync.lastId].other.color = join_argb(255, staticObject.v[1]*255, staticObject.v[2]*255, staticObject.v[3]*255)
                    elseif data.targetType == 1 then
                        bulletSync[bulletSync.lastId].other.color = join_argb(255, pedP.v[1]*255, pedP.v[2]*255, pedP.v[3]*255)
                    elseif data.targetType == 2 then
                        bulletSync[bulletSync.lastId].other.color = join_argb(255, carP.v[1]*255, carP.v[2]*255, carP.v[3]*255)
                    elseif data.targetType == 3 then
                        bulletSync[bulletSync.lastId].other.color = join_argb(255, dinamicObject.v[1]*255, dinamicObject.v[2]*255, dinamicObject.v[3]*255)
                    end
                end
            end
        end
    end
end
function getCarFreeSeat(car)
    if doesCharExist(getDriverOfCar(car)) then
      local maxPassengers = getMaximumNumberOfPassengers(car)
      for i = 0, maxPassengers do
        if isCarPassengerSeatFree(car, i) then
          return i + 1
        end
      end
      return nil -- no free seats
    else
      return 0 -- driver seat
    end
end

function jumpIntoCar(car)
    local seat = getCarFreeSeat(car)
    if not seat then return false end                         -- no free seats
    if seat == 0 then warpCharIntoCar(playerPed, car)         -- driver seat
    else warpCharIntoCarAsPassenger(playerPed, car, seat - 1) -- passenger seat
    end
    restoreCameraJumpcut()
    return true
end

function fps_correction()
	return representIntAsFloat(readMemory(0xB7CB5C, 4, false))
end

function teleportPlayer(x, y, z)
    if isCharInAnyCar(playerPed) then
      setCharCoordinates(playerPed, x, y, z)
    end
    setCharCoordinatesDontResetAnim(playerPed, x, y, z)
end

function isKeysDown(keycombo_or_keyId)
    keycombo_or_keyId = table.concat(keycombo_or_keyId, ", ")
    for w in string.gmatch(keycombo_or_keyId, "%d+") do
      if isKeyDown(w) then
        return true
      end
    end
end

function savesettings()
    if doesFileExist(fpath) then
      local f = io.open(fpath, 'w+')
      if f then
        f:write(encodeJson(defTable)):close()
      end
    end
end

function setCharCoordinatesDontResetAnim(char, x, y, z)
    if doesCharExist(char) then
      local ptr = getCharPointer(char)
      setEntityCoordinates(ptr, x, y, z)
    end
end

function setEntityCoordinates(entityPtr, x, y, z)
    if entityPtr ~= 0 then
      local matrixPtr = readMemory(entityPtr + 0x14, 4, false)
      if matrixPtr ~= 0 then
        local posPtr = matrixPtr + 0x30
        writeMemory(posPtr + 0, 4, representFloatAsInt(x), false) -- X
        writeMemory(posPtr + 4, 4, representFloatAsInt(y), false) -- Y
        writeMemory(posPtr + 8, 4, representFloatAsInt(z), false) -- Z
      end
    end
end

function getIcon(icon)
    imgui.PushFont(fa_font)
    fa_icon = icon
    imgui.PopFont()
    return fa_icon
end
function salat()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowRounding = 2.0
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    
    style.ChildWindowRounding = 2.0
    style.FrameRounding = 2.0
    style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
    style.ScrollbarSize = 13.0
    style.ScrollbarRounding = 0
    style.GrabMinSize = 8.0
    style.GrabRounding = 1.0

    colors[clr.FrameBg]                = ImVec4(0.42, 0.48, 0.16, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.85, 0.98, 0.26, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.85, 0.98, 0.26, 0.67)
    colors[clr.TitleBg]                = ImVec4(0.42, 0.48, 0.16, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.42, 0.48, 0.16, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.42, 0.48, 0.16, 1.00)
    colors[clr.CheckMark]              = ImVec4(0.85, 0.98, 0.26, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.77, 0.88, 0.24, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.85, 0.98, 0.26, 1.00)
    colors[clr.Button]                 = ImVec4(buttonColor.v[1], buttonColor.v[2], buttonColor.v[3], buttonColor.v[3])
    colors[clr.ButtonHovered]          = ImVec4(0.85, 0.98, 0.26, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.82, 0.98, 0.06, 1.00)
    colors[clr.Header]                 = ImVec4(0.85, 0.98, 0.26, 0.31)
    colors[clr.HeaderHovered]          = ImVec4(0.85, 0.98, 0.26, 0.80)
    colors[clr.HeaderActive]           = ImVec4(0.85, 0.98, 0.26, 1.00)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.63, 0.75, 0.10, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.63, 0.75, 0.10, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.85, 0.98, 0.26, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.85, 0.98, 0.26, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.85, 0.98, 0.26, 0.95)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.81, 0.35, 1.00)
    colors[clr.TextSelectedBg]         = ImVec4(0.85, 0.98, 0.26, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
    
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
		style.WindowPadding = imgui.ImVec2(8, 8)
		style.WindowRounding = 6
		style.ChildWindowRounding = 5
		style.FramePadding = imgui.ImVec2(5, 4)
		style.FrameRounding = 3.0
		style.ItemSpacing = imgui.ImVec2(5, 4)
		style.ItemInnerSpacing = imgui.ImVec2(4, 4)
		style.IndentSpacing = 21
		style.ScrollbarSize = 10.0
		style.ScrollbarRounding = 13
		style.GrabMinSize = 8
		style.GrabRounding = 1
		style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
		style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
end
function getNearestList()
    local text = ""
    lua_thread.create(function()
    getNear = true
    wait(300)
    getNear = false

    wait(500)
    for k,v in ipairs(nearestList) do
        text = v.nName..'['..v.nId..']\n'
        sampShowDialog(1193, 'Ближайшие игроки', text, 'Следить', 'Закрыть', 2)
    end

    end)
end
function blackred()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2

    style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 6
    style.ChildWindowRounding = 5
    style.FramePadding = imgui.ImVec2(5, 4)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    

    colors[clr.Text]                   = ImVec4(0.95, 0.96, 0.98, 1.00);
    colors[clr.TextDisabled]           = ImVec4(0.29, 0.29, 0.29, 1.00);
    colors[clr.WindowBg]               = ImVec4(0.14, 0.14, 0.14, 1.00);

    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94);
    colors[clr.Border]                 = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.BorderShadow]           = ImVec4(1.00, 1.00, 1.00, 0.10);
    colors[clr.FrameBg]                = ImVec4(0.22, 0.22, 0.22, 1.00);
    colors[clr.FrameBgHovered]         = ImVec4(0.18, 0.18, 0.18, 1.00);
    colors[clr.FrameBgActive]          = ImVec4(0.09, 0.12, 0.14, 1.00);
    colors[clr.TitleBg]                = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.TitleBgActive]          = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.TitleBgCollapsed]       = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.MenuBarBg]              = ImVec4(0.20, 0.20, 0.20, 1.00);
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.39);
    colors[clr.ScrollbarGrab]          = ImVec4(0.36, 0.36, 0.36, 1.00);
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.18, 0.22, 0.25, 1.00);
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[clr.ComboBg]                = ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[clr.CheckMark]              = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.SliderGrab]             = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.SliderGrabActive]       = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.Button]                 = ImVec4(buttonColor.v[1], buttonColor.v[2], buttonColor.v[3], buttonColor.v[3])
    colors[clr.ButtonHovered]          = ImVec4(1.00, 0.39, 0.39, 1.00);
    colors[clr.ButtonActive]           = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.Header]                 = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.HeaderHovered]          = ImVec4(1.00, 0.39, 0.39, 1.00);
    colors[clr.HeaderActive]           = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.ResizeGrip]             = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.ResizeGripHovered]      = ImVec4(1.00, 0.39, 0.39, 1.00);
    colors[clr.ResizeGripActive]       = ImVec4(1.00, 0.19, 0.19, 1.00);
    colors[clr.CloseButton]            = ImVec4(0.40, 0.39, 0.38, 0.16);
    colors[clr.CloseButtonHovered]     = ImVec4(0.40, 0.39, 0.38, 0.39);
    colors[clr.CloseButtonActive]      = ImVec4(0.40, 0.39, 0.38, 1.00);
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00);
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00);
    colors[clr.PlotHistogram]          = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.18, 0.18, 1.00);
    colors[clr.TextSelectedBg]         = ImVec4(1.00, 0.32, 0.32, 1.00);
    colors[clr.ModalWindowDarkening]   = ImVec4(0.26, 0.26, 0.26, 0.60);
		style.WindowPadding = imgui.ImVec2(8, 8)
		style.WindowRounding = 6
		style.ChildWindowRounding = 5
		style.FramePadding = imgui.ImVec2(5, 4)
		style.FrameRounding = 3.0
		style.ItemSpacing = imgui.ImVec2(5, 4)
		style.ItemInnerSpacing = imgui.ImVec2(4, 4)
		style.IndentSpacing = 21
		style.ScrollbarSize = 10.0
		style.ScrollbarRounding = 13
		style.GrabMinSize = 8
		style.GrabRounding = 1
		style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
		style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
end
function set_player_skin(id, skin)
	local BS = raknetNewBitStream()
	raknetBitStreamWriteInt32(BS, id)
	raknetBitStreamWriteInt32(BS, skin)
	raknetEmulRpcReceiveBitStream(153, BS)
	raknetDeleteBitStream(BS)
end
function violet()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
	style.Alpha = 1.00

    style.WindowRounding = 2.0
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    
    style.ChildWindowRounding = 2.0
    style.FrameRounding = 2.0
    style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
    style.ScrollbarSize = 9.0
    style.ScrollbarRounding = 0
    style.GrabMinSize = 8.0
    style.GrabRounding = 1.0

    colors[clr.FrameBg]                = ImVec4(0.442, 0.115, 0.718, 0.540)
    colors[clr.FrameBgHovered]         = ImVec4(0.389, 0.190, 0.718, 0.400)
    colors[clr.FrameBgActive]          = ImVec4(0.441, 0.125, 0.840, 0.670)
    colors[clr.TitleBg]                = ImVec4(0.557, 0.143, 0.702, 1.000)
    colors[clr.TitleBgActive]          = ImVec4(0.557, 0.143, 0.702, 1.000)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.557, 0.143, 0.702, 1.000)
    colors[clr.CheckMark]              = ImVec4(0.643, 0.190, 0.862, 1.000)
    colors[clr.SliderGrab]             = ImVec4(0.434, 0.100, 0.757, 1.000)
    colors[clr.SliderGrabActive]       = ImVec4(0.434, 0.100, 0.757, 1.000)
    colors[clr.Button]                 = ImVec4(buttonColor.v[1], buttonColor.v[2], buttonColor.v[3], buttonColor.v[3])
    colors[clr.ButtonHovered]          = ImVec4(0.508, 0.000, 1.000, 1.000)
    colors[clr.ButtonActive]           = ImVec4(0.508, 0.000, 1.000, 1.000)
    colors[clr.Header]                 = ImVec4(0.628, 0.098, 0.884, 0.310)
    colors[clr.HeaderHovered]          = ImVec4(0.695, 0.000, 0.983, 0.800)
    colors[clr.HeaderActive]           = ImVec4(0.695, 0.000, 0.983, 0.800)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.644, 0.021, 0.945, 0.800)
    colors[clr.ResizeGripHovered]      = ImVec4(0.644, 0.021, 0.945, 0.800)
    colors[clr.ResizeGripActive]       = ImVec4(0.644, 0.021, 0.945, 0.800)
    colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)

    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
		style.WindowPadding = imgui.ImVec2(8, 8)
		style.WindowRounding = 6
		style.ChildWindowRounding = 5
		style.FramePadding = imgui.ImVec2(5, 4)
		style.FrameRounding = 3.0
		style.ItemSpacing = imgui.ImVec2(5, 4)
		style.ItemInnerSpacing = imgui.ImVec2(4, 4)
		style.IndentSpacing = 21
		style.ScrollbarSize = 10.0
		style.ScrollbarRounding = 13
		style.GrabMinSize = 8
		style.GrabRounding = 1
		style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
		style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
end

function blue()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
	style.Alpha = 1.00

    style.WindowRounding = 2.0
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    
    style.ChildWindowRounding = 2.0
    style.FrameRounding = 2.0
    style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
    style.ScrollbarSize = 9.0
    style.ScrollbarRounding = 0
    style.GrabMinSize = 8.0
    style.GrabRounding = 1.0

    colors[clr.FrameBg]                = ImVec4(0.16, 0.29, 0.48, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.59, 0.98, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.TitleBg]                = ImVec4(0.16, 0.29, 0.48, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.16, 0.29, 0.48, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.16, 0.29, 0.48, 1.00)
    colors[clr.CheckMark]              = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.24, 0.52, 0.88, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.Button]                 = ImVec4(buttonColor.v[1], buttonColor.v[2], buttonColor.v[3], buttonColor.v[3])
    colors[clr.ButtonHovered]          = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.06, 0.53, 0.98, 1.00)
    colors[clr.Header]                 = ImVec4(0.26, 0.59, 0.98, 0.31)
    colors[clr.HeaderHovered]          = ImVec4(0.26, 0.59, 0.98, 0.80)
    colors[clr.HeaderActive]           = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.26, 0.59, 0.98, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.59, 0.98, 0.95)
    colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
   
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
		style.WindowPadding = imgui.ImVec2(8, 8)
		style.WindowRounding = 6
		style.ChildWindowRounding = 5
		style.FramePadding = imgui.ImVec2(10, 3)
		style.FrameRounding = 3.0
		style.ItemSpacing = imgui.ImVec2(5, 4)
		style.ItemInnerSpacing = imgui.ImVec2(4, 4)
		style.IndentSpacing = 21
		style.ScrollbarSize = 10.0
		style.ScrollbarRounding = 13
		style.GrabMinSize = 8
		style.GrabRounding = 1
		style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
		style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
end

function brown()
   imgui.SwitchContext()
   local style = imgui.GetStyle()
   local colors = style.Colors
   local clr = imgui.Col
   local ImVec4 = imgui.ImVec4

   style.WindowRounding = 2.0
   imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
   imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
   
   style.ChildWindowRounding = 2.0
   style.FrameRounding = 2.0
   style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
   style.ScrollbarSize = 9.0
   style.ScrollbarRounding = 0
   style.GrabMinSize = 8.0
   style.GrabRounding = 1.0

   colors[clr.FrameBg]                = ImVec4(0.48, 0.23, 0.16, 0.54)
   colors[clr.FrameBgHovered]         = ImVec4(0.98, 0.43, 0.26, 0.40)
   colors[clr.FrameBgActive]          = ImVec4(0.98, 0.43, 0.26, 0.67)
   colors[clr.TitleBg]                = ImVec4(0.48, 0.23, 0.16, 1.00)
   colors[clr.TitleBgActive]          = ImVec4(0.48, 0.23, 0.16, 1.00)
   colors[clr.TitleBgCollapsed]       = ImVec4(0.48, 0.23, 0.16, 1.00)
   colors[clr.CheckMark]              = ImVec4(0.98, 0.43, 0.26, 1.00)
   colors[clr.SliderGrab]             = ImVec4(0.88, 0.39, 0.24, 1.00)
   colors[clr.SliderGrabActive]       = ImVec4(0.98, 0.43, 0.26, 1.00)
   colors[clr.Button]                 = ImVec4(buttonColor.v[1], buttonColor.v[2], buttonColor.v[3], buttonColor.v[3])
   colors[clr.ButtonHovered]          = ImVec4(0.98, 0.43, 0.26, 1.00)
   colors[clr.ButtonActive]           = ImVec4(0.98, 0.28, 0.06, 1.00)
   colors[clr.Header]                 = ImVec4(0.98, 0.43, 0.26, 0.31)
   colors[clr.HeaderHovered]          = ImVec4(0.98, 0.43, 0.26, 0.80)
   colors[clr.HeaderActive]           = ImVec4(0.98, 0.43, 0.26, 1.00)
   colors[clr.Separator]              = colors[clr.Border]
   colors[clr.SeparatorHovered]       = ImVec4(0.75, 0.25, 0.10, 0.78)
   colors[clr.SeparatorActive]        = ImVec4(0.75, 0.25, 0.10, 1.00)
   colors[clr.ResizeGrip]             = ImVec4(0.98, 0.43, 0.26, 0.25)
   colors[clr.ResizeGripHovered]      = ImVec4(0.98, 0.43, 0.26, 0.67)
   colors[clr.ResizeGripActive]       = ImVec4(0.98, 0.43, 0.26, 0.95)
   colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
   colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.50, 0.35, 1.00)
   colors[clr.TextSelectedBg]         = ImVec4(0.98, 0.43, 0.26, 0.35)
   colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
   colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
   colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)

   colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
   colors[clr.ComboBg]                = colors[clr.PopupBg]
   colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
   colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
   colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
   colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
   colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
   colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
   colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
   colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
   colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
   colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
   colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
   colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
   colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
	 style.WindowPadding = imgui.ImVec2(8, 8)
	 style.WindowRounding = 6
	 style.ChildWindowRounding = 5
	 style.FramePadding = imgui.ImVec2(5, 4)
	 style.FrameRounding = 3.0
	 style.ItemSpacing = imgui.ImVec2(5, 4)
	 style.ItemInnerSpacing = imgui.ImVec2(4, 4)
	 style.IndentSpacing = 21
	 style.ScrollbarSize = 10.0
	 style.ScrollbarRounding = 13
	 style.GrabMinSize = 8
	 style.GrabRounding = 1
	 style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
	 style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
end

function red()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowRounding = 2.0
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    
    style.ChildWindowRounding = 2.0
    style.FrameRounding = 2.0
    style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
    style.ScrollbarSize = 9.0
    style.ScrollbarRounding = 0
    style.GrabMinSize = 8.0
    style.GrabRounding = 1.0

    colors[clr.FrameBg]                = ImVec4(0.48, 0.16, 0.16, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.98, 0.26, 0.26, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.98, 0.26, 0.26, 0.67)
    colors[clr.TitleBg]                = ImVec4(0.48, 0.16, 0.16, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.48, 0.16, 0.16, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.48, 0.16, 0.16, 1.00)
    colors[clr.CheckMark]              = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.88, 0.26, 0.24, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.Button]                 = ImVec4(buttonColor.v[1], buttonColor.v[2], buttonColor.v[3], buttonColor.v[3])
    colors[clr.ButtonHovered]          = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.98, 0.06, 0.06, 1.00)
    colors[clr.Header]                 = ImVec4(0.98, 0.26, 0.26, 0.31)
    colors[clr.HeaderHovered]          = ImVec4(0.98, 0.26, 0.26, 0.80)
    colors[clr.HeaderActive]           = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.75, 0.10, 0.10, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.75, 0.10, 0.10, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.98, 0.26, 0.26, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.98, 0.26, 0.26, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.98, 0.26, 0.26, 0.95)
    colors[clr.TextSelectedBg]         = ImVec4(0.98, 0.26, 0.26, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)

    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
		style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 6
    style.ChildWindowRounding = 5
    style.FramePadding = imgui.ImVec2(5, 4)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    style.ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
end

function saveSettings()
	sampSetCursorMode(0)


		inicfg.save(HLcfg, 'AdminTools.ini')

	thisScript():reload()
end
function imgui.CenterText(text)
    local width = imgui.GetWindowWidth()
    local height = imgui.GetWindowHeight()
    local calc = imgui.CalcTextSize(text)
    imgui.SetCursorPosX( width / 2 - calc.x / 2 )
    imgui.SetCursorPosY( height / 2 - calc.y / 2 )
    imgui.Text(text)
end
function imgui.CenterText1(text)
    imgui.SetCursorPosX(imgui.GetWindowSize().x / 2 - imgui.CalcTextSize(text).x / 2)
    imgui.Text(text)
end
function showCursorForClickWarp(toggle)
    if toggle then
      sampSetCursorMode(CMODE_LOCKCAM)
    else
      sampToggleCursor(false)
    end
    cursorEnabled = toggle
  end
function wallhack()
	wh = not wh
	if wh then
		printStyledString('WH Enabled', 1000, 4)
		nameTagOn()
	else
		printStyledString('WH Disabled', 1000, 4)
		nameTagOff()
	end
end
function givecar(text)

	if text ~= "" then
		if text:find('%d+%s+%d+') then
		local id, car = text:match('(%d+)%s+(%d+)')
		lua_thread.create(function()
		sampSendChat('/g '..id)
		wait(1000)
		sampSendChat('/veh '..car..' 0 0')
	end)
else
	sampAddChatMessage('{FF8C00}Некорректный ввод [ID] [ID т/с]', -1)
end
else
	sampAddChatMessage('Введите: /givecar [ID] [ID т/с]', -1)
end
end



function repstat()
	lua_thread.create(function()

	getrep = true
	wait(500)
	sampSendChat('/astats')
	wait(300)
	getrep = false
	wait(1500)
	if otvrep == nil then
		otvrep = 'Not'
	end
	repstat = ('{ffffff}Репортов за день: {FFD700}                        '..HLcfg.config.dayReports..'\n{ffffff}Всего ответов: '..otvrep)
	sampShowDialog(333312, "Статистика администратора", repstat, "Иду работать", "Окей", 0)
end)


end
function renderDrawButton(d3dFont, Title, posX, posY, sizeX, sizeY, targetX, targetY, boxColor, targetBoxColor, textColor, targetTextColor)
    local bool = false
    local currentBoxColor= boxColor
    local currentTextColor= textColor

    if targetX > posX and targetX < posX + sizeX and targetY > posY and targetY < posY + sizeY then
        currentBoxColor = targetBoxColor
        currentTextColor = targetTextColor
        if isKeyJustPressed(1) then bool = true end
    end

    renderDrawBoxWithBorder(posX, posY, sizeX, sizeY, currentBoxColor, 4, 0xFF242424)
    renderFontDrawText(d3dFont, Title, posX+(sizeX-renderGetFontDrawTextLength(d3dFont, Title))/2, posY+(sizeY-renderGetFontDrawHeight(d3dFont))/2, currentTextColor)
    return bool
end
function onScriptTerminate(script, quit)
	if script == thisScript() and not quit and pong then
		showCursor(false, false)
	end
end
function coerce(x, lo, hi)
    return math.max(math.min(x, hi), lo)
end
function imgui.hitbox(name,visible,posX,posY,sizeX,sizeY)
	imgui.SetCursorPos(imgui.ImVec2(posX,posY))
	if visible then
		name = string.gsub(name,'nil','')
		if name == xo_enemy then
			imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(255/255,23/255,23/255,0.8))
			imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(255/255,23/255,23/255,0.8))
			imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(255/255,23/255,23/255,0.8))
		elseif name == XO then
			imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(61/255,230/255,28/255,0.8))
			imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(61/255,230/255,28/255,1.0))
			imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(61/255,230/255,28/255,1.0))
		else
			imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(107/255,107/255,107/255,0.5))
			imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(107/255,107/255,107/255,0.6))
			imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(107/255,107/255,107/255,0.6))
		end
		local but = imgui.Button(name,imgui.ImVec2(sizeX,sizeY))
			imgui.PopStyleColor(3)
	else
		local but = imgui.InvisibleButton('##'..name,imgui.ImVec2(sizeX,sizeY))
	end

	if imgui.IsItemClicked() and Move then
		if name ~= 'X' and name ~= 'O' then
			Move = false
			return true
		end
	end
	return but

end

function gameOver(win)
	if win == XO then
		send('Игра окончена. Победитель: '..win..' поздравляем!',true)
	else
		send('Игра окончена. Проигравший: '..win..' в следующий раз обязательно повезёт!',false)
	end
	Game = false
	Move = false

	A1,A2,A3	= 'nil','nil','nil'
	B1,B2,B3	= 'nil','nil','nil'
	C1,C2,C3	= 'nil','nil','nil'

	xo_enemy_nick = 'nil'
end

function waitAnim()

		while true do wait(0)
			if waitAnimText == '' or waitAnimText ~= '.' then
				waitAnimText = '.'
			end
			wait(1000)
			if waitAnimText == '.' or waitAnimText ~= '..' then
				waitAnimText = '..'
			end
			wait(1000)
			if waitAnimText == '..' or waitAnimText ~= '' then
				waitAnimText = ''
			end
			wait(750)
		end

end

--------- IRC
function send(arg,msg)
    s:sendChat('#'..Channel.v, arg)
    if msgInChat.v or msg then
    	sampAddChatMessage(u8'[ZeroGame] '..Nick..':{FFFFFF} '..arg,0xffff00)
    end
end
function sendXO()
	send(('A1=%s.A2=%s.A3=%s.B1=%s.B2=%s.B3=%s.C1=%s.C2=%s.C3=%s.'):format(A1,A2,A3,B1,B2,B3,C1,C2,C3),false)

end

function irc_ping()
	while true do wait(350)

		if connected then
			s:think();

		end


	end
end




function gun(text)
	if text ~= nil or '' then
		if text:find('%d+%s+%d+') then
			local gun, pt = text:match('(%d+)%s+(%d+)')
			sampSendChat('/givegun '..getMyId()..' '..gun..' '..pt)
		else
			sampAddChatMessage('[ViceTools] {FF8C00}Некорректный ввод. [ID оружия] [Патроны]', stColor)
		end
	else
		sampAddChatMessage('[ViceTools] {FF8C00}Введите: /gun [ID оружия] [Патроны]', stColor)
	end
end
function car(text)
	lua_thread.create(function()
	if text ~= nil or '' then
		if text:find('%d+%s+%d+%s+%d+') then
			cmd_carcar, cmd_carc1, cmd_carc2 = text:match('(%d+)%s+(%d+)%s+(%d+)')
			gocar = true
			wait(1000)
			sampSendChat('/veh '..cmd_carcar..' '..cmd_carc1..' '..cmd_carc2)
			wait(500)

			gocar = false
			setCharCoordinates(PLAYER_PED, car_px, car_py, car_pz)
		else
			sampAddChatMessage('[ViceTools] {FF8C00}Некорректный ввод. [ID т/с] [Цвет1] [Цвет2]', stColor)
		end
	else
		sampAddChatMessage('[ViceTools] {FF8C00}Введите: /car [ID т/с] [Цвет1] [Цвет2]', stColor)
	end
end)
end
function ipban()
	if banipc then
		sampAddChatMessage('Отправляется в бан по айпи!', -1)
		sampSendChat('/banip '..ip..' 7 osk proekta')
		banipc = false
  end
end
function checkgm()
	lua_thread.create(function()
	checkgm = true
	wait(1000)
	sampSendChat('/agm')
	wait(300)
	checkgm = false
 end)
end

function monochrome()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 6
    style.ChildWindowRounding = 5
    style.FramePadding = imgui.ImVec2(5, 4)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    

colors[clr.Text] = ImVec4(0.00, 1.00, 1.00, 1.00)
colors[clr.TextDisabled] = ImVec4(0.00, 0.40, 0.41, 1.00)
colors[clr.WindowBg] = ImVec4(0.00, 0.00, 0.00, 1.00)

colors[clr.Border] = ImVec4(0.00, 1.00, 1.00, 0.65)
colors[clr.BorderShadow] = ImVec4(0.00, 0.00, 0.00, 0.00)
colors[clr.FrameBg] = ImVec4(0.44, 0.80, 0.80, 0.18)
colors[clr.FrameBgHovered] = ImVec4(0.44, 0.80, 0.80, 0.27)
colors[clr.FrameBgActive] = ImVec4(0.44, 0.81, 0.86, 0.66)
colors[clr.TitleBg] = ImVec4(0.14, 0.18, 0.21, 0.73)
colors[clr.TitleBgCollapsed] = ImVec4(0.00, 0.00, 0.00, 0.54)
colors[clr.TitleBgActive] = ImVec4(0.00, 1.00, 1.00, 0.27)
colors[clr.MenuBarBg] = ImVec4(0.00, 0.00, 0.00, 0.20)
colors[clr.ScrollbarBg] = ImVec4(0.22, 0.29, 0.30, 0.71)
colors[clr.ScrollbarGrab] = ImVec4(0.00, 1.00, 1.00, 0.44)
colors[clr.ScrollbarGrabHovered] = ImVec4(0.00, 1.00, 1.00, 0.74)
colors[clr.ScrollbarGrabActive] = ImVec4(0.00, 1.00, 1.00, 1.00)
colors[clr.ComboBg] = ImVec4(0.16, 0.24, 0.22, 0.60)
colors[clr.CheckMark] = ImVec4(0.00, 1.00, 1.00, 0.68)
colors[clr.SliderGrab] = ImVec4(0.00, 1.00, 1.00, 0.36)
colors[clr.SliderGrabActive] = ImVec4(0.00, 1.00, 1.00, 0.76)
colors[clr.Button] = ImVec4(buttonColor.v[1], buttonColor.v[2], buttonColor.v[3], buttonColor.v[4])
colors[clr.ButtonHovered] = ImVec4(0.01, 1.00, 1.00, 0.43)
colors[clr.ButtonActive] = ImVec4(0.00, 1.00, 1.00, 0.62)
colors[clr.Header] = ImVec4(0.00, 1.00, 1.00, 0.33)
colors[clr.HeaderHovered] = ImVec4(0.00, 1.00, 1.00, 0.42)
colors[clr.HeaderActive] = ImVec4(0.00, 1.00, 1.00, 0.54)
colors[clr.ResizeGrip] = ImVec4(0.00, 1.00, 1.00, 0.54)
colors[clr.ResizeGripHovered] = ImVec4(0.00, 1.00, 1.00, 0.74)
colors[clr.ResizeGripActive] = ImVec4(0.00, 1.00, 1.00, 1.00)
colors[clr.CloseButton] = ImVec4(0.00, 0.78, 0.78, 0.35)
colors[clr.CloseButtonHovered] = ImVec4(0.00, 0.78, 0.78, 0.47)
colors[clr.CloseButtonActive] = ImVec4(0.00, 0.78, 0.78, 1.00)
colors[clr.PlotLines] = ImVec4(0.00, 1.00, 1.00, 1.00)
colors[clr.PlotLinesHovered] = ImVec4(0.00, 1.00, 1.00, 1.00)
colors[clr.PlotHistogram] = ImVec4(0.00, 1.00, 1.00, 1.00)
colors[clr.PlotHistogramHovered] = ImVec4(0.00, 1.00, 1.00, 1.00)
colors[clr.TextSelectedBg] = ImVec4(0.00, 1.00, 1.00, 0.22)
colors[clr.ModalWindowDarkening] = ImVec4(0.04, 0.10, 0.09, 0.51)
end

function purple()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

	style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 6
    style.ChildWindowRounding = 5
    style.FramePadding = imgui.ImVec2(5, 4)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    

	colors[clr.FrameBg]                = ImVec4(0.46, 0.11, 0.29, 1.00)
    colors[clr.FrameBgHovered]         = ImVec4(0.69, 0.16, 0.43, 1.00)
    colors[clr.FrameBgActive]          = ImVec4(0.58, 0.10, 0.35, 1.00)
    colors[clr.TitleBg]                = ImVec4(0.00, 0.00, 0.00, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.61, 0.16, 0.39, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.CheckMark]              = ImVec4(0.94, 0.30, 0.63, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.85, 0.11, 0.49, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.89, 0.24, 0.58, 1.00)
    colors[clr.Button]                 = ImVec4(buttonColor.v[1], buttonColor.v[2], buttonColor.v[3], buttonColor.v[3])
    colors[clr.ButtonHovered]          = ImVec4(0.69, 0.17, 0.43, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.59, 0.10, 0.35, 1.00)
    colors[clr.Header]                 = ImVec4(0.46, 0.11, 0.29, 1.00)
    colors[clr.HeaderHovered]          = ImVec4(0.69, 0.16, 0.43, 1.00)
    colors[clr.HeaderActive]           = ImVec4(0.58, 0.10, 0.35, 1.00)
    colors[clr.Separator]              = ImVec4(0.69, 0.16, 0.43, 1.00)
    colors[clr.SeparatorHovered]       = ImVec4(0.58, 0.10, 0.35, 1.00)
    colors[clr.SeparatorActive]        = ImVec4(0.58, 0.10, 0.35, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.46, 0.11, 0.29, 0.70)
    colors[clr.ResizeGripHovered]      = ImVec4(0.69, 0.16, 0.43, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.70, 0.13, 0.42, 1.00)
    colors[clr.TextSelectedBg]         = ImVec4(1.00, 0.78, 0.90, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.60, 0.19, 0.40, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)

    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.Border]                 = ImVec4(0.49, 0.14, 0.31, 1.00)
    colors[clr.BorderShadow]           = ImVec4(0.49, 0.14, 0.31, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.15, 0.15, 0.15, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function salat()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 6
    style.ChildWindowRounding = 8
    style.FramePadding = imgui.ImVec2(5, 4)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
  

            colors[clr.Text]                 = ImVec4(1.00, 1.00, 1.00, 0.78)
            colors[clr.TextDisabled]         = ImVec4(0.36, 0.42, 0.47, 1.00)
            colors[clr.WindowBg]             = ImVec4(0.11, 0.15, 0.17, 1.00)
            
            colors[clr.PopupBg]              = ImVec4(0.08, 0.08, 0.08, 0.94)
            colors[clr.Border]               = ImVec4(0.43, 0.43, 0.50, 0.50)
            colors[clr.BorderShadow]         = ImVec4(0.00, 0.00, 0.00, 0.00)
            colors[clr.FrameBg]              = ImVec4(0.25, 0.29, 0.20, 1.00)
            colors[clr.FrameBgHovered]       = ImVec4(0.12, 0.20, 0.28, 1.00)
            colors[clr.FrameBgActive]        = ImVec4(0.09, 0.12, 0.14, 1.00)
            colors[clr.TitleBg]              = ImVec4(0.09, 0.12, 0.14, 0.65)
            colors[clr.TitleBgActive]        = ImVec4(0.35, 0.58, 0.06, 1.00)
            colors[clr.TitleBgCollapsed]     = ImVec4(0.00, 0.00, 0.00, 0.51)
            colors[clr.MenuBarBg]            = ImVec4(0.15, 0.18, 0.22, 1.00)
            colors[clr.ScrollbarBg]          = ImVec4(0.02, 0.02, 0.02, 0.39)
            colors[clr.ScrollbarGrab]        = ImVec4(0.20, 0.25, 0.29, 1.00)
            colors[clr.ScrollbarGrabHovered] = ImVec4(0.18, 0.22, 0.25, 1.00)
            colors[clr.ScrollbarGrabActive]  = ImVec4(0.09, 0.21, 0.31, 1.00)
            colors[clr.ComboBg]              = ImVec4(0.20, 0.25, 0.29, 1.00)
            colors[clr.CheckMark]            = ImVec4(0.72, 1.00, 0.28, 1.00)
            colors[clr.SliderGrab]           = ImVec4(0.43, 0.57, 0.05, 1.00)
            colors[clr.SliderGrabActive]     = ImVec4(0.55, 0.67, 0.15, 1.00)
            colors[clr.Button] = ImVec4(buttonColor.v[1], buttonColor.v[2], buttonColor.v[3], buttonColor.v[4])
            colors[clr.ButtonHovered]        = ImVec4(0.45, 0.69, 0.07, 1.00)
            colors[clr.ButtonActive]         = ImVec4(0.27, 0.50, 0.00, 1.00)
            colors[clr.Header]               = ImVec4(0.20, 0.25, 0.29, 0.55)
            colors[clr.HeaderHovered]        = ImVec4(0.72, 0.98, 0.26, 0.80)
            colors[clr.HeaderActive]         = ImVec4(0.74, 0.98, 0.26, 1.00)
            colors[clr.Separator]            = ImVec4(0.50, 0.50, 0.50, 1.00)
            colors[clr.SeparatorHovered]     = ImVec4(0.60, 0.60, 0.70, 1.00)
            colors[clr.SeparatorActive]      = ImVec4(0.70, 0.70, 0.90, 1.00)
            colors[clr.ResizeGrip]           = ImVec4(0.68, 0.98, 0.26, 0.25)
            colors[clr.ResizeGripHovered]    = ImVec4(0.72, 0.98, 0.26, 0.67)
            colors[clr.ResizeGripActive]     = ImVec4(0.06, 0.05, 0.07, 1.00)
            colors[clr.CloseButton]          = ImVec4(0.40, 0.39, 0.38, 0.16)
            colors[clr.CloseButtonHovered]   = ImVec4(0.40, 0.39, 0.38, 0.39)
            colors[clr.CloseButtonActive]    = ImVec4(0.40, 0.39, 0.38, 1.00)
            colors[clr.PlotLines]            = ImVec4(0.61, 0.61, 0.61, 1.00)
            colors[clr.PlotLinesHovered]     = ImVec4(1.00, 0.43, 0.35, 1.00)
            colors[clr.PlotHistogram]        = ImVec4(0.90, 0.70, 0.00, 1.00)
            colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
            colors[clr.TextSelectedBg]       = ImVec4(0.25, 1.00, 0.00, 0.43)
            colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
end

function gray()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2

    style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 6
    style.ChildWindowRounding = 5
    style.FramePadding = imgui.ImVec2(5, 4)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    

	colors[clr.Text]                   = ImVec4(0.90, 0.90, 0.90, 1.00)
    colors[clr.TextDisabled]           = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.00, 0.00, 0.00, 1.00)

    colors[clr.PopupBg]                = ImVec4(0.00, 0.00, 0.00, 1.00)
    colors[clr.Border]                 = ImVec4(0.82, 0.77, 0.78, 1.00)
    colors[clr.BorderShadow]           = ImVec4(0.35, 0.35, 0.35, 0.66)
    colors[clr.FrameBg]                = ImVec4(1.00, 1.00, 1.00, 0.28)
    colors[clr.FrameBgHovered]         = ImVec4(0.68, 0.68, 0.68, 0.67)
    colors[clr.FrameBgActive]          = ImVec4(0.79, 0.73, 0.73, 0.62)
    colors[clr.TitleBg]                = ImVec4(0.00, 0.00, 0.00, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.46, 0.46, 0.46, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 1.00)
    colors[clr.MenuBarBg]              = ImVec4(0.00, 0.00, 0.00, 0.80)
    colors[clr.ScrollbarBg]            = ImVec4(0.00, 0.00, 0.00, 0.60)
    colors[clr.ScrollbarGrab]          = ImVec4(1.00, 1.00, 1.00, 0.87)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(1.00, 1.00, 1.00, 0.79)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.80, 0.50, 0.50, 0.40)
    colors[clr.ComboBg]                = ImVec4(0.24, 0.24, 0.24, 0.99)
    colors[clr.CheckMark]              = ImVec4(0.99, 0.99, 0.99, 0.52)
    colors[clr.SliderGrab]             = ImVec4(1.00, 1.00, 1.00, 0.42)
    colors[clr.SliderGrabActive]       = ImVec4(0.76, 0.76, 0.76, 1.00)
    colors[clr.Button]                 = ImVec4(buttonColor.v[1], buttonColor.v[2], buttonColor.v[3], buttonColor.v[3])
    colors[clr.ButtonHovered]          = ImVec4(0.68, 0.68, 0.68, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.67, 0.67, 0.67, 1.00)
    colors[clr.Header]                 = ImVec4(0.72, 0.72, 0.72, 0.54)
    colors[clr.HeaderHovered]          = ImVec4(0.92, 0.92, 0.95, 0.77)
    colors[clr.HeaderActive]           = ImVec4(0.82, 0.82, 0.82, 0.80)
    colors[clr.Separator]              = ImVec4(0.73, 0.73, 0.73, 1.00)
    colors[clr.SeparatorHovered]       = ImVec4(0.81, 0.81, 0.81, 1.00)
    colors[clr.SeparatorActive]        = ImVec4(0.74, 0.74, 0.74, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.80, 0.80, 0.80, 0.30)
    colors[clr.ResizeGripHovered]      = ImVec4(0.95, 0.95, 0.95, 0.60)
    colors[clr.ResizeGripActive]       = ImVec4(1.00, 1.00, 1.00, 0.90)
    colors[clr.CloseButton]            = ImVec4(0.45, 0.45, 0.45, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.70, 0.70, 0.90, 0.60)
    colors[clr.CloseButtonActive]      = ImVec4(0.70, 0.70, 0.70, 1.00)
    colors[clr.PlotLines]              = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextSelectedBg]         = ImVec4(1.00, 1.00, 1.00, 0.35)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.88, 0.88, 0.88, 0.35)
end
function translite(text)
	for k, v in pairs(chars) do
		text = string.gsub(text, k, v)
	end
	return text
end

function blackred()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
    local ImVec2 = imgui.ImVec2

    style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 6
    style.ChildWindowRounding = 5
    style.FramePadding = imgui.ImVec2(5, 4)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    

    colors[clr.Text]                   = ImVec4(0.95, 0.96, 0.98, 1.00);
    colors[clr.TextDisabled]           = ImVec4(0.29, 0.29, 0.29, 1.00);
    colors[clr.WindowBg]               = ImVec4(0.14, 0.14, 0.14, 1.00);

    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94);
    colors[clr.Border]                 = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.BorderShadow]           = ImVec4(1.00, 1.00, 1.00, 0.10);
    colors[clr.FrameBg]                = ImVec4(0.22, 0.22, 0.22, 1.00);
    colors[clr.FrameBgHovered]         = ImVec4(0.18, 0.18, 0.18, 1.00);
    colors[clr.FrameBgActive]          = ImVec4(0.09, 0.12, 0.14, 1.00);
    colors[clr.TitleBg]                = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.TitleBgActive]          = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.TitleBgCollapsed]       = ImVec4(0.14, 0.14, 0.14, 1.00);
    colors[clr.MenuBarBg]              = ImVec4(0.20, 0.20, 0.20, 1.00);
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.39);
    colors[clr.ScrollbarGrab]          = ImVec4(0.36, 0.36, 0.36, 1.00);
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.18, 0.22, 0.25, 1.00);
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[clr.ComboBg]                = ImVec4(0.24, 0.24, 0.24, 1.00);
    colors[clr.CheckMark]              = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.SliderGrab]             = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.SliderGrabActive]       = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.Button]                 = ImVec4(buttonColor.v[1], buttonColor.v[2], buttonColor.v[3], buttonColor.v[3])
    colors[clr.ButtonHovered]          = ImVec4(1.00, 0.39, 0.39, 1.00);
    colors[clr.ButtonActive]           = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.Header]                 = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.HeaderHovered]          = ImVec4(1.00, 0.39, 0.39, 1.00);
    colors[clr.HeaderActive]           = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.ResizeGrip]             = ImVec4(1.00, 0.28, 0.28, 1.00);
    colors[clr.ResizeGripHovered]      = ImVec4(1.00, 0.39, 0.39, 1.00);
    colors[clr.ResizeGripActive]       = ImVec4(1.00, 0.19, 0.19, 1.00);
    colors[clr.CloseButton]            = ImVec4(0.40, 0.39, 0.38, 0.16);
    colors[clr.CloseButtonHovered]     = ImVec4(0.40, 0.39, 0.38, 0.39);
    colors[clr.CloseButtonActive]      = ImVec4(0.40, 0.39, 0.38, 1.00);
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00);
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00);
    colors[clr.PlotHistogram]          = ImVec4(1.00, 0.21, 0.21, 1.00);
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.18, 0.18, 1.00);
    colors[clr.TextSelectedBg]         = ImVec4(1.00, 0.32, 0.32, 1.00);
    colors[clr.ModalWindowDarkening]   = ImVec4(0.26, 0.26, 0.26, 0.60);
end

function violet()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
	style.Alpha = 1.00

    style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 6
    style.ChildWindowRounding = 5
    style.FramePadding = imgui.ImVec2(5, 4)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    

    colors[clr.FrameBg]                = ImVec4(0.442, 0.115, 0.718, 0.540)
    colors[clr.FrameBgHovered]         = ImVec4(0.389, 0.190, 0.718, 0.400)
    colors[clr.FrameBgActive]          = ImVec4(0.441, 0.125, 0.840, 0.670)
    colors[clr.TitleBg]                = ImVec4(0.557, 0.143, 0.702, 1.000)
    colors[clr.TitleBgActive]          = ImVec4(0.557, 0.143, 0.702, 1.000)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.557, 0.143, 0.702, 1.000)
    colors[clr.CheckMark]              = ImVec4(0.643, 0.190, 0.862, 1.000)
    colors[clr.SliderGrab]             = ImVec4(0.434, 0.100, 0.757, 1.000)
    colors[clr.SliderGrabActive]       = ImVec4(0.434, 0.100, 0.757, 1.000)
    colors[clr.Button]                 = ImVec4(buttonColor.v[1], buttonColor.v[2], buttonColor.v[3], buttonColor.v[3])
    colors[clr.ButtonHovered]          = ImVec4(0.508, 0.000, 1.000, 1.000)
    colors[clr.ButtonActive]           = ImVec4(0.508, 0.000, 1.000, 1.000)
    colors[clr.Header]                 = ImVec4(0.628, 0.098, 0.884, 0.310)
    colors[clr.HeaderHovered]          = ImVec4(0.695, 0.000, 0.983, 0.800)
    colors[clr.HeaderActive]           = ImVec4(0.695, 0.000, 0.983, 0.800)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.644, 0.021, 0.945, 0.800)
    colors[clr.ResizeGripHovered]      = ImVec4(0.644, 0.021, 0.945, 0.800)
    colors[clr.ResizeGripActive]       = ImVec4(0.644, 0.021, 0.945, 0.800)
    colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)

    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end
function setTime(param)
    local hour = tonumber(param)
    if hour ~= nil and hour >= 0 and hour <= 23 then
      setTimes = hour
      patch_samp_time_set(true)
    else
      patch_samp_time_set(false)
      setTimes = nil
    end
  end
  
  function setWeather(param)
    local bs = raknetNewBitStream()
        raknetBitStreamWriteInt8(bs, param)
        raknetEmulRpcReceiveBitStream(152, bs)
        raknetDeleteBitStream(bs)
  end
  
  
  --- Functions
  function patch_samp_time_set(enable)
      if enable and default == nil then
          default = readMemory(sampGetBase() + 0x9C0A0, 4, true)
          writeMemory(sampGetBase() + 0x9C0A0, 4, 0x000008C2, true)
      elseif enable == false and default ~= nil then
          writeMemory(sampGetBase() + 0x9C0A0, 4, default, true)
          default = nil
      end
  end
  
function blue()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4
	style.Alpha = 1.00

    style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 6
    style.ChildWindowRounding = 5
    style.FramePadding = imgui.ImVec2(5, 4)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    

    colors[clr.Text]                 = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]         = ImVec4(0.73, 0.75, 0.74, 1.00)
    colors[clr.WindowBg]             = ImVec4(0.00, 0.00, 0.00, 0.94)

    colors[clr.PopupBg]              = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.Border]               = ImVec4(0.20, 0.20, 0.20, 0.50)
    colors[clr.BorderShadow]         = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.FrameBg]              = ImVec4(0.26, 0.37, 0.98, 0.54)
    colors[clr.FrameBgHovered]       = ImVec4(0.33, 0.33, 0.93, 0.40)
    colors[clr.FrameBgActive]        = ImVec4(0.44, 0.44, 0.99, 0.67)
    colors[clr.TitleBg]              = ImVec4(0.30, 0.33, 0.95, 0.67)
    colors[clr.TitleBgActive]        = ImVec4(0.00, 0.16, 1.00, 1.00)
    colors[clr.TitleBgCollapsed]     = ImVec4(0.22, 0.19, 1.00, 0.67)
    colors[clr.MenuBarBg]            = ImVec4(0.39, 0.56, 1.00, 1.00)
    colors[clr.ScrollbarBg]          = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]        = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered] = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]  = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.ComboBg]              = ImVec4(0.20, 0.20, 0.20, 0.99)
    colors[clr.CheckMark]            = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.SliderGrab]           = ImVec4(0.30, 0.41, 0.99, 1.00)
    colors[clr.SliderGrabActive]     = ImVec4(0.52, 0.52, 0.97, 1.00)
    colors[clr.Button] = ImVec4(buttonColor.v[1], buttonColor.v[2], buttonColor.v[3], buttonColor.v[4])
    colors[clr.ButtonHovered]        = ImVec4(0.41, 0.57, 1.00, 0.65)
    colors[clr.ButtonActive]         = ImVec4(0.20, 0.20, 0.20, 0.50)
    colors[clr.Header]               = ImVec4(0.15, 0.19, 1.00, 0.54)
    colors[clr.HeaderHovered]        = ImVec4(0.03, 0.24, 0.57, 0.65)
    colors[clr.HeaderActive]         = ImVec4(0.36, 0.40, 0.95, 0.00)
    colors[clr.Separator]            = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.SeparatorHovered]     = ImVec4(0.20, 0.42, 0.98, 0.54)
    colors[clr.SeparatorActive]      = ImVec4(0.20, 0.40, 0.93, 0.54)
    colors[clr.ResizeGrip]           = ImVec4(0.01, 0.17, 1.00, 0.54)
    colors[clr.ResizeGripHovered]    = ImVec4(0.21, 0.51, 0.98, 0.45)
    colors[clr.ResizeGripActive]     = ImVec4(0.04, 0.55, 0.95, 0.66)
    colors[clr.CloseButton]          = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.CloseButtonHovered]   = ImVec4(0.10, 0.21, 0.98, 1.00)
    colors[clr.CloseButtonActive]    = ImVec4(0.02, 0.26, 1.00, 1.00)
    colors[clr.PlotLines]            = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]     = ImVec4(0.18, 0.15, 1.00, 1.00)
    colors[clr.PlotHistogram]        = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.TextSelectedBg]       = ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.ModalWindowDarkening] = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function brown()
   imgui.SwitchContext()
   local style = imgui.GetStyle()
   local colors = style.Colors
   local clr = imgui.Col
   local ImVec4 = imgui.ImVec4

   style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 6
    style.ChildWindowRounding = 5
    style.FramePadding = imgui.ImVec2(5, 4)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    

   colors[clr.FrameBg]                = ImVec4(0.48, 0.23, 0.16, 0.54)
   colors[clr.FrameBgHovered]         = ImVec4(0.98, 0.43, 0.26, 0.40)
   colors[clr.FrameBgActive]          = ImVec4(0.98, 0.43, 0.26, 0.67)
   colors[clr.TitleBg]                = ImVec4(0.48, 0.23, 0.16, 1.00)
   colors[clr.TitleBgActive]          = ImVec4(0.48, 0.23, 0.16, 1.00)
   colors[clr.TitleBgCollapsed]       = ImVec4(0.48, 0.23, 0.16, 1.00)
   colors[clr.CheckMark]              = ImVec4(0.98, 0.43, 0.26, 1.00)
   colors[clr.SliderGrab]             = ImVec4(0.88, 0.39, 0.24, 1.00)
   colors[clr.SliderGrabActive]       = ImVec4(0.98, 0.43, 0.26, 1.00)
   colors[clr.Button]                 = ImVec4(buttonColor.v[1], buttonColor.v[2], buttonColor.v[3], buttonColor.v[3])
   colors[clr.ButtonHovered]          = ImVec4(0.98, 0.43, 0.26, 1.00)
   colors[clr.ButtonActive]           = ImVec4(0.98, 0.28, 0.06, 1.00)
   colors[clr.Header]                 = ImVec4(0.98, 0.43, 0.26, 0.31)
   colors[clr.HeaderHovered]          = ImVec4(0.98, 0.43, 0.26, 0.80)
   colors[clr.HeaderActive]           = ImVec4(0.98, 0.43, 0.26, 1.00)
   colors[clr.Separator]              = colors[clr.Border]
   colors[clr.SeparatorHovered]       = ImVec4(0.75, 0.25, 0.10, 0.78)
   colors[clr.SeparatorActive]        = ImVec4(0.75, 0.25, 0.10, 1.00)
   colors[clr.ResizeGrip]             = ImVec4(0.98, 0.43, 0.26, 0.25)
   colors[clr.ResizeGripHovered]      = ImVec4(0.98, 0.43, 0.26, 0.67)
   colors[clr.ResizeGripActive]       = ImVec4(0.98, 0.43, 0.26, 0.95)
   colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
   colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.50, 0.35, 1.00)
   colors[clr.TextSelectedBg]         = ImVec4(0.98, 0.43, 0.26, 0.35)
   colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
   colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
   colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
       
   colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
   colors[clr.ComboBg]                = colors[clr.PopupBg]
   colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
   colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
   colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
   colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
   colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
   colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
   colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
   colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
   colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
   colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
   colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
   colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
   colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function red()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 6
    style.ChildWindowRounding = 5
    style.FramePadding = imgui.ImVec2(5, 4)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    

    colors[clr.FrameBg]                = ImVec4(0.48, 0.16, 0.16, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.98, 0.26, 0.26, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.98, 0.26, 0.26, 0.67)
    colors[clr.TitleBg]                = ImVec4(0.48, 0.16, 0.16, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.48, 0.16, 0.16, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.48, 0.16, 0.16, 1.00)
    colors[clr.CheckMark]              = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.88, 0.26, 0.24, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.Button]                 = ImVec4(buttonColor.v[1], buttonColor.v[2], buttonColor.v[3], buttonColor.v[3])
    colors[clr.ButtonHovered]          = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.98, 0.06, 0.06, 1.00)
    colors[clr.Header]                 = ImVec4(0.98, 0.26, 0.26, 0.31)
    colors[clr.HeaderHovered]          = ImVec4(0.98, 0.26, 0.26, 0.80)
    colors[clr.HeaderActive]           = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.75, 0.10, 0.10, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.75, 0.10, 0.10, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.98, 0.26, 0.26, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.98, 0.26, 0.26, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.98, 0.26, 0.26, 0.95)
    colors[clr.TextSelectedBg]         = ImVec4(0.98, 0.26, 0.26, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
        
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end


function lightblue()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 6
    style.ChildWindowRounding = 5
    style.FramePadding = imgui.ImVec2(5, 4)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    

colors[clr.Text]   = ImVec4(0.00, 0.00, 0.00, 0.51)
colors[clr.TextDisabled]   = ImVec4(0.24, 0.24, 0.24, 1.00)
colors[clr.WindowBg]              = ImVec4(1.00, 1.00, 1.00, 1.00)
        
colors[clr.PopupBg]               = ImVec4(0.92, 0.92, 0.92, 1.00)
colors[clr.Border]                = ImVec4(0.86, 0.86, 0.86, 1.00)
colors[clr.BorderShadow]          = ImVec4(0.00, 0.00, 0.00, 0.00)
colors[clr.FrameBg]               = ImVec4(0.88, 0.88, 0.88, 1.00)
colors[clr.FrameBgHovered]        = ImVec4(0.82, 0.82, 0.82, 1.00)
colors[clr.FrameBgActive]         = ImVec4(0.76, 0.76, 0.76, 1.00)
colors[clr.TitleBg]               = ImVec4(0.00, 0.45, 1.00, 0.82)
colors[clr.TitleBgCollapsed]      = ImVec4(0.00, 0.45, 1.00, 0.82)
colors[clr.TitleBgActive]         = ImVec4(0.00, 0.45, 1.00, 0.82)
colors[clr.MenuBarBg]             = ImVec4(0.00, 0.37, 0.78, 1.00)
colors[clr.ScrollbarBg]           = ImVec4(0.00, 0.00, 0.00, 0.00)
colors[clr.ScrollbarGrab]         = ImVec4(0.00, 0.35, 1.00, 0.78)
colors[clr.ScrollbarGrabHovered]  = ImVec4(0.00, 0.33, 1.00, 0.84)
colors[clr.ScrollbarGrabActive]   = ImVec4(0.00, 0.31, 1.00, 0.88)
colors[clr.ComboBg]               = ImVec4(0.92, 0.92, 0.92, 1.00)
colors[clr.CheckMark]             = ImVec4(0.00, 0.49, 1.00, 0.59)
colors[clr.SliderGrab]            = ImVec4(0.00, 0.49, 1.00, 0.59)
colors[clr.SliderGrabActive]      = ImVec4(0.00, 0.39, 1.00, 0.71)
colors[clr.Button] = ImVec4(buttonColor.v[1], buttonColor.v[2], buttonColor.v[3], buttonColor.v[4])
colors[clr.ButtonHovered]         = ImVec4(0.00, 0.49, 1.00, 0.71)
colors[clr.ButtonActive]          = ImVec4(0.00, 0.49, 1.00, 0.78)
colors[clr.Header]                = ImVec4(0.00, 0.49, 1.00, 0.78)
colors[clr.HeaderHovered]         = ImVec4(0.00, 0.49, 1.00, 0.71)
colors[clr.HeaderActive]          = ImVec4(0.00, 0.49, 1.00, 0.78)
colors[clr.ResizeGrip]            = ImVec4(0.00, 0.39, 1.00, 0.59)
colors[clr.ResizeGripHovered]     = ImVec4(0.00, 0.27, 1.00, 0.59)
colors[clr.ResizeGripActive]      = ImVec4(0.00, 0.25, 1.00, 0.63)
colors[clr.CloseButton]           = ImVec4(0.00, 0.35, 0.96, 0.71)
colors[clr.CloseButtonHovered]    = ImVec4(0.00, 0.31, 0.88, 0.69)
colors[clr.CloseButtonActive]     = ImVec4(0.00, 0.25, 0.88, 0.67)
colors[clr.PlotLines]             = ImVec4(0.00, 0.39, 1.00, 0.75)
colors[clr.PlotLinesHovered]      = ImVec4(0.00, 0.39, 1.00, 0.75)
colors[clr.PlotHistogram]         = ImVec4(0.00, 0.39, 1.00, 0.75)
colors[clr.PlotHistogramHovered]  = ImVec4(0.00, 0.35, 0.92, 0.78)
colors[clr.TextSelectedBg]        = ImVec4(0.00, 0.47, 1.00, 0.59)
colors[clr.ModalWindowDarkening]  = ImVec4(0.20, 0.20, 0.20, 0.35)
end
function standart_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowRounding = 2.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
    style.ChildWindowRounding = 2.0
    style.FrameRounding = 2.0
    style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
    style.ScrollbarSize = 13.0
    style.ScrollbarRounding = 0
    style.GrabMinSize = 8.0
    style.GrabRounding = 1.0

    colors[clr.FrameBg]                = ImVec4(0.16, 0.29, 0.48, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.59, 0.98, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.16, 0.29, 0.48, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.CheckMark]              = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.24, 0.52, 0.88, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.Button]                 = ImVec4(buttonColor.v[1], buttonColor.v[2], buttonColor.v[3], buttonColor.v[4])
    colors[clr.ButtonHovered]          = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.06, 0.53, 0.98, 1.00)
    colors[clr.Header]                 = ImVec4(0.26, 0.59, 0.98, 0.31)
    colors[clr.HeaderHovered]          = ImVec4(0.26, 0.59, 0.98, 0.80)
    colors[clr.HeaderActive]           = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.26, 0.59, 0.98, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.59, 0.98, 0.95)
    colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
    colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function apply_custom_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 6
    style.ChildWindowRounding = 5
    style.FramePadding = imgui.ImVec2(5, 4)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
    
     imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    

	colors[clr.Text]                   = ImVec4(0.96, 0.59, 0.11, 1.00);
    colors[clr.TextDisabled]           = ImVec4(1.00, 0.00, 0.00, 1.00);
    colors[clr.WindowBg]               = ImVec4(0.10, 0.02, 0.02, 0.97);
         
    colors[clr.PopupBg]                = ImVec4(0.10, 0.03, 0.02, 0.90);
    colors[clr.Border]                 = ImVec4(1.00, 0.79, 0.00, 0.40);
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00);
    colors[clr.FrameBg]                = ImVec4(0.40, 0.12, 0.21, 0.15);
    colors[clr.FrameBgHovered]         = ImVec4(0.98, 0.00, 0.00, 0.40);
    colors[clr.FrameBgActive]          = ImVec4(0.96, 0.64, 0.02, 0.45);
    colors[clr.TitleBg]                = ImVec4(1.00, 0.53, 0.00, 0.83);
    colors[clr.TitleBgActive]          = ImVec4(0.80, 0.30, 0.08, 0.79);
    colors[clr.TitleBgCollapsed]       = ImVec4(1.00, 0.00, 0.00, 0.20);
    colors[clr.MenuBarBg]              = ImVec4(0.79, 0.20, 0.12, 0.80);
    colors[clr.ScrollbarBg]            = ImVec4(0.90, 0.72, 0.07, 0.13);
    colors[clr.ScrollbarGrab]          = ImVec4(1.00, 0.69, 0.00, 0.30);
    colors[clr.ScrollbarGrabHovered]   = ImVec4(1.00, 0.00, 0.00, 0.40);
    colors[clr.ScrollbarGrabActive]    = ImVec4(1.00, 0.00, 0.03, 0.40);
    colors[clr.ComboBg]                = ImVec4(0.52, 0.07, 0.07, 0.99);
    colors[clr.CheckMark]              = ImVec4(0.87, 1.00, 0.00, 0.50);
    colors[clr.SliderGrab]             = ImVec4(1.00, 0.47, 0.00, 1.00);
    colors[clr.SliderGrabActive]       = ImVec4(1.00, 0.00, 0.00, 1.00);
    colors[clr.Button]                 = ImVec4(buttonColor.v[1], buttonColor.v[2], buttonColor.v[3], buttonColor.v[3])
    colors[clr.ButtonHovered]          = ImVec4(0.87, 0.09, 0.09, 1.00);
    colors[clr.ButtonActive]           = ImVec4(0.74, 0.79, 0.05, 1.00);
    colors[clr.Header]                 = ImVec4(1.00, 0.44, 0.00, 0.45);
    colors[clr.HeaderHovered]          = ImVec4(0.96, 0.06, 0.26, 0.80);
    colors[clr.HeaderActive]           = ImVec4(1.00, 0.97, 0.00, 0.80);
    colors[clr.Separator]              = ImVec4(0.58, 0.09, 0.09, 1.00);
    colors[clr.SeparatorHovered]       = ImVec4(0.65, 0.29, 0.17, 1.00);
    colors[clr.SeparatorActive]        = ImVec4(0.63, 0.08, 0.10, 1.00);
    colors[clr.ResizeGrip]             = ImVec4(0.50, 0.07, 0.07, 0.30);
    colors[clr.ResizeGripHovered]      = ImVec4(0.43, 0.06, 0.06, 0.60);
    colors[clr.ResizeGripActive]       = ImVec4(0.32, 0.06, 0.06, 0.90);
    colors[clr.CloseButton]            = ImVec4(0.34, 0.08, 0.08, 0.79);
    colors[clr.CloseButtonHovered]     = ImVec4(0.29, 0.06, 0.06, 0.60);
    colors[clr.CloseButtonActive]      = ImVec4(0.23, 0.03, 0.05, 1.00);
    colors[clr.PlotLines]              = ImVec4(0.38, 0.15, 0.15, 1.00);
    colors[clr.PlotLinesHovered]       = ImVec4(0.30, 0.08, 0.13, 1.00);
    colors[clr.PlotHistogram]          = ImVec4(0.32, 0.06, 0.08, 1.00);
    colors[clr.PlotHistogramHovered]   = ImVec4(0.26, 0.06, 0.07, 1.00);
    colors[clr.TextSelectedBg]         = ImVec4(0.94, 0.37, 0.03, 0.35);
    colors[clr.ModalWindowDarkening]   = ImVec4(0.42, 0.14, 0.14, 0.35);
end

function black()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 6
    style.ChildWindowRounding = 5
    style.FramePadding = imgui.ImVec2(5, 4)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
   imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    


  colors[clr.Text] = ImVec4(0.80, 0.80, 0.83, 1.00)
  colors[clr.TextDisabled] = ImVec4(0.24, 0.23, 0.29, 1.00)
  colors[clr.WindowBg] = ImVec4(0.06, 0.05, 0.07, 1.00)

  colors[clr.PopupBg] = ImVec4(0.07, 0.07, 0.09, 1.00)
  colors[clr.Border] = ImVec4(0.80, 0.80, 0.83, 0.88)
  colors[clr.BorderShadow] = ImVec4(0.92, 0.91, 0.88, 0.00)
  colors[clr.FrameBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
  colors[clr.FrameBgHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
  colors[clr.FrameBgActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
  colors[clr.TitleBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
  colors[clr.TitleBgCollapsed] = ImVec4(1.00, 0.98, 0.95, 0.75)
  colors[clr.TitleBgActive] = ImVec4(0.07, 0.07, 0.09, 1.00)
  colors[clr.MenuBarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
  colors[clr.ScrollbarBg] = ImVec4(0.10, 0.09, 0.12, 1.00)
  colors[clr.ScrollbarGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
  colors[clr.ScrollbarGrabHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
  colors[clr.ScrollbarGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
  colors[clr.ComboBg] = ImVec4(0.19, 0.18, 0.21, 1.00)
  colors[clr.CheckMark] = ImVec4(0.80, 0.80, 0.83, 0.31)
  colors[clr.SliderGrab] = ImVec4(0.80, 0.80, 0.83, 0.31)
  colors[clr.SliderGrabActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
  colors[clr.Button] = ImVec4(buttonColor.v[1], buttonColor.v[2], buttonColor.v[3], buttonColor.v[4])
  colors[clr.ButtonHovered] = ImVec4(0.24, 0.23, 0.29, 1.00)
  colors[clr.ButtonActive] = ImVec4(0.56, 0.56, 0.58, 1.00)
  colors[clr.Header] = ImVec4(0.10, 0.09, 0.12, 1.00)
  colors[clr.HeaderHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
  colors[clr.HeaderActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
  colors[clr.ResizeGrip] = ImVec4(0.00, 0.00, 0.00, 0.00)
  colors[clr.ResizeGripHovered] = ImVec4(0.56, 0.56, 0.58, 1.00)
  colors[clr.ResizeGripActive] = ImVec4(0.06, 0.05, 0.07, 1.00)
  colors[clr.CloseButton] = ImVec4(0.40, 0.39, 0.38, 0.16)
  colors[clr.CloseButtonHovered] = ImVec4(0.40, 0.39, 0.38, 0.39)
  colors[clr.CloseButtonActive] = ImVec4(0.40, 0.39, 0.38, 1.00)
  colors[clr.PlotLines] = ImVec4(0.40, 0.39, 0.38, 0.63)
  colors[clr.PlotLinesHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
  colors[clr.PlotHistogram] = ImVec4(0.40, 0.39, 0.38, 0.63)
  colors[clr.PlotHistogramHovered] = ImVec4(0.25, 1.00, 0.00, 1.00)
  colors[clr.TextSelectedBg] = ImVec4(0.25, 1.00, 0.00, 0.43)
  colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
end

function yellow()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 6
    style.ChildWindowRounding = 5
    style.FramePadding = imgui.ImVec2(5, 4)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    

    colors[clr.Text]                 = ImVec4(0.92, 0.92, 0.92, 1.00)
    colors[clr.TextDisabled]         = ImVec4(0.44, 0.44, 0.44, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.08, 0.08, 0.08, 1.00)

    colors[clr.PopupBg]              = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]              = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.Border]               = ImVec4(0.51, 0.36, 0.15, 1.00)
    colors[clr.BorderShadow]         = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.FrameBg]              = ImVec4(0.11, 0.11, 0.11, 1.00)
    colors[clr.FrameBgHovered]       = ImVec4(0.51, 0.36, 0.15, 1.00)
    colors[clr.FrameBgActive]        = ImVec4(0.78, 0.55, 0.21, 1.00)
    colors[clr.TitleBg]              = ImVec4(0.51, 0.36, 0.15, 1.00)
    colors[clr.TitleBgActive]        = ImVec4(0.91, 0.64, 0.13, 1.00)
    colors[clr.TitleBgCollapsed]     = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.MenuBarBg]            = ImVec4(0.11, 0.11, 0.11, 1.00)
    colors[clr.ScrollbarBg]          = ImVec4(0.06, 0.06, 0.06, 0.53)
    colors[clr.ScrollbarGrab]        = ImVec4(0.21, 0.21, 0.21, 1.00)
    colors[clr.ScrollbarGrabHovered] = ImVec4(0.47, 0.47, 0.47, 1.00)
    colors[clr.ScrollbarGrabActive]  = ImVec4(0.81, 0.83, 0.81, 1.00)
    colors[clr.CheckMark]            = ImVec4(0.78, 0.55, 0.21, 1.00)
    colors[clr.SliderGrab]           = ImVec4(0.91, 0.64, 0.13, 1.00)
    colors[clr.SliderGrabActive]     = ImVec4(0.91, 0.64, 0.13, 1.00)
    colors[clr.Button] = ImVec4(buttonColor.v[1], buttonColor.v[2], buttonColor.v[3], buttonColor.v[4])
    colors[clr.ButtonHovered]        = ImVec4(0.91, 0.64, 0.13, 1.00)
    colors[clr.ButtonActive]         = ImVec4(0.78, 0.55, 0.21, 1.00)
    colors[clr.Header]               = ImVec4(0.51, 0.36, 0.15, 1.00)
    colors[clr.HeaderHovered]        = ImVec4(0.91, 0.64, 0.13, 1.00)
    colors[clr.HeaderActive]         = ImVec4(0.93, 0.65, 0.14, 1.00)
    colors[clr.Separator]            = ImVec4(0.21, 0.21, 0.21, 1.00)
    colors[clr.SeparatorHovered]     = ImVec4(0.91, 0.64, 0.13, 1.00)
    colors[clr.SeparatorActive]      = ImVec4(0.78, 0.55, 0.21, 1.00)
    colors[clr.ResizeGrip]           = ImVec4(0.21, 0.21, 0.21, 1.00)
    colors[clr.ResizeGripHovered]    = ImVec4(0.91, 0.64, 0.13, 1.00)
    colors[clr.ResizeGripActive]     = ImVec4(0.78, 0.55, 0.21, 1.00)
    colors[clr.CloseButton]          = ImVec4(0.47, 0.47, 0.47, 1.00)
    colors[clr.CloseButtonHovered]   = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]    = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotLines]            = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]     = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]        = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.TextSelectedBg]       = ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.ModalWindowDarkening] = ImVec4(0.80, 0.80, 0.80, 0.35)
end
function did()
    msg(sampGetCurrentDialogId())
end
function orange()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 6
    style.ChildWindowRounding = 5
    style.FramePadding = imgui.ImVec2(5, 4)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    

colors[clr.Text]                 = ImVec4(1.00, 1.00, 1.00, 1.00)

colors[clr.TextDisabled]         = ImVec4(0.73, 0.75, 0.74, 1.00)

colors[clr.WindowBg]             = ImVec4(1.00, 0.56, 0.10, 0.94)



colors[clr.PopupBg]              = ImVec4(0.08, 0.08, 0.08, 0.94)

colors[clr.Border]               = ImVec4(0.00, 0.00, 0.00, 0.50)

colors[clr.BorderShadow]         = ImVec4(0.00, 0.00, 0.00, 0.00)

colors[clr.FrameBg]              = ImVec4(0.18, 0.54, 1.00, 0.58)

colors[clr.FrameBgHovered]       = ImVec4(0.00, 0.00, 0.00, 0.40)

colors[clr.FrameBgActive]        = ImVec4(0.84, 0.66, 0.66, 0.67)

colors[clr.TitleBg]              = ImVec4(0.00, 0.00, 0.00, 0.67)

colors[clr.TitleBgActive]        = ImVec4(0.47, 0.22, 0.22, 1.00)

colors[clr.TitleBgCollapsed]     = ImVec4(0.47, 0.22, 0.22, 0.67)

colors[clr.MenuBarBg]            = ImVec4(0.00, 0.00, 0.00, 1.00)

colors[clr.ScrollbarBg]          = ImVec4(0.00, 0.00, 0.00, 0.53)

colors[clr.ScrollbarGrab]        = ImVec4(0.31, 0.31, 0.31, 1.00)

colors[clr.ScrollbarGrabHovered] = ImVec4(0.41, 0.41, 0.41, 1.00)

colors[clr.ScrollbarGrabActive]  = ImVec4(0.51, 0.51, 0.51, 1.00)

colors[clr.ComboBg]              = ImVec4(0.00, 0.00, 0.00, 0.99)

colors[clr.CheckMark]            = ImVec4(1.00, 0.86, 0.86, 1.00)

colors[clr.SliderGrab]           = ImVec4(1.00, 0.65, 0.07, 1.00)

colors[clr.SliderGrabActive]     = ImVec4(0.84, 0.66, 0.66, 1.00)

colors[clr.Button] = ImVec4(buttonColor.v[1], buttonColor.v[2], buttonColor.v[3], buttonColor.v[4])

colors[clr.ButtonHovered]        = ImVec4(0.71, 0.39, 0.39, 0.65)

colors[clr.ButtonActive]         = ImVec4(0.00, 0.00, 0.00, 0.50)

colors[clr.Header]               = ImVec4(0.00, 0.00, 0.00, 0.54)

colors[clr.HeaderHovered]        = ImVec4(0.84, 0.66, 0.66, 0.65)

colors[clr.HeaderActive]         = ImVec4(0.84, 0.66, 0.66, 0.00)

colors[clr.Separator]            = ImVec4(0.43, 0.43, 0.50, 0.50)

colors[clr.SeparatorHovered]     = ImVec4(0.71, 0.39, 0.39, 0.54)

colors[clr.SeparatorActive]      = ImVec4(0.71, 0.39, 0.39, 0.54)

colors[clr.ResizeGrip]           = ImVec4(0.71, 0.39, 0.39, 0.54)

colors[clr.ResizeGripHovered]    = ImVec4(0.84, 0.66, 0.66, 0.66)

colors[clr.ResizeGripActive]     = ImVec4(0.84, 0.66, 0.66, 0.66)

colors[clr.CloseButton]          = ImVec4(0.41, 0.41, 0.41, 1.00)

colors[clr.CloseButtonHovered]   = ImVec4(0.98, 0.39, 0.36, 1.00)

colors[clr.CloseButtonActive]    = ImVec4(0.98, 0.39, 0.36, 1.00)

colors[clr.PlotLines]            = ImVec4(0.60, 0.60, 0.60, 1.00)

colors[clr.PlotLinesHovered]     = ImVec4(1.00, 0.43, 0.35, 1.00)

colors[clr.PlotHistogram]        = ImVec4(0.90, 0.70, 0.00, 1.00)

colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)

colors[clr.TextSelectedBg]       = ImVec4(0.26, 0.59, 0.98, 0.35)

colors[clr.ModalWindowDarkening] = ImVec4(0.80, 0.80, 0.80, 0.35)

end

function glamurnoroz()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 6
    style.ChildWindowRounding = 5
    style.FramePadding = imgui.ImVec2(5, 4)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    

	colors[clr.Text]                 = ImVec4(0.00, 0.00, 0.00, 1.00)
    colors[clr.TextDisabled]         = ImVec4(0.22, 0.22, 0.22, 1.00)
    colors[clr.WindowBg]             = ImVec4(1.00, 1.00, 1.00, 0.71)

    colors[clr.PopupBg]              = ImVec4(1.00, 1.00, 1.00, 0.94)
    colors[clr.Border]               = ImVec4(1.00, 1.00, 1.00, 0.50)
    colors[clr.BorderShadow]         = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.FrameBg]              = ImVec4(0.77, 0.49, 0.66, 0.54)
    colors[clr.FrameBgHovered]       = ImVec4(1.00, 1.00, 1.00, 0.40)
    colors[clr.FrameBgActive]        = ImVec4(1.00, 1.00, 1.00, 0.67)
    colors[clr.TitleBg]              = ImVec4(0.76, 0.51, 0.66, 0.71)
    colors[clr.TitleBgActive]        = ImVec4(0.97, 0.74, 0.88, 0.74)
    colors[clr.TitleBgCollapsed]     = ImVec4(1.00, 1.00, 1.00, 0.67)
    colors[clr.MenuBarBg]            = ImVec4(1.00, 1.00, 1.00, 0.54)
    colors[clr.ScrollbarBg]          = ImVec4(0.81, 0.81, 0.81, 0.54)
    colors[clr.ScrollbarGrab]        = ImVec4(0.78, 0.28, 0.58, 0.13)
    colors[clr.ScrollbarGrabHovered] = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.ScrollbarGrabActive]  = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.ComboBg]              = ImVec4(0.20, 0.20, 0.20, 0.99)
    colors[clr.CheckMark]            = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.SliderGrab]           = ImVec4(0.71, 0.39, 0.39, 1.00)
    colors[clr.SliderGrabActive]     = ImVec4(0.76, 0.51, 0.66, 0.46)
    colors[clr.Button] = ImVec4(buttonColor.v[1], buttonColor.v[2], buttonColor.v[3], buttonColor.v[4])
    colors[clr.ButtonHovered]        = ImVec4(0.77, 0.52, 0.67, 0.54)
    colors[clr.ButtonActive]         = ImVec4(0.20, 0.20, 0.20, 0.50)
    colors[clr.Header]               = ImVec4(0.78, 0.28, 0.58, 0.54)
    colors[clr.HeaderHovered]        = ImVec4(0.78, 0.28, 0.58, 0.25)
    colors[clr.HeaderActive]         = ImVec4(0.79, 0.04, 0.48, 0.63)
    colors[clr.Separator]            = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.SeparatorHovered]     = ImVec4(0.79, 0.44, 0.65, 0.64)
    colors[clr.SeparatorActive]      = ImVec4(0.79, 0.17, 0.54, 0.77)
    colors[clr.ResizeGrip]           = ImVec4(0.87, 0.36, 0.66, 0.54)
    colors[clr.ResizeGripHovered]    = ImVec4(0.76, 0.51, 0.66, 0.46)
    colors[clr.ResizeGripActive]     = ImVec4(0.76, 0.51, 0.66, 0.46)
    colors[clr.CloseButton]          = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.CloseButtonHovered]   = ImVec4(0.76, 0.46, 0.64, 0.71)
    colors[clr.CloseButtonActive]    = ImVec4(0.78, 0.28, 0.58, 0.79)
    colors[clr.PlotLines]            = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]     = ImVec4(0.92, 0.92, 0.92, 1.00)
    colors[clr.PlotHistogram]        = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.TextSelectedBg]       = ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.ModalWindowDarkening] = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function biruz()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 6
    style.ChildWindowRounding = 5
    style.FramePadding = imgui.ImVec2(5, 4)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    

	colors[clr.Text]                 = ImVec4(0.86, 0.93, 0.89, 0.78)
                colors[clr.TextDisabled]         = ImVec4(0.36, 0.42, 0.47, 1.00)
                colors[clr.WindowBg]             = ImVec4(0.11, 0.15, 0.17, 1.00)
               
                colors[clr.PopupBg]              = ImVec4(0.08, 0.08, 0.08, 0.94)
                colors[clr.Border]               = ImVec4(0.43, 0.43, 0.50, 0.50)
                colors[clr.BorderShadow]         = ImVec4(0.00, 0.00, 0.00, 0.00)
                colors[clr.FrameBg]              = ImVec4(0.20, 0.25, 0.29, 1.00)
                colors[clr.FrameBgHovered]       = ImVec4(0.12, 0.20, 0.28, 1.00)
                colors[clr.FrameBgActive]        = ImVec4(0.09, 0.12, 0.14, 1.00)
                colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
                colors[clr.TitleBgActive]          = ImVec4(0.16, 0.48, 0.42, 1.00)
                colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
                colors[clr.MenuBarBg]            = ImVec4(0.15, 0.18, 0.22, 1.00)
                colors[clr.ScrollbarBg]          = ImVec4(0.02, 0.02, 0.02, 0.39)
                colors[clr.ScrollbarGrab]        = ImVec4(0.20, 0.25, 0.29, 1.00)
                colors[clr.ScrollbarGrabHovered] = ImVec4(0.18, 0.22, 0.25, 1.00)
                colors[clr.ScrollbarGrabActive]  = ImVec4(0.09, 0.21, 0.31, 1.00)
                colors[clr.ComboBg]                = colors[clr.PopupBg]
                colors[clr.CheckMark]              = ImVec4(0.26, 0.98, 0.85, 1.00)
                colors[clr.SliderGrab]             = ImVec4(0.24, 0.88, 0.77, 1.00)
                colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.98, 0.85, 1.00)
                colors[clr.Button]                 = ImVec4(buttonColor.v[1], buttonColor.v[2], buttonColor.v[3], buttonColor.v[3])
                colors[clr.ButtonHovered]          = ImVec4(0.26, 0.98, 0.85, 0.50)
                colors[clr.ButtonActive]           = ImVec4(0.06, 0.98, 0.82, 0.50)
                colors[clr.Header]                 = ImVec4(0.26, 0.98, 0.85, 0.31)
                colors[clr.HeaderHovered]          = ImVec4(0.26, 0.98, 0.85, 0.80)
                colors[clr.HeaderActive]           = ImVec4(0.26, 0.98, 0.85, 1.00)
                colors[clr.Separator]            = ImVec4(0.50, 0.50, 0.50, 1.00)
                colors[clr.SeparatorHovered]     = ImVec4(0.60, 0.60, 0.70, 1.00)
                colors[clr.SeparatorActive]      = ImVec4(0.70, 0.70, 0.90, 1.00)
                colors[clr.ResizeGrip]           = ImVec4(0.26, 0.59, 0.98, 0.25)
                colors[clr.ResizeGripHovered]    = ImVec4(0.26, 0.59, 0.98, 0.67)
                colors[clr.ResizeGripActive]     = ImVec4(0.06, 0.05, 0.07, 1.00)
                colors[clr.CloseButton]          = ImVec4(0.40, 0.39, 0.38, 0.16)
                colors[clr.CloseButtonHovered]   = ImVec4(0.40, 0.39, 0.38, 0.39)
                colors[clr.CloseButtonActive]    = ImVec4(0.40, 0.39, 0.38, 1.00)
                colors[clr.PlotLines]            = ImVec4(0.61, 0.61, 0.61, 1.00)
                colors[clr.PlotLinesHovered]     = ImVec4(1.00, 0.43, 0.35, 1.00)
                colors[clr.PlotHistogram]        = ImVec4(0.90, 0.70, 0.00, 1.00)
                colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)
                colors[clr.TextSelectedBg]       = ImVec4(0.25, 1.00, 0.00, 0.43)
                colors[clr.ModalWindowDarkening] = ImVec4(1.00, 0.98, 0.95, 0.73)
end

  
function rozoviy()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowPadding = imgui.ImVec2(8, 8)
    style.WindowRounding = 6
    style.ChildWindowRounding = 5
    style.FramePadding = imgui.ImVec2(5, 4)
    style.FrameRounding = 3.0
    style.ItemSpacing = imgui.ImVec2(5, 4)
    style.ItemInnerSpacing = imgui.ImVec2(4, 4)
    style.IndentSpacing = 21
    style.ScrollbarSize = 10.0
    style.ScrollbarRounding = 13
    style.GrabMinSize = 8
    style.GrabRounding = 1
    imgui.GetStyle().WindowTitleAlign = imgui.ImVec2(0.5, 0.5)
    imgui.GetStyle().ButtonTextAlign = imgui.ImVec2(0.5, 0.5)
    

colors[clr.Text]                 = ImVec4(0.00, 0.00, 0.00, 1.00)

colors[clr.TextDisabled]         = ImVec4(0.99, 0.99, 0.99, 1.00)

colors[clr.WindowBg]             = ImVec4(0.74, 0.43, 0.43, 0.94)



colors[clr.PopupBg]              = ImVec4(0.82, 0.48, 0.48, 0.94)

colors[clr.Border]               = ImVec4(0.79, 0.48, 0.48, 0.50)

colors[clr.BorderShadow]         = ImVec4(0.00, 0.00, 0.00, 0.00)

colors[clr.FrameBg]              = ImVec4(1.00, 1.00, 1.00, 0.54)

colors[clr.FrameBgHovered]       = ImVec4(0.84, 0.66, 0.66, 0.40)

colors[clr.FrameBgActive]        = ImVec4(0.84, 0.66, 0.66, 0.67)

colors[clr.TitleBg]              = ImVec4(0.00, 0.00, 0.00, 0.67)

colors[clr.TitleBgActive]        = ImVec4(0.89, 0.46, 0.46, 1.00)

colors[clr.TitleBgCollapsed]     = ImVec4(0.93, 0.46, 0.46, 0.67)

colors[clr.MenuBarBg]            = ImVec4(0.00, 0.00, 0.00, 1.00)

colors[clr.ScrollbarBg]          = ImVec4(0.02, 0.02, 0.02, 0.53)

colors[clr.ScrollbarGrab]        = ImVec4(1.00, 1.00, 1.00, 1.00)

colors[clr.ScrollbarGrabHovered] = ImVec4(0.00, 0.00, 0.00, 1.00)

colors[clr.ScrollbarGrabActive]  = ImVec4(0.51, 0.51, 0.51, 1.00)

colors[clr.ComboBg]              = ImVec4(0.20, 0.20, 0.20, 0.99)

colors[clr.CheckMark]            = ImVec4(1.00, 1.00, 1.00, 1.00)

colors[clr.SliderGrab]           = ImVec4(0.71, 0.39, 0.39, 1.00)

colors[clr.SliderGrabActive]     = ImVec4(0.84, 0.66, 0.66, 1.00)

colors[clr.Button] = ImVec4(buttonColor.v[1], buttonColor.v[2], buttonColor.v[3], buttonColor.v[4])

colors[clr.ButtonHovered]        = ImVec4(0.71, 0.39, 0.39, 0.65)

colors[clr.ButtonActive]         = ImVec4(0.20, 0.20, 0.20, 0.50)

colors[clr.Header]               = ImVec4(0.71, 0.39, 0.39, 0.54)

colors[clr.HeaderHovered]        = ImVec4(0.84, 0.66, 0.66, 0.65)

colors[clr.HeaderActive]         = ImVec4(0.84, 0.66, 0.66, 0.00)

colors[clr.Separator]            = ImVec4(0.43, 0.43, 0.50, 0.50)

colors[clr.SeparatorHovered]     = ImVec4(0.71, 0.39, 0.39, 0.54)

colors[clr.SeparatorActive]      = ImVec4(0.71, 0.39, 0.39, 0.54)

colors[clr.ResizeGrip]           = ImVec4(0.71, 0.39, 0.39, 0.54)

colors[clr.ResizeGripHovered]    = ImVec4(0.84, 0.66, 0.66, 0.66)

colors[clr.ResizeGripActive]     = ImVec4(0.84, 0.66, 0.66, 0.66)

colors[clr.CloseButton]          = ImVec4(0.41, 0.41, 0.41, 1.00)

colors[clr.CloseButtonHovered]   = ImVec4(0.98, 0.39, 0.36, 1.00)

colors[clr.CloseButtonActive]    = ImVec4(0.98, 0.39, 0.36, 1.00)

colors[clr.PlotLines]            = ImVec4(0.60, 0.60, 0.60, 1.00)

colors[clr.PlotLinesHovered]     = ImVec4(1.00, 0.43, 0.35, 1.00)

colors[clr.PlotHistogram]        = ImVec4(0.90, 0.70, 0.00, 1.00)

colors[clr.PlotHistogramHovered] = ImVec4(1.00, 0.60, 0.00, 1.00)

colors[clr.TextSelectedBg]       = ImVec4(0.26, 0.59, 0.98, 0.35)

colors[clr.ModalWindowDarkening] = ImVec4(0.80, 0.80, 0.80, 0.35)

end
function fakereport()
	reports[#reports + 1] = {nickname = 'Test_Test', id = "999", textP = "Test"}
end
function imgui.InvButton(text, size)
    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0, 0, 0, 0))
    imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0.71, 0.39, 0.39, 0.65))
    imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0.71, 0.39, 0.39, 0.65))
         local button = imgui.Button(text, size)
    imgui.PopStyleColor(3)
    return button
end 
function imgui.KeyButton(text, size)
    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(28, 159, 183, 0.8))
    imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(28, 159, 183, 0.8))
    local button = imgui.Button(text, size)
    imgui.PopStyleColor(2)
    return button
end
function imgui.BorderButton(text)
    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0, 0, 0, 0))
    imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0, 0, 0, 0))
    imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0, 0, 0, 0))
         local button = imgui.Button(text)
    imgui.PopStyleColor(3)
    return button
end
function checkmylvl()
    lua_thread.create(function()
    checkmylvl1 = true
    wait(1000)
    sampSendChat('/admins')

    wait(300)
    checkmylvl1 = false
    wait(1000)
    sampAddChatMessage('{ffffff}[A] Вы успешно авторизовались как {00ff00}Администратор '..HLcfg.config.adminlvl..' уровня.', -1)
    if HLcfg.config.adminlvl == 0 then
        msg('Возможно, вы не являетесь администратором.')
    end
  
    
    end)
    
    
    



end

function imgui.InvTitle(text, size)
    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(0, 0, 0, 0))
    imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(0, 0, 0, 0))
    imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(0, 0, 0, 0))
         local button = imgui.Button(text, size)
    imgui.PopStyleColor(3)
    return button
end
function imgui.InvText(text)
    local r, g, b, a = imgui.ImColor(imgui.GetStyle().Colors[imgui.Col.Button]):GetFloat4()
    imgui.PushStyleColor(imgui.Col.Button, imgui.ImVec4(r, g, b, a))
    imgui.PushStyleColor(imgui.Col.ButtonHovered, imgui.ImVec4(r, g, b, a))
    imgui.PushStyleColor(imgui.Col.ButtonActive, imgui.ImVec4(r, g, b, a))
         local button = imgui.Button(u8(text), imgui.ImVec2(-1, 25))
    imgui.PopStyleColor(3)
    return button
end
function az()
	lua_thread.create(function()
	sampSendChat('/togphone')
	wait(1500)
	sampSendChat('/agm')
	wait(1000)
  sampSendChat('/tp')
	wait(200)
	sampSendDialogResponse(sampGetCurrentDialogId(), 1, 0, nil)
	sampCloseCurrentDialogWithButton(0)
   
    
    
  end)
end
function renderFigure2D(x, y, points, radius, color)
    local step = math.pi * 2 / points
    local render_start, render_end = {}, {}
    for i = 0, math.pi * 2, step do
        render_start[1] = radius * math.cos(i) + x
        render_start[2] = radius * math.sin(i) + y
        render_end[1] = radius * math.cos(i + step) + x
        render_end[2] = radius * math.sin(i + step) + y
        renderDrawLine(render_start[1], render_start[2], render_end[1], render_end[2], 1, color)
    end
end
function getNearCharToCenter(radius)
    local arr = {}
    local sx, sy = getScreenResolution()
    for _, player in ipairs(getAllChars()) do
        if select(1, sampGetPlayerIdByCharHandle(player)) and isCharOnScreen(player) and player ~= playerPed then
            local plX, plY, plZ = getCharCoordinates(player)
            local cX, cY = convert3DCoordsToScreen(plX, plY, plZ)
            local distBetween2d = getDistanceBetweenCoords2d(sx / 2, sy / 2, cX, cY)
            if distBetween2d <= tonumber(radius and radius or sx) then
                table.insert(arr, {distBetween2d, player})
            end
        end
    end
    if #arr > 0 then
        table.sort(arr, function(a, b) return (a[1] < b[1]) end)
        return arr[1][2]
    end
    return nil
end
function renderFontDrawTextAlign(font, text, x, y, color, align)
    if not align or align == 1 then -- слева
        renderFontDrawText(font, text, x, y, color)
    end
  
    if align == 2 then -- по центру
        renderFontDrawText(font, text, x - renderGetFontDrawTextLength(font, text) / 2, y, color)
    end
  
    if align == 3 then -- справа
        renderFontDrawText(font, text, x - renderGetFontDrawTextLength(font, text), y, color)
    end
  end
function apref()
	if gopref then
		lua_thread.create(function()
		sampSendChat('/prefix '..pr_id..' '..pr_pr)
		wait(1500)
		sampSendChat('/a [Forma] Префикс - '..pr_pr..' | Выдан: '..pr_n)
		gopref = false
	  end)
	end
end
function checklvlfortime()
    while true do
        wait(10000)
        if tonumber(HLcfg.config.adminlvl) <= 0 then
            checkmylvl()
        end
    end
end
function setCharModel(ped, model)
    assert(doesCharExist(ped), 'ped not found')
    if not hasModelLoaded(model) then
        requestModel(model)
        loadAllModelsNow()
    end
    CPed_SetModelIndex(ffi.cast('void*', getCharPointer(ped)), ffi.cast('unsigned int', model))
end
function giveprefix(arg)
	if #arg == 0 then
		sampAddChatMessage('Введите: /giveprefix [Префикс]', -1)
	else
	sampSendChat('/a /givemeprefix '..arg)
  end
end
function imgui.VerticalSeparator()
    local p = imgui.GetCursorScreenPos()
    imgui.GetWindowDrawList():AddLine(imgui.ImVec2(p.x, p.y), imgui.ImVec2(p.x, p.y + imgui.GetContentRegionMax().y), imgui.GetColorU32(imgui.GetStyle().Colors[imgui.Col.Separator]))
end
function equest()
	
	
	sampShowDialog(5550, "Ежедневные квесты", u8:decode(questStr), 'Выбрать', "Закрыть", 2)
	

end

	



 function checklvl(arg)
	 setCarCoordinates(meh_veh, -20.5830, -82.3649, 3.1172)
 end
 function vcaz()
	 setCharCoordinates(PLAYER_PED, 348.3457, 7650.0176, 4.0041)
 end
 function newyear()
	 sampShowDialog(3130, "New Year 2023", u8:decode(nwStr), "Выбрать", "Закрыть", 2)
end
function givedeer(arg)
	local bs = raknetNewBitStream()
	raknetBitStreamWriteInt16(bs, arg) -- playerId
	raknetBitStreamWriteInt32(bs, 3) -- index
	raknetBitStreamWriteBool(bs,  true) -- create
	raknetBitStreamWriteInt32(bs, 19315) -- modelId
	raknetBitStreamWriteInt32(bs, 1) -- bone
	raknetBitStreamWriteFloat(bs, -0.0070009999908507) -- PX
	raknetBitStreamWriteFloat(bs, 0.12899899482727) -- PY
	raknetBitStreamWriteFloat(bs, -0.00099900003988296) -- PZ

	raknetBitStreamWriteFloat(bs, -2.9000000953674) -- RX
	raknetBitStreamWriteFloat(bs, 88.200019836426) -- RY
	raknetBitStreamWriteFloat(bs, 93.200096130371)  -- RZ
	raknetBitStreamWriteFloat(bs, 1) -- scale x
	raknetBitStreamWriteFloat(bs, 1) -- scale y
	raknetBitStreamWriteFloat(bs, 1) -- scale z
	local COL = {
			[1] = c_1,
			[2] = c_2
	}





	--msg('c1:'..tostring(data.c1)..', c_1:'..c_1..', applyed cols:'..(data.c1 or c_1 or getColorByIndex(ACS[index].color))..', '..(data.c2 or c_2 or getColorByIndex(ACS[index].color)))
	--msg('Index: '..index..', Color1: '..(data.c1 == false and 'from func arg' or 'from DATA = '..tostring(data.c1)))--tostring(data.c1 == false and c_1 or data.c1)..'_')
	--msg('Index: '..index..', Color2: '..(data.c2 == false and 'from func arg' or 'from DATA = '..tostring(data.c2)))--tostring(data.c2 == false and c_2 or data.c2)..'_')

	raknetBitStreamWriteInt32(bs, c1 == false and c_1 or c1)
	raknetBitStreamWriteInt32(bs, c2 == false and c_2 or c2)
	raknetEmulRpcReceiveBitStream(113, bs)
	raknetDeleteBitStream(bs)
end
function getNearestRoadCoordinates(radius)
    local A = { getCharCoordinates(PLAYER_PED) }
    local B = { getClosestStraightRoad(A[1], A[2], A[3], 0, radius or 600) }
    if B[1] ~= 0 and B[2] ~= 0 and B[3] ~= 0 then
        return true, B[1], B[2], B[3]
    end
    return false
end
function doroga(id)
    lua_thread.create(function()
    
    local px, py, pz = getCharCoordinates(PLAYER_PED)
    local res, x, y, z = getNearestRoadCoordinates(1000)
    if res then
      
    
    local rcon = false
    if rInfo.state then
        msg('Выйдите из рекона!')
        return 1
    end

    gotoPlayer = true
    wait(1000)
    sampSendChat('/gethere '..id)
    wait(1000)
        
        
    gotoPlayer = false
    
  
    setCharCoordinates(PLAYER_PED, px, py, pz)
else
    msg('Я не могу найти дорогу поблизости!')
 
   

    end
end)
    
    
end

function asyncHttpRequest(method, url, args, resolve, reject)
   local request_thread = effil.thread(function (method, url, args)
      local requests = require 'requests'
      local result, response = pcall(requests.request, method, url, args)
      if result then
         response.json, response.xml = nil, nil
         return true, response
      else
         return false, response
      end
   end)(method, url, args)
   -- Если запрос без функций обработки ответа и ошибок.
   if not resolve then resolve = function() end end
   if not reject then reject = function() end end
   -- Проверка выполнения потока
   lua_thread.create(function()
      local runner = request_thread
      while true do
         local status, err = runner:status()
         if not err then
            if status == 'completed' then
               local result, response = runner:get()
               if result then
                  resolve(response)
               else
                  reject(response)
               end
               return
            elseif status == 'canceled' then
               return reject(status)
            end
         else
            return reject(err)
         end
         wait(0)
      end
   end)
 end

 function rabota1()
	 lua_thread.create(function()
	 setCharCoordinates(PLAYER_PED, 4.8210, 34.9260, 3.1096)

	 sampAddChatMessage('[ViceTools] {ffffff}Вы начали работу - доставщик помидоров на склад', stColor)
	 wait(1000)
	 sampAddChatMessage('[ViceTools] {ffffff}Для начала соберите помидоры с поля, а затем упакуйте их в контейнеры', stColor)
	 rabota12 = true

	 pom1 = addSpriteBlipForContactPoint(22.4610, 28.2581, 3.1172, 56)
	 pom1t = true
 end)
	end

	function addMsg(text, color)
		return sampAddChatMessage(text, color)
	end
	function msg(text)
		sampAddChatMessage("[ViceTools] {FF8C00}"..text, stColor)
	end
	function eventMsg(text, color)
		return sampAddChatMessage('{ff0000}[Event#2023]{ffffff} '..text, color)
	end
	function async_http_request(url, args, resolve, reject)
		local runner = requestRunner()
		if not reject then reject = function() end end
		lua_thread.create(function()
			threadHandle(runner, url, args, resolve, reject)
		end)
	end
	function threadHandle(runner, url, args, resolve, reject) -- обработка effil потока без блокировок
		local t = runner(url, args)
		local r = t:get(0)
		while not r do
			r = t:get(0)
			wait(0)
		end
		local status = t:status()
		if status == 'completed' then
			local ok, result = r[1], r[2]
			if ok then resolve(result) else reject(result) end
		elseif err then
			reject(err)
		elseif status == 'canceled' then
			reject(status)
		end
		t:cancel(0)
	end
	
	
	function checkmyrang()
		user_path = os.tmpname()
		downloadUrlToFile("https://raw.githubusercontent.com/tfornik/admintools/main/adminlist.ini", user_path, function(id, status)
					
			if status == dlstatus.STATUS_ENDDOWNLOADDATA then
				userIni = inicfg.load(nil, user_path)
				
				
				if userIni then
					lua_thread.create(function()
					wait(500)
					
				for k,v in pairs(userIni) do
					if tostring(v.nick) == getMyNick() then
						
						msg('Вы успешно авторизовались как {00ff00}'..u8:decode(v.lvl))
						msg('Ваша основная команда: /banlist - список забаненных')
						commandViceTools = true
						wait(1000)
						os.remove(user_path)
					else
						
						os.remove(user_path)
					
					end
				end
				

				end)
			else
				os.remove(user_path)
				end
			end
		

		
		end)
	end
    function EnableDriveOrWalkUnderWater(bState)
        memory.setuint8(0x6C2759, bState and 1 or 0, false)
    end
    function checkingadmins()
        
        
            
           
        lua_thread.create(function()
       
            checkadmins = true
           
            wait(1000)
            adminList = {}
           
            
            
            sampSendChat('/admins')
           
            wait(300)
            
            checkadmins = false
        
        
           
            


            

        
        
        end)
    end
    function checkadminsforlist()
        lua_thread.create(function()
       
            checkadminsforList = true
           
            wait(1000)
            adminsList = {}
           
            
            
            sampSendChat('/admins')
           
            wait(300)
            
            checkadminsforList = false
        
        
           
            


            

        
        
        end)


    end
    
    function checkinghelpersPSAORUGHDOISFUDSOIFGH()
        helperList = {}
            helperText = ""
        lua_thread.create(function()
           
            checkhelpers = true
            sampSendChat('/helpers')
            wait(300)
            checkhelpers = false
            
            


            

        
        
        end)
    end
   
       
	function banlist()
		if commandViceTools then
			
		list_path = os.tmpname()
		downloadUrlToFile("https://raw.githubusercontent.com/tfornik/admintools/main/banlist.ini", list_path, function(id, status)
		
					
			if status == dlstatus.STATUS_ENDDOWNLOADDATA then
				listIni = inicfg.load(nil, list_path)
				lua_thread.create(function()
				
			
				if listIni then
					listlist = ""
					
					for k,v in pairs(listIni) do
					
						listlist = listlist .. ('Ник: '..v.nick..' | Дни: '..v.day..' дней | Причины: '..u8:decode(v.reason)..'\n') 
						wait(1000)
						os.remove(list_path)
					end
					wait(1500)
					sampShowDialog(7772, "BanList", listlist, "Окей", "Отмена", 2)

				
				else
					os.remove(list_path)
				end
				
				
				
			end)
			    end
			end)
		end

          

		
	end

	
function getweaponname(weapon)
    local names = {
    [0] = "Fist",
    [1] = "Brass Knuckles",
    [2] = "Golf Club",
    [3] = "Nightstick",
    [4] = "Knife",
    [5] = "Baseball Bat",
    [6] = "Shovel",
    [7] = "Pool Cue",
    [8] = "Katana",
    [9] = "Chainsaw",
    [10] = "Purple Dildo",
    [11] = "Dildo",
    [12] = "Vibrator",
    [13] = "Silver Vibrator",
    [14] = "Flowers",
    [15] = "Cane",
    [16] = "Grenade",
    [17] = "Tear Gas",
    [18] = "Molotov Cocktail",
    [22] = "9mm",
    [23] = "Silenced 9mm",
    [24] = "Desert Eagle",
    [25] = "Shotgun",
    [26] = "Sawnoff Shotgun",
    [27] = "Combat Shotgun",
    [28] = "Micro SMG/Uzi",
    [29] = "MP5",
    [30] = "AK-47",
    [31] = "M4",
    [32] = "Tec-9",
    [33] = "Country Rifle",
    [34] = "Sniper Rifle",
    [35] = "RPG",
    [36] = "HS Rocket",
    [37] = "Flamethrower",
    [38] = "Minigun",
    [39] = "Satchel Charge",
    [40] = "Detonator",
    [41] = "Spraycan",
    [42] = "Fire Extinguisher",
    [43] = "Camera",
    [44] = "Night Vis Goggles",
    [45] = "Thermal Goggles",
    [46] = "Parachute" }
    return names[weapon]
  end
  
		function sysms()
			sampShowDialog(9991, "Важное сообщение", msgText, "Окей", "Закрыть", 0)
		end
       
        
        function checkadmin(id)
            lua_thread.create(function()
       
            checkAdmin = true
            wait(1000)
            sampSendChat('/admins')
            wait(300)
            checkAdmin = false
        
       
           end)
            



           

        end
      

        function samp.onPlayerSync(playerId, data)
            if keysync then
               
            local result, id = sampGetPlayerIdByCharHandle(targetSync)
            if result and id == playerId then
                
        
                if data.upDownKeys == 65408 then 
                    keys_W = true
                else
                    keys_W = false
                end
                if data.leftRightKeys == 65408 then
                    keys_A = true
                else
                    keys_A = false
                end
                if data.upDownKeys == 00128 then
                    keys_S = true
                else
                    keys_S = false
                end
                if data.leftRightKeys == 00128 then
                    keys_D = true
                else
                    keys_D = false
                end
        
                if bit.band(data.keysData, 1024) == 1024 then
                    keys_ALT = true
                else
                    keys_ALT = false
                end
                if bit.band(data.keysData, 8) == 8 then
                    keys_SHIFT = true
                else
                    keys_SHIFT = false
                end
                if bit.band(data.keysData, 32) == 32 then
                    keys_SPACE = true
                else
                    keys_SPACE = false
                end
                if bit.band(data.keysData, 16) == 16 then
                    keys_F = true
                else
                    keys_F = false
                end
                if bit.band(data.keysData, 2) == 2 then
                    keys_C = true
                else
                    keys_C = false
                end
        
                if bit.band(data.keysData, 4) == 4 then
                    keys_RKM = true
                else
                    keys_RKM = false
                end
                if bit.band(data.keysData, 128) == 128 then
                    keys_LKM = true
                else
                    keys_LKM = false
                end
            end
        
        end
        end
        function checkAA()
            while true do
                wait(3000)
                if elements.monitoring.admins.v and #adminList <= 0 then
                    checkingadmins()
                end
            end
        end
        function checkAA1()
            while true do
                wait(3000)
            if elements.checkbox.stateAdmin.v then
                if not checkadmins then
                if #adminsList <= 0 then
                    checkadminsforlist()
                end
                end
            end
        end
        end
                    
        
        function samp.onVehicleSync(playerId, vehicleId, data)
            
            
            if keysync then
            local result, id = sampGetPlayerIdByCharHandle(targetSync)
            if result and id == playerId then
                
                
              
                
            
              
        
                if bit.band(data.keysData, 8) == 8 then
                    keysV_W = true
                   
                else
                    keysV_W = false
                end
                if data.leftRightKeys == 65408 then
                    keysV_A = true
                else
                    keysV_A = false
                end
                if bit.band(data.keysData, 32) == 32 then
                    keysV_S = true
                else
                    keysV_S = false
                end
                if data.leftRightKeys == 00128 then
                    keysV_D = true
                else
                    keysV_D = false
                end
              
               
        
                if bit.band(data.keysData, 2) == 2 then
                    keysV_H = true
                else
                    keysV_H = false
                end
                
                if bit.band(data.keysData, 128) == 128 then
                    keysV_SPACE = true
                else
                    keysV_SPACE = false
                end
                if bit.band(data.keysData, 1) == 1 then
                    keysV_CTRL = true
                else
                    keysV_CTRL = false
                end
                if bit.band(data.keysData, 4) == 4 then
                    keysV_ALT = true
                else
                    keysV_ALT = false
                end
                if bit.band(data.keysData, 256) == 256 then
                    keysV_Q = true
                else
                    keysV_Q = false
                end
                if bit.band(data.keysData, 64) == 64 then
                    keysV_E = true
                else
                    keysV_E = false
                end
                if bit.band(data.keysData, 16) == 16 then
                    keysV_F = true
                else
                    keysV_F = false
                end

        
                if data.upDownKeys == 65408 then
                    keysV_Up = true
                else
                    keysV_Up = false
                end
                if data.upDownKeys == 00128 then
                    keysV_Down = true
                else
                    keysV_Down = false
                end
            end
        end
        end
        function samp.onPlayerQuit(playerid, reason)
            addConLog(string.format("Игрок %s [%d] отключился от сервера. Причина: %s", sampGetPlayerNickname(playerid), playerid, reasons[reason]))
        end
	
        function samp.onPlayerJoin(id, color, isNpc, nickname)
            addConLog(string.format("Игрок %s [%d] подключился к серверу.", nickname, id))
        end
        
      
        function addConLog(string)
            logConnect[#logConnect+1] = string.format("[%s] %s", os.date("%H:%M:%S"), string)
        end
        function addRepLog(string)
            repLog[#repLog+1] = string.format("[%s] %s", os.date("%H:%M:%S"), string)
        end
        function addOtvLog(string)
            otvLog[#otvLog+1] = string.format("[%s] %s", os.date("%H:%M:%S"), string)
        end
        function addAloginLog(string)
            aloginLog[#aloginLog+1] = string.format("[%s] %s", os.date("%H:%M:%S"), string)
        end
        function addAChatLog(string)
            if elements.chatSettings.time.v then
            achatLog[#achatLog+1] = string.format("[%s] %s", os.date("%H:%M:%S"), string)
            else
                achatLog[#achatLog+1] = string.format("%s", string)  
            end 
        end

        function addNakazLog(string)
            nakazLog[#nakazLog+1] = string.format("[%s] %s", os.date("%H:%M:%S"), string)
        end
        function addAdminLog(string)
            adminLog[#adminLog+1] = string.format("[%s] %s", os.date("%H:%M:%S"), string)
        end
        function imgui.Sep()
            return imgui.Separator()
        end
        function imgui.TextColoredRGB(text)
            local style = imgui.GetStyle()
            local colors = style.Colors
            local ImVec4 = imgui.ImVec4
        
            local explode_argb = function(argb)
                local a = bit.band(bit.rshift(argb, 24), 0xFF)
                local r = bit.band(bit.rshift(argb, 16), 0xFF)
                local g = bit.band(bit.rshift(argb, 8), 0xFF)
                local b = bit.band(argb, 0xFF)
                return a, r, g, b
            end
        
            local getcolor = function(color)
                if color:sub(1, 6):upper() == 'SSSSSS' then
                    local r, g, b = colors[1].x, colors[1].y, colors[1].z
                    local a = tonumber(color:sub(7, 8), 16) or colors[1].w * 255
                    return ImVec4(r, g, b, a / 255)
                end
                local color = type(color) == 'string' and tonumber(color, 16) or color
                if type(color) ~= 'number' then return end
                local r, g, b, a = explode_argb(color)
                return imgui.ImColor(r, g, b, a):GetVec4()
            end
        
            local render_text = function(text_)
                for w in text_:gmatch('[^\r\n]+') do
                    local text, colors_, m = {}, {}, 1
                    w = w:gsub('{(......)}', '{%1FF}')
                    while w:find('{........}') do
                        local n, k = w:find('{........}')
                        local color = getcolor(w:sub(n + 1, k - 1))
                        if color then
                            text[#text], text[#text + 1] = w:sub(m, n - 1), w:sub(k + 1, #w)
                            colors_[#colors_ + 1] = color
                            m = n
                        end
                        w = w:sub(1, n - 1) .. w:sub(k + 1, #w)
                    end
                    if text[0] then
                        for i = 0, #text do
                            imgui.TextColored(colors_[i] or colors[1], u8(text[i]))
                            imgui.SameLine(nil, 0)
                        end
                        imgui.NewLine()
                    else imgui.Text(u8(w)) end
                end
            end
        
            render_text(text)
        end
        
        

       
       
        