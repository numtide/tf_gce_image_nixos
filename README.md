# tf_gce_image_nixos

A terraform module to provide NixOS images on GCP.

This module actually creates a new image in the project using a public tarball
or a NixOS release.  Those tarballs have been created by the NixOps projects
are are listed here:
https://github.com/NixOS/nixops/commit/c28a4f7acedbc1b3b8446f3713f219109da19134

## Module Input Variables

* `release` - (Optional) The image release. This should generally be untouched.
* `project` - (Optional) The project in which the resource belongs. If it is not provided, the provider project is used.

## Outputs

* `self_link` - The URI of the created resource.

## Example

```hcl
module "nixos_image" {
  source = "github.com/numtide/tf_gce_image_nixos"
}

resource "google_compute_instance" "example" {
  name         = "example"
  machine_type = "n1-standard-1"
  zone         = "us-central1-a"

  disk {
    image = "${module.nixos_image.self_link}"
  }

  network_interface {
    network       = "default"
  }
}
```

### Default configuration.nix

A new configuration.nix can be passed trough the userdata. Here is the default
configuration to expand upon:

```nix
{ config, pkgs, ... }:

{
  imports = [ <nixpkgs/nixos/modules/virtualisation/google-compute-image.nix> ];
}
```

## TODO

* How are these images updated?
* Why are the images 100GB in size?

## License

Apache 2 Licensed. See LICENSE for full details.