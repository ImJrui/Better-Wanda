GLOBAL.setmetatable(env, {__index = function(t, k) return GLOBAL.rawget(GLOBAL, k) end })

local lang = GetModConfigData("LANGUAGE")
 
local function _Translate(string) 
    return string[lang] or string["EN"]
end
 
STRINGS.NAMES.POCKETWATCH_WEAPON_CHARGED = _Translate({
    EN = "Charged Alarming Clock", 
    CN = "充能的警钟", 
    JP = "充電された警報時計", 
    RU = "Заряженные тревожные часы", 
    TH = "นาฬิกาเตือนภัยที่ชาร์จแล้ว", 
    VI = "Đồng hồ báo thức sạc đầy"
})

STRINGS.NAMES.WATCH_CONTAINER = _Translate({
    EN = "Watch Box", 
    CN = "怀表盒", 
    JP = "懐中時計箱", 
    RU = "Коробка для часов", 
    TH = "กล่องนาฬิกาพก", 
    VI = "Hộp đồng hồ bỏ túi"
})
 
STRINGS.RECIPE_DESC.WATCH_CONTAINER = _Translate({
    EN = "It will store the watch very well", 
    CN = "它可以很好地储存怀表", 
    JP = "時計をとてもよく保管できます", 
    RU = "Он очень хорошо хранит часы", 
    TH = "มันจะเก็บนาฬิกาได้ดีมาก", 
    VI = "Nó sẽ lưu trữ đồng hồ rất tốt"
})
 
-- 为每个角色填充检查 WATCH_CONTAINER 的台词
STRINGS.CHARACTERS.GENERIC.DESCRIBE.WATCH_CONTAINER = _Translate({
    EN = "A container for pocket watches.",
    CN = "怀表的容器。",
    JP = "懐中時計の容器。",
    RU = "Контейнер для карманных часов.",
    TH = "ภาชนะสำหรับนาฬิกาพก",
    VI = "Hộp đựng đồng hồ bỏ túi."
})
 
STRINGS.CHARACTERS.WILLOW.DESCRIBE.WATCH_CONTAINER = _Translate({
    EN = "It's not flammable, but it holds timepieces.",
    CN = "它不易燃，但装着计时器。",
    JP = "可燃性ではないが、時計を収納する。",
    RU = "Он не горит, но хранит часы.",
    TH = "มันไม่ติดไฟ แต่เก็บนาฬิกาได้",
    VI = "Nó không cháy được, nhưng chứa đồng hồ."
})
 
STRINGS.CHARACTERS.WOLFGANG.DESCRIBE.WATCH_CONTAINER = _Translate({
    EN = "Strong box for tiny clocks!",
    CN = "装小钟表的结实盒子！",
    JP = "小さな時計のための頑丈な箱！",
    RU = "Прочная коробка для маленьких часов!",
    TH = "กล่องแข็งแรงสำหรับนาฬิกาเล็กๆ!",
    VI = "Hộp chắc chắn cho đồng hồ nhỏ!"
})
 
STRINGS.CHARACTERS.WENDY.DESCRIBE.WATCH_CONTAINER = _Translate({
    EN = "It echoes with silent ticks.",
    CN = "它回荡着无声的滴答声。",
    JP = "静かな ticks が反響する。",
    RU = "Он эхом отражает тихие тиканья.",
    TH = "มันก้องกังวานด้วยเสียงติ๊กที่เงียบงัน",
    VI = "Nó vang vọng những tiếng tích tắc thầm lặng."
})
 
STRINGS.CHARACTERS.WX78.DESCRIBE.WATCH_CONTAINER = _Translate({
    EN = "A storage unit for temporal devices.",
    CN = "时间设备的存储单元。",
    JP = "時間デバイスの保存ユニット。",
    RU = "Блок хранения для временных устройств.",
    TH = "หน่วยเก็บอุปกรณ์เกี่ยวกับเวลา",
    VI = "Đơn vị lưu trữ cho thiết bị thời gian."
})
 
STRINGS.CHARACTERS.WICKERBOTTOM.DESCRIBE.WATCH_CONTAINER = _Translate({
    EN = "An organized way to store chronometers.",
    CN = "存储精密计时器的有条理的方式。",
    JP = "クロノメーターを整理して保管する方法。",
    RU = "Организованный способ хранения хронометров.",
    TH = "วิธีที่จัดระเบียบสำหรับเก็บนาฬิกาเคาะเวลา",
    VI = "Một cách có tổ chức để lưu trữ đồng hồ đo thời gian."
})
 
STRINGS.CHARACTERS.WOODIE.DESCRIBE.WATCH_CONTAINER = _Translate({
    EN = "Good for keepin' watches safe.",
    CN = "好好保管怀表。",
    JP = "時計を安全に保管するのに良い。",
    RU = "Хорошо для безопасного хранения часов.",
    TH = "ดีสำหรับการเก็บนาฬิกาให้ปลอดภัย",
    VI = "Tốt để giữ đồng hồ an toàn."
})
 
STRINGS.CHARACTERS.WAXWELL.DESCRIBE.WATCH_CONTAINER = _Translate({
    EN = "A mundane box for mundane timekeepers.",
    CN = "平凡盒子装平凡计时器。",
    JP = "平凡な時計のための平凡な箱。",
    RU = "Обычная коробка для обычных часов.",
    TH = "กล่องธรรมดาสำหรับนาฬิกาธรรมดา",
    VI = "Một cái hộp tầm thường cho đồng hồ tầm thường."
})
 
STRINGS.CHARACTERS.WATHGRITHR.DESCRIBE.WATCH_CONTAINER = _Translate({
    EN = "A vessel for time-keeping warriors!",
    CN = "计时战士的容器！",
    JP = "時間を守る戦士のための容器！",
    RU = "Сосуд для воинов, следящих за временем!",
    TH = "ภาชนะสำหรับนักรบที่รักษาเวลา!",
    VI = "Bình chứa cho các chiến binh giữ thời gian!"
})
 
STRINGS.CHARACTERS.WEBBER.DESCRIBE.WATCH_CONTAINER = _Translate({
    EN = "It's like a little home for watches!",
    CN = "它像怀表的小家！",
    JP = "時計の小さな家のようだ！",
    RU = "Это как маленький дом для часов!",
    TH = "มันเหมือนบ้านเล็กๆ สำหรับนาฬิกา!",
    VI = "Nó giống như một ngôi nhà nhỏ cho đồng hồ!"
})
 
STRINGS.CHARACTERS.WARLY.DESCRIBE.WATCH_CONTAINER = _Translate({
    EN = "Could use it to store cooking timers.",
    CN = "可以用来存储烹饪计时器。",
    JP = "料理用タイマーを保管するのに使える。",
    RU = "Можно использовать для хранения кухонных таймеров.",
    TH = "สามารถใช้เก็บนาฬิกาจับเวลาในการทำอาหาร",
    VI = "Có thể dùng nó để lưu trữ đồng hồ nấu ăn."
})
 
STRINGS.CHARACTERS.WORMWOOD.DESCRIBE.WATCH_CONTAINER = _Translate({
    EN = "The box feels... timeless.",
    CN = "这盒子感觉...永恒。",
    JP = "箱は... 永遠のように感じる。",
    RU = "Коробка ощущается... вне времени.",
    TH = "กล่องรู้สึก... เหมือนไม่มีเวลา",
    VI = "Chiếc hộp cảm thấy... vĩnh cửu."
})
 
STRINGS.CHARACTERS.WANDA.DESCRIBE.WATCH_CONTAINER = _Translate({
    EN = "A precise holder for precise instruments.",
    CN = "精密仪器的精确持有器。",
    JP = "精密な機器のための精密なホルダー。",
    RU = "Точный держатель для точных инструментов.",
    TH = "ที่ยึดที่แม่นยำสำหรับเครื่องมือที่แม่นยำ",
    VI = "Một giá đỡ chính xác cho các dụng cụ chính xác."
})