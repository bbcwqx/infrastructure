# cluster-config

## encrypting secrets

[reference](https://fluxcd.io/flux/guides/mozilla-sops/#encrypting-secrets-using-openpgp)

Create secret

```bash
kubectl -n default create secret generic basic-auth \
    --from-literal=user=admin \
    --from-literal=password=change-me \
    --dry-run=client \
    -o yaml > basic-auth.yaml
```

Encrypt, make sure you're in the directory that contains the .sops.yaml config file

```bash
sops --encrypt --in-place basic-auth.yaml
```
