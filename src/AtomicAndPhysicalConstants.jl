module AtomicAndPhysicalConstants

using PyFormattedStrings
using Dates
using HTTP
using JSON
using Reexport
@reexport using Unitful

include("units_definition.jl")
include("constants.jl")
include("types.jl")
include("constructors.jl")
include("isotopes.jl")
include("subatomic_species.jl")
include("update_pion_mass.jl")
include("update_constants.jl")
include("update_isos.jl")
include("particle_functions.jl")
include("set_units.jl")

export @setunits
export ACCELERATOR, MKS, CGS
export massof, chargeof
export c_light, h_planck, h_bar_planck, r_e, r_p, e_charge, mu_0_vac, eps_0_vac, classical_radius_factor, fine_structure, N_avogadro
export C_LIGHT, H_PLANCK, H_BAR_PLANCK, R_E, R_P, E_CHARGE
export SubatomicSpecies
export AtomicSpecies
export SUBATOMIC_SPECIES
export ATOMIC_SPECIES
export setCODATA
export @u_str, NewUnits

#export anom_mag_moment_electron, anom_mag_moment_muon, anom_mag_moment_proton, anom_mag_moment_deuteron, anom_mag_moment_neutron, anom_mag_moment_He3

end