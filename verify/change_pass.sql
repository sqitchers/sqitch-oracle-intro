-- Verify change_pass

DESCRIBE flipr.change_pass;

SELECT 1/COUNT(*)
  FROM all_source
 WHERE type = 'PROCEDURE'
   AND name = 'CHANGE_PASS'
   AND text LIKE '%password = flipr.crypt(newpass, DBMS_RANDOM.STRING(''p'', 10))%';
