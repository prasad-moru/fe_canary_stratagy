{{- define "cassandra-cluster.name" -}}
{{ .Chart.Name }}
{{- end }}

{{- define "cassandra-cluster.fullname" -}}
{{ .Release.Name }}-{{ include "cassandra-cluster.name" . }}
{{- end }}

{{- define "cassandra-cluster.labels" -}}
app.kubernetes.io/name: {{ include "cassandra-cluster.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}
