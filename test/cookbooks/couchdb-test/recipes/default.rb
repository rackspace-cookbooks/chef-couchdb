include_recipe 'couchdb'

couchdb_database 'mydb' do
  action :create
end

couchdb_config 'random_uuid' do
  action :create
  section 'uuids'
  key 'algorithm'
  value 'random'
end

couchdb_database 'mydb2' do
  action :create
end

couchdb_database 'myotherdb' do
  action :delete
end

couchdb_replication 'mydb' do
  target 'mydb2'
  continuous true
end
