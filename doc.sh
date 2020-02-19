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

    find ./vendor/github.com/${org}/${project}/${dir} \
        -type d \
        -maxdepth 1 \
        -mindepth 1 \
        -exec basename {} \;
}

for package in $(packages crossplane crossplane-runtime apis); do
    gendoc crossplane crossplane-runtime apis $package v1alpha1
done

for package in $(packages crossplane crossplane apis); do
    gendoc crossplane crossplane apis $package v1alpha1
done


gendoc crossplane stack-aws apis "" v1alpha3
gendoc crossplane stack-aws apis database v1alpha3
gendoc crossplane stack-aws apis database v1beta1
gendoc crossplane stack-aws apis cache v1beta1
gendoc crossplane stack-aws apis identity v1alpha3
gendoc crossplane stack-aws apis network v1alpha3
gendoc crossplane stack-aws apis storage v1alpha3
gendoc crossplane stack-aws apis compute v1alpha3

gendoc crossplane stack-azure apis "" v1alpha3
gendoc crossplane stack-azure apis cache v1beta1
gendoc crossplane stack-azure apis compute v1alpha3
gendoc crossplane stack-azure apis database v1alpha3
gendoc crossplane stack-azure apis database v1beta1
gendoc crossplane stack-azure apis network v1alpha3
gendoc crossplane stack-azure apis storage v1alpha3

gendoc crossplane stack-gcp apis "" v1alpha3
gendoc crossplane stack-gcp apis servicenetworking v1beta1
gendoc crossplane stack-gcp apis database v1beta1
gendoc crossplane stack-gcp apis cache v1beta1
gendoc crossplane stack-gcp apis storage v1alpha3
gendoc crossplane stack-gcp apis compute v1alpha3
gendoc crossplane stack-gcp apis compute v1beta1
gendoc crossplane stack-gcp apis container v1alpha1
gendoc crossplane stack-gcp apis container v1beta1

gendoc crossplane stack-rook apis "" v1alpha1
for package in $(packages crossplane stack-rook apis | grep -v v1alpha1); do
    gendoc crossplane stack-rook apis $package v1alpha1
done
