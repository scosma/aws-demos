#!/bin/bash

aws cloudformation update-stack --stack-name sftp-demo --template-body file://sftp-demo-iam.yml --capabilities CAPABILITY_IAM --region us-west-2
