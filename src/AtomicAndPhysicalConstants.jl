module AtomicAndPhysicalConstants

export PreRelease
export CODATA2002, CODATA2006, CODATA2010, CODATA2014, CODATA2018, CODATA2022

using EnumX

include("units_definition.jl")
include("prerelease.jl")
include("types.jl")
include("2002_constants.jl")
include("2006_constants.jl")
include("2010_constants.jl")
include("2014_constants.jl")
include("2018_constants.jl")
include("2022_constants.jl")
include("docstrings.jl")

using Reexport
@reexport using .PreRelease
@reexport using .CODATA2022




end