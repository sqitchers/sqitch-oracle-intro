-- Deploy insert_list
-- requires: lists
-- requires: appschema

CREATE OR REPLACE PROCEDURE flipr.insert_list(
    nickname    VARCHAR2,
    name        VARCHAR2,
    description VARCHAR2
) AS
BEGIN
    INSERT INTO flipr.lists (nickname, name, description)
    VALUES (nickname, name, description);
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
       AND name  = 'INSERT_LIST';

    IF l_err_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE flipr.insert_list';
        raise_application_error(-20001, 'Errors in FLIPR.INSERT_LIST');
    END IF;
END;
/
