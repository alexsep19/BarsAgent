DROP TABLE SYS_EXECUTION_DEPENDENCY CASCADE CONSTRAINTS;
DROP TABLE SYS_EXECUTION CASCADE CONSTRAINTS;
DROP TABLE SYS_PLAN_DEPENDENCY CASCADE CONSTRAINTS;
DROP TABLE SYS_PLAN CASCADE CONSTRAINTS;
DROP SEQUENCE SEQ_ID_SYS_PLAN;
DROP SEQUENCE SEQ_ID_SYS_EXECUTION;

--
-- SYS_PLAN
--
CREATE SEQUENCE SEQ_ID_SYS_PLAN
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE TABLE SYS_PLAN (
  ID_PK     NUMBER(19) PRIMARY KEY      NOT NULL,
  ALIAS   VARCHAR2(32) DEFAULT NULL   NOT NULL,
  NM    VARCHAR2(1000) DEFAULT NULL NOT NULL,
  ACTIVE  CHAR(1) DEFAULT 1           NOT NULL,
  TASK_ID NUMBER(19)                  NULL,
  CONSTRAINT FK_PLAN_SCHEDULING_TASK FOREIGN KEY (TASK_ID) REFERENCES SYS_SCHEDULING_TASK (ID)
);
CREATE UNIQUE INDEX AU_PLAN_ALIAS_UINDEX
  ON SYS_PLAN (ALIAS);
CREATE UNIQUE INDEX AU_PLAN_NAME_UINDEX
  ON SYS_PLAN (NAME);
COMMENT ON COLUMN SYS_PLAN.ID_PK IS 'Суррогатный ключ';
COMMENT ON COLUMN SYS_PLAN.NM IS 'Наименование действия';
COMMENT ON COLUMN SYS_PLAN.ALIAS IS 'Технический псевдоним';
COMMENT ON COLUMN SYS_PLAN.ACTIVE IS 'Признак активности, не удален из интерфейса';

CREATE TABLE SYS_PLAN_DEPENDENCY (
  PLAN_ID       NUMBER(19) NOT NULL,
  DEPENDENCY_ID NUMBER(19) NOT NULL,
  CONSTRAINT PK_PLAN_ID_DEPENDENCY_ID PRIMARY KEY (PLAN_ID, DEPENDENCY_ID),
  CONSTRAINT FK_PLAN_DEPENDENCY_PID FOREIGN KEY (PLAN_ID) REFERENCES SYS_PLAN (ID),
  CONSTRAINT FK_PLAN_DEPENDENCY_DID FOREIGN KEY (DEPENDENCY_ID) REFERENCES SYS_PLAN (ID)
);

INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (1, 1, 'soup', 'Сварить суп');
INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (2, 3, 'barbecue', 'Шашлык');
INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (3, NULL, 'add-onion', 'Заправить луком');
INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (4, NULL, 'add-potato', 'Заправить картошкой');
INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (5, NULL, 'add-carrot', 'Заправить морковкой');
INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (6, NULL, 'add-cabbage', 'Заправить капустой');
INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (7, NULL, 'boil-meat', 'Отварить мясо');
INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (8, NULL, 'buy-meat', 'Купить мясо');
INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (9, NULL, 'buy-potato', 'Купить картошку');
INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (10, NULL, 'buy-carrot', 'Купить морковку');
INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (11, NULL, 'buy-cabbage', 'Купить капусту');
INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (12, NULL, 'buy-onion', 'Купить лук');
INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (13, NULL, 'marinate-meat', 'Мариновать мясо');
INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (14, NULL, 'kindle-coal', 'Жечь угли в мангале');
INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (15, NULL, 'buy-coal', 'Купить уголь');
INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (16, NULL, 'buy-wax', 'Купить жидкий воск');
INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (17, NULL, 'skewer-meat', 'Нанизать мясо на шампуры');
INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (18, NULL, 'roast-meat', 'Жарить на мангале');

INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (1, 3);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (3, 4);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (3, 5);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (3, 12);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (4, 6);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (4, 9);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (5, 6);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (5, 10);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (6, 7);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (6, 11);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (7, 8);

INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (2, 18);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (18, 17);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (17, 13);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (13, 8);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (13, 12);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (18, 14);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (14, 15);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (14, 16);



INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (21, NULL, 'loadCreditTypes', 'Загрузка типов продуктов');
INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (22, NULL, 'loadEventTypes', 'Загрузка типов событий');
INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (23, NULL, 'loadRestructingTypes', 'Загрузка типов реструктуризации');
INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (24, NULL, 'loadScheduleTypes', 'Загрузка типов графиков');

INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (25, NULL, 'loadCurrencies', 'Загрузка валют');
INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (26, NULL, 'loadCalendars', 'Загрузка производственных календарей');
INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (27, NULL, 'loadRates', 'Загрузка курсов валют');
INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (28, NULL, 'loadCustomers', 'Загрузка покупателей');
INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (29, NULL, 'loadAccounts', 'Загрузка счетов');
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (26, 25);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (27, 25);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (27, 26);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (29, 25);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (29, 28);

INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (30, NULL, 'loadFacilities', 'Загрузка договоров');
INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (31, NULL, 'loadDeals', 'Загрузка сделок');
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (31, 30);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (31, 25);

INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (32, NULL, 'loadBalance', 'Загрузка остатков в разрезе сделки');
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (32, 29);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (32, 31);

INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (33, NULL, 'loadSchedules', 'Загрузка графиков');
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (33, 25);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (33, 31);

INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (34, NULL, 'loadFlows', 'Загрузка графиков погашения сделки');
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (34, 33);

INSERT INTO SYS_PLAN (ID, TASK_ID, ALIAS, NAME) VALUES (35, 2, 'loadDataLayer', 'Загрузка слоя дата');
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (35, 21);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (35, 22);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (35, 23);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (35, 24);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (35, 26);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (35, 30);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (35, 31);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (35, 32);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (35, 33);
INSERT INTO SYS_PLAN_DEPENDENCY (PLAN_ID, DEPENDENCY_ID) VALUES (35, 34);







--
-- SYS_EXECUTION
--
CREATE SEQUENCE SEQ_ID_SYS_EXECUTION
START WITH 1
INCREMENT BY 1
NOCACHE
NOCYCLE;

CREATE TABLE SYS_EXECUTION (
  ID_PK        NUMBER(19) PRIMARY KEY      NOT NULL,
  ALIAS      VARCHAR2(32) DEFAULT NULL   NOT NULL,
  NM       VARCHAR2(1000) DEFAULT NULL NOT NULL,
  ACTIVE     CHAR(1) DEFAULT 1           NOT NULL,
  START_DATE TIMESTAMP                   NULL,
  STOP_DATE  TIMESTAMP                   NULL,
  TASK_ID    NUMBER(19)                  NULL,
  CONSTRAINT FK_EXECUTION_SCHEDULING_TASK FOREIGN KEY (TASK_ID) REFERENCES SYS_SCHEDULING_TASK (ID)
);
CREATE UNIQUE INDEX AU_EXECUTION_ALIAS_UINDEX
  ON SYS_EXECUTION (ALIAS);
CREATE UNIQUE INDEX AU_EXECUTION_NAME_UINDEX
  ON SYS_EXECUTION (NAME);
COMMENT ON COLUMN SYS_EXECUTION.ID_PK IS 'Суррогатный ключ';
COMMENT ON COLUMN SYS_EXECUTION.NM IS 'Наименование действия';
COMMENT ON COLUMN SYS_EXECUTION.ALIAS IS 'Технический псевдоним';
COMMENT ON COLUMN SYS_EXECUTION.ACTIVE IS 'Признак активности, не удален из интерфейса';

CREATE TABLE SYS_EXECUTION_DEPENDENCY (
  EXECUTION_ID  NUMBER(19) NOT NULL,
  DEPENDENCY_ID NUMBER(19) NOT NULL,
  CONSTRAINT PK_EXECUTION_ID_DEPENDENCY_ID PRIMARY KEY (EXECUTION_ID, DEPENDENCY_ID),
  CONSTRAINT FK_EXECUTION_DEPENDENCY_PID FOREIGN KEY (EXECUTION_ID) REFERENCES SYS_EXECUTION (ID),
  CONSTRAINT FK_EXECUTION_DEPENDENCY_DID FOREIGN KEY (DEPENDENCY_ID) REFERENCES SYS_EXECUTION (ID)
);

DELETE FROM SYS_EXECUTION_DEPENDENCY;
DELETE FROM SYS_EXECUTION;

INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (1, 1, 'soup', 'Сварить суп');
INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (2, 3, 'barbecue', 'Шашлык');
INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (3, NULL, 'add-onion', 'Заправить луком');
INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (4, NULL, 'add-potato', 'Заправить картошкой');
INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (5, NULL, 'add-carrot', 'Заправить морковкой');
INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (6, NULL, 'add-cabbage', 'Заправить капустой');
INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (7, NULL, 'boil-meat', 'Отварить мясо');
INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (8, NULL, 'buy-meat', 'Купить мясо');
INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (9, NULL, 'buy-potato', 'Купить картошку');
INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (10, NULL, 'buy-carrot', 'Купить морковку');
INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (11, NULL, 'buy-cabbage', 'Купить капусту');
INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (12, NULL, 'buy-onion', 'Купить лук');
INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (13, NULL, 'marinate-meat', 'Мариновать мясо');
INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (14, NULL, 'kindle-coal', 'Жечь угли в мангале');
INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (15, NULL, 'buy-coal', 'Купить уголь');
INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (16, NULL, 'buy-wax', 'Купить жидкий воск');
INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (17, NULL, 'skewer-meat', 'Нанизать мясо на шампуры');
INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (18, NULL, 'roast-meat', 'Жарить на мангале');

INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (1, 3);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (3, 4);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (3, 5);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (3, 12);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (4, 6);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (4, 9);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (5, 6);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (5, 10);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (6, 7);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (6, 11);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (7, 8);

INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (2, 18);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (18, 17);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (17, 13);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (13, 8);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (13, 12);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (18, 14);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (14, 15);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (14, 16);



INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (21, NULL, 'loadCreditTypes', 'Загрузка типов продуктов');
INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (22, NULL, 'loadEventTypes', 'Загрузка типов событий');
INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (23, NULL, 'loadRestructingTypes', 'Загрузка типов реструктуризации');
INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (24, NULL, 'loadScheduleTypes', 'Загрузка типов графиков');

INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (25, NULL, 'loadCurrencies', 'Загрузка валют');
INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (26, NULL, 'loadCalendars', 'Загрузка производственных календарей');
INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (27, NULL, 'loadRates', 'Загрузка курсов валют');
INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (28, NULL, 'loadCustomers', 'Загрузка покупателей');
INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (29, NULL, 'loadAccounts', 'Загрузка счетов');
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (26, 25);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (27, 25);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (27, 26);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (29, 25);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (29, 28);

INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (30, NULL, 'loadFacilities', 'Загрузка договоров');
INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (31, NULL, 'loadDeals', 'Загрузка сделок');
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (31, 30);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (31, 25);

INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (32, NULL, 'loadBalance', 'Загрузка остатков в разрезе сделки');
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (32, 29);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (32, 31);

INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (33, NULL, 'loadSchedules', 'Загрузка графиков');
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (33, 25);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (33, 31);

INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (34, NULL, 'loadFlows', 'Загрузка графиков погашения сделки');
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (34, 33);

INSERT INTO SYS_EXECUTION (ID, TASK_ID, ALIAS, NAME) VALUES (35, 2, 'loadDataLayer', 'Загрузка слоя дата');
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (35, 21);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (35, 22);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (35, 23);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (35, 24);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (35, 25);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (35, 26);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (35, 27);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (35, 28);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (35, 29);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (35, 30);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (35, 31);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (35, 32);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (35, 33);
INSERT INTO SYS_EXECUTION_DEPENDENCY (EXECUTION_ID, DEPENDENCY_ID) VALUES (35, 34);