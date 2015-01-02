source 'https://api.berkshelf.com'

metadata

cookbook 'apt'
cookbook 'build-essential'
cookbook 'yum', '~> 3.0'
cookbook 'yum-epel'

group :integration do
  cookbook 'couchdb-test', path: './test/cookbooks/couchdb-test'
end
