-- Deploy crypt
-- requires: appschema

CREATE OR REPLACE FUNCTION flipr.crypt(
    password VARCHAR2,
    salt     VARCHAR2
) RETURN VARCHAR2 IS
    salted CHAR(10) := SUBSTR(salt, 0, 10);
BEGIN
    RETURN salted || LOWER( RAWTOHEX( UTL_RAW.CAST_TO_RAW(
         sys.dbms_obfuscation_toolkit.md5(input_string => password || salted)
    ) ) );
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
       AND name  = 'CRYPT';

    IF l_err_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE flipr.crypt';
        raise_application_error(-20001, 'Errors in FLIPR.CRYPT');
    END IF;
END;
/
