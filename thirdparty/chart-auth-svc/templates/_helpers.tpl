{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "auth-svc.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{- define "auth-svc.name" -}}
{{- default .Chart.Name | trunc 63 | trimSuffix "-" -}}
{{- end -}}

{{/*
Common labels
*/}}
{{- define "auth-svc.labels" -}}
helm.sh/chart: {{ include "auth-svc.chart" . }}
app.kubernetes.io/name: {{ include "auth-svc.name" . }}
{{ include "auth-svc.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "auth-svc.selectorLabels" -}}
app.kubernetes.io/name: {{ include "auth-svc.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}


{{- define "apiVersion.Deployment" -}}
  {{- if .Capabilities.APIVersions.Has "apps/v1/Deployment" -}}
    {{- print "apps/v1" -}}
  {{- else -}}
    {{- print "apps/v1beta2" -}}
  {{- end -}}
{{- end -}}

{{- define "apiVersion.Ingress" -}}
  {{- if .Capabilities.APIVersions.Has "networking.k8s.io/v1beta1/Ingress" -}}
    {{- print "networking.k8s.io/v1beta1" -}}
  {{- else -}}
    {{- print "extensions/v1beta1" -}}
  {{- end -}}
{{- end -}}
