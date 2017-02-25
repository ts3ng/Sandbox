FOO="aqua fluentd"


if [[ $FOO =~ .*aqua.* ]]; then
	echo "match: $FOO"
else
	echo "no match: $FOO"
fi
