# Evh Topics
topics = [
  {
    key         = "read_topic_1",
    consumers   = ["topic_1_read", "group_1_read"],
    partitions  = 1,
    retention   = 1,
    listen      = true,
    send        = false,
    manage      = false
  },
  {
    key         = "write_topic_1",
    consumers   = ["topic_1_write", "group_1_write"],
    partitions  = 1,
    retention   = 1,
    listen      = false,
    send        = true,
    manage      = false
  },
  {
    key         = "read_write_topic_1",
    consumers   = ["read_topic_1_write", "group_1_read_write"],
    partitions  = 1,
    retention   = 1,
    listen      = true,
    send        = true,
    manage      = false
  },
  {
    key         = "manage_topic_1",
    consumers   = ["manage_1_write", "group_1_manage"],
    partitions  = 1,
    retention   = 1,
    listen      = true,
    send        = true,
    manage      = true
  },
  {
    key         = "read_topic_2",
    consumers   = ["topic_2_read", "group_2_read"],
    partitions  = 1,
    retention   = 1,
    listen      = true,
    send        = false,
    manage      = false
  },
  {
    key         = "write_topic_2",
    consumers   = ["topic_2_write", "group_2_write"],
    partitions  = 1,
    retention   = 1,
    listen      = false,
    send        = true,
    manage      = false
  },
  {
    key         = "read_write_topic_1",
    consumers   = ["read_topic_2_write", "group_1_read_write"],
    partitions  = 1,
    retention   = 1,
    listen      = true,
    send        = true,
    manage      = false
  },
  {
    key         = "manage_topic_2",
    consumers   = ["manage_2_write", "group_2_manage"],
    partitions  = 1,
    retention   = 1,
    listen      = true,
    send        = true,
    manage      = true
  }
]
