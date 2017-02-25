FOO="https://splunk-hec-endpoint/services/collector"
BAR="http://internal-booster-s-Internal-WQ3GH4KJ5EVC-1229214418.us-east-1.elb.amazonaws.com:9998/services/collector"

if [[ $FOO =~ ^(https|http)://.*/services/collector ]]; then
	FOO=`echo $FOO | awk -F "/" '{print $3}' | awk -F ":" '{print $1}'`
	echo "match: $FOO"
        BAR=`echo $BAR | awk -F "/" '{print $3}' | awk -F ":" '{print $1}'`
        echo "match: $BAR"
else
	echo "no match"
fi

echo "LOG TEST"
LOGLINE="docker run -e blah=foo -e bar=baz -e hah=har har har -e bib=bab index.docker.io/adobeplatform/something:latest"
REGEX="s/\(-e\ [^=]*\)=\([^e]*\)/\1=****** /g"

echo "TESTLOG=$(echo $LOGLINE | sed "$REGEX")"
