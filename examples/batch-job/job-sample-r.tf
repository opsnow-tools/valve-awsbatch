# batch-job.tf

resource "aws_batch_job_definition" "sample-r" {
  name = "${local.upper_full_name}-SAMPLE-R"
  type = "container"

  container_properties = <<CONTAINER_PROPERTIES
{
  "image": "docker-registry-devops.coruscant.opsnow.com/sample-r",
  "memory": 1024,
  "vcpus": 1,
  "volumes": [
    {
      "host": {
        "sourcePath": "/tmp"
      },
      "name": "/home/results"
    }
  ],
  "environment": [
      {"name": "VARNAME", "value": "VARVAL"}
  ],
  "ulimits": [
    {
      "hardLimit": 1024,
      "name": "nofile",
      "softLimit": 1024
    }
  ]
}
CONTAINER_PROPERTIES

}