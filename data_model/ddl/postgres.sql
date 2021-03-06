CREATE EXTENSION IF NOT EXISTS tablefunc;

CREATE TABLE DATA_PNT 
    ( 
     DATA_PNT_ID BIGINT NOT NULL , 
     DATA_PNT_CAN_ID INTEGER , 
     NAME VARCHAR (50) , 
     DESCR VARCHAR (256) , 
     DATA_LEN INTEGER , 
     CAN_DATA_OFFST INTEGER , 
     DATA_TYPE VARCHAR , 
     LOW_ERR_THRHLD DOUBLE PRECISION , 
     LOW_WRNG_THRHLD DOUBLE PRECISION , 
     HIGH_WRNG_THRHLD DOUBLE PRECISION , 
     HIGH_ERR_THRHLD DOUBLE PRECISION , 
     MSRMNT_ID_FK BIGINT NOT NULL , 
     UNITS VARCHAR (30) 
    ) 
;


CREATE INDEX DATA_PNT__IDXv1 ON DATA_PNT 
    ( 
     DATA_PNT_CAN_ID ASC 
    ) 
;

ALTER TABLE DATA_PNT 
    ADD CONSTRAINT DATA_PNT_PK PRIMARY KEY ( DATA_PNT_ID ) ;



CREATE TABLE DEV 
    ( 
     DEV_ID BIGINT NOT NULL , 
     DEV_NAME VARCHAR (255) , 
     DEV_ABBREV VARCHAR (10) 
    ) 
;



ALTER TABLE DEV 
    ADD CONSTRAINT DEV_PK PRIMARY KEY ( DEV_ID ) ;



CREATE TABLE DEV_TYPE 
    ( 
     DEV_TYPE_ID BIGINT NOT NULL , 
     DEV_TYPE VARCHAR (20) 
    ) 
;



ALTER TABLE DEV_TYPE 
    ADD CONSTRAINT DEV_TYPE_PK PRIMARY KEY ( DEV_TYPE_ID ) ;


ALTER TABLE DEV_TYPE 
    ADD CONSTRAINT DEV_TYPE_UK UNIQUE ( DEV_TYPE ) ;



CREATE TABLE LNG_TERM_TREND_DATA 
    ( 
     LNG_TERM_TREND_DATA_ID BIGSERIAL NOT NULL , 
     DATA_PNT_CAN_ID INTEGER , 
     TSTAMP TIMESTAMPTZ , 
     EXTD BOOLEAN , 
     RTR BOOLEAN , 
     DATA_LEN INTEGER , 
     FVAL DOUBLE PRECISION , 
     IVAL INTEGER , 
     CVAL VARCHAR (16) , 
     STATE VARCHAR (10) CHECK ( STATE IN ('HighErr', 'HighWarn', 'LowErr', 'LowWarn', 'Normal')) 
    ) 
;

CREATE TABLE AVG_POWER
    (
     AVG_POWER_ID BIGSERIAL NOT NULL ,
     TSTAMP TIMESTAMPTZ ,
     AVG_POWER DOUBLE PRECISION ,
     INTERVAL INTEGER
    )
;

ALTER TABLE AVG_POWER 
    ADD CONSTRAINT AVG_POWER_PK PRIMARY KEY ( AVG_POWER_ID ) ;



CREATE INDEX LNG_TERM_TREND_DATA_IDXv1 ON LNG_TERM_TREND_DATA 
    ( 
     DATA_PNT_CAN_ID ASC 
    ) 
;
CREATE INDEX LNG_TERM_TREND_DATA_IDXv2 ON LNG_TERM_TREND_DATA 
    ( 
     TSTAMP ASC 
    ) 
;

ALTER TABLE LNG_TERM_TREND_DATA 
    ADD CONSTRAINT LNG_TERM_TREND_DATA_PK PRIMARY KEY ( LNG_TERM_TREND_DATA_ID ) ;



CREATE TABLE MED_TERM_TREND_DATA 
    ( 
     MED_TERM_TREND_DATA_ID BIGSERIAL NOT NULL , 
     DATA_PNT_CAN_ID INTEGER , 
     TSTAMP TIMESTAMPTZ , 
     EXTD BOOLEAN , 
     RTR BOOLEAN , 
     DATA_LEN INTEGER , 
     FVAL DOUBLE PRECISION , 
     IVAL INTEGER , 
     CVAL VARCHAR (16) , 
     STATE VARCHAR (10) CHECK ( STATE IN ('HighErr', 'HighWarn', 'LowErr', 'LowWarn', 'Normal')) 
    ) 
;


CREATE INDEX MED_TERM_TREND_DATA_IDXv1 ON MED_TERM_TREND_DATA 
    ( 
     DATA_PNT_CAN_ID ASC 
    ) 
;
CREATE INDEX MED_TERM_TREND_DATA_IDXv2 ON MED_TERM_TREND_DATA 
    ( 
     TSTAMP ASC 
    ) 
;

ALTER TABLE MED_TERM_TREND_DATA 
    ADD CONSTRAINT MED_TERM_TREND_DATA_PK PRIMARY KEY ( MED_TERM_TREND_DATA_ID ) ;



CREATE TABLE MSRMNT 
    ( 
     MSRMNT_ID BIGINT NOT NULL , 
     MSRMNT_NAME VARCHAR (255) , 
     CAN_ID INTEGER UNIQUE, 
     DEV_ID_FK BIGINT NOT NULL , 
     DEV_TYPE_ID_FK BIGINT NOT NULL , 
     REPRTNG_FRQ INTEGER , 
     MSRMNT_TYPE VARCHAR 
    ) 
;


CREATE INDEX MSRMNT__IDXv1 ON MSRMNT 
    ( 
     CAN_ID ASC 
    ) 
;

ALTER TABLE MSRMNT 
    ADD CONSTRAINT MSRMNT_PK PRIMARY KEY ( MSRMNT_ID ) ;




CREATE TABLE MSRMNT_TYPE 
    (      
     MSRMNT_TYPE_ID BIGINT NOT NULL , 
     MSRMNT_TYPE VARCHAR (255) , 
     LOW_ERR_THRHLD DOUBLE PRECISION , 
     LOW_WRNG_THRHLD DOUBLE PRECISION , 
     HIGH_ERR_THRHLD DOUBLE PRECISION , 
     HIGH_WRNG_THRHLD DOUBLE PRECISION , 
     REPRTNG_FRQ INTEGER 
    ) 
;


CREATE INDEX MSRMNT_TYPE__IDXv1 ON MSRMNT_TYPE
    ( 
     MSRMNT_TYPE_ID ASC 
    ) 
;

ALTER TABLE MSRMNT_TYPE 
    ADD CONSTRAINT MSRMNT_TYPE__PK PRIMARY KEY ( MSRMNT_TYPE_ID ) ;



CREATE TABLE MSRMNT_DATA 
    ( 
     MSRMNT_DATA_ID BIGINT NOT NULL , 
     DATA_PNT_CAN_ID INTEGER NOT NULL , 
     TSTAMP TIMESTAMPTZ , 
     EXTD BOOLEAN , 
     RTR BOOLEAN , 
     DATA_LEN INTEGER , 
     FVAL DOUBLE PRECISION , 
     IVAL INTEGER , 
     CVAL VARCHAR (16) , 
     STATE VARCHAR (10) CHECK ( STATE IN ('HighErr', 'HighWarn', 'LowErr', 'LowWarn', 'Normal')) 
    ) 
;


CREATE INDEX MSRMNT_DATA_IDXv1 ON MSRMNT_DATA 
    ( 
     DATA_PNT_CAN_ID ASC 
    ) 
;
CREATE INDEX MSRMNT_DATA_IDXv2 ON MSRMNT_DATA 
    ( 
     TSTAMP ASC 
    ) 
;

ALTER TABLE MSRMNT_DATA 
    ADD CONSTRAINT MSRMNT_DATA_PK PRIMARY KEY ( MSRMNT_DATA_ID ) ;



CREATE TABLE SHT_TERM_TREND_DATA 
    ( 
     SHT_TERM_TREND_DATA_ID BIGSERIAL NOT NULL , 
     DATA_PNT_CAN_ID INTEGER NOT NULL , 
     TSTAMP TIMESTAMPTZ , 
     EXTD BOOLEAN , 
     RTR BOOLEAN , 
     DATA_LEN INTEGER , 
     FVAL DOUBLE PRECISION , 
     IVAL INTEGER , 
     CVAL VARCHAR (16) , 
     STATE VARCHAR (10) CHECK ( STATE IN ('HighErr', 'HighWarn', 'LowErr', 'LowWarn', 'Normal')) 
    ) 
;


CREATE INDEX SHT_TERM_TREND_DATA_IDXv1 ON SHT_TERM_TREND_DATA 
    ( 
     DATA_PNT_CAN_ID ASC 
    ) 
;
CREATE INDEX SHT_TERM_TREND_DATA_IDXv2 ON SHT_TERM_TREND_DATA 
    ( 
     TSTAMP ASC 
    ) 
;

ALTER TABLE SHT_TERM_TREND_DATA 
    ADD CONSTRAINT SHT_TERM_TREND_DATA_PK PRIMARY KEY ( SHT_TERM_TREND_DATA_ID ) ;




ALTER TABLE MSRMNT 
    ADD CONSTRAINT DEV_MSRMNT FOREIGN KEY 
    ( 
     DEV_ID_FK
    ) 
    REFERENCES DEV 
    ( 
     DEV_ID
    ) 
;


ALTER TABLE DATA_PNT 
    ADD CONSTRAINT MSRMNT_DATA_PNT FOREIGN KEY 
    ( 
     MSRMNT_ID_FK
    ) 
    REFERENCES MSRMNT 
    ( 
     MSRMNT_ID
    ) 
;


ALTER TABLE MSRMNT 
    ADD CONSTRAINT MSRMNT_DEV_TYPE FOREIGN KEY 
    ( 
     DEV_TYPE_ID_FK
    ) 
    REFERENCES DEV_TYPE 
    ( 
     DEV_TYPE_ID
    ) 
;

CREATE OR REPLACE VIEW ALERTS AS
SELECT t1.DATA_PNT_CAN_ID,
  t1.TSTAMP,
  t1.FVAL,
  t1.IVAL,
  t1.CVAL,
  t1.STATE
FROM MSRMNT_DATA t1
WHERE t1.TSTAMP =
  (SELECT MAX(t2.TSTAMP)
  FROM MSRMNT_DATA t2
  WHERE t1.DATA_PNT_CAN_ID = t2.DATA_PNT_CAN_ID
  )
AND t1.STATE != 'Normal' ;



CREATE OR REPLACE VIEW all_trend_data AS 
        (         SELECT sht_term_trend_data.sht_term_trend_data_id,
                    sht_term_trend_data.data_pnt_can_id,
                    sht_term_trend_data.tstamp,
                    sht_term_trend_data.extd,
                    sht_term_trend_data.rtr,
                    sht_term_trend_data.data_len,
                    sht_term_trend_data.fval,
                    sht_term_trend_data.ival,
                    sht_term_trend_data.cval,
                    sht_term_trend_data.state
                   FROM sht_term_trend_data
        UNION
                 SELECT med_term_trend_data.med_term_trend_data_id AS sht_term_trend_data_id,
                    med_term_trend_data.data_pnt_can_id,
                    med_term_trend_data.tstamp,
                    med_term_trend_data.extd,
                    med_term_trend_data.rtr,
                    med_term_trend_data.data_len,
                    med_term_trend_data.fval,
                    med_term_trend_data.ival,
                    med_term_trend_data.cval,
                    med_term_trend_data.state
                   FROM med_term_trend_data)
UNION
         SELECT lng_term_trend_data.lng_term_trend_data_id AS sht_term_trend_data_id,
            lng_term_trend_data.data_pnt_can_id,
            lng_term_trend_data.tstamp,
            lng_term_trend_data.extd,
            lng_term_trend_data.rtr,
            lng_term_trend_data.data_len,
            lng_term_trend_data.fval,
            lng_term_trend_data.ival,
            lng_term_trend_data.cval,
            lng_term_trend_data.state
           FROM lng_term_trend_data;

ALTER TABLE all_trend_data
  OWNER TO prohelion;


CREATE OR REPLACE VIEW all_trend_data_summary AS 
 SELECT ct.tstamp,
    ct."Velocity",
    ct."Battery_Ah",
    ct."Battery_SOC",
    ct."Bus_mA",
    ct."Bus_V",
    ct."Array1_mA",
    ct."Array1_V",
    ct."Array2_mA",
    ct."Array2_V",
    ct."Array3_mA",
    ct."Array3_V",
    ct."Wind_Speed",
    ct."Wind_Direction",
    ct."Latitiude",
    ct."Longitude",
    ct."Setpoint",
    ct."Irradiance"
   FROM crosstab('
	SELECT date_trunc(''second'',tstamp) as tstamp, data_pnt_can_id, fval
		FROM all_trend_data
		where data_pnt_can_id in (16436,28484,28480,16420,16416,28692,28688,28756,28752,28820,28816,12852,13076,13072,20500,12884)
		ORDER  BY 1,2 '::text, 'VALUES (''16436''), (''28484''), (''28480''),(''16420''::int), (''16416''), (''28692''), (''28688''), (''28756''), (''28752''), (''28820''), (''28816''), (''12852''), (''12848''), (''13076''), (''13072''), (''20500''), (''12884'')  '::text) ct(tstamp timestamp without time zone, "Velocity" double precision, "Battery_SOC" double precision, "Battery_Ah" double precision, "Bus_mA" double precision, "Bus_V" double precision, "Array1_mA" double precision, "Array1_V" double precision, "Array2_mA" double precision, "Array2_V" double precision, "Array3_mA" double precision, "Array3_V" double precision, "Wind_Speed" double precision, "Wind_Direction" double precision, "Latitiude" double precision, "Longitude" double precision, "Setpoint" double precision, "Irradiance" double precision);

ALTER TABLE all_trend_data_summary
  OWNER TO prohelion;

CREATE OR REPLACE VIEW lng_term_trend_data_summary AS 
SELECT ct.tstamp,
    ct."Velocity",
    ct."Battery_Ah",
    ct."Battery_SOC",
    ct."Bus_mA",
    ct."Bus_V",
    ct."Array1_mA",
    ct."Array1_V",
    ct."Array2_mA",
    ct."Array2_V",
    ct."Array3_mA",
    ct."Array3_V",
    ct."Wind_Speed",
    ct."Wind_Direction",
    ct."Latitiude",
    ct."Longitude",
    ct."Setpoint",
    ct."Irradiance"
   FROM crosstab('
	SELECT date_trunc(''second'',tstamp) as tstamp, data_pnt_can_id, fval
		FROM lng_term_trend_data
		where data_pnt_can_id in (16436,28484,28480,16420,16416,28692,28688,28756,28752,28820,28816,12852,13076,13072,20500,12884)
		ORDER  BY 1,2 '::text, 'VALUES (''16436''), (''28484''), (''28480''),(''16420''::int), (''16416''), (''28692''), (''28688''), (''28756''), (''28752''), (''28820''), (''28816''), (''12852''), (''12848''), (''13076''), (''13072''), (''20500''), (''12884'')  '::text) ct(tstamp timestamp without time zone, "Velocity" double precision, "Battery_SOC" double precision, "Battery_Ah" double precision, "Bus_mA" double precision, "Bus_V" double precision, "Array1_mA" double precision, "Array1_V" double precision, "Array2_mA" double precision, "Array2_V" double precision, "Array3_mA" double precision, "Array3_V" double precision, "Wind_Speed" double precision, "Wind_Direction" double precision, "Latitiude" double precision, "Longitude" double precision, "Setpoint" double precision, "Irradiance" double precision);

ALTER TABLE lng_term_trend_data_summary
  OWNER TO prohelion;

CREATE OR REPLACE VIEW med_term_trend_data_summary AS 
SELECT ct.tstamp,
    ct."Velocity",
    ct."Battery_Ah",
    ct."Battery_SOC",
    ct."Bus_mA",
    ct."Bus_V",
    ct."Array1_mA",
    ct."Array1_V",
    ct."Array2_mA",
    ct."Array2_V",
    ct."Array3_mA",
    ct."Array3_V",
    ct."Wind_Speed",
    ct."Wind_Direction",
    ct."Latitiude",
    ct."Longitude",
    ct."Setpoint",
    ct."Irradiance"
   FROM crosstab('
	SELECT date_trunc(''second'',tstamp) as tstamp, data_pnt_can_id, fval
		FROM med_term_trend_data
		where data_pnt_can_id in (16436,28484,28480,16420,16416,28692,28688,28756,28752,28820,28816,12852,13076,13072,20500,12884)
		ORDER  BY 1,2 '::text, 'VALUES (''16436''), (''28484''), (''28480''),(''16420''::int), (''16416''), (''28692''), (''28688''), (''28756''), (''28752''), (''28820''), (''28816''), (''12852''), (''12848''), (''13076''), (''13072''), (''20500''), (''12884'')  '::text) ct(tstamp timestamp without time zone, "Velocity" double precision, "Battery_SOC" double precision, "Battery_Ah" double precision, "Bus_mA" double precision, "Bus_V" double precision, "Array1_mA" double precision, "Array1_V" double precision, "Array2_mA" double precision, "Array2_V" double precision, "Array3_mA" double precision, "Array3_V" double precision, "Wind_Speed" double precision, "Wind_Direction" double precision, "Latitiude" double precision, "Longitude" double precision, "Setpoint" double precision, "Irradiance" double precision);

ALTER TABLE med_term_trend_data_summary
  OWNER TO prohelion;

CREATE OR REPLACE VIEW sht_term_trend_data_summary AS 
SELECT ct.tstamp,
    ct."Velocity",
    ct."Battery_Ah",
    ct."Battery_SOC",
    ct."Bus_mA",
    ct."Bus_V",
    ct."Array1_mA",
    ct."Array1_V",
    ct."Array2_mA",
    ct."Array2_V",
    ct."Array3_mA",
    ct."Array3_V",
    ct."Wind_Speed",
    ct."Wind_Direction",
    ct."Latitiude",
    ct."Longitude",
    ct."Setpoint",
    ct."Irradiance"
   FROM crosstab('
	SELECT date_trunc(''second'',tstamp) as tstamp, data_pnt_can_id, fval
		FROM sht_term_trend_data
		where data_pnt_can_id in (16436,28484,28480,16420,16416,28692,28688,28756,28752,28820,28816,12852,13076,13072,20500,12884)
		ORDER  BY 1,2 '::text, 'VALUES (''16436''), (''28484''), (''28480''),(''16420''::int), (''16416''), (''28692''), (''28688''), (''28756''), (''28752''), (''28820''), (''28816''), (''12852''), (''12848''), (''13076''), (''13072''), (''20500''), (''12884'')  '::text) ct(tstamp timestamp without time zone, "Velocity" double precision, "Battery_SOC" double precision, "Battery_Ah" double precision, "Bus_mA" double precision, "Bus_V" double precision, "Array1_mA" double precision, "Array1_V" double precision, "Array2_mA" double precision, "Array2_V" double precision, "Array3_mA" double precision, "Array3_V" double precision, "Wind_Speed" double precision, "Wind_Direction" double precision, "Latitiude" double precision, "Longitude" double precision, "Setpoint" double precision, "Irradiance" double precision);

ALTER TABLE sht_term_trend_data_summary
  OWNER TO prohelion;


CREATE OR REPLACE VIEW sht_and_med_term_trend_data AS 
 SELECT sht_term_trend_data.sht_term_trend_data_id,
    sht_term_trend_data.data_pnt_can_id,
    sht_term_trend_data.tstamp,
    sht_term_trend_data.extd,
    sht_term_trend_data.rtr,
    sht_term_trend_data.data_len,
    sht_term_trend_data.fval,
    sht_term_trend_data.ival,
    sht_term_trend_data.cval,
    sht_term_trend_data.state
   FROM sht_term_trend_data;

ALTER TABLE sht_and_med_term_trend_data
  OWNER TO prohelion;


CREATE OR REPLACE VIEW sht_and_med_term_trend_data_summary AS 
 SELECT ct.tstamp,
    ct."Velocity",
    ct."Battery_Ah",
    ct."Battery_SOC",
    ct."Bus_mA",
    ct."Bus_V",
    ct."Array1_mA",
    ct."Array1_V",
    ct."Array2_mA",
    ct."Array2_V",
    ct."Array3_mA",
    ct."Array3_V",
    ct."Wind_Speed",
    ct."Wind_Direction",
    ct."Latitiude",
    ct."Longitude",
    ct."Setpoint",
    ct."Irradiance"
   FROM crosstab('
	SELECT date_trunc(''second'',tstamp) as tstamp, data_pnt_can_id, fval
		FROM sht_and_med_term_trend_data
		where data_pnt_can_id in (16436,28484,28480,16420,16416,28692,28688,28756,28752,28820,28816,12852,13076,13072,20500,12884)
		ORDER  BY 1,2 '::text, 'VALUES (''16436''), (''28484''), (''28480''),(''16420''::int), (''16416''), (''28692''), (''28688''), (''28756''), (''28752''), (''28820''), (''28816''), (''12852''), (''12848''), (''13076''), (''13072''), (''20500''), (''12884'')  '::text) ct(tstamp timestamp without time zone, "Velocity" double precision, "Battery_SOC" double precision, "Battery_Ah" double precision, "Bus_mA" double precision, "Bus_V" double precision, "Array1_mA" double precision, "Array1_V" double precision, "Array2_mA" double precision, "Array2_V" double precision, "Array3_mA" double precision, "Array3_V" double precision, "Wind_Speed" double precision, "Wind_Direction" double precision, "Latitiude" double precision, "Longitude" double precision, "Setpoint" double precision, "Irradiance" double precision);

ALTER TABLE sht_and_med_term_trend_data_summary
  OWNER TO prohelion;


CREATE OR REPLACE VIEW all_trend_data_with_deviceinfo AS 
 SELECT trend_data.tstamp + '10:00:00'::interval AS "BNE_time",
    dev.dev_name,
    msrmnt.msrmnt_name,
    data_pnt.name,
    trend_data.data_pnt_can_id,
    trend_data.fval,
    trend_data.ival,
    trend_data.cval
   FROM all_trend_data trend_data
   JOIN data_pnt ON trend_data.data_pnt_can_id = data_pnt.data_pnt_can_id
   JOIN msrmnt ON msrmnt.msrmnt_id = data_pnt.msrmnt_id_fk
   JOIN dev ON dev.dev_id = msrmnt.dev_id_fk
  ORDER BY trend_data.tstamp, trend_data.data_pnt_can_id;

ALTER TABLE all_trend_data_with_deviceinfo
  OWNER TO prohelion;


CREATE OR REPLACE VIEW splunk_lookup_data AS
 SELECT data_pnt.data_pnt_can_id,
    data_pnt.name AS data_pnt_name,
    dev.dev_name,
    msrmnt.msrmnt_name
   FROM data_pnt
     JOIN msrmnt ON data_pnt.msrmnt_id_fk = msrmnt.msrmnt_id
     JOIN dev ON msrmnt.dev_id_fk = dev.dev_id;

ALTER TABLE splunk_lookup_data
  OWNER TO prohelion;



CREATE SEQUENCE HIBERNATE_SEQUENCE START WITH 1 INCREMENT BY 1; 


-- Oracle SQL Developer Data Modeler Summary Report: 
-- 
-- CREATE TABLE                             8
-- CREATE INDEX                            10
-- ALTER TABLE                             12
-- CREATE VIEW                              1
-- CREATE PACKAGE                           0
-- CREATE PACKAGE BODY                      0
-- CREATE PROCEDURE                         0
-- CREATE FUNCTION                          0
-- CREATE TRIGGER                           0
-- ALTER TRIGGER                            0
-- CREATE STRUCTURED TYPE                   0
-- CREATE COLLECTION TYPE                   0
-- CREATE CLUSTER                           0
-- CREATE CONTEXT                           0
-- CREATE DATABASE                          0
-- CREATE DIMENSION                         0
-- CREATE DIRECTORY                         0
-- CREATE DISK GROUP                        0
-- CREATE ROLE                              0
-- CREATE ROLLBACK SEGMENT                  0
-- CREATE SEQUENCE                          0
-- CREATE MATERIALIZED VIEW                 0
-- CREATE SYNONYM                           0
-- CREATE TABLESPACE                        0
-- CREATE USER                              0
-- 
-- DROP TABLESPACE                          0
-- DROP DATABASE                            0
-- 
-- ERRORS                                   0
-- WARNINGS                                 0
