#
# DataMapper Configuration of the three HIS Servers
#
configure :development do
  # The production HIS Server
  DataMapper.setup(:default, { :adapter  => 'sqlserver',
                               :host     => 'sideswipe.msu.montana.edu',
                               :username => 'hisuser',
                               :password => '',
                               :database => 'OD'
                             })
  # The AG HIS Server Brian McGlynn is using
  DataMapper.setup(:tanager, { :adapter  => 'sqlserver',
                               :host     => 'tanager.msu.montana.edu',
                               :username => 'odmclient',
                               :password => '',
                               :database => 'OD'
                             })

  # The prototype HIS Server we'll remove soon
  DataMapper.setup(:ravage, { :adapter  => 'sqlserver',
                              :host     => 'ravage.msu.montana.edu',
                              :username => 'sa',
                              :password => '',
                              :database => 'LittleBear11'
                            })
end
