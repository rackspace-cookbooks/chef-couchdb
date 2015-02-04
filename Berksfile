source 'https://api.berkshelf.com'

metadata

cookbook 'apt'
cookbook 'build-essential'
cookbook 'yum', '~> 3.0'
cookbook 'yum-epel'
cookbook 'erlang', git: 'https://github.com/the-galley/erlang.git'

group :integration do
  cookbook 'couchdb-test', path: './test/cookbooks/couchdb-test'
end
