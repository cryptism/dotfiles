# Defined in - @ line 1
function stfu --description alias\ stfu=osascript\ -e\ \'set\ volume\ output\ muted\ true\'
	osascript -e 'set volume output muted true' $argv;
end
