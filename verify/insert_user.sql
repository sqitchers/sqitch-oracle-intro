-- Verify insert_user

DESCRIBE flipr.insert_user;

SELECT 1/COUNT(*)
  FROM all_source
 WHERE type = 'PROCEDURE'
   AND name = 'INSERT_USER'
   AND text LIKE '%flipr.crypt(password, DBMS_RANDOM.STRING(''p'', 10))%';
