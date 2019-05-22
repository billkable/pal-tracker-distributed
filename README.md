# READ ME!!

This is a revised repository for the PAL course distributed codebase.

It is stripped of the Spring Cloud Service Discovery and Service Registry,
as modern Spring applications will likely favor use of platform provided
service registry and discovery mechanisms such as Service Mesh.

## Initial setup

You can run the following script to prepare your local and Cloud Foundry
environments to deploy the PAL Tracker Distributed application:

```bash
./scripts/set-user-env.sh <BASE ROUTE SPECIFICATION>
```

where the `<BASE ROUTE SPECIFICATION>` is the same combination of
`${UNIQUE_IDENTIFIER}.${DOMAIN}` string you prepared and applied in your
`pal-tracker` application.

For example, where the domain is `apps.evans.pal.pivotal.io` and the unique
identifier is `jsmith`,
the `<BASE ROUTE SPECIFICATION>` is:

`jsmith.apps.evans.pal.pivotal.io`

You would run the user setup script as:

```bash
./scripts/set-user-env.sh jsmith.apps.evans.pal.pivotal.io 
```
