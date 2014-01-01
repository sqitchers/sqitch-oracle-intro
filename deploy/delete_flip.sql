-- Deploy delete_flip
-- requires: flips
-- requires: appschema

CREATE OR REPLACE PROCEDURE flipr.delete_flip(
    flip_id INTEGER
) IS
    flipr_flip_delete_failed EXCEPTION;
BEGIN
    DELETE FROM flipr.flips WHERE id = flip_id;
    IF SQL%ROWCOUNT = 0 THEN RAISE flipr_flip_delete_failed; END IF;
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
       AND name  = 'DELETE_FLIP';

    IF l_err_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE flipr.delete_flip';
        raise_application_error(-20001, 'Errors in FLIPR.DELETE_FLIP');
    END IF;
END;
/
