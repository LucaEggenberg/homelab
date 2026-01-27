# Usage
```sh
kubeseal --controller-name sealed-secrets --format yaml < secret.yml > sealed-secret.yml

nix-shell -p kubeseal --run "kubeseal --controller-name sealed-secrets --format yaml < secret.yml > sealed-secret.yml"
```


```yaml
apiVersion: v1
kind: Secret
metadata:
  name: name
  namespace: namespace
type: Opaque
data:
  SECRET_NAME:
```

