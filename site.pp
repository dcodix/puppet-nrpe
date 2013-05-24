node "nodename" {
        import "nrpe"

        ##NRPE##
        $individualpluginspackages   = [ 'nagios-plugins-procs', 'nagios-plugins-load', 'nagios-plugins-disk' ]
        $ownplugins = [ 'check_redis' ]
        class { 'nrpe': }

        nrpe::config { 'nrpe.cfg':
                allowed_hosts => '10.30.10.91',
                dont_blame_nrpe => '1',
                nrpe_user => 'nagios',
                nrpe_group => 'nagios',
                pid_file => '/var/run/nrpe.pid',
        }
        nrpe::command {
                'check_users' : cmd => "check_users -w 5 -c 10";
                'check_load' : cmd => "check_load -w 15,10,5 -c 30,25,20";
                'check_hda1' : cmd => "check_disk -w 20% -c 10% -p /dev/hda1";
                'check_zombie_procs' : cmd => "check_procs -w 5 -c 10 -s Z";
                'check_total_procs' : cmd => "check_procs -w 150 -c 200";
                'check_disk_tot' : cmd => "check_disk -w 10% -c 5%";
                'check_procs' : cmd => "check_procs -w 270 -c 320";
                'check_linux_raid' : cmd => "check_linux_raid";
                'check_timesync' : cmd => "check_timesync";
                'check_redis_6379' : cmd => "check_redis -S localhost -p 6379 -w 1800000000 -c 2000000000 -s";
                'check_memory' : cmd => "check_memory 10  5";
                'check_swap' : cmd => "check_swap -c 10% -w 20%";
        }

}

