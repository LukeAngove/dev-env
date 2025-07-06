# nix-dev

This repository contains a development environment configured with Nix, primarily for Neovim setup and related tools.

## Structure

- `shell.nix`: Defines the Nix shell environment, including all development dependencies and tools.
- `enter-nix`: A script to enter the Nix shell, ensuring all dependencies are available.
- `checkhealth.sh`: A script to perform health checks on the environment and Neovim configuration.
- `nvim_config/`: Contains the Neovim configuration files, organized by `init.lua` and `lua/` modules.
- `.github/workflows/`: GitHub Actions workflows for continuous integration, including checks for Docker and Podman environments.

## Entering the Nix Shell

To set up the development environment with all necessary dependencies, run:

```bash
./enter-nix
```

Once inside the Nix shell, you will have access to all the tools and configurations defined in `shell.nix`, including Neovim with its custom configuration.

## Running Health Checks

To verify that everything is set up correctly, you can run the health checks:

```bash
./enter-nix checkhealth
```