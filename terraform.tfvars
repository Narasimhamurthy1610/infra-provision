instance_type    = "t2.large"
private_key_path = "/home/narasimhag/Downloads/test.pem"


cluster_name = "octabyte-cluster"
cluster_version = "1.30"

node_groups = {
  "ng-1" = {
    instance_types = ["t3.medium"]
    capacity_type  = "ON_DEMAND"
    scaling_config = {
      desired_size = 2
      max_size     = 4
      min_size     = 1
    }
  }
}