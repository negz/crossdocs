#! /bin/bash

gendoc() {
    local org=$1
    local project=$2
    local dir=$3
    local package=$4
    local version=$5

    local group_name=$(grep groupName ${GOPATH}/src/github.com/${org}/${project}/${dir}/${package}/${version}/doc.go | awk -F= '{ print $2 }')

    mkdir -p out/docs/api/${org}/${project}

    go run ${GOPATH}/src/github.com/negz/crossdocs/main.go \
        -config config/${org}/${project}.json \
        -template-dir template \
        -api-dir "github.com/${org}/${project}/${dir}/${package}/${version}" \
        -out-file out/docs/api/${org}/${project}/${group_name//./-}-${version}.md
}

gendoc crossplaneio crossplane-runtime apis core v1alpha1

gendoc crossplaneio crossplane apis cache v1alpha1
gendoc crossplaneio crossplane apis compute v1alpha1
gendoc crossplaneio crossplane apis database v1alpha1
gendoc crossplaneio crossplane apis stacks v1alpha1
gendoc crossplaneio crossplane apis storage v1alpha1
gendoc crossplaneio crossplane apis workload v1alpha1

# TODO(negz): Support the base aws/apis/v1alpha2 package
gendoc crossplaneio stack-aws aws/apis cache v1alpha2
gendoc crossplaneio stack-aws aws/apis compute v1alpha2
gendoc crossplaneio stack-aws aws/apis database v1alpha2
gendoc crossplaneio stack-aws aws/apis storage v1alpha2
