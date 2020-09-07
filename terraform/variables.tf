variable region {
  type    = string
  default = "ap-northeast-1"
}
variable profile {
  type    = string
  default = "default"
}

variable suffix {
  type = map
  default = {
    default = "DomainMonitorDefault"
  }
}

variable suffix_kebab {
  type = map
  default = {
    default = "domain-monitor-default"
  }
}

variable workspace_params {
  type = map
  default = {
    default = {
      host_name = "t.livepocket.jp"
      host_port = "443"
    }
  }
}

variable consumer_key {}
variable consumer_secret {}
variable access_key {}
variable access_secret {}
