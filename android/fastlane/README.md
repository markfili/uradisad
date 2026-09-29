fastlane documentation
----

# Installation

Make sure you have the latest version of the Xcode command line tools installed:

```sh
xcode-select --install
```

For _fastlane_ installation instructions, see [Installing _fastlane_](https://docs.fastlane.tools/#installing-fastlane)

# Available Actions

## Android

### android check_access

```sh
[bundle exec] fastlane android check_access
```

Check that the service-account key can reach this app on Google Play

### android fetch_metadata

```sh
[bundle exec] fastlane android fetch_metadata
```

Download the current store listing into fastlane/metadata (run once, then edit and commit)

### android build

```sh
[bundle exec] fastlane android build
```

Build a signed release AAB with the FVM-pinned Flutter

### android internal

```sh
[bundle exec] fastlane android internal
```

Build and upload to the internal testing track

### android production

```sh
[bundle exec] fastlane android production
```

Build and submit to production. Options: rollout:0.2 for a staged rollout, draft:true to only create a draft

### android promote

```sh
[bundle exec] fastlane android promote
```

Promote the latest internal release to production without rebuilding

### android metadata

```sh
[bundle exec] fastlane android metadata
```

Upload the store listing text, images and screenshots from fastlane/metadata

----

This README.md is auto-generated and will be re-generated every time [_fastlane_](https://fastlane.tools) is run.

More information about _fastlane_ can be found on [fastlane.tools](https://fastlane.tools).

The documentation of _fastlane_ can be found on [docs.fastlane.tools](https://docs.fastlane.tools).
