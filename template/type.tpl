{{- define "type" }}
## {{ .Name.Name }}

{{ renderComments .CommentLines }}{{ if eq .Kind "Alias" }} Alias of {{.Underlying}}.{{- end}}
{{ with (typeReferences .) }}
Appears in:

{{ range . }}{{ if linkForType . }}* [{{ typeDisplayName . }}](#{{ typeDisplayName . }}){{ else }}* {{ typeDisplayName . }}{{ end }}{{ end }}
{{ end }}
{{ if .Members -}}
Name | Type | Description
-----|------|------------
{{- if isExportedType . }}
`apiVersion` | string | `{{apiGroup .}}`
`kind` | string | `{{.Name.Name}}`
{{- end }}
{{ range .Members }}{{ template "member" . }}{{end}}
{{ range .Members }}{{ template "embed" . }}{{end}}
{{ end -}}
{{- end -}}