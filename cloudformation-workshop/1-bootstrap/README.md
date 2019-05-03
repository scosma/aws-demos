## Automated Bootstrapping with CloudFormation Helper Scripts


### Lab 1 - Adding metadata for cfn-init to read

Most of the time, you should be looking for ways to simplify life. For example, when installing a package, you could run something like this to install and make sure it turns on at boot:

<pre>
$ sudo yum install httpd
$ sudo chkconfig httpd on
</pre>

These are commands you would have to run and you are explicitly telling the OS what to do. This becomes harder to manage at scale. Instead, consider using tools to simplify the process. This is where cfn-init comes in. 

1\. Add [AWS::CloudFormation::Init](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-init.html) metadata for cfn-init to retrieve.

The CFN helper scripts get the CloudFormation stack's metadata and specifically everything out of the AWS::CloudFormation::Init section. Within this metadata, you can specify packages to download, files to create, authentication groups/users, run arbitrary commands, as well as some others. 

In this lab, we want to specify in metadata:
- Add the **httpd** package from **yum**
- Ensure that httpd turns on 

<details>
<summary>HINT 1</summary>

Add [AWS::CloudFormation::Init](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-init.html) as metadata for the EC2 instance resource. 

</details>

<details>
<summary>HINT 2</summary>

We care specifically about the [**packages** section](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-init.html#aws-resource-init-packages) this time as we want to install httpd.

</details>

<details>
<summary>HINT 3</summary>

How do you make sure things are turned on? This is where the [**Services**](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-resource-init.html#aws-resource-init-services) section comes in.

</details>

<details>
<summary>Ok here's the answer!</summary>

Take a look at [createApps-3-init.yml](https://github.com/hub714/aws-demos/blob/master/cloudformation-workshop/hints/createApps-3-init.yml) and see if there's anything that differs from your code. If you copy/paste this one you will also get a very successful index.html page instead of the default.

</details>

At this point, you have the metadata ready for the CloudFormation helper scripts to run. Now you just have to run the scripts.

### Lab 2 - Running arbitrary scripts on EC2 at boot

Using EC2 Userdata, you have the ability to run Bash or Powershell scripts when an EC2 instance first starts up. In this lab, you will learn how to use Userdata to install the CloudFormation helper scripts.

1\. Add a [Creation Policy](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-attribute-creationpolicy.html)

When CloudFormation creates a resource, it simply waits for a 200 OK and will mark the resource as CREATE_COMPLETE. However, when we're doing bootstrapping, a CREATE_COMPLETE does not mean that the application is done and running. This is when we look into creation policies. 

Add a creation policy to your EC2 resource.

<details>
<summary>HINT 1</summary>

The [docs](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/aws-attribute-creationpolicy.html) will explain this one. No hints this time!

</details>

2\. Add a Userdata property to your EC2 Instance definition.

Typically, you won't write everything on your own. You will probably start with some templates and base code. A great place to start looking is in the [CloudFormation documentation sample templates](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/quickref-ec2.html#scenario-ec2-instance-with-vol-and-tags). 

Within userdata, you can put in any scripts you would like. For some more information, and some JSON examples, take a look [here](https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/deploying.applications.html). 

3\. Update and call the CFN Helper Scripts

There are a few things we will have to do within userdata:
- Update aws-cfn-bootstrap
- call cfn-init with the right parameters
- call cfn-signal with the right

<details>
<summary>HINT 1</summary>

[Userdata](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/user-data.html) has to be base64. There are also a lot of sample bash scripts that will run arbitrary commands. Don't try to reinvent the wheel. Find a sample.

</details>

<details>
<summary>HINT 2</summary>

Cfn-init does the bootstrapping and cfn-signal tells CloudFormation whether or not the bootstrapping was successful.

</details>

<details>
<summary>Ok here's the answer!</summary>

Take a look at [createApps-4-init.yml](https://github.com/hub714/aws-demos/blob/master/cloudformation-workshop/hints/createApps-4-init.yml) and see if there's anything that differs from your code. If you copy/paste this one you will also get a very successful index.html page instead of the default.

</details>

4\. Update your stack

You should now have a fully working stack! 

### Bonus

No instructions or hints, but one of the most common things that you will need to do will be to create IAM Roles, scope them down, and attach them to your instance. Challenge yourself to create a role to:
- Read objects only from a specific S3 bucket: immersionday.hubertcheung.com
- Create EBS volumes
- Anything else you would like to do

Then attach the role to the EC2 instance so it can do that.