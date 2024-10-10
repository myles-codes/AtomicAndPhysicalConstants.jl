module AtomicAndPhysicalConstants

using PyFormattedStrings
using Dates
using HTTP
using JSON
using Reexport
@reexport using Unitful

include("physical_constants.jl")
include("atomic_isotopes.jl")
include("subatomic_species.jl")
include("species_initialize.jl")
include("update_pion_mass.jl")
include("update_constants.jl")
include("update_iso_masses.jl")
include("particle_functions.jl")
include("set_units.jl")

export setunits, printunits
export PARTICLE_PHYSICS, MKS, CGS
export mass, charge
export c_light, m_electron, m_proton, m_neutron, m_muon, m_helion, m_deuteron, m_pion_0, m_pion_charged
export r_e, e_charge, h_planck, mu_0_vac, eps_0_vac
export kg_per_amu, eV_per_amu, N_avogadro, fine_structure, classical_radius_factor, r_p, h_bar_planck, kg_per_eV, eps_0_vac
export mu_deuteron, mu_electron, mu_helion, mu_muon, mu_neutron, mu_proton, mu_triton
export SubatomicSpecies
export AtomicSpecies
export SUBATOMIC_SPECIES
export Atomic_Particles
export setCODATA
export @u_str, NewUnits

#export anom_mag_moment_electron, anom_mag_moment_muon, anom_mag_moment_proton, anom_mag_moment_deuteron, anom_mag_moment_neutron, anom_mag_moment_He3

end