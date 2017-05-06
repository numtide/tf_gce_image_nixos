variable "release" {
  type        = "string"
  default     = "17.03"
  description = "The NixOS release series to use"
}

variable "release_map" {
  type = "map"

  default = {
    "16.03" = "16.03.847.8688c17"
    "17.03" = "17.03.1082.4aab5c5798"
  }

  description = "A map of release series to actual releases"
}

variable "project" {
  type        = "string"
  default     = ""
  description = "The project in which the resource belongs. If it is not provided, the provider project is used."
}

resource "google_compute_image" "nixos" {
  name = "nixos-${replace(var.release_map[var.release], ".", "-")}"

  #description = "NixOS ${var.release}"
  family  = "nixos-${replace(var.release, ".", "-")}"
  project = "${var.project}"

  raw_disk {
    #source = "gs://nixos-cloud-images/nixos-image-${var.release}-x86_64-linux.raw.tar.gz"
    source = "https://nixos-cloud-images.storage.googleapis.com/nixos-image-${var.release_map[var.release]}-x86_64-linux.raw.tar.gz"
  }
}

output "self_link" {
  value = "${google_compute_image.nixos.self_link}"
}
