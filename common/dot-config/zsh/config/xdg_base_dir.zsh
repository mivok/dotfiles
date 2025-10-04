# Set paths for tools that need additional configuration to use files in
# $XDG_CONFIG_HOME, $XDG_CACHE_HOME, and $XDG_DATA_HOME

# Terraform
export TF_CLI_CONFIG_FILE="$XDG_CONFIG_HOME/terraform/terraformrc"

# Postgres
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"
