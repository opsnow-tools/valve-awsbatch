```bash
aws batch submit-job --cli-input-json file://submit_job.json

aws logs filter-log-events --log-group-name /aws/events/batchlog
aws logs filter-log-events --log-group-name /aws/events/batch2alertnow
```