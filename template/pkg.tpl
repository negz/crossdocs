{{- define "packages" -}}
{{- range .packages -}}
# {{ packageDisplayName . }} API Reference

{{ with (index .GoPackages 0 ) }}{{ renderComments .DocComments }}{{ end }}

This API group contains the following resources:

{{ range (visibleTypes (sortedTypes .Types)) }}{{ if (isExportedType .) }}* [{{ typeDisplayName . }}]({{ linkForType . }})
{{ end }}{{- end -}}
{{- range (visibleTypes (sortedTypes .Types)) -}}
{{ template "type" .  }}
{{- end -}}
{{end}}
Generated with `gen-crd-api-reference-docs`{{ with .gitCommit }} on git commit `{{ . }}`{{end}}.
{{- end -}}