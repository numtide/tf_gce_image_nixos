variable "release" {
  default = "17.03.1082.4aab5c5798"
}

variable "project" {
  type        = "string"
  default     = ""
  description = "Google Project name. Inherited from provider by default."
}

resource "google_compute_image" "nixos" {
  name = "nixos-${replace(var.release, ".", "-")}"

  #description = "NixOS ${var.release}"
  family  = "nixos-${replace(substr(var.release, 0, 5), ".", "-")}"
  project = "${var.project}"

  raw_disk {
    #source = "gs://nixos-cloud-images/nixos-image-${var.release}-x86_64-linux.raw.tar.gz"
    source = "https://nixos-cloud-images.storage.googleapis.com/nixos-image-${var.release}-x86_64-linux.raw.tar.gz"
  }
}

output "self_link" {
  value = "${google_compute_image.nixos.self_link}"
}
