class roles::web {
  include profiles::base
  include profiles::consul
  include profiles::webserver
}
