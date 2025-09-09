CREATE OR REPLACE PROCEDURE SCHEMA1.sp_refresh_user_order_stats()
RETURNS STRING
LANGUAGE JAVASCRIPT
EXECUTE AS OWNER
AS
$$
var cmd = `CREATE OR REPLACE TABLE SCHEMA1.user_order_stats AS
           SELECT o.user_id,
                  COUNT(*) AS order_count,
                  COALESCE(SUM(o.order_total),0) AS total_spent
           FROM SCHEMA2.orders o
           GROUP BY o.user_id`;
snowflake.execute({sqlText: cmd});
return 'user_order_stats refreshed';
$$;
