<?php
$connection = ssh2_connect('w01.war2moodle.wf.ulcc.ac.uk', 22);
ssh2_auth_password($connection, 'russell.boyatt', 'dd092s210s2');
$sftp = ssh2_sftp($connection);

$handle = opendir("ssh2.sftp://$sftp/coursebackups/");
echo "Directory handle: $handle\n";
echo "Entries:\n";
while (false != ($entry = readdir($handle))){
    echo "$entry\n";
}
