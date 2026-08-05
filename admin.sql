select instance_name,
       host_name,
       version,
       status
  from v$instance;

select name,
       dbid,
       created,
       log_mode
  from v$database;

select open_mode
  from v$database;

select name,
       open_mode
  from v$pdbs;