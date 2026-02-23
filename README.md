# kind + helmfile example

## Prerequisites

- [mise](https://mise.jdx.dev/getting-started.html#installing-mise-cli)
- [docker](https://docs.docker.com/engine/install/) (for kind to be able to run)

## Deploy

```bash
mise run deploy-dev
# will setup the kind cluster (if needed) and then deploy everything specified in the helmfile for the "dev" environment
```

To check if it worked you should be able to access: [example.localtest.me](http://example.localtest.me) and be greeted with a html page that shows the rendered [charts/example-app/files/index.html](./charts/example-app/files/index.html).

> [!NOTE]
> You might have to wait a few seconds before the page is accessible.

> [!NOTE]
> `localtest.me` is just a wildcard DNS entry that points at `127.0.0.1`, so you will need internet for it to be able to resolve, it can be replaced by *.localhost entries in the `/etc/hosts` file, but it works differenly on different OS, so `localtest.me` was used for this example.

## Destroy

```bash
mise run delete-kind-cluster
# destroys the kind cluster (if needed)
```

