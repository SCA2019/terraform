terraform init
terraform plan -out planfile.binary
terraform show -json planfile.binary > opa-input.json
chmod +x opa
./opa eval -i opa-input.json -d policy.repo 'data.terraform'
