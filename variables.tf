variable "name" {
  description = "The name for the Storage Account. Will be prefixed with st on create. Must be between 7 and 22 characters long, letters and number only and must be globally unique as it generates a URL for clients to connect to like <server_name>.<blob|table ect>.core.windows.net."
  type        = string
  validation {
    # alltrue is logical AND
    # we use length regexall to return true when there are 0 regex matches
    condition = alltrue(
      # All true requires a list as the arg
      [
        length(regexall("^st", var.name)) == 0,
      ]
    )
    error_message = "Variable name should not be prefixed with 'st' as this is done automatically."
  }
  validation {
    condition     = length(var.name) >= 7 && length(var.name) <= 22
    error_message = "Variable name should be between 7 and 22 characters long."
  }
}

variable "default_action" {
  description = "Allow access to all networks?"
  default     = "Deny"
  type        = string
  validation {
    condition = anytrue([
      var.default_action == "Allow",
      var.default_action == "Deny"
    ])
    error_message = "Valid values are Allow or Deny. This variable is optional, and defaults to Deny."
  }
}
