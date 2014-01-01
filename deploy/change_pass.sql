-- Deploy change_pass
-- requires: users
-- requires: appschema
-- requires: crypt

CREATE OR REPLACE PROCEDURE flipr.change_pass(
    nick    VARCHAR2,
    oldpass VARCHAR2,
    newpass VARCHAR2
) IS
   flipr_auth_failed EXCEPTION;
BEGIN
    UPDATE flipr.users
       SET password = flipr.crypt(newpass, DBMS_RANDOM.STRING('p', 10))
     WHERE nickname = nick
       AND password = flipr.crypt(oldpass, password);
     IF SQL%ROWCOUNT = 0 THEN RAISE flipr_auth_failed; END IF;
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
       AND name  = 'CHANGE_PASS';

    IF l_err_count > 0 THEN
        EXECUTE IMMEDIATE 'DROP PROCEDURE flipr.CHANGE_PASS';
        raise_application_error(-20001, 'Errors in FLIPR.CHANGE_PASS');
    END IF;
END;
/
