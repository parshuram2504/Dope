{{/*
Return the chart name, allowing it to be overridden.
*/}}
{{- define "dope.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Return the fully qualified application name.
*/}}
{{- define "dope.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Common labels for chart resources.
*/}}
{{- define "dope.labels" -}}
helm.sh/chart: {{ printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" }}
{{ include "dope.selectorLabels" . }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Labels used to associate the Service with the Deployment's Pods.
*/}}
{{- define "dope.selectorLabels" -}}
app.kubernetes.io/name: {{ include "dope.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
