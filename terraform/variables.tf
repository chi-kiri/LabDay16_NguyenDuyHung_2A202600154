variable "aws_region" {
  description = "AWS Region"
  type        = string
  default     = "us-east-1"
}

variable "hf_token" {
  description = "Hugging Face Token (không cần cho Ollama, giữ lại để tương thích)"
  type        = string
  sensitive   = true
  default     = ""
}

variable "model_id" {
  description = "Ollama Model ID to serve (CPU-friendly models)"
  type        = string
  default     = "tinyllama"
}