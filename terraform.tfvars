# Add values
# Use the AMI of the custom Ec2 image you previously created
imageid                = "ami-021769d848635b6f4"
# Use t2.micro for the AWS Free Tier
instance-type          = "t3.micro"
key-name               = "module-02-key"
vpc_security_group_ids = "sg-04956b65"
tag-name               = "module-06"
user-sns-topic         = "jrh-updates"
elb-name               = "jrh-elb"
tg-name                = "jrh-tg"
asg-name               = "jrh-asg"
desired                = 3
min                    = 2
max                    = 5
number-of-azs          = 3
region                 = "eu-south-1"
raw-s3-bucket          = "albi-module-06-raw-12345"
finished-s3-bucket     = "albi-module-06-finished-12345"
sqs-name               = "jrh-sqs"

