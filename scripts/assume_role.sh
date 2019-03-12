#!/usr/bin/env bash

set -euo pipefail

assume_aws_role() {

  local __iam_role_arn=$NONPROD_IAM_ROLE_ARN

  if [ -z "$__iam_role_arn" ]; then
    echo "Must provide the iam role arn to assume role to in env. var: \$NONPROD_IAM_ROLE_ARN"
    return 1
  fi

  sts_token_json=$(aws sts assume-role --role-arn ${NONPROD_IAM_ROLE_ARN} --role-session-name s3-access)

  access_key_id=$(echo ${sts_token_json} | jq -r '.Credentials.AccessKeyId')
  secret_access_key=$(echo ${sts_token_json} | jq -r '.Credentials.SecretAccessKey')
  session_token=$(echo ${sts_token_json} | jq -r '.Credentials.SessionToken')

  export AWS_ACCESS_KEY_ID=${access_key_id}
  export AWS_SECRET_ACCESS_KEY=${secret_access_key}
  export AWS_SESSION_TOKEN=${session_token}

  # Export to other jobs as well.
  echo "export AWS_ACCESS_KEY_ID=${access_key_id}"
  echo "export AWS_SECRET_ACCESS_KEY=${secret_access_key}"
  echo "export AWS_SESSION_TOKEN=${session_token}"
}

assume_aws_role
