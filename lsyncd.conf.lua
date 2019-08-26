settings {
    logfile         = "/var/log/lsyncd/lsyncd.log",
    statusFile      = "/var/log/lsyncd/lsyncd.stat",
    statusIntervall = 1,
    nodaemon        = false
}

sync {
    default.rsyncssh,
    source = "/data/snapshots",
    host = "192.168.50.5",
    targetdir = "/data/snapshots",
    delay           = 5,
    rsync = { rsh="/usr/bin/ssh -l root -i /home/vagrant/.ssh/id_rsa -o StrictHostKeyChecking=no"}
}