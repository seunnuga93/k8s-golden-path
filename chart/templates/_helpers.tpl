{{- define "golden-path.name" -}}
{{- .Release.Name -}}
{{- end -}}

{{- define "golden-path.labels" -}}
app.kubernetes.io/name: {{ include "golden-path.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end -}}
