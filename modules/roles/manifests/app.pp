class roles::app {
  include profiles::base
  include profiles::consul
  include profiles::application
}
