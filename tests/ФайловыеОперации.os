#Использовать asserts
#Использовать logos
#Использовать tempfiles
#Использовать fs
#Использовать "../src"

Перем юТест;
Перем Лог;
Перем МенеджерВременныхФайлов;

// Основная точка входа
Функция ПолучитьСписокТестов(ЮнитТестирование) Экспорт
	
	ПередЗапускомТестов();
	
	юТест = ЮнитТестирование;
	
	ВсеТесты = Новый Массив;
	  
	ВсеТесты.Добавить("Тест_ПолучениеРесурсов");
	ВсеТесты.Добавить("Тест_СериализацияИДесериализация");
	
	Возврат ВсеТесты;
	
КонецФункции

Процедура ПередЗапускомТестов()
	
	Попытка
		ВремТестер = Новый Тестер;
		Лог = Логирование.ПолучитьЛог(ВремТестер.ИмяЛога());
	Исключение
		Лог = Логирование.ПолучитьЛог("Test");
	КонецПопытки;
	
КонецПроцедуры

Процедура ПередЗапускомТеста() Экспорт
	
	ПараметрыПриложения.УстановитьРежимОтладки();
	
	МенеджерВременныхФайлов = Новый МенеджерВременныхФайлов;
	
КонецПроцедуры

Процедура ПослеЗапускаТеста() Экспорт
	
	МенеджерВременныхФайлов.Удалить();
	МенеджерВременныхФайлов = Неопределено;
	
КонецПроцедуры

Процедура Тест_ПолучениеРесурсов() Экспорт
	
	Файл = Новый Файл(ФайловыеОперации.Ресурсы());

	Ожидаем.Что(Файл.Существует(), "Директории не существует").ЭтоИстина();
	Ожидаем.Что(Файл.ЭтоКаталог(), "Не является директорией").ЭтоИстина();
	Ожидаем.Что(НайтиФайлы(ФайловыеОперации.Ресурсы(), "*.json").Количество(), "Изменилось количество ресурсов").Равно(4);

КонецПроцедуры

Процедура Тест_СериализацияИДесериализация() Экспорт

	ПутьКФайлу = МенеджерВременныхФайлов.СоздатьФайл("test.json");

	Объект = ФайловыеОперации.ПрочитатьОбъект(ФайловыеОперации.РесурсОтчет(), Истина);
	Ожидаем.Что(ТипЗнч(Объект), "Типы не совпали").Равно(Тип("Соответствие"));

	ФайловыеОперации.ЗаписатьОбъект(ПутьКФайлу, Объект);

КонецПроцедуры
