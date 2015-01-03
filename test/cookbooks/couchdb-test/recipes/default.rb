include_recipe 'couchdb'

couchdb_database 'mydb' do
  action :create
end

couchdb_config 'myadmin_user' do
  action :create
  section 'uuids'
  key 'algorithm'
  value 'random'
end

couchdb_database 'myotherdb' do
  action :create
end
