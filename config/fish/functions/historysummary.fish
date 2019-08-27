# Defined in - @ line 1
function historysummary --description alias\ historysummary=history\ \|\ awk\ \'\{a\[\$2\]++\}\ END\{for\(i\ in\ a\)\{printf\ \"\%5d\\t\%s\\n\",a\[i\],i\}\}\'\ \|\ sort\ -rn\ \|\ head
	history | awk '{a[$2]++} END{for(i in a){printf "%5d\t%s\n",a[i],i}}' | sort -rn | head $argv;
end
