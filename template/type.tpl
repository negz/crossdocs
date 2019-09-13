{{- define "type" }}
## {{ .Name.Name }}

{{ renderComments .CommentLines }}{{ if eq .Kind "Alias" }} Alias of {{.Underlying}}.{{- end}}
{{ with (typeReferences .) }}
Appears in:
{{ range . }}{{ if linkForType . }}
* [{{ typeDisplayName . }}](#{{ typeDisplayName . }}){{ else }}* {{ typeDisplayName . }}{{ end }}{{ end }}
{{ end }}
{{ if .Members -}}
Name | Type | Description
-----|------|------------
{{- if isExportedType . }}
`apiVersion` | string | `{{apiGroup .}}`
`kind` | string | `{{.Name.Name}}`
{{- end }}
{{ range .Members }}{{ template "member" . }}{{end}}
{{ with embeddedFields . }}
Also supports all fields of:
{{ range . }}{{ template "embed" . }}{{end}}
{{ end }}
{{ end -}}
{{- end -}}