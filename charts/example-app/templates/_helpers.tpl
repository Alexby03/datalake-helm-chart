{{- define "helper-func-example.name" -}}
{{- .Chart.Name -}}
{{- end -}}

{{- define "helper-func-example.fullname" -}}
{{- printf "%s-%s" .Release.Name .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

