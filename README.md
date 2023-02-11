<div align="center">

<!-- omit in toc -->
# asdf-zbctl
[![Community Extension](https://img.shields.io/badge/Community%20Extension-An%20open%20source%20community%20maintained%20project-FF4700)](https://github.com/camunda-community-hub/community)
[![Lifecycle Incubating](https://img.shields.io/badge/Lifecycle-Incubating-blue)](https://github.com/Camunda-Community-Hub/community/blob/main/extension-lifecycle.md#incubating-)
[![Build](https://github.com/camunda-community-hub/asdf-zbctl/actions/workflows/build.yml/badge.svg)](https://github.com/camunda-community-hub/asdf-zbctl/actions/workflows/build.yml)
[![Lint](https://github.com/camunda-community-hub/asdf-zbctl/actions/workflows/lint.yml/badge.svg)](https://github.com/camunda-community-hub/asdf-zbctl/actions/workflows/lint.yml)

</div>

<!-- omit in toc -->
# Contents

- [Overview](#overview)
- [Dependencies](#dependencies)
- [Install](#install)
- [Contributing](#contributing)
- [License](#license)

# Overview

This is a [zbctl](https://docs.camunda.io/docs/apis-clients/cli-client/) plugin
for the [asdf version manager](https://asdf-vm.com).

`zbctl` is a command line interface to interact with Zeebe in [Camunda Platform 8](https://camunda.com/platform/).

# Dependencies

- `bash`, `curl`, `grep`, and other generic POSIX utilities.

# Install

Plugin:

```shell
asdf plugin add zbctl https://github.com/camunda-community-hub/asdf-zbctl.git
```

zbctl:

```shell
# Show all installable versions
asdf list-all zbctl

# Install specific version
asdf install zbctl latest

# Set a version globally (on your ~/.tool-versions file)
asdf global zbctl latest

# Now zbctl commands are available
zbctl version
```

Check [asdf](https://github.com/asdf-vm/asdf) readme for more instructions on how to
install & manage versions.

# Contributing

Contributions of any kind are welcome! See the [contributing guide](CONTRIBUTING.MD).

[Thanks go to these contributors](https://github.com/camunda-community-hub/asdf-zbctl/graphs/contributors)!

# License

See [LICENSE](LICENSE) © [Ahmed AbouZaid](https://github.com/aabouzaid/)
