# Defined in - @ line 1
function unix2mac --description alias\ unix2mac=tr\ \'\\012\'\ \'\\015\'
	tr '\012' '\015' $argv;
end
