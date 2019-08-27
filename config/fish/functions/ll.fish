# Defined in - @ line 1
function ll --description 'alias ll=ls -lFa | TERM=vt100 less'
	ls -lFa | TERM=vt100 less $argv;
end
