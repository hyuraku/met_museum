# Changelog

All notable changes to this project are documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [1.5.0] - 2026-06-24

### Added
- `MetMuseum::Collection.new` now accepts `open_timeout:` and `read_timeout:`
  keyword arguments (defaults: `5` / `15` seconds) to configure HTTP timeouts.

### Changed
- `search(limit:)` reuses the same client instance instead of allocating a new
  `MetMuseum::Collection` per object id.
- Supported Ruby versions are now 3.3, 3.4 and 3.5; `required_ruby_version` is
  `>= 3.3`.

### Removed
- Unused private `multi_option` method.

### Development
- The spec suite is now deterministic: HTTP interactions are recorded with VCR
  and replayed offline, so CI no longer depends on the live Met API.

## [1.4.2]
- Last release before this changelog was introduced.
