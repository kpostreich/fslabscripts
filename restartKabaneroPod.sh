#kubectl get pods -n kabanero  -o=name | grep kabanero-operator | sed "s/^.\{4\}//"

#Fnd the kabaneor-operator pod

POD=$(kubectl get pods -n kabanero  -o=name | grep kabanero-operator | sed "s/^.\{4\}//")

echo "--> Found kabaneoro operator pod:$POD"
 

#delete the kabaneor-operator pod

echo "---> Restarting pod: $POD"

oc delete pod $POD -n kabanero


NEWPOD=$(kubectl get pods -n kabanero  -o=name | grep kabanero-operator | sed "s/^.\{4\}//")


echo "Pod restarted: $NEWPOD"
