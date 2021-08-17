﻿
#Область ОбработчикиСобытийФормы

&НаСервере
Процедура ПриСохраненииДанныхВНастройкахНаСервере(Настройки)
	
	ПоследниеНавигационныеСсылки = Элементы.НавигационнаяСсылкаСтрока.СписокВыбора;
	Настройки.Вставить("ПоследниеНавигационныеСсылки", ПоследниеНавигационныеСсылки);
	
КонецПроцедуры

&НаСервере
Процедура ПриЗагрузкеДанныхИзНастроекНаСервере(Настройки)
	
	#Область ПоследниеНавигационныеСсылки
	ПоследниеНавигационныеСсылки = Настройки["ПоследниеНавигационныеСсылки"];
	Если ПоследниеНавигационныеСсылки = Неопределено Тогда ПоследниеНавигационныеСсылки = Новый СписокЗначений КонецЕсли;
	ПредставленияНавСсылок = ПредставленияНавигационныхСсылок(ПоследниеНавигационныеСсылки.ВыгрузитьЗначения());
	СписокВыбора = Элементы.НавигационнаяСсылкаСтрока.СписокВыбора;
	Для каждого ЭлементСписка Из ПоследниеНавигационныеСсылки Цикл
		СписокВыбора.Добавить(ЭлементСписка.Значение, ПредставлениеНавигационнойСсылкиФорматированнаяСтрока(ЭлементСписка.Значение, ПредставленияНавСсылок[ЭлементСписка.Значение]));	
	КонецЦикла; 
	#КонецОбласти // ПоследниеНавигационныеСсылки  
		
КонецПроцедуры

&НаКлиенте
Процедура ПриОткрытии(Отказ)         
	
	ТекстИзБуфераОбмена = ТекстИзБуфераОбмена();
	Если ЭтоНавигационнаяСсылка(ТекстИзБуфераОбмена) Тогда
		ЭлементНавСсылка = Элементы.НавигационнаяСсылкаСтрока;
		ЭтаФорма.ТекущийЭлемент = ЭлементНавСсылка;
		НавигационнаяСсылкаСтрока = ТекстИзБуфераОбмена;
		НавигационнаяСсылкаСтрокаПриИзменении(ЭлементНавСсылка);
	КонецЕсли;    
	
	УправлениеФормой(ЭтаФорма);

КонецПроцедуры

#КонецОбласти // ОбработчикиСобытийФормы

#Область ОбработчикиСобытийЭлементовФормы

&НаКлиенте
Процедура НавигационнаяСсылкаСтрокаПриИзменении(Элемент)
	
	ЗаполнитьВедомыеРеквизитыНавигационнойСсылки();
	
	СписокВыбора = Элементы.НавигационнаяСсылкаСтрока.СписокВыбора;
	Если ЗначениеЗаполнено(НавигационнаяСсылкаПредставление) Тогда
		ЭлементСписка = СписокВыбора.НайтиПоЗначению(НавигационнаяСсылкаСтрока);
		Если ЭлементСписка = Неопределено Тогда
			ЭлементСписка = СписокВыбора.Добавить(НавигационнаяСсылкаСтрока);
		КонецЕсли; 
		ЭлементСписка.Представление = ПредставлениеНавигационнойСсылкиФорматированнаяСтрока(НавигационнаяСсылкаСтрока, НавигационнаяСсылкаПредставление);
		СписокВыбора.Сдвинуть(ЭлементСписка, - СписокВыбора.Индекс(ЭлементСписка));	
		МаксКоличествоЭлементовСписка = 42;
		Пока СписокВыбора.Количество() > МаксКоличествоЭлементовСписка Цикл
		    СписокВыбора.Удалить(МаксКоличествоЭлементовСписка);
		КонецЦикла;
		ЭтаФорма.СохраняемыеВНастройкахДанныеМодифицированы = Истина;
	КонецЕсли;    
	
	УправлениеФормой(ЭтаФорма);
	
КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьВедомыеРеквизитыНавигационнойСсылки()
	
	НавигационнаяСсылкаПредставление = ПредставлениеНавигационнойСсылки(НавигационнаяСсылкаСтрока);
	УникальныйИдентификаторОбъекта	 = Новый УникальныйИдентификатор;
	СсылкаНаОбъект					 = СсылкаНаОбъектНавигационнойСсылки(НавигационнаяСсылкаСтрока, УникальныйИдентификаторОбъекта);
	УникальныйИдентификаторСтрока	 = УникальныйИдентификаторОбъекта;
	ЗаполнитьКодыПолученияСсылок();

КонецПроцедуры

&НаКлиенте
Процедура ЗаполнитьКодыПолученияСсылок()
	
	КодПолученияСсылкиПоКодуНомеру	 = ТекстМодуляПолученияСсылкиПоКодуНомеру(СсылкаНаОбъект);
	КодПолученияСсылкиПоНаименованию = ТекстМодуляПолученияСсылкиПоНаименованию(СсылкаНаОбъект);
	КодПолученияСсылкиПоУнИд		 = ТекстМодуляПолученияСсылкиПоУникальномуИдентификатору(СсылкаНаОбъект);
	
КонецПроцедуры

&НаКлиенте
Процедура НавигационнаяСсылкаПредставлениеНажатие(Элемент, СтандартнаяОбработка)
	Если ЗначениеЗаполнено(НавигационнаяСсылкаСтрока) Тогда
		СтандартнаяОбработка = Ложь;
		ПерейтиПоНавигационнойСсылке(НавигационнаяСсылкаСтрока);
	КонецЕсли;
КонецПроцедуры
 
#КонецОбласти // ОбработчикиСобытийЭлементовФормы

#Область ОбработчикиКомандФормы

&НаКлиенте
Процедура СкопироватьКодПолученияСсылкиПоУнИд(Команда)
	ТекстВБуферОбмена(КодПолученияСсылкиПоУнИд);
КонецПроцедуры

&НаКлиенте
Процедура СкопироватьКодПолученияСсылкиПоКодуНомеру(Команда)
	ТекстВБуферОбмена(КодПолученияСсылкиПоКодуНомеру);
КонецПроцедуры

&НаКлиенте
Процедура СкопироватьКодПолученияСсылкиПоНаименованию(Команда)
	ТекстВБуферОбмена(КодПолученияСсылкиПоНаименованию);
КонецПроцедуры

#КонецОбласти // ОбработчикиКомандФормы

#Область СлужебныеПроцедурыИФункции

&НаКлиентеНаСервереБезКонтекста
Процедура УправлениеФормой(ЭтаФорма) 
	
	ЭтаФорма.Элементы.СкопироватьКодПолученияСсылкиПоУнИд.Доступность			 = ЗначениеЗаполнено(ЭтаФорма.КодПолученияСсылкиПоУнИд);
	ЭтаФорма.Элементы.СкопироватьКодПолученияСсылкиПоКодуНомеру.Доступность		 = ЗначениеЗаполнено(ЭтаФорма.КодПолученияСсылкиПоКодуНомеру);
	ЭтаФорма.Элементы.СкопироватьКодПолученияСсылкиПоНаименованию.Доступность	 = ЗначениеЗаполнено(ЭтаФорма.КодПолученияСсылкиПоНаименованию);

КонецПроцедуры // УправлениеФормой()

&НаСервереБезКонтекста
Функция ПолучитьУникальныйИдентификаторНавигационнойСсылки(НавигационнаяСсылка)

	Если не ЗначениеЗаполнено(НавигационнаяСсылка) Тогда
		Возврат новый УникальныйИдентификатор("00000000-0000-0000-0000-000000000000");
	КонецЕсли; 	
	
	Ссылка = СсылкаНаОбъектНавигационнойСсылки(НавигационнаяСсылка);
	
	Если ЗначениеЗаполнено(Ссылка) Тогда
		Возврат Ссылка.УникальныйИдентификатор();	
	КонецЕсли; 

КонецФункции // ПолучитьУникальныйИдентификаторНавигационнойСсылки()

// Преобразует уникальный идентификатор в шестнадцатеричное число,
//	которое используется в навигационных ссылках
//
// Параметры:
//  УникальныйИдентификатор	 - УникальныйИдентификатор, Строка	 - Преобразуемый идентификатор
//  ДобавитьПрефикс			 - Булево							 - Если Истина - к числу будет добавлен префикс "0x"
// 
// Возвращаемое значение:
//   - Строка   - Сформированное строковое представление числа, Если формат идентификатора не верен, возвращается Неопределено.
//
&НаКлиентеНаСервереБезКонтекста
Функция УникальныйИдентификаторВШестнадцатеричноеЧисло(Знач УникальныйИдентификатор, ДобавитьПрефикс = Истина)

	// Входящее:	00112233-4455-6677-8899-aabbccddeeff
	// Ожидается:	[0x]8899aabbccddeeff6677445500112233
	
	СоставныеЧасти = СтрРазделить(Строка(УникальныйИдентификатор), "-", Ложь);
	Если СоставныеЧасти.Количество() <> 5 Тогда Возврат Неопределено КонецЕсли; 	
	
	ШестнадцатеричноеЧисло = 
	?(ДобавитьПрефикс, "0x", "")
	+ СоставныеЧасти[3]		// 8899 
	+ СоставныеЧасти[4]		// aabbccddeeff
	+ СоставныеЧасти[2]		// 6677
	+ СоставныеЧасти[1]		// 4455
	+ СоставныеЧасти[0];	// 00112233
	
	Возврат ШестнадцатеричноеЧисло;

КонецФункции // УникальныйИдентификаторВШестнадцатеричноеЧисло()

// Формирует уникальный идентификатор из шестнадцатеричного числа
//
// Параметры:
//  ШестнадцатеричноеЧисло	 - 	 - 
// 
// Возвращаемое значение:
//   - 
//
&НаКлиентеНаСервереБезКонтекста
Функция УникальныйИдентификаторИзШестнадцатеричногоЧисла(Знач ШестнадцатеричноеЧисло)

	// Входящее:	[0x]8899aabbccddeeff6677445500112233
	// Ожидается:	00112233-4455-6677-8899-aabbccddeeff
	
	ШестнадцатеричноеЧислоБезПрефикса = СтрЗаменить(ШестнадцатеричноеЧисло, "0x", "");
	Если СтрДлина(ШестнадцатеричноеЧислоБезПрефикса) <> 32 Тогда Возврат Неопределено КонецЕсли;
	
	// Разметка:        1   5           17  21  25
	// Входящее:	[0x]8899aabbccddeeff6677445500112233
	ЧастиЧисла = Новый Массив;
	ЧастиЧисла.Добавить(Сред(ШестнадцатеричноеЧислоБезПрефикса, 1,	 4));	// 8899
	ЧастиЧисла.Добавить(Сред(ШестнадцатеричноеЧислоБезПрефикса, 5,	 12));	// aabbccddeeff
	ЧастиЧисла.Добавить(Сред(ШестнадцатеричноеЧислоБезПрефикса, 17,	 4));	// 6677
	ЧастиЧисла.Добавить(Сред(ШестнадцатеричноеЧислоБезПрефикса, 21,	 4));	// 4455
	ЧастиЧисла.Добавить(Сред(ШестнадцатеричноеЧислоБезПрефикса, 25,	 8));	// 00112233
	
	УникальныйИдентификатор = Новый УникальныйИдентификатор(
			ЧастиЧисла[4]		// 00112233
	+ "-" + ЧастиЧисла[3]		// 4455
	+ "-" + ЧастиЧисла[2]		// 6677
	+ "-" + ЧастиЧисла[0]		// 8899 
	+ "-" + ЧастиЧисла[1]		// aabbccddeeff
	);
	
	Возврат УникальныйИдентификатор;

КонецФункции // УникальныйИдентификаторИзШестнадцатеричногоЧисла()

&НаКлиентеНаСервереБезКонтекста
Функция ЭтоНавигационнаяСсылка(Строка)

	ОперандДанных	 = "e1cib/data/";
	ОперандСсылки	 = "?ref=";
	
	Возврат ТипЗнч(Строка) = Тип("Строка")
	И ЗначениеЗаполнено(Строка)
	И СтрНачинаетсяС(Строка, ОперандДанных)
	И СтрНайти(Строка, ОперандСсылки) > СтрДлина(ОперандДанных);

КонецФункции // ЭтоНавигационнаяСсылка()

// По навигационной ссылке получает ссылку на объект.
//
// Параметры:
//  НавигационнаяСсылка		 - Строка					 - Навигационная ссылка
//	УникальныйИдентификатор	 - УникальныйИдентификатор	 - Уникальный идентификатор объекта из навигационной ссылки
//  ИмяРеквизита			 - Строка					 - Имя реквизита объекта или колонки табличной части, если указано в навигационной ссылке.
//  ИмяТабличнойЧасти		 - Строка					 - Имя табличной части, если указано в навигационной ссылке.
//  ИндексТабЧасти			 - Число					 - Индекс в табличной части, если указан в навигационной ссылке.
// 
// Возвращаемое значение:
//  Ссылка - Если определить ссылку не удалось - возвращается Неопределено.
//
&НаСервереБезКонтекста
Функция СсылкаНаОбъектНавигационнойСсылки(НавигационнаяСсылка, УникальныйИдентификатор = Неопределено, ИмяРеквизита = Неопределено, ИмяТабличнойЧасти = Неопределено, ИндексТабЧасти = Неопределено)
	
	// Форматы ссылок (см. https://its.1c.ru/db/v8doc):
	// e1cib/data/<путькметаданным>?ref=<идентификаторссылки>
	// e1cib/data/<путькметаданным>.<имяреквизита>?ref=<идентификаторссылки>
	// e1cib/data/<путькметаданным>.<имятабличнойчасти>.<имяреквизита>?ref=<идентификаторссылки>&index=<индексстрокитабличнойчасти>
	
	ОперандДанных	 = "e1cib/data/";
	ОперандСсылки	 = "?ref=";
	ОперандИндекса	 = "&index=";
	
	ПозицияОперандаДанных	 = СтрНайти(НавигационнаяСсылка, ОперандДанных);
	ПозицияОперандаСсылки	 = СтрНайти(НавигационнаяСсылка, ОперандСсылки);
	ПозицияОперандаИндекса	 = СтрНайти(НавигационнаяСсылка, ПозицияОперандаИНдекса);
	
	ЕстьСсылка = Булево(ПозицияОперандаДанных) и Булево(ПозицияОперандаСсылки); 		
	Если не ЕстьСсылка Тогда Возврат Неопределено КонецЕсли;
	
	ПолноеИмяМетаданныхСсылки = Сред(
	НавигационнаяСсылка, 
	ПозицияОперандаДанных + СтрДлина(ОперандДанных),
	(ПозицияОперандаСсылки - 1) - (ПозицияОперандаДанных - 1 + СтрДлина(ОперандДанных))
	);
	
	СтекИмени = СтрРазделить(ПолноеИмяМетаданныхСсылки, ".", Ложь);
	Если СтекИмени.ВГраница() < 1 Тогда Возврат Неопределено КонецЕсли; 
	
	ИмяОбъектаМетаданных = СтекИмени[1];
	ПолноеИмяМетаданного = СтекИмени[0] + "." + СтекИмени[1];	// напр. Документ.ИмяДокумента
	
	ОбъектМетаданных = Метаданные.НайтиПоПолномуИмени(ПолноеИмяМетаданного);
	Если ОбъектМетаданных = Неопределено Тогда Возврат Неопределено КонецЕсли; 
	
	УникальныйИдентификаторШестнЧисло = Сред(НавигационнаяСсылка, ПозицияОперандаСсылки + СтрДлина(ОперандСсылки), 32);
	
	УникальныйИдентификатор = УникальныйИдентификаторИзШестнадцатеричногоЧисла(УникальныйИдентификаторШестнЧисло);
	Если УникальныйИдентификатор = Неопределено Тогда Возврат Неопределено КонецЕсли; 
	
	Если		 Метаданные.Документы				.Содержит(ОбъектМетаданных) Тогда Ссылка = Документы				[ИмяОбъектаМетаданных].ПолучитьСсылку(УникальныйИдентификатор);
	ИначеЕсли	 Метаданные.Справочники				.Содержит(ОбъектМетаданных) Тогда Ссылка = Справочники				[ИмяОбъектаМетаданных].ПолучитьСсылку(УникальныйИдентификатор);
	ИначеЕсли	 Метаданные.ПланыВидовХарактеристик	.Содержит(ОбъектМетаданных) Тогда Ссылка = ПланыВидовХарактеристик	[ИмяОбъектаМетаданных].ПолучитьСсылку(УникальныйИдентификатор);
	ИначеЕсли	 Метаданные.ПланыСчетов				.Содержит(ОбъектМетаданных) Тогда Ссылка = ПланыСчетов				[ИмяОбъектаМетаданных].ПолучитьСсылку(УникальныйИдентификатор);
	ИначеЕсли	 Метаданные.ПланыВидовРасчета		.Содержит(ОбъектМетаданных) Тогда Ссылка = ПланыВидовРасчета		[ИмяОбъектаМетаданных].ПолучитьСсылку(УникальныйИдентификатор);
	ИначеЕсли	 Метаданные.ПланыОбмена				.Содержит(ОбъектМетаданных) Тогда Ссылка = ПланыОбмена				[ИмяОбъектаМетаданных].ПолучитьСсылку(УникальныйИдентификатор);
	ИначеЕсли	 Метаданные.Задачи					.Содержит(ОбъектМетаданных) Тогда Ссылка = Задачи					[ИмяОбъектаМетаданных].ПолучитьСсылку(УникальныйИдентификатор);
	ИначеЕсли	 Метаданные.БизнесПроцессы			.Содержит(ОбъектМетаданных) Тогда Ссылка = БизнесПроцессы			[ИмяОбъектаМетаданных].ПолучитьСсылку(УникальныйИдентификатор);
	Иначе Возврат Неопределено;
	КонецЕсли; 	
	
	Если СтекИмени.ВГраница() = 3 Тогда			// Есть табличная часть и реквизит
		ИмяРеквизита		 = СтекИмени[3];
		ИмяТабличнойЧасти	 = СтекИмени[2];
		ЕстьИндекс = Булево(ПозицияОперандаИндекса);
		Если ЕстьИндекс Тогда
			ИндексТабЧастиСтрокой = Сред(НавигационнаяСсылка, ПозицияОперандаИндекса + СтрДлина(ОперандИндекса));
			Если ЗначениеЗаполнено(ИндексТабЧастиСтрокой) Тогда
				ИндексТабЧасти = Число(ИндексТабЧастиСтрокой);
			иначе
				ИндексТабЧасти = 0;
			КонецЕсли; 
		КонецЕсли; 
	ИначеЕсли СтекИмени.ВГраница() = 3 Тогда	// Есть реквзит
		ИмяРеквизита = СтекИмени[2];
	КонецЕсли; 
	
	Возврат Ссылка;
	
КонецФункции // СсылкаНаОбъектНавигационнойСсылки()

&НаКлиентеНаСервереБезКонтекста
Функция ПредставленияНавигационныхСсылок(НавигационныеСсылки)
	
	Представления = Новый Соответствие;

	ПредставленияНавСсылок = ПолучитьПредставленияНавигационныхСсылок(НавигационныеСсылки);
	Для Индекс = 0 По НавигационныеСсылки.ВГраница() Цикл
		ПредставлениеНавСсылки = ПредставленияНавСсылок[Индекс];
		Если ТипЗнч(ПредставлениеНавСсылки) = Тип("ПредставлениеНавигационнойСсылки") Тогда
			Представление = ПредставлениеНавСсылки.Текст;
		Иначе
			Представление = Неопределено;
		КонецЕсли; 
		Представления.Вставить(НавигационныеСсылки[Индекс], Представление);
	КонецЦикла; 	
	
	Возврат Представления;

КонецФункции // ПредставленияНавигационныхСсылок()
 
&НаКлиентеНаСервереБезКонтекста
Функция ПредставлениеНавигационнойСсылки(НавигационнаяСсылка)
	
	Представление = "";
	
	НавигационныеСсылки = Новый Массив;
	Если ЗначениеЗаполнено(НавигационнаяСсылка) Тогда
		НавигационныеСсылки.Добавить(НавигационнаяСсылка);
	КонецЕсли; 
	ПредставленияНавСсылок = ПолучитьПредставленияНавигационныхСсылок(НавигационныеСсылки);
	Если ЗначениеЗаполнено(ПредставленияНавСсылок) Тогда
		ПредставлениеНавСсылки = ПредставленияНавСсылок[0];
		Если ТипЗнч(ПредставлениеНавСсылки) = Тип("ПредставлениеНавигационнойСсылки") Тогда
			Представление = ПредставлениеНавСсылки.Текст;
		КонецЕсли; 
	КонецЕсли;

	Возврат Представление;
	
КонецФункции	// ПредставлениеНавигационнойСсылки()

&НаКлиентеНаСервереБезКонтекста
Функция ПредставлениеНавигационнойСсылкиФорматированнаяСтрока(НавигационнаяСсылка, Представление)
	
	ШрифтСсылки = Новый Шрифт(,,,, Истина);

	СоставСтроки = новый Массив;
	СоставСтроки.Добавить(Представление);
	СоставСтроки.Добавить(" ");
	СоставСтроки.Добавить(новый ФорматированнаяСтрока(НавигационнаяСсылка, , WebЦвета.Серый));
	
	Возврат Новый ФорматированнаяСтрока(СоставСтроки);

КонецФункции // ПредставлениеНавигационнойСсылкиДляСписка()

// Формирует программный код для получения указанной ссылки через уникальный идентификатор по уникальному идентификатору
// Например: Справочники.Номенклатура.ПолучитьСсылку(Новый УникальныйИдентификатор("00112233-4455-6677-8899-aabbccddeeff"))
//
// Параметры:
//  СсылкаНаОбъект	 - ЛюбаяСсылка	 - Ссылка на объект.
//
// Возвращаемое значение:
//  Строка - Команда для получения ссылки. 
//
&НаСервереБезКонтекста
Функция ТекстМодуляПолученияСсылкиПоУникальномуИдентификатору(СсылкаНаОбъект)
	
	ВозвращаемоеЗначениеПоУмолчанию = "";
	ТекстМодуля = "";
	
	Если Не ЭтоСсылка(СсылкаНаОбъект) Тогда
		Возврат ВозвращаемоеЗначениеПоУмолчанию;
	КонецЕсли; 
	
	ОбъектМетаданных = СсылкаНаОбъект.Метаданные();
	ИмяМенеджера = ИмяМенеджераОбъектаМетаданных(ОбъектМетаданных);
	Если не ЗначениеЗаполнено(ИмяМенеджера) Тогда
		Возврат ВозвращаемоеЗначениеПоУмолчанию;
	КонецЕсли; 
	ИмяОбъектаМетаданных = ОбъектМетаданных.Имя;
	
	Если СсылкаНаОбъект.Пустая() Тогда
		
		ТекстМодуля = СтрШаблон(
		"%1.%2.ПустаяСсылка()",
		ИмяМенеджера,
		ИмяОбъектаМетаданных
		);
		
	Иначе
		
		ТекстМодуля = СтрШаблон(
		"%1.%2.ПолучитьСсылку(Новый УникальныйИдентификатор(""%3""))",
		ИмяМенеджера,
		ИмяОбъектаМетаданных,
		СсылкаНаОбъект.УникальныйИдентификатор()
		);
		
	КонецЕсли;
	
	Возврат ТекстМодуля;

КонецФункции // ТекстМодуляПолученияСсылкиПоКодуНомеру()	
	
// Формирует программный код для получения указанной ссылки через уникальный идентификатор по коду/номеру
// Например: Справочники.Номенклатура.НайтиПоКоду("123456789")
// Требует обращение к серверу для определения кода и получения самого элемента.
// Используется простая форма написания, без поддержки иерархии - для производительности.
// Идентичность не контролируется. Возможно получение другого элемента с таким же кодом/номером в пределах периода нумерации.
//
// Параметры:
//  СсылкаНаОбъект	 - ЛюбаяСсылка	 - Ссылка на объект.
//
// Возвращаемое значение:
//  Строка - Команда для получения ссылки. 
//
&НаСервереБезКонтекста
Функция ТекстМодуляПолученияСсылкиПоКодуНомеру(СсылкаНаОбъект)

	ВозвращаемоеЗначениеПоУмолчанию = "";
	ТекстМодуля = "";
	
	Если Не ЭтоСсылка(СсылкаНаОбъект) Тогда
		Возврат ВозвращаемоеЗначениеПоУмолчанию;
	КонецЕсли; 
	
	ОбъектМетаданных = СсылкаНаОбъект.Метаданные();
	ИмяМенеджера = ИмяМенеджераОбъектаМетаданных(ОбъектМетаданных);
	Если не ЗначениеЗаполнено(ИмяМенеджера) Тогда
		Возврат ВозвращаемоеЗначениеПоУмолчанию;
	КонецЕсли; 
	ИмяОбъектаМетаданных = ОбъектМетаданных.Имя;
	
	МенеджерыИспользующиеКод	 = "Справочники, ПланыВидовХарактеристик, ПланыСчетов, ПланыВидовРасчета, ПланыОбмена";
	МенеджерыИспользующиеНомер	 = "Документы, БизнесПроцессы, Задачи";
	
	КодНомерЭтоЧисло = Ложь;
	
	ИспользуетсяКод = Булево(СтрНайти(МенеджерыИспользующиеКод, ИмяМенеджера))
		И ОбъектМетаданных.ДлинаКода > 0;
	
	ИспользуетсяНомер = Булево(СтрНайти(МенеджерыИспользующиеНомер, ИмяМенеджера))
		И ОбъектМетаданных.ДлинаНомера > 0;
	
	Если Не ИспользуетсяКод И Не ИспользуетсяНомер Тогда
		//ВызватьИсключение СтрШаблон("Объект метаданных %1 не использует ни код, ни номер", ОбъектМетаданных.ПолноеИмя());
		Возврат ВозвращаемоеЗначениеПоУмолчанию;
	КонецЕсли; 
	
	Если Метаданные.Справочники.Содержит(ОбъектМетаданных) Тогда
		КодНомерЭтоЧисло = ОбъектМетаданных.ТипКода = Метаданные.СвойстваОбъектов.ТипКодаСправочника.Число;
	ИначеЕсли Метаданные.ПланыВидовРасчета.Содержит(ОбъектМетаданных) Тогда
		КодНомерЭтоЧисло = ОбъектМетаданных.ТипКода = Метаданные.СвойстваОбъектов.ТипКодаПланаВидовРасчета.Число;
	ИначеЕсли Метаданные.Документы.Содержит(ОбъектМетаданных) Тогда
		КодНомерЭтоЧисло = ОбъектМетаданных.ТипНомера = Метаданные.СвойстваОбъектов.ТипНомераДокумента.Число;
	ИначеЕсли Метаданные.БизнесПроцессы.Содержит(ОбъектМетаданных) Тогда
		КодНомерЭтоЧисло = ОбъектМетаданных.ТипНомера = Метаданные.СвойстваОбъектов.ТипНомераБизнесПроцесса.Число;
	ИначеЕсли Метаданные.Задачи.Содержит(ОбъектМетаданных) Тогда
		КодНомерЭтоЧисло = ОбъектМетаданных.ТипНомера = Метаданные.СвойстваОбъектов.ТипНомераЗадачи.Число;
	КонецЕсли; 	
	
	#Область ПолучениеКодаНомераДаты
	
	ЕстьПериодичностьНомера = 
		(Метаданные.Документы.Содержит(ОбъектМетаданных)
			И ОбъектМетаданных.ПериодичностьНомера <> Метаданные.СвойстваОбъектов.ПериодичностьНомераДокумента.Непериодический) 
		Или (Метаданные.БизнесПроцессы.Содержит(ОбъектМетаданных)
			И ОбъектМетаданных.ПериодичностьНомера <> Метаданные.СвойстваОбъектов.ПериодичностьНомераБизнесПроцесса.Непериодический);
		
	Если ИспользуетсяКод Тогда
		ПоляВыбора = "Код";
	ИначеЕсли ЕстьПериодичностьНомера Тогда
		ПоляВыбора = "Номер, Дата";
	Иначе
		ПоляВыбора = "Номер";
	КонецЕсли; 
	
	Запрос = Новый Запрос;
	Запрос.Текст = 
	СтрШаблон(
	"ВЫБРАТЬ ПЕРВЫЕ 1 %1 ИЗ %2 ГДЕ Ссылка = &Ссылка",
	ПоляВыбора,							// %1
	ОбъектМетаданных.ПолноеИмя());		// %2
	
	Запрос.УстановитьПараметр("Ссылка", СсылкаНаОбъект);
	УстановитьПривилегированныйРежим(Истина);
	РезультатЗапроса = Запрос.Выполнить();
	УстановитьПривилегированныйРежим(Ложь);
	Если РезультатЗапроса.Пустой() Тогда
		ВызватьИсключение "Не удалось получить код/номер объекта";
	КонецЕсли; 
	Выборка = РезультатЗапроса.Выбрать();
	Выборка.Следующий();
	
	ИскомыйКодНомерОбъекта = Выборка[0];
	ИскомаяДатаОбъекта = ?(РезультатЗапроса.Колонки.Количество() > 1, Выборка[1], '00010101');
	#КонецОбласти // ПолучениеКодаНомераДаты 
	
	Если КодНомерЭтоЧисло Тогда
		ПредставлениеКодаНомера = Формат(ИскомыйКодНомерОбъекта, "ЧРД=.; ЧН=0; ЧГ=0");		
	Иначе
		ПредставлениеКодаНомера = """" + СтрЗаменить(ИскомыйКодНомерОбъекта, """", """""") + """";
	КонецЕсли;
	
	Если ИспользуетсяКод Тогда
		
		ТекстМодуля = СтрШаблон(
		"%1.%2.НайтиПоКоду(%3)",
		ИмяМенеджера,
		ИмяОбъектаМетаданных,
		ПредставлениеКодаНомера,
		);
		
	ИначеЕсли ЕстьПериодичностьНомера Тогда
		               
		ДатаПериода = Выборка[1];
		
		ТекстМодуля = СтрШаблон(
		"%1.%2.НайтиПоНомеру(%3, '%4')",
		ИмяМенеджера,
		ИмяОбъектаМетаданных,
		ПредставлениеКодаНомера,
		Формат(ИскомаяДатаОбъекта, "ДФ=ггггММдд")
		);
		
	Иначе
		
		ТекстМодуля = СтрШаблон(
		"%1.%2.НайтиПоНомеру(%3)",
		ИмяМенеджера,
		ИмяОбъектаМетаданных,
		ПредставлениеКодаНомера
		);
	
	КонецЕсли; 
	
	Возврат ТекстМодуля;

КонецФункции // ТекстМодуляПолученияСсылкиПоКодуНомеру()

// Формирует программный код для получения указанной ссылки через уникальный идентификатор по наименованию
// Требует обращение к серверу для определения наименования и получения самого элемента.
// Идентичность не контролируется. Возможно получение другого элемента с таким же наименованием.
//
// Параметры:
//  СсылкаНаОбъект	 - ЛюбаяСсылка	 - Ссылка на объект.
//
// Возвращаемое значение:
//  Строка - Команда для получения ссылки. 
//
&НаСервереБезКонтекста
Функция ТекстМодуляПолученияСсылкиПоНаименованию(СсылкаНаОбъект)

	ВозвращаемоеЗначениеПоУмолчанию = "";
	ТекстМодуля = "";
	
	Если Не ЭтоСсылка(СсылкаНаОбъект) Тогда
		Возврат ВозвращаемоеЗначениеПоУмолчанию;
	КонецЕсли; 
	
	ОбъектМетаданных = СсылкаНаОбъект.Метаданные();
	ИмяМенеджера = ИмяМенеджераОбъектаМетаданных(ОбъектМетаданных);
	Если не ЗначениеЗаполнено(ИмяМенеджера) Тогда
		Возврат ВозвращаемоеЗначениеПоУмолчанию;
	КонецЕсли; 
	ИмяОбъектаМетаданных = ОбъектМетаданных.Имя;
	
	МетаКоллекцииПоддерживающиеНаименование = Новый Массив;
	МетаКоллекцииПоддерживающиеНаименование.Добавить(Метаданные.Задачи);
	МетаКоллекцииПоддерживающиеНаименование.Добавить(Метаданные.ПланыВидовРасчета);
	МетаКоллекцииПоддерживающиеНаименование.Добавить(Метаданные.ПланыВидовХарактеристик);
	МетаКоллекцииПоддерживающиеНаименование.Добавить(Метаданные.ПланыОбмена);
	МетаКоллекцииПоддерживающиеНаименование.Добавить(Метаданные.ПланыСчетов);
	МетаКоллекцииПоддерживающиеНаименование.Добавить(Метаданные.Справочники);
	
	ЕстьНаименование = Ложь;
	Для каждого КоллекцияМетаданных Из МетаКоллекцииПоддерживающиеНаименование Цикл
		Если КоллекцияМетаданных.Содержит(ОбъектМетаданных) Тогда
			ЕстьНаименование = Истина;
			Прервать;
		КонецЕсли; 
	КонецЦикла; 
	
	Если Не ЕстьНаименование Тогда
		//ВызватьИсключение СтрШаблон("Объект метаданных %1 не поддерживает наименование", ОбъектМетаданных.ПолноеИмя());
		Возврат ВозвращаемоеЗначениеПоУмолчанию;
	КонецЕсли; 
	
	Если ОбъектМетаданных.ДлинаНаименования = 0 Тогда
		//ВызватьИсключение СтрШаблон("Объект метаданных %1 не использует наименование", ОбъектМетаданных.ПолноеИмя());
		Возврат ВозвращаемоеЗначениеПоУмолчанию;
	КонецЕсли; 
	
	Запрос = Новый Запрос;
	Запрос.Текст = СтрШаблон("ВЫБРАТЬ ПЕРВЫЕ 1 Наименование ИЗ %1 ГДЕ Ссылка = &Ссылка", ОбъектМетаданных.ПолноеИмя());
	Запрос.УстановитьПараметр("Ссылка", СсылкаНаОбъект);
	УстановитьПривилегированныйРежим(Истина);
	РезультатЗапроса = Запрос.Выполнить();
	УстановитьПривилегированныйРежим(Ложь);
	Если РезультатЗапроса.Пустой() Тогда
		ВызватьИсключение "Не удалось получить наименование объекта";
	КонецЕсли;
	Выборка = РезультатЗапроса.Выбрать();
	Выборка.Следующий();
	ИскомоеНаименованиеОбъекта = Выборка[0];
	ПоисковоеНаименованиеОбъекта = СтрЗаменить(ИскомоеНаименованиеОбъекта, """", """""");
	
	ТекстМодуля = СтрШаблон(
	"%1.%2.НайтиПоНаименованию(""%3"", Истина)",
	ИмяМенеджера,
	ИмяОбъектаМетаданных,
	ПоисковоеНаименованиеОбъекта
	);
		
	Возврат ТекстМодуля;

КонецФункции // ТекстМодуляПолученияСсылкиПоНаименованию()

// Проверка того, что переданный тип является ссылочным типом данных.
// Для типа "Неопределено" возвращается Ложь.
//
// Возвращаемое значение:
//  Булево.
//
&НаСервереБезКонтекста
Функция ЭтоСсылка(Тип)	// БСП

	Если ТипЗнч(Тип) <> Тип("Тип") Тогда
		Возврат ЭтоСсылка(ТипЗнч(Тип))
	КонецЕсли; 
	
	Возврат Тип <> Тип("Неопределено") 
		И (Справочники				.ТипВсеСсылки().СодержитТип(Тип)
		ИЛИ Документы				.ТипВсеСсылки().СодержитТип(Тип)
		ИЛИ Перечисления			.ТипВсеСсылки().СодержитТип(Тип)
		ИЛИ ПланыВидовХарактеристик	.ТипВсеСсылки().СодержитТип(Тип)
		ИЛИ ПланыСчетов				.ТипВсеСсылки().СодержитТип(Тип)
		ИЛИ ПланыВидовРасчета		.ТипВсеСсылки().СодержитТип(Тип)
		ИЛИ БизнесПроцессы			.ТипВсеСсылки().СодержитТип(Тип)
		//ИЛИ БизнесПроцессы.ТипВсеСсылкиТочекМаршрутаБизнесПроцессов().СодержитТип(Тип)
		ИЛИ Задачи					.ТипВсеСсылки().СодержитТип(Тип)
		ИЛИ ПланыОбмена				.ТипВсеСсылки().СодержитТип(Тип));
	
КонецФункции
	
&НаСервереБезКонтекста
Функция ИмяМенеджераОбъектаМетаданных(ОбъектМетаданных)

	Если		 Метаданные.Справочники				.Содержит(ОбъектМетаданных) Тогда ИмяМенеджера = "Справочники";
	ИначеЕсли	 Метаданные.Документы				.Содержит(ОбъектМетаданных) Тогда ИмяМенеджера = "Документы";
	ИначеЕсли	 Метаданные.ПланыВидовХарактеристик	.Содержит(ОбъектМетаданных) Тогда ИмяМенеджера = "ПланыВидовХарактеристик";
	ИначеЕсли	 Метаданные.ПланыСчетов				.Содержит(ОбъектМетаданных) Тогда ИмяМенеджера = "ПланыСчетов";
	ИначеЕсли	 Метаданные.ПланыВидовРасчета		.Содержит(ОбъектМетаданных) Тогда ИмяМенеджера = "ПланыВидовРасчета";
	ИначеЕсли	 Метаданные.ПланыОбмена				.Содержит(ОбъектМетаданных) Тогда ИмяМенеджера = "ПланыОбмена";
	ИначеЕсли	 Метаданные.БизнесПроцессы			.Содержит(ОбъектМетаданных) Тогда ИмяМенеджера = "БизнесПроцессы";
	ИначеЕсли	 Метаданные.Задачи					.Содержит(ОбъектМетаданных) Тогда ИмяМенеджера = "Задачи";
	Иначе ИмяМенеджера = "";
	КонецЕсли; 	
	
	Возврат ИмяМенеджера;

КонецФункции // ИмяМенеджераОбъектаМетаданных()

#Область ВыборСсылкиНаОбъект

&НаСервереБезКонтекста
Функция СписокДопустимыхРазделовМетаданных()

	СписокРазделов = Новый СписокЗначений;
	СписокРазделов.Добавить("Документ",					 "Документ", ,					 БиблиотекаКартинок.Документ);
	СписокРазделов.Добавить("Справочнки",				 "Справочник", ,				 БиблиотекаКартинок.Справочник);
	СписокРазделов.Добавить("ПланВидовХарактеристик",	 "План видов характеристик", ,	 БиблиотекаКартинок.ПланВидовХарактеристик);
	СписокРазделов.Добавить("ПланВидовРасчета",			 "План видов расчета", ,		 БиблиотекаКартинок.ПланВидовРасчета);
	СписокРазделов.Добавить("ПланСчетов",				 "План счетов", ,				 БиблиотекаКартинок.ПланСчетов);
	СписокРазделов.Добавить("ПланОбмена",				 "План видов характеристик", ,	 БиблиотекаКартинок.ПланОбмена);
	
	Возврат СписокРазделов;

КонецФункции // СписокДопустимыхРазделовМетаданных()

&НаСервереБезКонтекста
Функция КартинкаМетаданного(ИмяРазделаМетаданных)

	ЭлементСписка = СписокДопустимыхРазделовМетаданных().НайтиПоЗначению(ИмяРазделаМетаданных);
	Если ЭлементСписка <> Неопределено Тогда
		Возврат ЭлементСписка.Картинка;
	КонецЕсли; 
	
	Возврат Новый Картинка();
	
КонецФункции // КартинкаМетаданного()

#КонецОбласти // ВыборСсылкиНаОбъект 

#Область БуферОбмена

&НаКлиенте
Функция ТекстВБуферОбмена(Текст)

	БуферОбмена = Новый COMОбъект("htmlfile");
	БуферОбмена.ParentWindow.ClipboardData.Setdata("Text", Текст);
	ПоказатьОповещениеПользователя("Скопировано", , Текст);

КонецФункции // ТекстВБуферОбмена()
 
&НаКлиенте
Функция ТекстИзБуфераОбмена() Экспорт
	БуферОбмена = Новый COMОбъект("htmlfile");
	Возврат БуферОбмена.ParentWindow.ClipboardData.Getdata("Text");
КонецФункции // ТекстИзБуфераОбмена()

#КонецОбласти // БуферОбмена 

#КонецОбласти // СлужебныеПроцедурыИФункции






