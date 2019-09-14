{{- define "type" }}
## {{ .Name.Name }}

{{ renderComments .CommentLines }}{{ if eq .Kind "Alias" }} Alias of {{.Underlying}}.{{- end}}
{{ with (typeReferences .) }}
Appears in:
{{ range . }}{{ if linkForType . }}
* [{{ typeDisplayName . }}](#{{ typeDisplayName . }}){{ else }}* {{ typeDisplayName . }}{{ end }}{{ end }}
{{ end }}
{{ if .Members -}}
{{ if (gt (len .Members) (len (embeddedFields .)))}}
Name | Type | Description
-----|------|------------
{{- end -}}
{{- if isExportedType . }}
`apiVersion` | string | `{{apiGroup .}}`
`kind` | string | `{{.Name.Name}}`
{{- end }}
{{ range .Members }}{{ template "member" . }}{{end}}
{{ if embeddedFields . }}
{{ .Name.Name }} supports all fields of:
{{ range embeddedFields . }}{{ template "embed" . }}{{end}}
{{ end }}
{{ end -}}
{{- end -}}