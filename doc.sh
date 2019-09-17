#! /bin/bash

gendoc() {
    local org=$1
    local project=$2
    local dir=$3
    local package=$4
    local version=$5

    local group_name=$(grep groupName vendor/github.com/${org}/${project}/${dir}/${package}/${version}/doc.go | awk -F= '{ print $2 }')

    mkdir -p out/docs/api/${org}/${project}

    go run ${GOPATH}/src/github.com/negz/crossdocs/main.go \
        -config config/${org}/${project}.json \
        -template-dir template \
        -api-dir "github.com/${org}/${project}/${dir}/${package}/${version}" \
        -out-file out/docs/api/${org}/${project}/${group_name//./-}-${version}.md
}

packages() {
    local org=$1
    local project=$2
    local dir=$3

    find vendor/github.com/${org}/${project}/${dir} \
        -type d \
        -depth 1 \
        -exec basename {} \;
}

for package in $(packages crossplaneio crossplane-runtime apis); do
    gendoc crossplaneio crossplane-runtime apis $package v1alpha1
done

for package in $(packages crossplaneio crossplane apis); do
    gendoc crossplaneio crossplane apis $package v1alpha1
done

gendoc crossplaneio stack-aws aws apis v1alpha2
for package in $(packages crossplaneio stack-aws aws/apis | grep -v v1alpha2); do
    gendoc crossplaneio stack-aws aws/apis $package v1alpha2
done

gendoc crossplaneio stack-azure azure apis v1alpha2
for package in $(packages crossplaneio stack-azure azure/apis | grep -v v1alpha2); do
    gendoc crossplaneio stack-azure azure/apis $package v1alpha2
done

gendoc crossplaneio stack-gcp gcp apis v1alpha2
for package in $(packages crossplaneio stack-gcp gcp/apis | grep -v v1alpha2); do
    gendoc crossplaneio stack-gcp gcp/apis $package v1alpha2
done
