# Defined in - @ line 1
function eject --description 'alias eject=diskutil eject'
	diskutil eject $argv;
end
