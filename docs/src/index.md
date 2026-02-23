# VOFI / Vofinit.jl

The VOFI library initializes the volume-fraction scalar field in a
computational mesh, given an analytic expression `f(x,y,z)` for the
interface. The grid cells can be cuboids of variable size. The implicit
function `f(x,y,z)` is specified by the user: the interface is represented by
the zero level set, `f(x,y,z) == 0`, and the reference phase is located where
`f(x,y,z) < 0`.

This repository provides a thin Julia wrapper (`Vofinit.jl`) around the
`libvofi` routines. Each routine in `src/` contains a short description of
what it does and the expected I/O variables.

Quick start

```julia
using Vofinit

f(x,y,z) = x^2 + y^2 + z^2 - 1.0
x0 = [0.0,0.0,0.0]
h0 = [1.0,1.0,1.0]

ct = getcelltype(f, x0, h0)
val = getcc(f, x0, h0, [0.5,0.5,0.5])

println(ct, " ", val)
```

See the **Reference** page for API details.
