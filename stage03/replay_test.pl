#!/usr/bin/perl

require "ec2ops.pl";

parse_input();
print "SUCCESS: parsed input\n";

setlibsleep(0);
print "SUCCESS: set sleep time for each lib call\n";

setremote($masters{"CLC"});
print "SUCCESS: set remote CLC: masterclc=$masters{CLC}\n";

run_command("ssh -o StrictHostKeyChecking=no root\@$current_artifacts{remoteip} uname -a");
print "SUCCESS: ran remote test command\n";

run_command("scp -o StrictHostKeyChecking=no replay_test.tgz root\@$current_artifacts{remoteip}:/root/replay_test.tgz");
print "SUCCESS: copied replay_test.tgz\n";

run_command("ssh -o StrictHostKeyChecking=no root\@$current_artifacts{remoteip} tar zxvf /root/replay_test.tgz");
print "SUCCESS: ran remote replay test untar command\n";

setrunat("runat 600");

run_command("$remote_pre cd /root/replay_test; ./replay_test.sh $remote_post");
print "SUCCESS: ran remote replay test command\n";

doexit(0, "EXITING SUCCESS\n");
