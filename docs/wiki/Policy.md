# Policy Model

## File
- governance.config.json (preferred)

## Required Keys
- version
- policyGeneratedBy
- bootstrap
- versionControl
- testing
- documentation
- language
- autonomy
- phases
- ciCdEnforced
- remoteRequired

## Key Options
### versionControl
- git-local
- git-remote
- git-remote-ci

### testing
- full
- baseline

### documentation
- inline
- comments-only
- generate

### autonomy
- feature
- milestone
- fully-autonomous

## Effect
Once policy exists, it overrides specification defaults.
