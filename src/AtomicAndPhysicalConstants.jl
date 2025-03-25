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
export setIsos


using PyFormattedStrings
using Dates
using HTTP
using JSON
using EnumX
using Reexport
@reexport using Unitful
import DynamicQuantities


include("units_definition.jl")
include("constants.jl")
include("types.jl")
include("constructors.jl")
include("isotopes.jl")
include("subatomic_species.jl")
include("functions.jl")
include("APCdef.jl")
include("showconst.jl")

end