module AtomicAndPhysicalConstants


export @APCdef
export ACCELERATOR, MKS, CGS
export Species
export SubatomicSpecies
export AtomicSpecies
export SUBATOMIC_SPECIES
export ATOMIC_SPECIES
export useCODATA
export NewUnits
export showconst
export full_name, atomicnumber, g_spin, gyromagnetic_anomaly, g_nucleon
export Kind
export ATOM, HADRON, LEPTON, PHOTON, NULL
export setisos
export CODATA_releases
export CODATA2002, CODATA2006, CODATA2010, CODATA2014, CODATA2018, CODATA2022


using PyFormattedStrings
using Dates
using HTTP
using JSON
using EnumX
using Reexport
using AtomicAndPhysicalConstants.NewUnits
@reexport using Unitful
import DynamicQuantities


include("units_definition.jl")
include("prerelease.jl")
include("2002_constants.jl")
include("2006_constants.jl")
include("2010_constants.jl")
include("2014_constants.jl")
include("2018_constants.jl")
include("2022_constants.jl")

using Reexport
@reexport using .CODATA2022



end