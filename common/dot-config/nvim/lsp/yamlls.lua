return {
  settings = {
    redhat = {
      telemetry = {
        enabled = false
      }
    },
    yaml = {
      format = {
        enable = true
      },
      schemaStore = {
        enable = true
      },
      schemas = {
          -- File patterns that are cloudformation yaml files
        ["https://raw.githubusercontent.com/awslabs/goformation/master/schema/cloudformation.schema.json"] = {
          "cloudformation/*.yml",
          "cloudformation/*.yaml",
        }
      }
    }
  }
}
