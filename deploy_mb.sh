#!/bin/bash

# This script will deploy a stack for the managed blockchain dApp
# We will specify several parameters to be used by the stack during deployment

export AWS_DEFAULT_REGION=us-east-1
sleep 3
export NETWORKID=$(aws managedblockchain list-invitations | jq -r '[.Invitations[] | select(.Status == "PENDING" and .NetworkSummary.Status == "AVAILABLE") | .NetworkSummary.Id][0]')
sleep 3
export INVITATIONID=$(aws managedblockchain list-invitations | jq -r '[.Invitations[] | select(.Status == "PENDING" and .NetworkSummary.Status == "AVAILABLE") | .InvitationId][0]')
sleep 3 
cd ~/environment
bash
sleep 5
aws cloudformation deploy --template-file accept-invite.yaml --stack-name amb-supplier --parameter-overrides NetworkId=$NETWORKID InvitationId=$INVITATIONID MemberName=Supplier AdminUsername=spadmin AdminPassword=Admin123 PeerNode1AZ=us-east-1a PeerNode2AZ=us-east-1b InstanceType=bc.t3.small
