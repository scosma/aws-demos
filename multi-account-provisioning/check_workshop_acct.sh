#!/bin/bash
for ((c=0; c<=1; c++))
do
   ABCD=`cat accounts.json | jq -r "[.Accounts[$c].Name] | .[]"`
   ACCTNUM=`cat accounts.json | jq -r "[.Accounts[$c].Id] | .[]"`
   echo "Working on $ABCD"
   #echo $ACCTNUM
   if [[ $ABCD == *"Workshop"* ]]; then
     # echo "It's there!"
     # echo "$ABCD: https://$ACCTNUM.signin.aws.amazon.com" >> accounts.txt
     if [[ $ACCTNUM == *"423040536147"* ]]; then
       echo "Skip me."
     else
        echo "Assuming role into workshop account $ACCTNUM"
        aws sts assume-role --profile default --role-arn arn:aws:iam::$ACCTNUM:role/OrganizationAccountAccessRole --role-session-name Hub@$ACCTNUM > output
        #cat output
        export AWS_ACCESS_KEY_ID=`cat output | grep AccessKeyId | awk '{print $2}' | tr -d '"'`
        export AWS_SECRET_ACCESS_KEY=`cat output | grep SecretAccessKey | awk '{print $2}'| tr -d '"' | tr -d ','`
        export AWS_SESSION_TOKEN=`cat output | grep SessionToken | awk '{print $2}'| tr -d '"' | tr -d ','`
        
        #echo $AWS_ACCESS_KEY_ID
        #echo $AWS_SECRET_ACCESS_KEY
        #echo $AWS_SESSION_TOKEN
        # Initial User creation
        # aws iam create-user --user-name workshop-admin
        # aws iam attach-user-policy --user-name workshop-admin --policy-arn arn:aws:iam::aws:policy/AdministratorAccess
        # aws iam create-login-profile --user-name workshop-admin --password ConcurPassword123
        
        echo "Deploying CloudFormation"
        # aws ec2 create-key-pair --region eu-west-1 --key-name aws@concur | jq -r .KeyMaterial > keypairs/${ACCTNUM}_keypair.pem
        # aws cloudformation deploy --region eu-west-1 --template-file prerequisites.yml --stack-name win310 --parameter-overrides MainPassword=AWSDaySAPConcur1! KeyPairName=aws@concur --capabilities CAPABILITY_NAMED_IAM > logs/${ACCTNUM}_log 2>1 &
        # To clean up
        # aws cloudformation delete-stack --stack-name win310 --region eu-west-1 >> logs/${ACCTNUM}_log
        # aws ec2 delete-key-pair --key-name aws@concur --region eu-west-1cd 
        # aws cloudformation list-stacks --region eu-west-1
     fi
   else 
     echo "Skipping account"
   fi
done