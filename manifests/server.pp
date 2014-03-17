# == Class: nfs::server
#
# This class installs the nfs-kernel-server package
#
# === Authors
#
# - Christopher Johnson - cjohn@ceh.ac.uk
#
class nfs::server (
  $nfs_kernel_server_version = installed
) {
  package {'nfs-kernel-server' :
    ensure => $nfs_kernel_server_version
  }

  concat { '/etc/exports' : }

  # Execute the following when /etc/exports changes
  exec { 'exportfs -ra' :
    path        => '/usr/sbin',
    refreshonly => true,
    subscribe   => File['/etc/exports'],
  }
}