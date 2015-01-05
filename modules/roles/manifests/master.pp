class roles::master {
  include profiles::base
  include profiles::consul
  include profiles::webserver
}
