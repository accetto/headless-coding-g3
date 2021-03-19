# Readme `TypeScript`

This Docker image **does not** come with any pre-installed `TypeScript` version by intention. That allows you to choose the version and the way of installation that suite you best.

Everything else you need is already included.

You can install `TypeScript` globally by:

```shell
npm install -g typescript
```

You can also install `TypeScript` locally for a particular project by:

```shell
npm install --save-dev typescript
```

You can check the current `TypeScript` version by:

```shell
tsc --version

### or also
tsc -v
```

You can start by following the [TypeScript Documentation](https://www.typescriptlang.org/docs/).
