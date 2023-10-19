terraform init
terraform plan -out planfile.binary
terraform show -json planfile.binary > plan-output.json
jq -s '.[0] * .[1]' plan-output.json opa-exclusions.json > opa-input.json
chmod +x opa
./opa eval -i opa-input.json -d policy.repo 'data.terraform'
