# Defined in - @ line 1
function mac2unix --description alias\ mac2unix=tr\ \'\\015\'\ \'\\012\'
	tr '\015' '\012' $argv;
end
