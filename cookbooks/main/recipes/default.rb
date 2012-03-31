if %w{solo app app_master}.include?(node[:instance_role])
  require_recipe "memcached"
  require_recipe "memcached::configure"
end

if %w{solo db_master}.include?(node[:instance_role])
  require_recipe "redis"
end

if %w{solo app_master app}.include?(node[:instance_role])
  require_recipe "redis::configure"
end

if %w{solo app_master}.include?(node[:instance_role])
  require_recipe "resque-scheduler"
end

if %w{solo app app_master}.include?(node[:instance_role])
  require_recipe "resque"
end

# require('pp')
# require('stringio')
# ey_cloud_report("debug") do
#   message(PP.pp(node,StringIO.new).string)
# end

#uncomment to include the newrelic_server_monitoring recipe
#require_recipe "newrelic_server_monitoring"

#enable Extension modules for a given Postgresql database
# if ['solo','db_master', 'db_slave'].include?(node[:instance_role])
  # Extensions that support both Postgres 9.0 and 9.1
  # postgresql9_autoexplain "dbname"
  # postgresql9_btree_gin "dbname"
  # postgresql9_btree_gist "dbname"
  # postgresql9_chkpass "dbname"
  # postgresql9_citext "dbname"
  # postgresql9_cube "dbname"
  # postgresql9_dblink "dbname"
  # postgresql9_dict_int "dbname"
  # postgresql9_dict_xsyn "dbname"
  # postgresql9_earthdistance "dbname"
  # postgresql9_fuzzystrmatch "dbname"
  # postgresql9_hstore "dbname"
  # postgresql9_intarray "dbname"
  # postgresql9_isn "dbname"
  # postgresql9_lo "dbname"
  # postgresql9_ltree "dbname"
  # postgresql9_pg_trgm "dbname"  
  # postgresql9_pgcrypto "dbname"
  # postgresql9_pgrowlocks "dbname"
  # postgresql9_postgis "dbname"
  # postgresql9_seg "dbname"
  # postgresql9_sslinfo "dbname"
  # postgresql9_tablefunc "dbname"
  # postgresql9_test_parser "dbname"
  # postgresql9_unaccent "dbname"
  # postgresql9_uuid_ossp "dbname"
  
  
  # 9.1 Extensions
  # postgresql9_file_fdw "dbname" 
  # postgresql9_xml2 "dbname"
  
  #Admin-Level Contribs
  # postgresql9_pg_buffercache "postgres"
  # postgresql9_pg_freespacemap "postgres"
  # postgresql9_pg_stat_statements "todo" - Not done
  
# end
