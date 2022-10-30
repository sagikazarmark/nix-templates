# My Nix flake templates

[![built with nix](https://builtwithnix.org/badge.svg)](https://builtwithnix.org)

This repository contains a list of project templates to be used with the `nix flake init` command.


## Usage

If you like any of the templates in this repository,
you can easily start a new project from them with the one of the following commands:

```shell
# Initialize in the current directory
nix flake init --template github:sagikazarmark/nix-templates#TEMPLATE

# Create a new directory
nix flake new --template github:sagikazarmark/nix-templates#TEMPLATE NEW_PROJECT
```


## Templates

| Template       | Description              |
|----------------|--------------------------|
| [base](./base) | A basic project template |


## Development

### Creating a new template

Use the `base` template to scaffold a new template:

```shell
nix flake new --template .#base NEW_TEMPLATE
```

Add the template to the list above.

### Updating templates

Some of the components need updating from time to time.
This section describes the steps to do that.

#### Upgrade nix-direnv

All templates come with a [nix-direnv](https://github.com/nix-community/nix-direnv) initialization in `.envrc` to make sure the generated projects are self-contained.
This makes projects usable without installing nix-direnv on the machine manually.

The nix-direnv version in `.envrc` is pinned, so it needs updating from time to time.

Run the following command to update nix-direnv to a [specific version](https://github.com/nix-community/nix-direnv/releases):

```shell
update-envrc 2.1.2
```

Review the changes then commit, push and open a PR.


## Credits

Check out the [Official Nix templates](https://github.com/NixOS/templates) for more examples.

Kudos to [@lucperkins](https://github.com/lucperkins) for creating [The Nix Way](https://github.com/the-nix-way).
These template are inspired by his [dev templates](https://github.com/the-nix-way/dev-templates).


## License

The project is licensed under the [MIT License](LICENSE).
