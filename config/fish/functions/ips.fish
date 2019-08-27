# Defined in - @ line 1
function ips --description alias\ ips=ifconfig\ -a\ \|\ perl\ -nle\'/\(\\d+\\.\\d+\\.\\d+\\.\\d+\)/\ \&\&\ print\ \'
	ifconfig -a | perl -nle'/(\d+\.\d+\.\d+\.\d+)/ && print ' $argv;
end
