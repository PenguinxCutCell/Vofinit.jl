# Vofinit.jl

[![In development documentation](https://img.shields.io/badge/docs-dev-blue.svg)](https://penguinxcutcell.github.io/Vofinit.jl/dev)
![CI](https://github.com/PenguinxCutCell/Vofinit.jl/actions/workflows/ci.yml/badge.svg)
![Coverage](https://codecov.io/gh/PenguinxCutCell/Vofinit.jl/branch/main/graph/badge.svg)

A small Julia wrapper around the libvofi library providing utilities to
compute cell types and volume fractions by calling the libvofi C API.

## Requirements

- Julia 1.x
- libvofi_jll (declared in Project.toml)

## Quick start

Clone the repository and install dependencies:
```bash
git clone git@github.com:PenguinxCutCell/Vofinit.jl.git
cd Vofinit.jl
julia --project=. -e 'using Pkg; Pkg.instantiate(); Pkg.build()'
```

## Run tests:
```bash
julia --project=. -e 'using Pkg; Pkg.test()'
```

## Usage example (in the REPL or a script):
```julia
using Vofinit

# box center and half-sizes as Cdouble tuples/arrays
x0 = Cdouble.((0,0,0))
h0 = Cdouble.((1,1,1))

# call with a do-block integrand
ctype = getcelltype(x0, h0) do x...
    sum(x .* x) - 0.25
end

# compute cell-centered volume fraction (example)
xex = Cdouble[0,0,0,0]
cc = getcc(x0, h0, xex) do x...
    sum(x .* x) - 0.25
end
```

## Contributing
- Create a branch, add tests for changes, run Pkg.test(), open a PR.


## License
- See repository for license information.