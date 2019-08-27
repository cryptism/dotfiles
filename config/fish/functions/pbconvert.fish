# Defined in - @ line 1
function pbconvert --description alias\ pbconvert=pbpaste\ \|\ perl\ -pe\ \'s/\\r\\n\|\\r/\\n/g\'\ \|\ pbcopy
	pbpaste | perl -pe 's/\r\n|\r/\n/g' | pbcopy $argv;
end
