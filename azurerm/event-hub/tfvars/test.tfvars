# Enviroment
environment         = "test"

# Default suffix
suffix              = "home-where-ever"

evh = {
  "subnet_address_prefix" = ["10.1.6.0/24"],
  "topics" = [
    {
      "key"       = "topic1",
      "consumers" = ["group1_write", "group1_read"],
      partitions  = 1,
      retention   = 2,
      listen      = true,
      send        = true,
      manage      = true
    },
    {
      "key"       = "topic2",
      "consumers" = ["group2_write", "group2_read"],
      partitions  = 1,
      retention   = 2,
      listen      = true,
      send        = true,
      manage      = true
    }
  ]
}
