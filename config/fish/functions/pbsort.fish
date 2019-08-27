# Defined in - @ line 1
function pbsort --description 'alias pbsort=pbpaste | sort | pbcopy'
	pbpaste | sort | pbcopy $argv;
end
