# crossdocs

A fork of [gen-crd-api-reference-docs](https://github.com/ahmetb/gen-crd-api-reference-docs)
tailored to generate Crossplane's markdown API documentation.

This tool is currently a giant hack. To generate docs you'll need to:

1. Clone this repo to `$GOPATH/src/go/github.com/negz/crossdocs`
1. Ensure crossplane, crossplane-runtime, and all stacks you want to generate
   docs for are in your `$GOPATH`, with the branch you want to document checked
   out and up-to-date.
1. Ensure any dependencies of the API packages you want to generate docs for are
   in your `$GOPATH`. :(
1. Run `./doc.sh`. You'll need to update this script to support new types.

