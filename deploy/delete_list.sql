-- Deploy delete_list
-- requires: lists
-- requires: appschema

CREATE OR REPLACE PROCEDURE flipr.delete_list(
    nick   VARCHAR2,
    lname  VARCHAR2
) IS
    flipr_list_delete_failed EXCEPTION;
BEGIN
    DELETE FROM flipr.lists
     WHERE nickname = nick
       AND name     = lname;
    IF SQL%ROWCOUNT = 0 THEN RAISE flipr_list_delete_failed; END IF;
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
       AND name  = 'DELETE_LIST';

    IF l_err_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE flipr.delete_list';
        raise_application_error(-20001, 'Errors in FLIPR.DELETE_LIST');
    END IF;
END;
/
