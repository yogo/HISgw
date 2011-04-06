#
# DataMapper Configuration of the three HIS Servers
#
#configure :development do
  databases = YAML.load(File.read(File.join(Dir.pwd, 'config', 'database.yml')))

  # The production HIS Server
  DataMapper.setup(:default, databases['default'])

  # The AG HIS Server Brian McGlynn is using
  DataMapper.setup(:tanager, databases['tanager'])

  # The prototype HIS Server we'll remove soon
  DataMapper.setup(:ravage, databases['ravage'])
#end
