#!/bin/sh

# Exit on error (-e)
# Unset variables are treated as errors (-u)
# Enable debug mode (-x)
set -eux

# This env value is set in devcontainer.json
cd $WORKSPACE_FOLDER

# Load environment variables.
export $(grep -v '^#' settings.env | xargs)

# Install dependencies.
npm install

# Install WordPress and activate the plugin/theme.
cd /var/www/html
echo "Setting up WordPress at $SITE_HOST"

# Remove previous core files.
echo "Removing wp-admin, wp-includes and root files..."
rm -rf wp-admin wp-includes
rm -rf ./*.php ./*.html ./*.txt
echo "Done."

wp core download --skip-content --force --version="$WP_CORE_VERSION"
wp config create --dbhost="db" --dbname="exampledb" --dbuser="exampleuser" --dbpass="examplepass"
wp core install --url="$SITE_HOST" --title="WordPress Trunk" --admin_user="admin" --admin_email="admin@example.com" --admin_password="password" --skip-email

# Remove previous plugins.
wp plugin uninstall --deactivate --all

# Read the plugins.txt file line by line
while IFS= read -r line
do
    # Trim leading and trailing whitespace
    line=$(echo "$line" | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')

    # Skip empty lines and lines that start with #
    if [ -z "$line" ] || [ "$(echo "$line" | cut -c1)" = "#" ]; then
        continue
    fi

    # Split line into plugin and version
    plugin_name=$(echo "$line" | cut -d'=' -f1)
    version=$(echo "$line" | cut -d'=' -f2)

    # Install and activate the plugin using WP CLI
    if [ $version = "latest" ]; then
        wp plugin install "$plugin_name" --activate
    else
        wp plugin install "$plugin_name" --version="$version" --activate
    fi
done < $WORKSPACE_FOLDER/plugins.txt
