#!/bin/bash
GLOBALTEST="this is a global"
function testfunction() {
        echo "testfunction: $1"
        echo "testfunction: $GLOBALTEST"
}
function casetest() {
case $1 in
        case1)
        echo "casetesting: $1"
        ;;
        *)
        echo "casetesting: other"
        ;;
esac
}

testfunction "stringpass"
casetest "case1"
