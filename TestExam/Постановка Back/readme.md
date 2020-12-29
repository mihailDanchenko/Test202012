## Методы REST api

### Создание заявки

**Описание сервиса**

Эндпоинт `POST {server}/v1/order/{uuid}`

Параметры запроса:

{uuid} -идентификатор создаваемой заявки

Метод выполняется с токеном пользователя

[OpenApi]

**Пример тела запроса:**

```json5
{
  "cargo_description": "Комплекты деталей металопроката",
  "cargo_value": 0,
  "cargo_value_unit": "LITER",
  "cargo_weight": 0,
  "fileUuids": [
    "3fa85f64-5717-4562-b3fc-2c963f66afa6"
  ],
  "from_storage_date": "2020-12-29",
  "to_storage_date": "2020-12-29",
  "is_timeless": true,
  "comment": "Добрый день! Очень заинтересовал ваш склад"
}
```

**Логика работы метода:**
1. Получить идентификатор заявки в строке запроса и данные в теле запроса.
2. Сохранить данные в таблице [orders.sql] в соответствии с мапингом:

| Поле в таблице    | Поле в JSON если не указано иное       |
|:------------------|:---------------------------------------|
| uuid              | =uuid_generate_v1()                    |
| contractor_uuid   | contractor_uuid из токена пользователя |
| user_uuid         | user_uuid из токена пользователя       |
| storage_uuid      | storage_uuid                           |
| cargo_description | cargo_description                      |
| cargo_value       | cargo_value                            |
| cargo_value_unit  | cargo_value_unit                       |
| cargo_weight      | cargo_weight                           |
| file_uuids        | file_uuids                             |
| from_storage_date | from_storage_date                      |
| to_storage_date   | to_storage_date                        |
| is_timeless       | is_timeless                            |
| comment           | comment                                |
| is_extended       | is_extended                            |
| created_at        | =now()                                 |
| updated_at        | =now()                                 |
| archived_at       | null                                   |
| deleted_at        | null                                   |

3. В случае ошибки сохранения - вернуть ошибку в ответе метода.

[orders.sql]: /TestExam/orders.sql
[OpenApi]: /TestExam/OpenAPI.yaml