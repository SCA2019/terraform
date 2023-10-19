package terraform

default allow := false # unless otherwise defined, allow is false

allow { # allow is true if...
	count(deny) == 0 # there are zero violations.
}

deny[msg] {
	s3Resources := input.resource_changes[_]
    s3Resources.type == "aws_s3_bucket"
    s3Resources.change.after.acl == "public"
    not contains(input.pipelineExclusions.DenyS3PublicBuckets, input.currentPipeline.name)
	msg := "OPA policy violation detected. PolicyName: [DenyS3PublicBuckets], Error: [Public buckets are not allowed]"
}

deny[msg] {
	s3Resources := input.resource_changes[_]
    s3Resources.type == "aws_s3_bucket"
    not s3Resources.change.after.tags.BillingAccountID
    not contains(input.pipelineExclusions.MandateBillingAccountIdTag, input.currentPipeline.name)
    msg := "OPA policy violation detected. PolicyName: [MandateBillingAccountIdTag], Error: [Mandatory tag BillingAccountID is missing]"
}
