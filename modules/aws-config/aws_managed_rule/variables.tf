# Default variables for the config rule module
variable "config_is_enabled" {
  description = "Flag indicating that AWS Config is active and recording"
  default     = false
}

variable "config_aws_managed_rule_count" {
  description = "Count of AWS managed rules to activate within AWS Config"
  default     = 0
}

variable "config_aws_managed_rule_activate_list" {
  description = "List of AWS managed config rule source IDs to activate"

  default = [{
    config_rule_name = "S3_BUCKET_PUBLIC_READ_PROHIBITED"
  }]
}

variable "config_aws_managed_periodic_rule_count" {
  description = "Count of AWS managed periodic rules to activate within AWS Config"
  default     = 0
}

variable "config_aws_managed_periodic_rule_activate_list" {
  description = "List of AWS managed config periodic rule source IDs to activate"

  default = [{
    config_rule_name = "CLOUD_TRAIL_ENABLED"
  }]
}

variable "config_aws_managed_periodic_scoped_rule_count" {
  description = "Count of AWS managed periodic scoped rules to activate within AWS Config"
  default     = 0
}

variable "config_aws_managed_periodic_scoped_rule_activate_list" {
  description = "List of AWS managed config periodic scoped rule source IDs to activate"

  default = [{
    config_rule_name = "ACM_CERTIFICATE_EXPIRATION_CHECK"
  }]
}

variable "config_aws_managed_periodic_scoped_rules" {
  description = "List of AWS managed periodic scoped config rules and default input parameters values"

  default = {
    ACM_CERTIFICATE_EXPIRATION_CHECK = {
      description                     = "Checks whether ACM Certificates in your account are marked for expiration within the specified number of days. Certificates provided by ACM are automatically renewed. ACM does not automatically renew certificates that you import."
      maximum_execution_frequency     = "TwentyFour_Hours"
      input_parameters                = "\"daysToExpiration\":\"14\""
      compliance_resource_types       = "AWS::ACM::Certificate"
      compliance_resource_types_extra = ""
    }

    DYNAMODB_AUTOSCALING_ENABLED = {
      description                     = "This rule checks whether Auto Scaling is enabled on your DynamoDB tables. Optionally you can set the read and write capacity units for the table."
      maximum_execution_frequency     = "TwentyFour_Hours"
      input_parameters                = ""
      compliance_resource_types       = "AWS::DynamoDB::Table"
      compliance_resource_types_extra = ""
    }
  }
}

variable "config_aws_managed_periodic_rules" {
  description = "List of AWS managed periodic config rules and default input parameters values"

  default = {
    CLOUD_TRAIL_ENABLED = {
      description                     = "Checks whether AWS CloudTrail is enabled in your AWS account. Optionally, you can specify which S3 bucket, SNS topic, and Amazon CloudWatch Logs ARN to use."
      maximum_execution_frequency     = "TwentyFour_Hours"
      input_parameters                = ""
      compliance_resource_types       = ""
      compliance_resource_types_extra = ""
    }

    DYNAMODB_THROUGHPUT_LIMIT_CHECK = {
      description                     = "Checks whether provisioned DynamoDB throughput is approaching the maximum limit for your account. By default, the rule checks if provisioned throughput exceeds a threshold of 80% of your account limits."
      maximum_execution_frequency     = "TwentyFour_Hours"
      input_parameters                = "\"accountRCUThresholdPercentage\":\"80\", \"accountWCUThresholdPercentage\":\"80\""
      compliance_resource_types       = ""
      compliance_resource_types_extra = ""
    }

    IAM_PASSWORD_POLICY = {
      description                     = "Checks whether the account password policy for IAM users meets the specified requirements."
      maximum_execution_frequency     = "TwentyFour_Hours"
      input_parameters                = "\"RequireUppercaseCharacters\":\"true\", \"RequireLowercaseCharacters\":\"true\", \"RequireSymbols\":\"true\", \"RequireNumbers\":\"true\", \"MinimumPasswordLength\":\"14\", \"PasswordReusePrevention\":\"24\", \"MaxPasswordAge\":\"90\""
      compliance_resource_types       = ""
      compliance_resource_types_extra = ""
    }

    ROOT_ACCOUNT_MFA_ENABLED = {
      description                     = "Checks whether the root user of your AWS account requires multi-factor authentication for console sign-in."
      maximum_execution_frequency     = "TwentyFour_Hours"
      input_parameters                = ""
      compliance_resource_types       = ""
      compliance_resource_types_extra = ""
    }

    CLOUDWATCH_ALARM_RESOURCE_CHECK = {
      description                     = "Checks whether the specified resource type has a CloudWatch alarm for the specified metric. For resource type, you can specify EBS volumes, EC2 instances, RDS clusters, or S3 buckets."
      maximum_execution_frequency     = "TwentyFour_Hours"
      input_parameters                = "\"resourceType\":\"AWS::EC2::Instance\", \"metricName\":\"CPUUtilization\""
      compliance_resource_types       = ""
      compliance_resource_types_extra = ""
    }
  }
}

variable "config_aws_managed_rules" {
  description = "List of AWS managed config rules and default input parameters values"

  default = {
    S3_BUCKET_PUBLIC_READ_PROHIBITED = {
      description                     = "Checks that your S3 buckets do not allow public read access. If an S3 bucket policy or bucket ACL allows public read access, the bucket is noncompliant."
      input_parameters                = ""
      compliance_resource_types       = "AWS::S3::Bucket"
      compliance_resource_types_extra = ""
    }

    S3_BUCKET_VERSIONING_ENABLED = {
      description                     = "Checks whether versioning is enabled for your S3 buckets. Optionally, the rule checks if MFA delete is enabled for your S3 buckets."
      input_parameters                = ""
      compliance_resource_types       = "AWS::S3::Bucket"
      compliance_resource_types_extra = ""
    }

    AUTOSCALING_GROUP_ELB_HEALTHCHECK_REQUIRED = {
      description                     = "Checks whether your Auto Scaling groups that are associated with a load balancer are using Elastic Load Balancing health checks."
      input_parameters                = ""
      compliance_resource_types       = "AWS::AutoScaling::AutoScalingGroup"
      compliance_resource_types_extra = ""
    }

    CLOUDFORMATION_STACK_NOTIFICATION_CHECK = {
      description                     = "Checks whether your CloudFormation stacks are sending event notifications to an SNS topic. Optionally checks whether specified SNS topics are used."
      input_parameters                = ""
      compliance_resource_types       = "AWS::CloudFormation::Stack"
      compliance_resource_types_extra = ""
    }

    DB_INSTANCE_BACKUP_ENABLED = {
      description                     = "Checks whether RDS DB instances have backups enabled. Optionally, the rule checks the backup retention period and the backup window."
      input_parameters                = ""
      compliance_resource_types       = "AWS::RDS::DBInstance"
      compliance_resource_types_extra = ""
    }

    EBS_OPTIMIZED_INSTANCE = {
      description                     = "Checks whether EBS optimization is enabled for your EC2 instances that can be EBS-optimized."
      input_parameters                = ""
      compliance_resource_types       = "AWS::EC2::Instance"
      compliance_resource_types_extra = ""
    }

    EC2_INSTANCE_DETAILED_MONITORING_ENABLED = {
      description                     = "Checks whether detailed monitoring is enabled for EC2 instances."
      input_parameters                = ""
      compliance_resource_types       = "AWS::EC2::Instance"
      compliance_resource_types_extra = ""
    }

    INSTANCES_IN_VPC = {
      description                     = "Checks whether your EC2 instances belong to a virtual private cloud (VPC). Optionally, you can specify the VPC ID to associate with your instances."
      input_parameters                = ""
      compliance_resource_types       = "AWS::EC2::Instance"
      compliance_resource_types_extra = ""
    }

    EC2_VOLUME_INUSE_CHECK = {
      description                     = "Checks whether EBS volumes are attached to EC2 instances. Optionally checks if EBS volumes are marked for deletion when an instance is terminated."
      input_parameters                = ""
      compliance_resource_types       = "AWS::EC2::Volume"
      compliance_resource_types_extra = ""
    }

    EIP_ATTACHED = {
      description                     = "Checks whether all EIP addresses allocated to a VPC are attached to EC2 instances or in-use ENIs."
      input_parameters                = ""
      compliance_resource_types       = "AWS::EC2::EIP"
      compliance_resource_types_extra = ""
    }

    ENCRYPTED_VOLUMES = {
      description                     = "Checks whether EBS volumes that are in an attached state are encrypted. Optionally, you can specify the ID of a KMS key to use to encrypt the volume."
      input_parameters                = ""
      compliance_resource_types       = "AWS::EC2::Volume"
      compliance_resource_types_extra = ""
    }

    IAM_USER_GROUP_MEMBERSHIP_CHECK = {
      description                     = "Checks whether IAM users are members of at least one IAM group."
      input_parameters                = ""
      compliance_resource_types       = "AWS::IAM::User"
      compliance_resource_types_extra = ""
    }

    IAM_USER_NO_POLICIES_CHECK = {
      description                     = "Checks that none of your IAM users have policies attached. IAM users must inherit permissions from IAM groups or roles."
      input_parameters                = ""
      compliance_resource_types       = "AWS::IAM::User"
      compliance_resource_types_extra = ""
    }

    RDS_MULTI_AZ_SUPPORT = {
      description                     = "Checks whether high availability is enabled for your RDS DB instances."
      input_parameters                = ""
      compliance_resource_types       = "AWS::RDS::DBInstance"
      compliance_resource_types_extra = ""
    }

    RDS_STORAGE_ENCRYPTED = {
      description                     = "Checks whether storage encryption is enabled for your RDS DB instances."
      input_parameters                = ""
      compliance_resource_types       = "AWS::RDS::DBInstance"
      compliance_resource_types_extra = ""
    }

    INCOMING_SSH_DISABLED = {
      description                     = "Checks whether security groups that are in use disallow unrestricted incoming SSH traffic."
      input_parameters                = ""
      compliance_resource_types       = "AWS::EC2::SecurityGroup"
      compliance_resource_types_extra = ""
    }

    S3_BUCKET_LOGGING_ENABLED = {
      description                     = "Checks whether logging is enabled for your S3 buckets."
      input_parameters                = ""
      compliance_resource_types       = "AWS::S3::Bucket"
      compliance_resource_types_extra = ""
    }

    S3_BUCKET_PUBLIC_WRITE_PROHIBITED = {
      description                     = "Checks that your S3 buckets do not allow public write access. If an S3 bucket policy or bucket ACL allows public write access, the bucket is noncompliant."
      input_parameters                = ""
      compliance_resource_types       = "AWS::S3::Bucket"
      compliance_resource_types_extra = ""
    }

    S3_BUCKET_SSL_REQUESTS_ONLY = {
      description                     = "Checks whether S3 buckets have policies that require requests to use Secure Socket Layer (SSL)."
      input_parameters                = ""
      compliance_resource_types       = "AWS::S3::Bucket"
      compliance_resource_types_extra = ""
    }

    ELB_ACM_CERTIFICATE_REQUIRED = {
      description                     = "This rule checks whether the Elastic Load Balancer(s) uses SSL certificates provided by AWS Certificate Manager. You must use an SSL or HTTPS listener with your Elastic Load Balancer to use this rule."
      input_parameters                = ""
      compliance_resource_types       = "AWS::ElasticLoadBalancing::LoadBalancer"
      compliance_resource_types_extra = ""
    }

    IAM_GROUP_HAS_USERS_CHECK = {
      description                     = "Checks whether IAM groups have at least one IAM user."
      input_parameters                = ""
      compliance_resource_types       = "AWS::IAM::Group"
      compliance_resource_types_extra = ""
    }

    S3_BUCKET_SERVER_SIDE_ENCRYPTION_ENABLED = {
      description                     = "Checks whether the S3 bucket policy denies the put-object requests that are not encrypted using AES-256 or AWS KMS."
      input_parameters                = ""
      compliance_resource_types       = "AWS::S3::Bucket"
      compliance_resource_types_extra = ""
    }

    CODEBUILD_PROJECT_ENVVAR_AWSCRED_CHECK = {
      description                     = "Checks whether the project contains environment variables AWS_ACCESS_KEY_ID and AWS_SECRET_ACCESS_KEY. The rule is NON_COMPLIANT when the project environment variables contains plaintext credentials."
      input_parameters                = ""
      compliance_resource_types       = "AWS::CodeBuild::Project"
      compliance_resource_types_extra = ""
    }

    CODEBUILD_PROJECT_SOURCE_REPO_URL_CHECK = {
      description                     = "Checks whether the GitHub or Bitbucket source repository URL contains either personal access tokens or user name and password. The rule is compliant with the usage of OAuth to grant authorization for accessing GitHub or Bitbucket repositories."
      input_parameters                = ""
      compliance_resource_types       = "AWS::CodeBuild::Project"
      compliance_resource_types_extra = ""
    }

    APPROVED_AMIS_BY_ID = {
      description                     = "Checks whether running instances are using specified AMIs. Specify a list of approved AMI IDs. Running instances with AMIs that are not on this list are noncompliant."
      input_parameters                = "\"amiIds\":\"ami-0000000z\""
      compliance_resource_types       = "AWS::EC2::Instance"
      compliance_resource_types_extra = ""
    }

    APPROVED_AMIS_BY_TAG = {
      description                     = "Checks whether running instances are using specified AMIs. Specify the tags that identify the AMIs. Running instances with AMIs that don't have at least one of the specified tags are noncompliant."
      input_parameters                = "\"amisByTagKeyAndValue\":\"tag-key1:tag-value1,tag-key2:tag-value2\""
      compliance_resource_types       = "AWS::EC2::Instance"
      compliance_resource_types_extra = ""
    }

    CLOUDWATCH_ALARM_ACTION_CHECK = {
      description                     = "Checks whether CloudWatch alarms have at least one alarm action, one INSUFFICIENT_DATA action, or one OK action enabled. Optionally, checks whether any of the actions matches one of the specified ARNs."
      input_parameters                = "\"alarmActionRequired\":\"true\", \"insufficientDataActionRequired\":\"true\", \"okActionRequired\":\"false\""
      compliance_resource_types       = "AWS::CloudWatch::Alarm"
      compliance_resource_types_extra = ""
    }

    CLOUDWATCH_ALARM_SETTINGS_CHECK = {
      description                     = "Checks whether CloudWatch alarms with the given metric name have the specified settings."
      input_parameters                = "\"metricName\":\"CPUUtilization\", \"period\":\"300\""
      compliance_resource_types       = "AWS::CloudWatch::Alarm"
      compliance_resource_types_extra = ""
    }

    DESIRED_INSTANCE_TENANCY = {
      description                     = "Checks instances for specified tenancy. Specify AMI IDs to check instances that are launched from those AMIs or specify Host IDs to check whether instances are launched on those Dedicated Hosts. Separate multiple ID values with commas."
      input_parameters                = "\"tenancy\":\"DEFAULT\""
      compliance_resource_types       = "AWS::EC2::Instance"
      compliance_resource_types_extra = ""
    }

    DESIRED_INSTANCE_TYPE = {
      description                     = "Checks whether your EC2 instances are of the specified instance types."
      input_parameters                = "\"instanceType\":\"t2.small\""
      compliance_resource_types       = "AWS::EC2::Instance"
      compliance_resource_types_extra = ""
    }

    EC2_MANAGEDINSTANCE_APPLICATIONS_BLACKLISTED = {
      description                     = "Checks that none of the specified applications are installed on the instance. Optionally, specify the version. Newer versions will not be blacklisted. Optionally, specify the platform to apply the rule only to instances running that platform."
      input_parameters                = "\"applicationNames\":\"FireFox\""
      compliance_resource_types       = "AWS::SSM::ManagedInstanceInventory"
      compliance_resource_types_extra = ""
    }

    EC2_MANAGEDINSTANCE_APPLICATIONS_REQUIRED = {
      description                     = "Checks whether all of the specified applications are installed on the instance. Optionally, specify the minimum acceptable version. Optionally, specify the platform to apply the rule only to instances running that platform."
      input_parameters                = "\"applicationNames\":\"FireFox\""
      compliance_resource_types       = "AWS::SSM::ManagedInstanceInventory"
      compliance_resource_types_extra = ""
    }

    EC2_MANAGEDINSTANCE_INVENTORY_BLACKLISTED = {
      description                     = "Checks whether instances managed by Amazon EC2 Systems Manager are configured to collect blacklisted inventory types."
      input_parameters                = "\"inventoryNames\":\"AWS:Network\""
      compliance_resource_types       = "AWS::SSM::ManagedInstanceInventory"
      compliance_resource_types_extra = ""
    }

    EC2_MANAGEDINSTANCE_PLATFORM_CHECK = {
      description                     = "Checks whether EC2 managed instances have the desired configurations."
      input_parameters                = "\"platformType\":\"Linux\""
      compliance_resource_types       = "AWS::SSM::ManagedInstanceInventory"
      compliance_resource_types_extra = ""
    }

    ELB_CUSTOM_SECURITY_POLICY_SSL_CHECK = {
      description                     = "Checks whether your Classic Load Balancer SSL listeners are using a custom policy. The rule is only applicable if there are SSL listeners for the Classic Load Balancer."
      input_parameters                = "\"sslProtocolsAndCiphers\":\"TLSv1.2\""
      compliance_resource_types       = "AWS::ElasticLoadBalancing::LoadBalancer"
      compliance_resource_types_extra = ""
    }

    ELB_PREDEFINED_SECURITY_POLICY_SSL_CHECK = {
      description                     = "Checks whether your Classic Load Balancer SSL listeners are using a predefined policy. The rule is only applicable if there are SSL listeners for the Classic Load Balancer."
      input_parameters                = "\"predefinedPolicyName\":\"Policy1\""
      compliance_resource_types       = "AWS::ElasticLoadBalancing::LoadBalancer"
      compliance_resource_types_extra = ""
    }

    RESTRICTED_INCOMING_TRAFFIC = {
      description                     = "Checks whether security groups that are in use disallow unrestricted incoming TCP traffic to the specified ports."
      input_parameters                = ""
      compliance_resource_types       = "AWS::EC2::SecurityGroup"
      compliance_resource_types_extra = ""
    }

    REDSHIFT_CLUSTER_CONFIGURATION_CHECK = {
      description                     = "Checks whether Amazon Redshift clusters have the specified settings."
      input_parameters                = "\"clusterDbEncrypted\":\"true\", \"loggingEnabled\":\"true\", \"nodeTypes\":\"dc1.large\""
      compliance_resource_types       = "AWS::Redshift::Cluster"
      compliance_resource_types_extra = ""
    }

    REDSHIFT_CLUSTER_MAINTENANCESETTINGS_CHECK = {
      description                     = "Checks whether Amazon Redshift clusters have the specified maintenance settings."
      input_parameters                = "\"allowVersionUpgrade\":\"true\", \"automatedSnapshotRetentionPeriod\":\"1\""
      compliance_resource_types       = "AWS::Redshift::Cluster"
      compliance_resource_types_extra = ""
    }

    FMS_WEBACL_RESOURCE_POLICY_CHECK = {
      description                     = "Checks whether the web ACL is associated with the ALBs or the Amazon CloudFront distributions. When AWS Firewall manager creates this rule, the FMS policy owner specifies the webACLId in the FMS policy and can optionally enable remediation."
      input_parameters                = "\"webACLId\":\"webaclid-000z\""
      compliance_resource_types       = "AWS::CloudFront::Distribution,AWS::ElasticLoadBalancingV2::LoadBalancer,AWS::WAFRegional::WebACL"
      compliance_resource_types_extra = ""
    }

    FMS_WEBACL_RULEGROUP_ASSOCIATION_CHECK = {
      description                     = "Checks whether the RuleGroupId and WafOverrideAction pairs are associated with the WebACL at highest priority. When AWS Firewall manager creates this rule, the FMS policy owner specifies the ruleGroups in the policy and can optionally enable remediation."
      input_parameters                = "\"ruleGroups\":\"null\""
      compliance_resource_types       = "AWS::WAF::WebACL,AWS::WAFRegional::WebACL"
      compliance_resource_types_extra = ""
    }

    IAM_POLICY_BLACKLISTED_CHECK = {
      description                     = "Checks that none of your IAM users, groups, or roles (excluding exceptionList) have the specified policies attached."
      input_parameters                = "\"policyArns\":\"arn:aws:iam::aws:policy/AdministratorAccess\""
      compliance_resource_types       = "AWS::IAM::user,AWS::IAM::Group,AWS::IAM::Role"
      compliance_resource_types_extra = ""
    }

    LAMBDA_FUNCTION_PUBLIC_ACCESS_PROHIBITED = {
      description                     = "Checks whether the Lambda function policy prohibits public access. The rule is NON_COMPLIANT if the Lambda function policy allows public access."
      input_parameters                = ""
      compliance_resource_types       = "AWS::Lambda::Function"
      compliance_resource_types_extra = ""
    }

    LAMBDA_FUNCTION_SETTINGS_CHECK = {
      description                     = "Checks that the AWS Lambda function settings for runtime, role, timeout, and memory size match the expected values."
      input_parameters                = "\"runtime\":\"null\", \"timeout\":\"3\", \"memorySize\":\"128\""
      compliance_resource_types       = "AWS::Lambda::Function"
      compliance_resource_types_extra = ""
    }

    S3_BUCKET_REPLICATION_ENABLED = {
      description                     = "Checks whether the Amazon S3 buckets have cross-region replication enabled."
      input_parameters                = ""
      compliance_resource_types       = "AWS::S3::Bucket"
      compliance_resource_types_extra = ""
    }

    REQUIRED_TAGS = {
      description                     = "Checks whether your resources have the tags that you specify. For example, you can check whether your EC2 instances have the 'CostCenter' tag. Separate multiple values with commas."
      input_parameters                = "\"tag1Key\":\"CostCenter\""
      compliance_resource_types       = "AWS::EC2::CustomerGateway,AWS::EC2::Instance,AWS::EC2::InternetGateway,AWS::EC2::NetworkAcl,AWS::EC2::NetworkInterface,AWS::EC2::RouteTable,AWS::EC2::SecurityGroup,AWS::EC2::Subnet,AWS::EC2::Volume, AWS::EC2::VPC"
      compliance_resource_types_extra = "AWS::EC2::VPNConnection,AWS::EC2::VPNGateway,AWS::ACM::Certificate,AWS::RDS::DBInstance,AWS::RDS::DBSecurityGroup,AWS::RDS::DBSnapshot,AWS::RDS::DBSubnetGroup,AWS::RDS::EventSubscription,AWS::S3::Bucket"
    }
  }
}

variable "name_space" {
  description = "Name space for this terraform run"
  default     = ""
}

variable "global_tags" {
  description = "Map of tags to apply to all resources that have tags parameters"
  type        = "map"
  default     = {}
}
