output "vpc" {
  value = "${module.vpc.vpc}"
}

output "subnet" {
  value = "${module.vpc.subnet}"
}
