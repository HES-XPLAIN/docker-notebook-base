# Release

Instructions for the release process and publication on ghcr.io.

## Tag the commit

Tag the commit and push the tag.

```
git tag vX -m "vX"
git push origin main --tags
```

## Create new release

In *Releases*, select *Draft a new release* in the GitHub interface.

* In *Choose a tag*, enter a new tag in the form `vX`
* Add notes to describe the changes
* Select *Publish release*

Alternatively, use the GitHub CLI interactively:
```
gh release create
```

## Set visibility to public

In *Package* > *Package settings* > *Danger Zone*, ensure the package visibility
is set to **Public**.

## Done!

Wait a few minutes for the image to be automatically built and published on ghcr.io.
