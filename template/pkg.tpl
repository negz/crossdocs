{{- define "packages" -}}
{{- range .packages -}}
# {{ packageDisplayName . }} API Reference

{{ with (index .GoPackages 0 ) }}{{ renderComments .DocComments }}{{ end }}

This API group contains the following Crossplane resources:

{{ range (visibleTypes (sortedTypes .Types)) }}{{ if (isExportedType .) }}* [{{ typeDisplayName . }}]({{ linkForType . }})
{{ end }}{{- end -}}
{{- range (visibleTypes (sortedTypes .Types)) -}}
{{ template "type" .  }}
{{- end -}}
{{end}}
This API documentation was generated by `crossdocs`.
{{- end -}}