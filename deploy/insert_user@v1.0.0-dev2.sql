-- Deploy insert_user
-- requires: users
-- requires: appschema

CREATE OR REPLACE PROCEDURE flipr.insert_user(
    nickname VARCHAR2,
    password VARCHAR2
) AS
BEGIN
    INSERT INTO flipr.users VALUES(
        nickname,
        LOWER( RAWTOHEX( UTL_RAW.CAST_TO_RAW(
             sys.dbms_obfuscation_toolkit.md5(input_string => password)
        ) ) ),
        DEFAULT
    );
END;
/

SHOW ERRORS;

-- Drop and die on error.
DECLARE
    l_err_count INTEGER;
BEGIN
    SELECT COUNT(*)
      INTO l_err_count
      FROM all_errors
     WHERE owner = 'FLIPR'
       AND name  = 'INSERT_USER';

    IF l_err_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE flipr.insert_user';
        raise_application_error(-20001, 'Errors in FLIPR.INSERT_USER');
    END IF;
END;
/
