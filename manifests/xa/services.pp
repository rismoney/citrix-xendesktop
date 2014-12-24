class citrix::xa::services{

  $ctx_disabled_service_list = hiera('ctx_disabled_service_list',[])

  service {$ctx_disabled_service_list:
    enable => false,
  }
}
