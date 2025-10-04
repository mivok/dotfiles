# Set paths for tools that need additional configuration to use files in
# $XDG_CONFIG_HOME, $XDG_CACHE_HOME, and $XDG_DATA_HOME

# Set XDG Base Directory variables if not already set
export XDG_CONFIG_HOME=${XDG_CONFIG_HOME:-$HOME/.config}
export XDG_CACHE_HOME=${XDG_CACHE_HOME:-$HOME/.cache}
export XDG_DATA_HOME=${XDG_DATA_HOME:-$HOME/.local/share}
export XDG_STATE_HOME=${XDG_STATE_HOME:-$HOME/.local/state}

# Terraform
export TF_CLI_CONFIG_FILE=$XDG_CONFIG_HOME/terraform/terraformrc

# Postgres
export PSQLRC="$XDG_CONFIG_HOME/pg/psqlrc"
export PGPASSFILE="$XDG_CONFIG_HOME/pg/pgpass"
export PGSERVICEFILE="$XDG_CONFIG_HOME/pg/pg_service.conf"
