#/bin/sh


## Fetching script name for help content
scriptName=`basename $0`

usage()
{
  echo "Usage:"
  echo "================================"
  echo "$1 <git organization name> <access_token> <comma saperated usernames>"
  echo "================================"
  echo "e.g. addMember.sh \"myOrg\" \"23fc3449696\" \"hvanpariya,hemanth\""
  echo "--------------------------------"
  echo "Steps to create access_token:"
  echo "Steps 1. click on https://github.com/settings/tokens"
  echo "Steps 2. \"Generate new Token\""
  echo "Steps 3. \"Select all permission\""
  echo "Steps 4. \"Generate\""
  echo "--------------------------------"
}

if [ $# -lt 3 ]; then
  usage $scriptName
  exit 1;
fi




## org name
ORG_NAME="$1"

## Access token
ACCESS_TOKEN="$2"

## user name who will get invite
USERNAME="$3"

usernames=$(echo $USERNAME | tr "," "\n")

## API for Git org
ORG_URL="https://api.github.com/orgs/"

## API details for membership
MEMBERSHIP="/memberships/"




## Method to add the git memberships
## arg1 : username of the member
addMember ()
{

eachUserURL="curl -X PUT ${ORG_URL}${ORG_NAME}${MEMBERSHIP}$1?access_token=${ACCESS_TOKEN}"
outputOfGit=`$eachUserURL 2> /dev/null`

message=`echo $outputOfGit| jq -r '.message'`

printf "%-18s  status: %-20s \n" $1 "$message"

}

for eachUser in $usernames
do
addMember $eachUser
done
