# Defined in - @ line 1
function wifi --description alias\ wifi=networksetup\ -setairportpower\ \(networksetup\ -listallhardwareports\ \|\ grep\ -A\ 2\ \'Hardware\ Port:\ Wi-Fi\'\ \|\ grep\ \'Device:\'\ \|\ awk\ \'\{print\ \}\'\)
	networksetup -setairportpower (networksetup -listallhardwareports | grep -A 2 'Hardware Port: Wi-Fi' | grep 'Device:' | awk '{print }') $argv;
end
