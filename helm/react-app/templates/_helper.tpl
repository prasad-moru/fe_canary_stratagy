{{/*
Expand the name of the chart.
*/}}
{{- define "react-app.name" -}}
{{ .Chart.Name }}
{{- end }}

{{/*
Create a default fully qualified app name.
*/}}
{{- define "react-app.fullname" -}}
{{ .Release.Name }}-{{ include "react-app.name" . }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "react-app.labels" -}}
helm.sh/chart: {{ include "react-app.chart" . }}
app.kubernetes.io/name: {{ include "react-app.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Create chart label
*/}}
{{- define "react-app.chart" -}}
{{ .Chart.Name }}-{{ .Chart.Version }}
{{- end }}
