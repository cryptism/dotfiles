# Defined in - @ line 1
function myip --description 'alias myip=dig +short myip.opendns.com @resolver1.opendns.com'
	dig +short myip.opendns.com @resolver1.opendns.com $argv;
end
