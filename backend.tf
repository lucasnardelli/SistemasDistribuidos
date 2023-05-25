terraform {
    backend "s3" {
        region = "us-east-2"
        bucket = "k8s-lucasnrd"
        encrypt = "true"
        key = "terraform.tfstate"
    }
}