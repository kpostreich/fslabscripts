#KLP

oc login -u admin -p passw0rd
oc project kabanero
oc get kabanero
echo "list pods in kabanero ns"
oc get pods -n kabanero
echo "list pods in knative-eventing ns"
oc get pods -n knative-eventing
echo "list pods in knative-serving ns"
oc get pods -n knative-serving
echo "list pods in openshift-operators ns"
oc get pods -n openshift-operators

echo "---> Process knative-eventing-operator pod in openshift-operators namespace"
kubectl get pods -n openshift-operators | grep knative-eventing | grep  -v Running|grep -v Completed | awk '{print $1}' | xargs kubectl delete pod --namespace=openshift-operators

sleep 10
echo "---> Process knative-serving-operator pod in openshift-operators namespace"
kubectl get pods -n openshift-operators | grep knative-serving | grep -v Running|grep -v Completed | awk '{print $1}' | xargs kubectl delete pod --namespace=openshift-operators

sleep 10 
echo "---> Process pods in knative-serving namespace"
kubectl get pods -n knative-serving | grep -v Running|grep -v Completed | awk '{print $1}' | xargs kubectl delete pod --namespace=knative-serving

sleep 10
echo "---> Process pods in knative-eventing namespace"
kubectl get pods -n knative-eventing | grep -v Running|grep -v Completed | awk '{print $1}' | xargs kubectl delete pod --namespace=knative-eventing

sleep 10
echo "---> Process pods in kabanero namespace"
kubectl get pods -n kabanero | grep -v Running|grep -v Completed | awk '{print $1}' | xargs kubectl delete pod --namespace=kabanero



sleep 10
####

#Fnd the activator pod in knative-serving namespace

POD=$(kubectl get pods -n knative-serving  -o=name | grep activator | sed "s/^.\{4\}//")

echo "--> Found kabaneoro operator pod:$POD"
 

#delete the activator pod

echo "---> Restarting pod: $POD"

oc delete pod $POD -n knative-serving


NEWPOD=$(kubectl get pods -n knative-servicing  -o=name | grep activator | sed "s/^.\{4\}//")


echo "Pod restarted: $NEWPOD"



sleep 10
####
#kubectl get pods -n kabanero  -o=name | grep kabanero-operator | sed "s/^.\{4\}//"

#Fnd the kabaneor-operator pod

POD=$(kubectl get pods -n kabanero  -o=name | grep kabanero-operator | sed "s/^.\{4\}//")

echo "--> Found kabaneoro operator pod:$POD"
 

#delete the kabaneor-operator pod

echo "---> Restarting pod: $POD"

oc delete pod $POD -n kabanero


NEWPOD=$(kubectl get pods -n kabanero  -o=name | grep kabanero-operator | sed "s/^.\{4\}//")


echo "Pod restarted: $NEWPOD"

sleep 10
echo "list pods in kabanero ns"
oc get pods -n kabanero
echo "list pods in knative-eventing ns"
oc get pods -n knative-eventing
echo "list pods in knative-serving ns"
oc get pods -n knative-serving
echo "list pods in openshift-operators ns"
oc get pods -n openshift-operators
echo " "

sleep 10
echo "get the state of the kabanero CR. Should be TRUE"
oc get kabanero -n kabanero

echo "COMPLETED"



#Output if no pods were found broken

#ibmdemo@workstation:~$ ./restartBrokenPods.sh 
#---> Process knative-eventing-operator pod in openshift-operators namespace
#error: resource(s) were provided, but no name, label selector, or --all flag specified
#---> Process knative-serving-operator pod in openshift-operators namespace
#error: resource(s) were provided, but no name, label selector, or --all flag specified
#---> Process pods in knative-serving namespace
#Error from server (NotFound): pods "NAME" not found
#---> Process pods in knative-eventing namespace
#Error from server (NotFound): pods "NAME" not found
#---> Process pods in kabanero namespace
#Error from server (NotFound): pods "NAME" not found
#COMPLETED
#ibmdemo@workstation:~$ 
