# p6df-core


## Table of Contents


### p6df-core
- [p6df-core](#p6df-core)

  - [Badges](#badges)
  - [Distributions](#distributions)
  - [Summary](#summary)
  - [Contributing](#contributing)
  - [Code of Conduct](#code-of-conduct)
  - [Changes](#changes)
    - [Usage](#usage)
  - [Author](#author)

### Badges

[![License](https://img.shields.io/badge/License-Apache%202.0-yellowgreen.svg)](https://opensource.org/licenses/Apache-2.0)
[![Gitpod ready-to-code](https://img.shields.io/badge/Gitpod-ready--to--code-blue?logo=gitpod)](https://gitpod.io/#https://github.com/p6m7g8/p6df-core)
[![Mergify](https://img.shields.io/endpoint.svg?url=https://gh.mergify.io/badges/p6m7g8/p6df-core/&style=flat)](https://mergify.io)
[![codecov](https://codecov.io/gh/p6m7g8/p6df-core/branch/master/graph/badge.svg?token=14Yj1fZbew)](https://codecov.io/gh/p6m7g8/p6df-core)
[![Known Vulnerabilities](https://snyk.io/test/github/p6m7g8/p6df-core/badge.svg?targetFile=package.json)](https://snyk.io/test/github/p6m7g8/p6df-core?targetFile=package.json)

## Summary

## Contributing

- [How to Contribute](CONTRIBUTING.md)

## Code of Conduct

- [Code of Conduct](CODE_OF_CONDUCT.md)

## Changes

- [Change Log](CHANGELOG.md)

### Usage

#### aliases.zsh:

- p6df::core::aliases::init()

#### dev.zsh:

- p6df::core::dev::graph()
- p6df::core::dev::graph::dot(module, module, dep)

#### main.zsh:

- p6df::core::main::init()

#### mgmt.zsh:

- p6df::core::mgmt::modules::diff()
- p6df::core::mgmt::modules::pull()
- p6df::core::mgmt::modules::send()
- p6df::core::mgmt::modules::status()
- p6df::core::mgmt::modules::sync()
- p6df::core::mgmt::modules::update()
- p6df::core::mgmt::update()

#### module.zsh:

- p6df::core::module::diff(module, dep, org, repo, ..., prefix)
- p6df::core::module::fetch(module, dep, org, repo, ..., prefix)
- p6df::core::module::init::start(module)
- p6df::core::module::parse(module)
- p6df::core::module::pull(module, dep, org, repo, ..., prefix)
- p6df::core::module::push(module, dep, org, repo, ..., prefix)
- p6df::core::module::source(relpath, relaux)
- p6df::core::module::status(module, dep, org, repo, ..., prefix)
- p6df::core::module::sync(module, dep, org, repo, ..., prefix)
- p6df::core::module::version(module)

#### modules.zsh:

- p6df::core::modules::collect()
- p6df::core::modules::diff()
- p6df::core::modules::fetch()
- p6df::core::modules::foreach(callback, ...)
- p6df::core::modules::init()
- p6df::core::modules::init::start()
- p6df::core::modules::pull()
- p6df::core::modules::push()
- p6df::core::modules::recurse::_bootstrap(module, callback)
- p6df::core::modules::recurse::callback(module, ..., callback)
- p6df::core::modules::recurse::callback::dep(module, ..., callback)
- p6df::core::modules::recurse::internal(module, callback)
- p6df::core::modules::status()
- p6df::core::modules::sync()

#### path.zsh:

- p6df::core::path::cd::init()
- p6df::core::path::init()

#### prompt.zsh:

- p6df::core::prompt::init()
- p6df::core::prompt::process()
- p6df::prompt::runtime(...)

#### theme.zsh:

- p6df::core::theme::init()

#### user.zsh:

- p6df::core::user::init()

#### util.zsh:

- p6df::util::cdpath::if(dir)
- p6df::util::exists(thing)
- p6df::util::file::load(file)
- p6df::util::path::if(dir)
- p6df::util::path_if()
- p6df::util::run::code(thing, ...)
- p6df::util::run::if(thing, ...)
- p6df::util::user::init()


## Author

Philip M . Gollucci <pgollucci@p6m7g8.com>
