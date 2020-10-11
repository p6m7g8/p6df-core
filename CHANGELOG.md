# Changelog

All notable changes to this project will be documented in this file. See [standard-version](https://github.com/conventional-changelog/standard-version) for commit guidelines.

## [2.0.0](https://github.com/p6m7g8/p6df-core/compare/v1.0.4...v2.0.0) (2020-10-11)


### Features

* **api:** v2.0.0-alpha ([#25](https://github.com/p6m7g8/p6df-core/issues/25)) ([6e47ec2](https://github.com/p6m7g8/p6df-core/commit/6e47ec2072f04c6b7e2b8b8e7fc1f5d1b9cd06cf))


### Bug Fixes

* **api:** drop unused function p6df::module::recurse2 ([#24](https://github.com/p6m7g8/p6df-core/issues/24)) ([da62b00](https://github.com/p6m7g8/p6df-core/commit/da62b00d1fb522ba73b232aa4d7fa3957b456198))
* **doc:** the function headers had markers inverted confusing the doc gen ([#22](https://github.com/p6m7g8/p6df-core/issues/22)) ([b30ed59](https://github.com/p6m7g8/p6df-core/commit/b30ed59728bd36f88c9e5ce9d05cc5f76a5c3e64))

### [1.0.4](https://github.com/p6m7g8/p6df-core/compare/v1.0.3...v1.0.4) (2020-09-27)


### Bug Fixes

* **module:** robbyrussell -> ohmyzsh ([#21](https://github.com/p6m7g8/p6df-core/issues/21)) ([410f9c4](https://github.com/p6m7g8/p6df-core/commit/410f9c4e2d486cca4b23f6d3939edc524652e72c))

### [1.0.3](https://github.com/p6m7g8/p6df-core/compare/v1.0.2...v1.0.3) (2020-09-20)


### Features

* **env:** adds ZSH_CACHE_DIR ([#16](https://github.com/p6m7g8/p6df-core/issues/16)) ([ca0b972](https://github.com/p6m7g8/p6df-core/commit/ca0b9725ec80e46462cf9255e1cd18a6001415db))
* **prompt:** + helm ([#20](https://github.com/p6m7g8/p6df-core/issues/20)) ([9027621](https://github.com/p6m7g8/p6df-core/commit/902762123ce8fc954a4f00594bb6bf4756362056))
* **prompt:** adds kubernetes, sorts clouds ([#15](https://github.com/p6m7g8/p6df-core/issues/15)) ([f13adbb](https://github.com/p6m7g8/p6df-core/commit/f13adbb9667980fe4102a1fe9837a427017e8476))


### Bug Fixes

* **prompt:** cloud verticle spacing works now ([#19](https://github.com/p6m7g8/p6df-core/issues/19)) ([47e899a](https://github.com/p6m7g8/p6df-core/commit/47e899ac4c4af4306f64b59313dff416c1b812f8))
* **prompt:** remove duplicate node ([#18](https://github.com/p6m7g8/p6df-core/issues/18)) ([9a7ef2e](https://github.com/p6m7g8/p6df-core/commit/9a7ef2e304e0eb382b2aeb841041634c218d888f))
* **zsh:** make cache dir for later use by plugins ([#17](https://github.com/p6m7g8/p6df-core/issues/17)) ([583d243](https://github.com/p6m7g8/p6df-core/commit/583d2434a17614f5cbcf7da23bd91e992bec39df))

### [1.0.2](https://github.com/p6m7g8/p6df-core/compare/v1.0.1...v1.0.2) (2020-07-07)


### Features

* **cicd:** setups semantic-version ([#7](https://github.com/p6m7g8/p6df-core/issues/7)) ([d621797](https://github.com/p6m7g8/p6df-core/commit/d621797a1b660cf1b4c94e040843c80a7141df82))
* **mgmt:** uses p6_git_p6_* functions, improves iterator() ([#8](https://github.com/p6m7g8/p6df-core/issues/8)) ([91ae53e](https://github.com/p6m7g8/p6df-core/commit/91ae53e8014b944db18a05eeb8fe092b55167f8b))
* **modules:** sets up *pull() and adds status() ([#14](https://github.com/p6m7g8/p6df-core/issues/14)) ([5331f1f](https://github.com/p6m7g8/p6df-core/commit/5331f1f90473af349756e14592d95a0d87335e89))


### Bug Fixes

* **api:** iterator() makes unique work ([#10](https://github.com/p6m7g8/p6df-core/issues/10)) ([c245761](https://github.com/p6m7g8/p6df-core/commit/c245761ed6e15a64b14ae3c8443631d314bdcffa))
* **load:** fixes the other case ([#12](https://github.com/p6m7g8/p6df-core/issues/12)) ([8b267d3](https://github.com/p6m7g8/p6df-core/commit/8b267d301b9ea6f5f6ebef2863eac73ec4a65d48))


* **aliases:** standardize names and expose them all ([#11](https://github.com/p6m7g8/p6df-core/issues/11)) ([aebcf12](https://github.com/p6m7g8/p6df-core/commit/aebcf1294d0227fb4e3b25199de79facbc2256ad))
* **doc:** regens ([#13](https://github.com/p6m7g8/p6df-core/issues/13)) ([e265044](https://github.com/p6m7g8/p6df-core/commit/e265044fd187ed851608cddc2af0bc6b4ec8a006))
* **docs:** regen ([#4](https://github.com/p6m7g8/p6df-core/issues/4)) ([ea97ae6](https://github.com/p6m7g8/p6df-core/commit/ea97ae6f11d4fc62180ff21ea6212c0ec95fa31c))
* **prompt:** standardize on _prompt_info ([#1](https://github.com/p6m7g8/p6df-core/issues/1)) ([8246864](https://github.com/p6m7g8/p6df-core/commit/82468649cf30a413fd9d5aef4203e11ca786ca9a))
* **release:** 1.0.2 ([f382736](https://github.com/p6m7g8/p6df-core/commit/f3827366b5ac9880adc018ea7ad9f52079fb09cb))

### [1.0.2](https://github.com/p6m7g8/p6df-core/compare/v1.0.1...v1.0.2) (2020-07-07)


### Features

* **cicd:** setups semantic-version ([#7](https://github.com/p6m7g8/p6df-core/issues/7)) ([d621797](https://github.com/p6m7g8/p6df-core/commit/d621797a1b660cf1b4c94e040843c80a7141df82))
* **mgmt:** uses p6_git_p6_* functions, improves iterator() ([#8](https://github.com/p6m7g8/p6df-core/issues/8)) ([91ae53e](https://github.com/p6m7g8/p6df-core/commit/91ae53e8014b944db18a05eeb8fe092b55167f8b))
* **modules:** sets up *pull() and adds status() ([#14](https://github.com/p6m7g8/p6df-core/issues/14)) ([5331f1f](https://github.com/p6m7g8/p6df-core/commit/5331f1f90473af349756e14592d95a0d87335e89))


### Bug Fixes

* **api:** iterator() makes unique work ([#10](https://github.com/p6m7g8/p6df-core/issues/10)) ([c245761](https://github.com/p6m7g8/p6df-core/commit/c245761ed6e15a64b14ae3c8443631d314bdcffa))
* **load:** fixes the other case ([#12](https://github.com/p6m7g8/p6df-core/issues/12)) ([8b267d3](https://github.com/p6m7g8/p6df-core/commit/8b267d301b9ea6f5f6ebef2863eac73ec4a65d48))


* **aliases:** standardize names and expose them all ([#11](https://github.com/p6m7g8/p6df-core/issues/11)) ([aebcf12](https://github.com/p6m7g8/p6df-core/commit/aebcf1294d0227fb4e3b25199de79facbc2256ad))
* **doc:** regens ([#13](https://github.com/p6m7g8/p6df-core/issues/13)) ([e265044](https://github.com/p6m7g8/p6df-core/commit/e265044fd187ed851608cddc2af0bc6b4ec8a006))
* **docs:** regen ([#4](https://github.com/p6m7g8/p6df-core/issues/4)) ([ea97ae6](https://github.com/p6m7g8/p6df-core/commit/ea97ae6f11d4fc62180ff21ea6212c0ec95fa31c))
* **prompt:** standardize on _prompt_info ([#1](https://github.com/p6m7g8/p6df-core/issues/1)) ([8246864](https://github.com/p6m7g8/p6df-core/commit/82468649cf30a413fd9d5aef4203e11ca786ca9a))
