_osfamily               = fact('osfamily')
_operatingsystem        = fact('operatingsystem')
_operatingsystemrelease = fact('operatingsystemrelease').to_f

case _osfamily
  when 'RedHat'
    $package_name     = 'check-mk-agent'
    $service_name     = 'xinetd'
    $mrpe_config_file = '/etc/check-mk-agent/mrpe.cfg'
  when 'Debian'
    $package_name = 'check-mk-agent'
    $service_name = 'xinetd'
end
