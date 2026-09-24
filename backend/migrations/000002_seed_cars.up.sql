-- 000002_seed_cars: стартовый набор из 10 автомобилей 10 марок.
-- Характеристики справочные, для указанной в version_note версии.
-- Фото: Wikimedia Commons (автор и лицензия указаны у каждого фото).
--
-- Чтобы добавить новую машину, НЕ правьте этот файл, а создайте новую миграцию
-- 00000N_add_<slug>.up.sql по образцу одного блока ниже (см. README).

INSERT INTO brands (slug, name, country, founded_year, history) VALUES
    ('toyota', 'Toyota', 'Япония', 1937, 'Toyota Motor Corporation выросла из автомобильного отдела ткацкой компании Toyoda Automatic Loom Works. Им руководил Киитиро Тоёда, сын изобретателя автоматического ткацкого станка Сакити Тоёды. Первый легковой автомобиль, Model AA, вышел в 1936 году, а в 1937-м автомобильное производство стало самостоятельной компанией.

В послевоенные годы Toyota создала знаменитую производственную систему Toyota Production System: «бережливое производство», «точно вовремя», кайдзен. Её до сих пор изучают инженеры по всему миру. В 1997 году компания выпустила Prius, первый массовый гибрид.

Сегодня Toyota входит в число крупнейших автопроизводителей мира по объёму продаж и славится надёжностью. Camry выпускается с 1982 года и остаётся одной из самых продаваемых моделей бренда.'),
    ('lada', 'Lada', 'Россия', 1966, 'Волжский автомобильный завод (АвтоВАЗ) в Тольятти основан в 1966 году по соглашению с итальянским концерном FIAT. Первый автомобиль, ВАЗ-2101 «Жигули», созданный на базе FIAT 124, сошёл с конвейера в 1970 году. На экспорт машины продавались под маркой Lada.

За десятилетия завод выпустил легендарные модели «классику», Ниву (ВАЗ-2121, один из первых компактных внедорожников с несущим кузовом), «Самару» и «Приору». С 2012 по 2022 год АвтоВАЗ входил в альянс Renault-Nissan, что дало доступ к современным платформам.

Lada Vesta, представленная в 2015 году, стала первой моделью в новом фирменном стиле с X-образной передней частью. Уже несколько лет подряд это самый продаваемый автомобиль в России.'),
    ('kia', 'Kia', 'Южная Корея', 1944, 'Kia начинала в 1944 году как производитель стальных труб и велосипедных деталей под названием Kyungsung Precision Industry. В 1950-х компания выпустила первый корейский велосипед, затем мотоциклы, грузовики, а в 1974 году и первый легковой автомобиль Brisa.

После азиатского финансового кризиса 1997 года Kia обанкротилась, и в 1998-м её купила Hyundai Motor. Сегодня обе марки входят в Hyundai Motor Group, но разрабатывают дизайн самостоятельно.

Перелом в имидже бренда связан с приходом в 2006 году дизайнера Петера Шрайера (раньше работал в Audi). Он ввёл фирменную решётку «нос тигра». Rio, собиравшийся в Санкт-Петербурге, много лет входил в тройку самых популярных автомобилей России.'),
    ('hyundai', 'Hyundai', 'Южная Корея', 1967, 'Hyundai Motor Company основана в 1967 году Чон Чжу Ёном как часть строительного конгломерата Hyundai. Первые автомобили собирались по лицензии Ford. В 1975 году вышел Pony, первый серийный корейский автомобиль собственной разработки (дизайн студии Italdesign Джорджетто Джуджаро).

В 1990–2000-е годы компания сделала ставку на качество и длинную гарантию и вышла в число крупнейших производителей мира. Сейчас Hyundai Motor Group объединяет марки Hyundai, Kia и Genesis.

С 2010 года в Санкт-Петербурге работал завод Hyundai, где выпускались Solaris и Creta. Creta, компактный кроссовер для развивающихся рынков, стал бестселлером в своём классе.'),
    ('volkswagen', 'Volkswagen', 'Германия', 1937, 'Volkswagen («народный автомобиль») основан в 1937 году для производства доступной машины, спроектированной Фердинандом Порше. Эта модель, известная как «Жук» (Käfer), выпускалась с 1938 по 2003 год, и её тираж превысил 21 миллион экземпляров.

В 1974 году появился Golf, давший имя целому классу автомобилей. Сегодня Volkswagen Group объединяет десяток марок, среди них Audi, Škoda, SEAT, Porsche, Lamborghini и Bentley.

Tiguan, компактный кроссовер на платформе MQB, выпускается с 2007 года. Второе поколение с 2016 года собиралось в том числе в Калуге и было одним из самых популярных кроссоверов на российском рынке.'),
    ('skoda', 'Škoda', 'Чехия', 1895, 'История Škoda начинается в 1895 году, когда Вацлав Лаурин и Вацлав Клемент открыли в Млада-Болеславе мастерскую по производству велосипедов. Затем появились мотоциклы, а в 1905 году первый автомобиль Voiturette A. В 1925 году компанию купил машиностроительный концерн Škoda.

В социалистический период марка выпускала доступные автомобили для стран Восточного блока. С 1991 года Škoda входит в Volkswagen Group и использует её платформы и технологии.

Octavia (название впервые появилось в 1959 году) стала символом марки: практичный лифтбэк с огромным багажником. В России Octavia много лет собиралась в Калуге и Нижнем Новгороде.'),
    ('bmw', 'BMW', 'Германия', 1916, 'Bayerische Motoren Werke (BMW) основана в Мюнхене в 1916 году как производитель авиационных двигателей. Сине-белая эмблема отсылает к цветам флага Баварии. В 1923 году вышел первый мотоцикл R 32, а в 1928-м, после покупки завода в Айзенахе, первый автомобиль.

После Второй мировой войны компания была на грани банкротства. Спасли её «Новый класс» 1960-х и поддержка семьи Квандт. С тех пор BMW строит свою репутацию на слогане «Freude am Fahren» (удовольствие от вождения) и заднеприводных компоновках.

3 серия выпускается с 1975 года и считается эталоном спортивного седана среднего класса. Поколение G20 дебютировало в 2018 году.'),
    ('mercedes-benz', 'Mercedes-Benz', 'Германия', 1926, 'Истоки марки уходят в 1886 год, когда Карл Бенц запатентовал Motorwagen, считающийся первым в мире автомобилем с бензиновым двигателем. Параллельно Готлиб Даймлер и Вильгельм Майбах строили свои моторы. Имя Mercedes появилось в 1900 году, в честь дочери дистрибьютора Эмиля Еллинека.

В 1926 году компании Benz & Cie. и Daimler-Motoren-Gesellschaft объединились в Daimler-Benz, и появилась марка Mercedes-Benz с трёхлучевой звездой. Многие технологии компании стали стандартом индустрии: зоны деформации, ABS, подушки безопасности.

E-класс, бизнес-седан марки, ведёт родословную от «понтонных» моделей 1950-х. Поколение W213 выпускалось с 2016 по 2023 год.'),
    ('mazda', 'Mazda', 'Япония', 1920, 'Mazda основана в Хиросиме в 1920 году под названием Toyo Cork Kogyo и сначала производила пробку. В 1931 году компания выпустила трёхколёсный грузовик Mazda-Go, а в 1960-м первый легковой автомобиль R360.

Mazda известна приверженностью роторному двигателю Ванкеля: RX-7, RX-8, а в 1991 году победа в гонке «24 часа Ле-Мана» на 787B. В 1989 году вышел родстер MX-5, самый продаваемый двухместный спорткар в истории.

Современные модели строятся по философии дизайна Kodo («душа движения») и технологии SKYACTIV. CX-5, представленный в 2012 году, стал самой продаваемой моделью марки. В России он собирался во Владивостоке.'),
    ('haval', 'Haval', 'Китай', 2013, 'Haval выделился в отдельный бренд в 2013 году внутри Great Wall Motor, крупнейшего частного автопроизводителя Китая (основан в 1984 году). Название образовано от английского «Have all» («иметь всё»). Бренд специализируется исключительно на кроссоверах и внедорожниках.

В 2019 году в Тульской области открылся завод Haval полного цикла со штамповкой, сваркой и окраской. Это первое в России производство китайского автопроизводителя такого уровня.

Jolion, компактный кроссовер, дебютировал в 2020 году и быстро стал одним из самых продаваемых автомобилей в России.');

-- ----------------------------------------------------------------------
-- toyota-camry
-- ----------------------------------------------------------------------
INSERT INTO cars (slug, brand_id, model, generation, year_from, year_to, body_type, car_class, description, aliases, auto_ru_url, avito_url, sort_order)
SELECT 'toyota-camry', id, 'Camry', 'XV70', 2017, 2024, 'Седан', 'E (бизнес)',
       'Восьмое поколение самого известного японского седана построено на платформе TNGA-K. Автомобиль получил более низкий центр тяжести, выразительный дизайн и просторный салон. В России Camry долго была эталоном бизнес-седана и собиралась в Санкт-Петербурге.',
       'тойота камри тоёта', 'https://auto.ru/cars/toyota/camry/all/', 'https://www.avito.ru/all/avtomobili/toyota/camry', 10
FROM brands WHERE slug = 'toyota';

INSERT INTO car_specs (car_id, version_note, engine_type, engine_volume_cc, power_hp, torque_nm, transmission, drive, acceleration_s, top_speed_kmh, fuel_consumption_l, fuel_tank_l, length_mm, width_mm, height_mm, wheelbase_mm, curb_weight_kg, trunk_l, seats)
SELECT id, '2.5 AT (181 л.с.)', 'Бензиновый, атмосферный', 2487, 181, 231, 'Автомат, 8 ступеней', 'Передний', 9.9, 210, 7.8, 60, 4885, 1840, 1455, 2825, 1570, 493, 5
FROM cars WHERE slug = 'toyota-camry';

INSERT INTO car_images (car_id, url, source_url, author, license, position)
SELECT id, 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ef/Toyota_Camry_%28XV70%29_IMG_9081.jpg/1280px-Toyota_Camry_%28XV70%29_IMG_9081.jpg',
       'https://commons.wikimedia.org/wiki/File:Toyota_Camry_%28XV70%29_IMG_9081.jpg', 'Alexander-93', 'CC BY-SA 4.0', 0 FROM cars WHERE slug = 'toyota-camry'
UNION ALL
SELECT id, 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e1/TOYOTA_CAMRY_%28XV70%29_China.jpg/1280px-TOYOTA_CAMRY_%28XV70%29_China.jpg',
       'https://commons.wikimedia.org/wiki/File:TOYOTA_CAMRY_%28XV70%29_China.jpg', 'Dinkun Chen', 'CC BY-SA 4.0', 1 FROM cars WHERE slug = 'toyota-camry'
UNION ALL
SELECT id, 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/TOYOTA_CAMRY_%28XV70%29_China_%283%29.jpg/1280px-TOYOTA_CAMRY_%28XV70%29_China_%283%29.jpg',
       'https://commons.wikimedia.org/wiki/File:TOYOTA_CAMRY_%28XV70%29_China_%283%29.jpg', 'Dinkun Chen', 'CC BY-SA 4.0', 2 FROM cars WHERE slug = 'toyota-camry';

-- ----------------------------------------------------------------------
-- lada-vesta
-- ----------------------------------------------------------------------
INSERT INTO cars (slug, brand_id, model, generation, year_from, year_to, body_type, car_class, description, aliases, auto_ru_url, avito_url, sort_order)
SELECT 'lada-vesta', id, 'Vesta', 'I (NG)', 2015, NULL, 'Седан', 'B+ (компактный)',
       'Самый продаваемый автомобиль в России. Vesta построена на платформе Lada B и отличается большим багажником и дорожным просветом 178 мм. В 2022 году модель обновилась до версии NG с новой оптикой и мультимедиа.',
       'лада веста ваз', 'https://auto.ru/cars/vaz/vesta/all/', 'https://www.avito.ru/all/avtomobili/vaz_lada/vesta', 20
FROM brands WHERE slug = 'lada';

INSERT INTO car_specs (car_id, version_note, engine_type, engine_volume_cc, power_hp, torque_nm, transmission, drive, acceleration_s, top_speed_kmh, fuel_consumption_l, fuel_tank_l, length_mm, width_mm, height_mm, wheelbase_mm, curb_weight_kg, trunk_l, seats)
SELECT id, '1.6 MT (106 л.с.)', 'Бензиновый, атмосферный', 1596, 106, 148, 'Механика, 5 ступеней', 'Передний', 11.8, 178, 7.0, 55, 4420, 1764, 1497, 2635, 1230, 480, 5
FROM cars WHERE slug = 'lada-vesta';

INSERT INTO car_images (car_id, url, source_url, author, license, position)
SELECT id, 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/39/2023_Lada_Vesta_sedan_white_front.jpg/1280px-2023_Lada_Vesta_sedan_white_front.jpg',
       'https://commons.wikimedia.org/wiki/File:2023_Lada_Vesta_sedan_white_front.jpg', 'Throwawayacc222', 'CC0', 0 FROM cars WHERE slug = 'lada-vesta'
UNION ALL
SELECT id, 'https://upload.wikimedia.org/wikipedia/commons/thumb/1/1a/2023_Lada_Vesta_sedan_white_rear.jpg/1280px-2023_Lada_Vesta_sedan_white_rear.jpg',
       'https://commons.wikimedia.org/wiki/File:2023_Lada_Vesta_sedan_white_rear.jpg', 'Throwawayacc222', 'CC0', 1 FROM cars WHERE slug = 'lada-vesta'
UNION ALL
SELECT id, 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d7/Lada_Vesta_sedan_brown_side.jpg/1280px-Lada_Vesta_sedan_brown_side.jpg',
       'https://commons.wikimedia.org/wiki/File:Lada_Vesta_sedan_brown_side.jpg', 'Throwawayacc222', 'CC0', 2 FROM cars WHERE slug = 'lada-vesta';

-- ----------------------------------------------------------------------
-- kia-rio
-- ----------------------------------------------------------------------
INSERT INTO cars (slug, brand_id, model, generation, year_from, year_to, body_type, car_class, description, aliases, auto_ru_url, avito_url, sort_order)
SELECT 'kia-rio', id, 'Rio', 'IV', 2017, 2023, 'Седан', 'B (малый)',
       'Четвёртое поколение Rio создавалось специально для российского рынка и собиралось в Санкт-Петербурге. Надёжный атмосферный мотор, классический «автомат» и доступная цена сделали его одним из самых популярных автомобилей страны.',
       'киа рио кия', 'https://auto.ru/cars/kia/rio/all/', 'https://www.avito.ru/all/avtomobili/kia/rio', 30
FROM brands WHERE slug = 'kia';

INSERT INTO car_specs (car_id, version_note, engine_type, engine_volume_cc, power_hp, torque_nm, transmission, drive, acceleration_s, top_speed_kmh, fuel_consumption_l, fuel_tank_l, length_mm, width_mm, height_mm, wheelbase_mm, curb_weight_kg, trunk_l, seats)
SELECT id, '1.6 AT (123 л.с.)', 'Бензиновый, атмосферный', 1591, 123, 151, 'Автомат, 6 ступеней', 'Передний', 11.2, 192, 6.6, 50, 4400, 1740, 1470, 2600, 1198, 480, 5
FROM cars WHERE slug = 'kia-rio';

INSERT INTO car_images (car_id, url, source_url, author, license, position)
SELECT id, 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/4e/Kia_Rio_sedan_%28Russia%29_%28Front%29.jpg/1280px-Kia_Rio_sedan_%28Russia%29_%28Front%29.jpg',
       'https://commons.wikimedia.org/wiki/File:Kia_Rio_sedan_%28Russia%29_%28Front%29.jpg', 'Peterolthof', 'CC BY-SA 4.0', 0 FROM cars WHERE slug = 'kia-rio'
UNION ALL
SELECT id, 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/9c/Kia_Rio_sedan_%28Russia%29_%28Back%29.jpg/1280px-Kia_Rio_sedan_%28Russia%29_%28Back%29.jpg',
       'https://commons.wikimedia.org/wiki/File:Kia_Rio_sedan_%28Russia%29_%28Back%29.jpg', 'Peterolthof', 'CC BY-SA 4.0', 1 FROM cars WHERE slug = 'kia-rio'
UNION ALL
SELECT id, 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/73/Kia_Rio_2017_%28Russia%29.jpg/1280px-Kia_Rio_2017_%28Russia%29.jpg',
       'https://commons.wikimedia.org/wiki/File:Kia_Rio_2017_%28Russia%29.jpg', 'Milhouse35', 'CC BY-SA 4.0', 2 FROM cars WHERE slug = 'kia-rio';

-- ----------------------------------------------------------------------
-- hyundai-creta
-- ----------------------------------------------------------------------
INSERT INTO cars (slug, brand_id, model, generation, year_from, year_to, body_type, car_class, description, aliases, auto_ru_url, avito_url, sort_order)
SELECT 'hyundai-creta', id, 'Creta', 'I', 2016, 2021, 'Кроссовер', 'J (компактный кроссовер)',
       'Компактный кроссовер, адаптированный для России: увеличенный клиренс 200 мм, подогрев всего, что можно, и версии с полным приводом. Первое поколение Creta сразу стало лидером своего сегмента.',
       'хендай хундай хёндэ крета', 'https://auto.ru/cars/hyundai/creta/all/', 'https://www.avito.ru/all/avtomobili/hyundai/creta', 40
FROM brands WHERE slug = 'hyundai';

INSERT INTO car_specs (car_id, version_note, engine_type, engine_volume_cc, power_hp, torque_nm, transmission, drive, acceleration_s, top_speed_kmh, fuel_consumption_l, fuel_tank_l, length_mm, width_mm, height_mm, wheelbase_mm, curb_weight_kg, trunk_l, seats)
SELECT id, '1.6 AT 2WD (123 л.с.)', 'Бензиновый, атмосферный', 1591, 123, 151, 'Автомат, 6 ступеней', 'Передний', 12.3, 169, 7.8, 55, 4270, 1780, 1630, 2590, 1330, 402, 5
FROM cars WHERE slug = 'hyundai-creta';

INSERT INTO car_images (car_id, url, source_url, author, license, position)
SELECT id, 'https://upload.wikimedia.org/wikipedia/commons/thumb/4/49/HYUNDAI_CRETA_%2C_iX25_%28GS%2CGC%29_China.jpg/1280px-HYUNDAI_CRETA_%2C_iX25_%28GS%2CGC%29_China.jpg',
       'https://commons.wikimedia.org/wiki/File:HYUNDAI_CRETA_%2C_iX25_%28GS%2CGC%29_China.jpg', 'Dinkun Chen', 'CC BY-SA 4.0', 0 FROM cars WHERE slug = 'hyundai-creta'
UNION ALL
SELECT id, 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/HYUNDAI_CRETA_%2C_iX25_%28GS%2CGC%29_China_%289%29.jpg/1280px-HYUNDAI_CRETA_%2C_iX25_%28GS%2CGC%29_China_%289%29.jpg',
       'https://commons.wikimedia.org/wiki/File:HYUNDAI_CRETA_%2C_iX25_%28GS%2CGC%29_China_%289%29.jpg', 'Dinkun Chen', 'CC BY-SA 4.0', 1 FROM cars WHERE slug = 'hyundai-creta'
UNION ALL
SELECT id, 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a4/HYUNDAI_CRETA_%2C_iX25_%28GS%2CGC%29_China_%282%29.jpg/1280px-HYUNDAI_CRETA_%2C_iX25_%28GS%2CGC%29_China_%282%29.jpg',
       'https://commons.wikimedia.org/wiki/File:HYUNDAI_CRETA_%2C_iX25_%28GS%2CGC%29_China_%282%29.jpg', 'Dinkun Chen', 'CC BY-SA 4.0', 2 FROM cars WHERE slug = 'hyundai-creta';

-- ----------------------------------------------------------------------
-- volkswagen-tiguan
-- ----------------------------------------------------------------------
INSERT INTO cars (slug, brand_id, model, generation, year_from, year_to, body_type, car_class, description, aliases, auto_ru_url, avito_url, sort_order)
SELECT 'volkswagen-tiguan', id, 'Tiguan', 'II', 2016, 2024, 'Кроссовер', 'J (компактный кроссовер)',
       'Второе поколение Tiguan построено на модульной платформе MQB. Оно заметно выросло в размерах, получило цифровую приборную панель и богатый набор систем помощи водителю. Модель собиралась в Калуге.',
       'фольксваген тигуан', 'https://auto.ru/cars/volkswagen/tiguan/all/', 'https://www.avito.ru/all/avtomobili/volkswagen/tiguan', 50
FROM brands WHERE slug = 'volkswagen';

INSERT INTO car_specs (car_id, version_note, engine_type, engine_volume_cc, power_hp, torque_nm, transmission, drive, acceleration_s, top_speed_kmh, fuel_consumption_l, fuel_tank_l, length_mm, width_mm, height_mm, wheelbase_mm, curb_weight_kg, trunk_l, seats)
SELECT id, '1.4 TSI DSG (150 л.с.)', 'Бензиновый, турбированный', 1395, 150, 250, 'Робот DSG, 6 ступеней', 'Передний', 9.2, 200, 6.3, 58, 4486, 1839, 1673, 2677, 1520, 615, 5
FROM cars WHERE slug = 'volkswagen-tiguan';

INSERT INTO car_images (car_id, url, source_url, author, license, position)
SELECT id, 'https://upload.wikimedia.org/wikipedia/commons/thumb/0/0d/Volkswagen_Tiguan_II_1.4_TSI_Comfortline_Ruby_Red_01.jpg/1280px-Volkswagen_Tiguan_II_1.4_TSI_Comfortline_Ruby_Red_01.jpg',
       'https://commons.wikimedia.org/wiki/File:Volkswagen_Tiguan_II_1.4_TSI_Comfortline_Ruby_Red_01.jpg', 'Ethan Llamas', 'CC BY-SA 4.0', 0 FROM cars WHERE slug = 'volkswagen-tiguan'
UNION ALL
SELECT id, 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/3e/Volkswagen_Tiguan_II_1.4_TSI_Comfortline_Ruby_Red_02.jpg/1280px-Volkswagen_Tiguan_II_1.4_TSI_Comfortline_Ruby_Red_02.jpg',
       'https://commons.wikimedia.org/wiki/File:Volkswagen_Tiguan_II_1.4_TSI_Comfortline_Ruby_Red_02.jpg', 'Ethan Llamas', 'CC BY-SA 4.0', 1 FROM cars WHERE slug = 'volkswagen-tiguan'
UNION ALL
SELECT id, 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/38/Volkswagen_Tiguan_II_facelift_IMG001.jpg/1280px-Volkswagen_Tiguan_II_facelift_IMG001.jpg',
       'https://commons.wikimedia.org/wiki/File:Volkswagen_Tiguan_II_facelift_IMG001.jpg', 'Zotyefan', 'CC BY-SA 4.0', 2 FROM cars WHERE slug = 'volkswagen-tiguan';

-- ----------------------------------------------------------------------
-- skoda-octavia
-- ----------------------------------------------------------------------
INSERT INTO cars (slug, brand_id, model, generation, year_from, year_to, body_type, car_class, description, aliases, auto_ru_url, avito_url, sort_order)
SELECT 'skoda-octavia', id, 'Octavia', 'IV (A8)', 2019, NULL, 'Лифтбэк', 'C (гольф-класс)',
       'Четвёртое поколение Octavia на платформе MQB Evo: цифровой салон, светодиодная оптика и по-прежнему огромный для своего класса багажник на 600 литров. Лифтбэк сочетает строгий вид седана с практичностью хэтчбека.',
       'шкода октавия', 'https://auto.ru/cars/skoda/octavia/all/', 'https://www.avito.ru/all/avtomobili/skoda/octavia', 60
FROM brands WHERE slug = 'skoda';

INSERT INTO car_specs (car_id, version_note, engine_type, engine_volume_cc, power_hp, torque_nm, transmission, drive, acceleration_s, top_speed_kmh, fuel_consumption_l, fuel_tank_l, length_mm, width_mm, height_mm, wheelbase_mm, curb_weight_kg, trunk_l, seats)
SELECT id, '1.4 TSI AT (150 л.с.)', 'Бензиновый, турбированный', 1395, 150, 250, 'Автомат, 8 ступеней', 'Передний', 8.5, 226, 6.0, 50, 4689, 1829, 1470, 2686, 1310, 600, 5
FROM cars WHERE slug = 'skoda-octavia';

INSERT INTO car_images (car_id, url, source_url, author, license, position)
SELECT id, 'https://upload.wikimedia.org/wikipedia/commons/thumb/3/35/Skoda_Octavia_IV_liftback_1.jpg/1280px-Skoda_Octavia_IV_liftback_1.jpg',
       'https://commons.wikimedia.org/wiki/File:Skoda_Octavia_IV_liftback_1.jpg', 'Mike-fiesta', 'CC BY-SA 4.0', 0 FROM cars WHERE slug = 'skoda-octavia'
UNION ALL
SELECT id, 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/62/Skoda_Octavia_IV_liftback_2.jpg/1280px-Skoda_Octavia_IV_liftback_2.jpg',
       'https://commons.wikimedia.org/wiki/File:Skoda_Octavia_IV_liftback_2.jpg', 'Mike-fiesta', 'CC BY-SA 4.0', 1 FROM cars WHERE slug = 'skoda-octavia'
UNION ALL
SELECT id, 'https://upload.wikimedia.org/wikipedia/commons/thumb/7/76/Skoda_Octavia_IV_liftback_3.jpg/1280px-Skoda_Octavia_IV_liftback_3.jpg',
       'https://commons.wikimedia.org/wiki/File:Skoda_Octavia_IV_liftback_3.jpg', 'Mike-fiesta', 'CC BY-SA 4.0', 2 FROM cars WHERE slug = 'skoda-octavia';

-- ----------------------------------------------------------------------
-- bmw-3-series
-- ----------------------------------------------------------------------
INSERT INTO cars (slug, brand_id, model, generation, year_from, year_to, body_type, car_class, description, aliases, auto_ru_url, avito_url, sort_order)
SELECT 'bmw-3-series', id, '3 серии', 'G20', 2018, NULL, 'Седан', 'D (премиум)',
       'Седьмое поколение «трёшки» стало больше, легче и технологичнее предшественника. Идеальная развесовка 50:50, задний привод и точное рулевое управление делают G20 одним из самых драйверских седанов в классе.',
       'бмв бэха трешка 3 series 3er 320i', 'https://auto.ru/cars/bmw/3er/all/', 'https://www.avito.ru/all/avtomobili/bmw/3_seriya', 70
FROM brands WHERE slug = 'bmw';

INSERT INTO car_specs (car_id, version_note, engine_type, engine_volume_cc, power_hp, torque_nm, transmission, drive, acceleration_s, top_speed_kmh, fuel_consumption_l, fuel_tank_l, length_mm, width_mm, height_mm, wheelbase_mm, curb_weight_kg, trunk_l, seats)
SELECT id, '320i AT (184 л.с.)', 'Бензиновый, турбированный', 1998, 184, 300, 'Автомат, 8 ступеней', 'Задний', 7.1, 235, 6.2, 59, 4709, 1827, 1442, 2851, 1470, 480, 5
FROM cars WHERE slug = 'bmw-3-series';

INSERT INTO car_images (car_id, url, source_url, author, license, position)
SELECT id, 'https://upload.wikimedia.org/wikipedia/commons/thumb/5/5f/BMW_3_SERIES_SEDAN_%28G20%29_China.jpg/1280px-BMW_3_SERIES_SEDAN_%28G20%29_China.jpg',
       'https://commons.wikimedia.org/wiki/File:BMW_3_SERIES_SEDAN_%28G20%29_China.jpg', 'Dinkun Chen', 'CC BY-SA 4.0', 0 FROM cars WHERE slug = 'bmw-3-series'
UNION ALL
SELECT id, 'https://upload.wikimedia.org/wikipedia/commons/thumb/8/85/BMW_3_SERIES_SEDAN_%28G20%29_China_%282%29.jpg/1280px-BMW_3_SERIES_SEDAN_%28G20%29_China_%282%29.jpg',
       'https://commons.wikimedia.org/wiki/File:BMW_3_SERIES_SEDAN_%28G20%29_China_%282%29.jpg', 'Dinkun Chen', 'CC BY-SA 4.0', 1 FROM cars WHERE slug = 'bmw-3-series'
UNION ALL
SELECT id, 'https://upload.wikimedia.org/wikipedia/commons/thumb/d/d2/BMW_3_SERIES_SEDAN_%28G20%29_China_%283%29.jpg/1280px-BMW_3_SERIES_SEDAN_%28G20%29_China_%283%29.jpg',
       'https://commons.wikimedia.org/wiki/File:BMW_3_SERIES_SEDAN_%28G20%29_China_%283%29.jpg', 'Dinkun Chen', 'CC BY-SA 4.0', 2 FROM cars WHERE slug = 'bmw-3-series';

-- ----------------------------------------------------------------------
-- mercedes-benz-e-class
-- ----------------------------------------------------------------------
INSERT INTO cars (slug, brand_id, model, generation, year_from, year_to, body_type, car_class, description, aliases, auto_ru_url, avito_url, sort_order)
SELECT 'mercedes-benz-e-class', id, 'E-класс', 'W213', 2016, 2023, 'Седан', 'E (премиум)',
       'Пятое поколение E-класса перенесло в бизнес-сегмент технологии флагманского S-класса: двойной широкоформатный дисплей, полуавтономное вождение и пневмоподвеску Air Body Control. Это эталон комфорта в своём классе.',
       'мерседес мерс е класс e-class e-klasse e200', 'https://auto.ru/cars/mercedes/e_klasse/all/', 'https://www.avito.ru/all/avtomobili/mercedes-benz/e-klass', 80
FROM brands WHERE slug = 'mercedes-benz';

INSERT INTO car_specs (car_id, version_note, engine_type, engine_volume_cc, power_hp, torque_nm, transmission, drive, acceleration_s, top_speed_kmh, fuel_consumption_l, fuel_tank_l, length_mm, width_mm, height_mm, wheelbase_mm, curb_weight_kg, trunk_l, seats)
SELECT id, 'E 200 AT (197 л.с.)', 'Бензиновый, турбированный', 1991, 197, 320, 'Автомат 9G-Tronic, 9 ступеней', 'Задний', 7.7, 240, 6.9, 66, 4923, 1852, 1468, 2939, 1605, 540, 5
FROM cars WHERE slug = 'mercedes-benz-e-class';

INSERT INTO car_images (car_id, url, source_url, author, license, position)
SELECT id, 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6d/Mercedes-Benz_E-Klasse_%28W213%29_150936.jpg/1280px-Mercedes-Benz_E-Klasse_%28W213%29_150936.jpg',
       'https://commons.wikimedia.org/wiki/File:Mercedes-Benz_E-Klasse_%28W213%29_150936.jpg', 'Trop86', 'CC0', 0 FROM cars WHERE slug = 'mercedes-benz-e-class'
UNION ALL
SELECT id, 'https://upload.wikimedia.org/wikipedia/commons/thumb/a/ae/Mercedes-Benz_E-Klasse_%28W213%29_E_220_d_%282020%29_%2853326573546%29.jpg/1280px-Mercedes-Benz_E-Klasse_%28W213%29_E_220_d_%282020%29_%2853326573546%29.jpg',
       'https://commons.wikimedia.org/wiki/File:Mercedes-Benz_E-Klasse_%28W213%29_E_220_d_%282020%29_%2853326573546%29.jpg', 'Charles from Port Chester, New York', 'CC BY 2.0', 1 FROM cars WHERE slug = 'mercedes-benz-e-class'
UNION ALL
SELECT id, 'https://upload.wikimedia.org/wikipedia/commons/thumb/9/91/Mercedes-Benz_E-Klasse_%282016%29_W213.jpg/1280px-Mercedes-Benz_E-Klasse_%282016%29_W213.jpg',
       'https://commons.wikimedia.org/wiki/File:Mercedes-Benz_E-Klasse_%282016%29_W213.jpg', 'GillyBerlin', 'CC BY 2.0', 2 FROM cars WHERE slug = 'mercedes-benz-e-class';

-- ----------------------------------------------------------------------
-- mazda-cx-5
-- ----------------------------------------------------------------------
INSERT INTO cars (slug, brand_id, model, generation, year_from, year_to, body_type, car_class, description, aliases, auto_ru_url, avito_url, sort_order)
SELECT 'mazda-cx-5', id, 'CX-5', 'II (KF)', 2017, NULL, 'Кроссовер', 'J (компактный кроссовер)',
       'Второе поколение CX-5 выполнено в стиле Kodo. Оно отличается качественным тихим салоном и управляемостью с системой G-Vectoring Control. Двигатели SKYACTIV-G обходятся без турбонаддува, что ценят за надёжность.',
       'мазда сх5 cx5 цх5', 'https://auto.ru/cars/mazda/cx_5/all/', 'https://www.avito.ru/all/avtomobili/mazda/cx-5', 90
FROM brands WHERE slug = 'mazda';

INSERT INTO car_specs (car_id, version_note, engine_type, engine_volume_cc, power_hp, torque_nm, transmission, drive, acceleration_s, top_speed_kmh, fuel_consumption_l, fuel_tank_l, length_mm, width_mm, height_mm, wheelbase_mm, curb_weight_kg, trunk_l, seats)
SELECT id, '2.0 AT 2WD (150 л.с.)', 'Бензиновый, атмосферный', 1998, 150, 213, 'Автомат, 6 ступеней', 'Передний', 10.4, 197, 7.0, 56, 4550, 1840, 1675, 2700, 1520, 506, 5
FROM cars WHERE slug = 'mazda-cx-5';

INSERT INTO car_images (car_id, url, source_url, author, license, position)
SELECT id, 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f8/Mazda_CX-5_%28KF%29_Facelift_1X7A0331_%282%29.jpg/1280px-Mazda_CX-5_%28KF%29_Facelift_1X7A0331_%282%29.jpg',
       'https://commons.wikimedia.org/wiki/File:Mazda_CX-5_%28KF%29_Facelift_1X7A0331_%282%29.jpg', 'Alexander Migl', 'CC BY-SA 4.0', 0 FROM cars WHERE slug = 'mazda-cx-5'
UNION ALL
SELECT id, 'https://upload.wikimedia.org/wikipedia/commons/thumb/c/cb/MAZDA_CX-5_%28KF%29_China_%2811%29.jpg/1280px-MAZDA_CX-5_%28KF%29_China_%2811%29.jpg',
       'https://commons.wikimedia.org/wiki/File:MAZDA_CX-5_%28KF%29_China_%2811%29.jpg', 'Dinkun Chen', 'CC BY-SA 4.0', 1 FROM cars WHERE slug = 'mazda-cx-5'
UNION ALL
SELECT id, 'https://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/2017_Mazda_CX-5_%28KF%29_Maxx_2WD_wagon_%282018-11-02%29_02.jpg/1280px-2017_Mazda_CX-5_%28KF%29_Maxx_2WD_wagon_%282018-11-02%29_02.jpg',
       'https://commons.wikimedia.org/wiki/File:2017_Mazda_CX-5_%28KF%29_Maxx_2WD_wagon_%282018-11-02%29_02.jpg', 'EurovisionNim', 'CC BY-SA 4.0', 2 FROM cars WHERE slug = 'mazda-cx-5';

-- ----------------------------------------------------------------------
-- haval-jolion
-- ----------------------------------------------------------------------
INSERT INTO cars (slug, brand_id, model, generation, year_from, year_to, body_type, car_class, description, aliases, auto_ru_url, avito_url, sort_order)
SELECT 'haval-jolion', id, 'Jolion', 'I', 2020, NULL, 'Кроссовер', 'J (компактный кроссовер)',
       'Компактный кроссовер тульской сборки с турбомотором и роботизированной коробкой с двумя сцеплениями. Богатое оснащение за разумные деньги быстро вывело Jolion в лидеры продаж среди кроссоверов в России.',
       'хавал хавейл джолион жолион', 'https://auto.ru/cars/haval/jolion/all/', 'https://www.avito.ru/all/avtomobili/haval/jolion', 100
FROM brands WHERE slug = 'haval';

INSERT INTO car_specs (car_id, version_note, engine_type, engine_volume_cc, power_hp, torque_nm, transmission, drive, acceleration_s, top_speed_kmh, fuel_consumption_l, fuel_tank_l, length_mm, width_mm, height_mm, wheelbase_mm, curb_weight_kg, trunk_l, seats)
SELECT id, '1.5T DCT 2WD (143 л.с.)', 'Бензиновый, турбированный', 1497, 143, 210, 'Робот DCT, 7 ступеней', 'Передний', 10.5, 180, 7.5, 55, 4472, 1841, 1574, 2700, 1430, 337, 5
FROM cars WHERE slug = 'haval-jolion';

INSERT INTO car_images (car_id, url, source_url, author, license, position)
SELECT id, 'https://upload.wikimedia.org/wikipedia/commons/thumb/f/f0/Haval_Jolion_1st_gen_in_Moscow_2024_front.jpg/1280px-Haval_Jolion_1st_gen_in_Moscow_2024_front.jpg',
       'https://commons.wikimedia.org/wiki/File:Haval_Jolion_1st_gen_in_Moscow_2024_front.jpg', 'Nord794ub', 'CC BY-SA 4.0', 0 FROM cars WHERE slug = 'haval-jolion'
UNION ALL
SELECT id, 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/e3/Haval_Jolion_1st_gen_in_Moscow_2024_back.jpg/1280px-Haval_Jolion_1st_gen_in_Moscow_2024_back.jpg',
       'https://commons.wikimedia.org/wiki/File:Haval_Jolion_1st_gen_in_Moscow_2024_back.jpg', 'Nord794ub', 'CC BY-SA 4.0', 1 FROM cars WHERE slug = 'haval-jolion'
UNION ALL
SELECT id, 'https://upload.wikimedia.org/wikipedia/commons/thumb/e/ed/Haval_Jolion_in_Tomsk_01.jpg/1280px-Haval_Jolion_in_Tomsk_01.jpg',
       'https://commons.wikimedia.org/wiki/File:Haval_Jolion_in_Tomsk_01.jpg', 'Ilya Plekhanov', 'CC BY-SA 4.0', 2 FROM cars WHERE slug = 'haval-jolion';
