# Managing keys

## Add a key
```bash
gpg --import keyfile.asc
```

## Check a key

```bash
gpg --fingerprint admin@mullvad.net
```

## List keys

```bash
gpg -k
```

## Remove a key
```bash
gpg --delete-key A1198702FC3E0A09A9AE5B75D5A1D4F266DE8DDF
```
