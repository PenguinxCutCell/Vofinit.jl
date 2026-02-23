module Vofinit

using libvofi_jll

export getcelltype, getcc

const cintegrand = Ref{Ptr{Cvoid}}(0)

function integrand(xyz, thunk)
    func = unsafe_pointer_to_objref(thunk)
    x = unsafe_load(xyz, 1)
    y = unsafe_load(xyz, 2)
    z = unsafe_load(xyz, 3)
    func(x, y, z)
end

"""
    getcelltype(func, x0, h0, ndim0 = Cint(3))

Determine the cell type based on the level set function.
# Arguments
- `func`: A function that takes three arguments (x, y, z) and returns a `Float64` value. This function represents the level set function of the interface.
- `x0`: A tuple of three `Float64` values representing the coordinates of the minimum vertex of the cell.
- `h0`: A tuple of three `Float64` values representing the cell size in each dimension.
- `ndim0`: A `Cint` value representing the number of dimensions (default is 3).
# Returns
- A `Cint` value representing the cell type, where 1 indicates a full cell, -1 indicates a cut cell, and 0 indicates an empty cell.
"""
function getcelltype(func, x0, h0, ndim0 = Cint(3))
    @ccall libvofi.vofi_get_cell_type(cintegrand[]::Ptr{Cvoid},
                                      func::Any,
                                      x0::Ref{Cdouble},
                                      h0::Ref{Cdouble},
                                      ndim0::Cint)::Cint
end

"""
    getcc(func, x0, h0, xex, ndim0 = Cint(3); nex = Cint.((0, 0)), npt = Cint.((4, 4, 4, 4)), nvis = Cint.((0, 0)))

Calculate the volume fraction of the cell using the VOFI algorithm.
# Arguments
- `func`: A function that takes three arguments (x, y, z) and returns a `Float64` value. This function represents the level set function of the interface.
- `x0`: A tuple of three `Float64` values representing the coordinates of the minimum vertex of the cell.
- `h0`: A tuple of three `Float64` values representing the cell size in each dimension.
- `xex`: A tuple of three `Float64` values representing a flag to compute the centroid and interface length/area.
- `ndim0`: A `Cint` value representing the number of dimensions (default is 3).
- `npt`: A tuple of four `Cint` values representing the number of points for the quadrature in each dimension.
- `nvis`: A tuple of two `Cint` values representing a flag for visualization output.
# Returns
- A `Float64` value representing the volume fraction of the cell.
"""
function getcc(func, x0, h0, xex, ndim0 = Cint(3);
               nex = Cint.((0, 0)),
               npt = Cint.((4, 4, 4, 4)),
               nvis = Cint.((0, 0)))
    @ccall libvofi.vofi_get_cc(cintegrand[]::Ptr{Cvoid},
                               func::Any,
                               x0::Ref{Cdouble},
                               h0::Ref{Cdouble},
                               xex::Ref{Cdouble},
                               nex::Ref{Cint},
                               npt::Ref{Cint},
                               nvis::Ref{Cint},
                               ndim0::Cint)::Cdouble
end

function __init__()
    cintegrand[] = @cfunction(integrand, Cdouble, (Ptr{Cdouble}, Ptr{Cvoid}))
end

end