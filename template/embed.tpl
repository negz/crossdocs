{{ define "embed" }}
* {{ if linkForType .Type }}[{{ typeDisplayName .Type}}]({{ linkForType .Type }}){{ else }}{{ typeDisplayName .Type }}{{ end }}{{ end -}}