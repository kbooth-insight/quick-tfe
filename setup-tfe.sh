#!/bin/bash
set +x

tfe_email="admin@local.com"
tfe_password=$(date +%s | sha256sum | base64 | head -c 16 ; echo)
tfe_username="admin"
tfe_domain="localhost"

echo '####################### PASSWORD!!!!! #################'
echo $tfe_password
echo '#######################################################'

# Setup logging
logfile="/tmp/install-ptfe.output"
# exec > $logfile 2>&1
mv /tmp/replicated.rli /etc/

cat > /etc/replicated-ptfe.conf <<EOF
{
  "disk_path": {
      "value": "/data"
  },
  "enc_password": {
    "value": "${tfe_password}"
  },
  "hostname": {
    "value": "${tfe_domain}"
  },
  "installation_type": {
    "value": "production"
    },
  "production_type": {
    "value": "disk"
    },
  "tls_vers": {
    "value": "tls_1_2_tls_1_3"
  }
}
EOF

cat > /etc/replicated.conf <<EOF
{
  "DaemonAuthenticationType":     "password",
  "DaemonAuthenticationPassword": "${tfe_password}",
  "TlsBootstrapType":             "self-signed",
  "TlsBootstrapHostname":         "${tfe_domain}",
  "BypassPreflightChecks":        true,
  "ImportSettingsFrom":           "/etc/replicated-ptfe.conf",
  "LicenseFileLocation":          "/etc/replicated.rli"
}
EOF


curl https://install.terraform.io/ptfe/stable > /tmp/ptfe-install.sh
chmod +x /tmp/ptfe-install.sh

private_ip=`hostname -I | awk '{print $2}'`
public_ip=`hostname -I | awk '{print $2}'`

sudo /tmp/ptfe-install.sh no-proxy private-address=${private_ip} public-address=${public_ip}
# | tee /tmp/install-ptfe.output

NOW=$(date +"%FT%T")
echo "[$NOW]  Sleeping for 5 minutes while PTFE installs."
sleep 300

while ! curl -ksfS --connect-timeout 5 https://${tfe_domain}/_health_check; do
    sleep 5
done

NOW=$(date +"%FT%T")
echo "[$NOW]  PTFE Instance is healthy"

NOW=$(date +"%FT%T")
echo "[$NOW]  Create initial site admin"

initial_token=$(replicated admin --tty=0 retrieve-iact)
curl -k \
  --header "Content-Type: application/json" \
  --request POST \
  --data '{"username":"'"${tfe_username}"'","email":"'"${tfe_email}"'","password":"'"${tfe_password}"'"}' \
  https://${tfe_domain}/admin/initial-admin-user?token=${initial_token}

NOW=$(date +"%FT%T")
echo "[$NOW]  Finished PTFE user_data script."
