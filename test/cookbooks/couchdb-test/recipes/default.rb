include_recipe 'couchdb'

couchdb_database 'mydb' do
  action :create
end

couchdb_database 'mydb' do
  action :delete
end
