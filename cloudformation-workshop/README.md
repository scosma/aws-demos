# CloudFormation Workshop
## Build your first web app with CloudFormation

## Summary
The goal of this workshop is to give users a hands on experience building CloudFormation templates. Ultimately, when all is done, users will have a working website on AWS. 

### Workshop Setup
Workshop accounts have already been created for you. Simply log into them and start the labs. You can feel free to run commands from anywhere, but a Cloud9 instance has been created for your convenience.

### Familiarize yourself with the workshop environment

1\. Access your AWS Cloud9 Development Environment

In the AWS Management Console, go to the [Cloud9 Dashboard](https://console.aws.amazon.com/cloud9/home) and find your environment which should be prefixed with the name of the CloudFormation stack you created earlier, in our case mythical-mysfits-devsecops. You can also find the name of your environment in the CloudFormation outputs as Cloud9Env. Click **Open IDE**.

![Cloud9 Env](images/cloud9.png)

2\. Familiarize yourself with the Cloud9 Environment

On the left pane (Blue), any files downloaded to your environment will appear here in the file tree. In the middle (Red) pane, any documents you open will show up here. Test this out by double clicking on README.md in the left pane and edit the file by adding some arbitrary text. Then save it by clicking **File** and **Save**. Keyboard shortcuts will work as well.

![Cloud9 Editing](images/cloud9-environment.png)

On the bottom, you will see a bash shell (Yellow). For the remainder of the lab, use this shell to enter all commands.  You can also customize your Cloud9 environment by changing themes, moving panes around, etc. As an example, you can change the theme from light to dark by following the instructions [here](https://docs.aws.amazon.com/cloud9/latest/user-guide/settings-theme.html).

### Set Up Cloud9 Environment

1\. Clone Workshop Repo

There are a number of files and startup scripts we have pre-created for you. They're all in the main repo that you're using, so we'll clone that locally. Run this:

<pre>
$ git clone https://github.com/hub714/aws-demos.git
</pre>

### Lab 1 - Launch an EC2 instance
The first thing we'll do is try to launch an EC2 instance into one of the public subnets of the VPC

1. Configure the AWS Command Line Interface (CLI)

As we'll be using the AWS CLI for this lab, let's configure it first. Cloud9 will automatically configure credentials for you, so what we're looking to do is configure the region.

<pre>
$ aws configure
</pre>

Don't change anything and hit enter 2 times until you see **Default region name [eu-west-1]**. Ensure it says eu-west-1. If it doesn't, type in **eu-west-1**. Hit enter 2 more times. In the end, your console should look like this:

<pre>
$ aws configure
AWS Access Key ID [****************5NHJ]: 
AWS Secret Access Key [****************Ar06]: 
Default region name [eu-west-1]: 
Default output format [None]: 
</pre>

Now test the CLI:

<pre>
$ aws ec2 describe-instances
</pre>

You should see something like this:

<pre>
$ aws ec2 describe-instances
{
    "Reservations": []
}
</pre>

2. Create an EC2 Key Pair

In order to log into your instance later, you'll have to create a key pair. You can do this in the console by navigating to the Key Pairs page of the EC2 Console or you can run a CLI command:

<pre>
$ aws ec2 create-key-pair --key-name cfn-workshop --query 'KeyMaterial' --output text > cfn-workshop-private-key.pem
$ chmod 600 cfn-workshop-private-key.pem
</pre>

This command creates a key pair and outputs it as a text file named `cfn-workshop-private-key.pem`. The chmod command locks it down. Keep in mind that you will never be able to download this key pair again, so don't lose it.

3. Launch an EC2 instance



1. Navigate to the AWS Management Console and choose EC2
2. Click **Key Pairs** on the left
3. Create a **Key Pair.**  *It will ask you to download this keypair. Download it and keep it safe. You will never be able to get this keypair again*



Create keypair
Log into Cloud9


