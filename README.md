# crossdocs

A fork of [gen-crd-api-reference-docs](https://github.com/ahmetb/gen-crd-api-reference-docs)
tailored to generate Crossplane's markdown API documentation.

This tool is currently a giant hack. To generate docs you'll need to:

1. Clone this repo to `$GOPATH/src/go/github.com/negz/crossdocs`
1. Update `Gopkg.toml` and `doc.sh` to ensure you're vendoring and running
   documentation generation for the versions of the Crossplane projects you
   care about.
1. Run `./doc.sh`.
1. Run `cp -R out/docs/api $GOPATH/src/github.com/crossplaneio/crossplane/docs/`
