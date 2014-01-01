-- Deploy insert_flip
-- requires: flips
-- requires: appschema

CREATE OR REPLACE PROCEDURE flipr.insert_flip(
    nickname  VARCHAR2,
    body      VARCHAR2
) AS
BEGIN
    INSERT INTO flipr.flips (nickname, body)
    VALUES (nickname, body);
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
       AND name  = 'INSERT_FLIP';

    IF l_err_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE flipr.insert_flip';
        raise_application_error(-20001, 'Errors in FLIPR.INSERT_FLIP');
    END IF;
END;
/
