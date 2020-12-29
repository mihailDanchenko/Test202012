CREATE TYPE storage.value_unit_type AS ENUM (
    'LITER',
    'METER3',
    'DAL'
    );
CREATE TABLE storage.orders (
    uuid                    UUID                        not null,
    contractor_uuid         UUID                        not null,
    user_uuid               UUID                        not null,
    storage_uuid            UUID                        not null,
    cargo_description       VARCHAR                     not null,
    cargo_value             INTEGER                     not null,
    cargo_value_unit        storage.value_unit_type     not null,
    cargo_weight            INTEGER                     not null,
    file_uuids              UUID[]                      null,
    from_storage_date       DATE                        not null,
    to_storage_date         DATE                        null,
    is_timeless             BOOLEAN                     not null,
    comment                 VARCHAR                     null,
    is_extended             BOOLEAN                     not null default FALSE,
    created_at              TIMESTAMPTZ                 not null default now(),
    updated_at              TIMESTAMPTZ                 not null default now(),
    archived_at             TIMESTAMPTZ                 default null,
    deleted_at              TIMESTAMPTZ                 default null,

CONSTRAINT pk_storage__orders PRIMARY KEY (uuid)
);

CREATE INDEX index_storage__orders__contractor_uuid ON storage.orders (contractor_uuid);
CREATE INDEX index_storage__orders__user_uuid ON storage.orders (user_uuid);
CREATE INDEX index_storage__orders__storage_uuid ON storage.orders (storage_uuid);

COMMENT ON TABLE storage.orders                  IS 'Заказы на аренду склада';
COMMENT ON COLUMN storage.orders.uuid                  IS 'UUID записи';
COMMENT ON COLUMN storage.orders.contractor_uuid       IS 'UUID контрагента';
COMMENT ON COLUMN storage.orders.user_uuid             IS 'UUID пользователя';
COMMENT ON COLUMN storage.orders.storage_uuid          IS 'UUID склада';
COMMENT ON COLUMN storage.orders.cargo_description     IS 'Описание груза';
COMMENT ON COLUMN storage.orders.cargo_value           IS 'Объем груза, в литрах';
COMMENT ON COLUMN storage.orders.cargo_value_unit      IS 'Единица измерения, указанная пользователем';
COMMENT ON COLUMN storage.orders.cargo_weight          IS 'Вес груза в килограммах ';
COMMENT ON COLUMN storage.orders.file_uuids            IS 'Массив идентификаторов приложенных файлов';
COMMENT ON COLUMN storage.orders.from_storage_date     IS 'Дата начала хранения';
COMMENT ON COLUMN storage.orders.to_storage_date       IS 'Дата окончания хранения';
COMMENT ON COLUMN storage.orders.is_timeless           IS 'Признах аренды "До востребования"';
COMMENT ON COLUMN storage.orders.comment               IS 'Комментарий, сопроводительное письмо';
COMMENT ON COLUMN storage.orders.is_extended           IS 'Признак расширенной заявки';
COMMENT ON COLUMN storage.orders.created_at            IS 'Дата и время создания записи';
COMMENT ON COLUMN storage.orders.updated_at            IS 'Дата и время обновления записи';
COMMENT ON COLUMN storage.orders.archived_at           IS 'Дата и время архивирования';
COMMENT ON COLUMN storage.orders.deleted_at            IS 'Дата и время удаления';

