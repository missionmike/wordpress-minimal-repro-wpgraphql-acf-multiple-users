# WordPress Minimal Reproduction for ACF Users Issue

> Note: the issue this repro was diagnosing is now closed: https://github.com/wp-graphql/wpgraphql-acf/issues/234

## Setup Instructions

### Setup Dev container

Reopen the repository in a dev container. The `.devcontainer/setup.sh` script should install the WP
Core and plugins using versions defined in `plugins.txt` and `settings.env` files.

### Access WP Admin

Visit: http://localhost:8080/wp-admin/plugins.php to view installed plugins. If you're not using the
default `SITE_HOST` in `settings.env`, update the URL accordingly.

Login with:

-   Username: `admin`
-   Password: `password`

Confirm that the "Test Theme" is activated here: http://localhost:8080/wp-admin/themes.php

### Confirm ACF Fields

Visit the ACF Fields page to confirm that the "Custom Users" field group is available.

### Add Two Test Users

Visit the Users page and add two test users: http://localhost:8080/wp-admin/users.php

I used "User One" and "User Two" as names. Use these two users to test with the "Hello World" post
(post ID `1`, used in query below).

### Test a Query in the GraphQL IDE or Postman

Use this test query in the GraphQL IDE or Postman:

```
query NewQuery {
  post(id: "1", idType: DATABASE_ID) {
    databaseId
    customUsers {
      users {
        edges {
          node {
            databaseId
            firstName
            lastName
          }
        }
      }
    }
  }
}
```
