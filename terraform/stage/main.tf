terraform {
  # Версия terraform
  required_version = ">=0.11,<0.12"
}

provider "google" {
  # Версия провайдера
  version = "2.0.0"

  # ID проекта
  project = "${var.project}"
  region  = "${var.region}"
}

module "app" {
  source              = "../modules/app"
  public_key_path     = "${var.public_key_path}"
  zone                = "${var.zone}"
  region              = "${var.region}"
  app_disk_image      = "${var.app_disk_image}"
  number_of_instances = "${var.number_of_instances}"
}

module "db" {
  source          = "../modules/db"
  public_key_path = "${var.public_key_path}"
  zone            = "${var.zone}"
  db_disk_image   = "${var.db_disk_image}"
}

module "vpc" {
  source          = "../modules/vpc"
  public_key_path = "${var.public_key_path}"
  source_ranges   = ["0.0.0.0/0"]
}
