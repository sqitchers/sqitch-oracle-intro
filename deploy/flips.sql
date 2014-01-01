-- Deploy flips
-- requires: appschema
-- requires: users

CREATE TABLE flipr.flips (
    id        INTEGER             PRIMARY KEY,
    nickname  VARCHAR2(512 CHAR)  NOT NULL REFERENCES flipr.users(nickname),
    body      VARCHAR2(180 CHAR)  NOT NULL,
    timestamp TIMESTAMP WITH TIME ZONE DEFAULT CURRENT_TIMESTAMP NOT NULL
);

CREATE SEQUENCE flipr.flip_id_seq START WITH 1 INCREMENT BY 1 NOCACHE;

CREATE OR REPLACE TRIGGER flipr.flip_pk BEFORE INSERT ON flipr.flips
FOR EACH ROW WHEN (NEW.id IS NULL)
DECLARE
    v_id flipr.flips.id%TYPE;
BEGIN
    SELECT flipr.flip_id_seq.nextval INTO v_id FROM DUAL;
    :new.id := v_id;
END;
/
