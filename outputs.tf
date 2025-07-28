output "ec2_public_ip" {
  value = module.ec2.public_ip
}

output "eks_cluster_name" {
  value = module.eks.cluster_name
}

output "eks_cluster_endpoint" {
  value = module.eks.cluster_endpoint
}


output "vpc_id" {
  value = module.vpc.vpc_id
}
/*output "rds_endpoint" {
  value = module.rds.db_endpoint
}

output "alb_dns" {
  value = module.alb.lb_dns_name
}
*/