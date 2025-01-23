
# Troubleshooting

## Install

can't install. add `"neverBuiltDependencies": ["@discordjs/opus"]` to package.json

```json
  "pnpm": {
    "overrides": {
      "onnxruntime-node": "1.20.0"
    },
    "neverBuiltDependencies": ["@discordjs/opus"]
  },
```

and `pnpm add opusscript`.

## Start

First `pnpm start` requires downloading `fast-bge-small-en-v1.5` for embedding