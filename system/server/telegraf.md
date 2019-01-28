### files
`/etc/telegraf/telegraf.conf`

    [global_tags]
    [agent]
      interval = "10s"
      round_interval = true
      metric_batch_size = 1000
      metric_buffer_limit = 10000
      collection_jitter = "0s"
      flush_interval = "10s"
      flush_jitter = "0s"
      precision = ""
      debug = false
      quiet = false
      logfile = ""
      hostname = ""
      omit_hostname = false
    [[inputs.cpu]]
      percpu = true
      totalcpu = true
      collect_cpu_time = false
      report_active = false
    [[inputs.disk]]
      ignore_fs = ["tmpfs", "devtmpfs", "devfs"]
    [[inputs.diskio]]
    [[inputs.kernel]]
    [[inputs.mem]]
    [[inputs.processes]]
    [[inputs.swap]]
    [[inputs.system]]
    [[inputs.docker]]
      endpoint = "unix:///var/run/docker.sock"
      perdevice = true
    [[inputs.hddtemp]]
      address = "0.0.0.0:7634"
    [[inputs.net]]
    [[inputs.sensors]]
    [[outputs.influxdb]]
      urls = ["http://localhost:8086"]
      database = "telegraf" # required
      retention_policy = ""
      write_consistency = "any"
      timeout = "5s"
