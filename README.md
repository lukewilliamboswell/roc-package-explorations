# Roc Package Explorations

A temporary home for some Roc packages. See [github.com/roc-lang/roc](https://github.com/roc-lang/roc) for more information on Roc.

Try running some of the examples with Roc; for example `roc run examples/hello-json.roc`.

```sh
% roc run examples/hello-json.roc
Successfully decoded image, title:"View from 15th Floor"
```

## Package URL Release

You can use the package as a URL release in your Roc project. For example, in your `main.roc` file you can reference the json package like so.

```roc
app "example"
    packages {
        cli: "https://github.com/roc-lang/basic-cli/releases/download/0.3.2/tE4xS_zLdmmxmHwHih9kHWQ7fsXtJr7W7h3425-eZFk.tar.br",
        json: "https://github.com/lukewilliamboswell/roc-package-explorations/releases/download/0.0.2/OGvGqF_v0DGBbWSJJR7afW89O6PzyRiBwJz6oEquu30.tar.br",
    }
    imports [
        cli.Stdout,
        json.Core.{ jsonWithOptions },
        Decode.{ DecodeResult, fromBytesPartial },
    ]
    provides [main] to cli
```

