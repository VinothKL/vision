#!/bin/bash

# ###
# To list the configured aws profile keys and command to export specific profile's 
# access/secret keys
# ##

PROFILES=$(awk -F"\\\]|\\\[" '/^\[/{print $2}' ~/.aws/credentials)

echo -e "Note: Enter number associated with the profile\n"

select PROFILE in $PROFILES; do
    export AWS_ACCESS_KEY_ID="$(aws configure get aws_access_key_id --profile $PROFILE)"
    export AWS_SECRET_ACCESS_KEY="$(aws configure get aws_secret_access_key --profile $PROFILE)"
    export AWS_DEFAULT_REGION="$(aws configure get region --profile $PROFILE)"
  break
done

echo AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
#echo AWS_SECRET_ACCESS_KEY=$(echo $AWS_SECRET_ACCESS_KEY|tr '[:print:]' '*')
echo AWS_SECRET_ACCESS_KEY=$(echo $AWS_SECRET_ACCESS_KEY)
echo AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION

echo -e "\nFor terminal work:\n"

echo "export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID; \
    export AWS_SECRET_ACCESS_KEY=$(echo $AWS_SECRET_ACCESS_KEY); \
    export AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION"
