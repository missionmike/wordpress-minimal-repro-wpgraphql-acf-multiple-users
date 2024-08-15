# WordPress Minimal Reproduction Boilerplate

Base WordPress VS Code Dev Container used to scaffold minimal reproductions for troubleshooting
issues.

The `.devcontainer` folder and contents is based on the
[official WordPress repo](https://github.com/WordPress/wordpress-develop/tree/trunk/.devcontainer).

The purpose of this repo is to be forked, then modified to scaffold a minimal reproduction for
specific plugin(s) or themes.

## Setup Instructions

### Basic Defaults

1. Reopen the repository in a dev container.

### Modified

2. Edit the `settings.env` file to make version adjustments.
3. Edit the `plugins.txt` file to modify the list of installed and activated plugins.
4. Run `sh .devcontainer/setup.sh` to reinstall WP Core and plugins with the modified settings.

### Access WP Admin

Visit: http://localhost:8080/wp-admin/plugins.php to view installed plugins. If you're not using the
default `SITE_HOST` in `settings.env`, update the URL accordingly.

Login with:

-   Username: `admin`
-   Password: `password`
