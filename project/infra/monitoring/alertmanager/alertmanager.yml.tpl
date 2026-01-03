route:
  receiver: "slack"
  group_by: ['alertname', 'job']
  group_wait: 10s
  group_interval: 2m
  repeat_interval: 2h

receivers:
  - name: "slack"
    slack_configs:
      - api_url: ${SLACK_WEBHOOK_URL}
        channel: "#alerts"
        send_resolved: true
        title: '[{{ .Status | toUpper }}] {{ .CommonLabels.alertname }}'
        text: >-
          {{ range .Alerts -}}
          *{{ .Labels.job }}* — {{ .Annotations.summary }}
          {{ .Annotations.description }}
          {{ end }}


