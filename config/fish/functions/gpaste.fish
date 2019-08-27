# Defined in - @ line 1
function gpaste --description alias\ gpaste=pbpaste\ \|\ perl\ -pe\ \'s/\\r\\n\|\\r/\\n/g\'
	pbpaste | perl -pe 's/\r\n|\r/\n/g' $argv;
end
