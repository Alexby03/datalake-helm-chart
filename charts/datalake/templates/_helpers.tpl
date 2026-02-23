{{/*
Expand the name of the chart.
*/}}
{{- define "datalake.fullname" -}}
{{- if .Values.global.prefix -}}
{{- printf "%s-%s" .Values.global.prefix .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- else -}}
{{- .Release.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}
{{- end -}}
