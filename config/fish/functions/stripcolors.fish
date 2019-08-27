# Defined in - @ line 1
function stripcolors --description alias\ stripcolors=sed\ -r\ \"s/\\x1B\\\[\(\[0-9\]\{1,2\}\(\;\[0-9\]\{1,2\}\)\?\)\?\[mGK\]//g\"
	sed -r "s/\x1B\[([0-9]{1,2}(;[0-9]{1,2})?)?[mGK]//g" $argv;
end
