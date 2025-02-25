bat=$(acpi -b)
stat=$(echo $bat | awk -F ', ' '{sub(/Battery 0: /, "", $1); printf $1}')
perc=$(echo $bat | awk -F ', ' '{printf $2}')
