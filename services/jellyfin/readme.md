# SMB Helm-Chart
```
https://github.com/kubernetes-csi/csi-driver-smb/tree/master
```

# SMB Credentials
```
kubectl create secret generic smbcredentials --from-literal username=mediaserver --from-literal password="<password>"
```

# Storage Class
```
kubectl create -f https://raw.githubusercontent.com/kubernetes-csi/csi-driver-smb/master/deploy/example/storageclass-smb.yaml
```