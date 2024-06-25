output "application_id" {
  value       = awscc_qbusiness_application.this.application_id
  description = "The ID of the QBusiness application."
}

output "index_id" {
  value       = awscc_qbusiness_index.this.index_id
  description = "The ID of the QBusiness index."
}

output "retriever_id" {
  value       = awscc_qbusiness_retriever.this.retriever_id
  description = "The ID of the QBusiness retriever."
}

output "web_experience_id" {
  value       = awscc_qbusiness_web_experience.this.web_experience_id
  description = "The ID of the QBusiness web experience."
}

output "web_endpoint" {
  value       = awscc_qbusiness_web_experience.this.default_endpoint
  description = "The default endpoint of the QBusiness web experience."
}
