# Release

Instructions for the release process and publication on ghcr.io.

## Create new release

Select *Create a new release* in the GitHub interface.

* In *Choose a tag*, enter a new tag in the form `X.Y.Z`
* Add notes to describe the changes
* Select *Publish release*

Alternatively, use the GitHub CLI interactively:
```
gh release create
```

## Done!

Wait a few minutes for the image to be automatically built and published on ghcr.io.
