resource "google_storage_bucket" "bucket2" {
  name = "armegeddon_bucket"
  location = "us"

  storage_class = "nearline"
  labels = {
    "env" = "tf_env"
    "dept" = "compliance"}

  uniform_bucket_level_access = true
  lifecycle_rule {
    condition {
        age = 30
      }
    action {
      type = "SetStorageClass"
      storage_class = "coldline"
    }
  }


retention_policy {
  is_locked = true
  retention_period = 777600
  }
}

   resource "google_storage_bucket_object" "girls_on_wheels" {
   bucket = google_storage_bucket.bucket2.name
   name = "r1_chicks"
   source = "r1_chicks.jpeg"

 }