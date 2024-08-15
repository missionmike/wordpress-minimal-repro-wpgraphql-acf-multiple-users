// Import the default config file and expose it in the project root.
// Useful for editor integrations.
const wpPrettierConfig = require('@wordpress/prettier-config');

// Copy the default config to append customizations.
const prettierConfig = { ...wpPrettierConfig };

// Improve readability and formatting for markdown files.
prettierConfig.printWidth = 100;
prettierConfig.proseWrap = 'always';

module.exports = prettierConfig;
