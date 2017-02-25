#!/bin/bash

if ! grep "secureClientPort" $(grep ExecStart ./dcos-exhibitor.service | awk -F'=' '{print $2}'); then sed -i '' s/zoo-cfg-extra=/zoo-cfg-extra=secureClientPort\\\\=2281\\\&/g $(grep ExecStart ./dcos-exhibitor.service | awk -F'=' '{print $2}'); fi

