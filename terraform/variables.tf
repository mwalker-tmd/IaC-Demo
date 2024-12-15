variable "env" {
  description = "The environment for the EKS cluster"
  type        = string
}
variable "aws_region" {
  description = "The AWS region for the EKS cluster"
  type        = string
}
variable "aws_zone_1" {
  description = "The first availability zone for the EKS cluster"
  type        = string
}
variable "aws_zone_2" {
  description = "The second availability zone for the EKS cluster"
  type        = string
}
variable "project_name" {
  description = "The name of the project"
  type        = string
}
variable "eks_version" {
  description = "The version of the EKS cluster"
  type        = string
}
variable "aws_profile" {
  description = "The AWS profile to use"
  type        = string
}