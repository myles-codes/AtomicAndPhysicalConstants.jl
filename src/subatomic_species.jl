

# AtomicAndPhysicalConstants.jl/subatomic_species.jl



"""
SubtomicSpecies 

### Description:
> mutable struct to store all (possibly degenerate) information about a subatomic particle<

### Fields:
- `species_name`      -- String common name for (anti) baryon
- `charge`            -- electric charge on the given particle in units of [e+]
- `mass`              -- mass of the given particle in [eV/c^2]
- `mu`  							-- magnetic moment of particle
- `spin`              -- spin of the particle

### Notes:
some parameters in this struct are likely named constants from PhysicalConstants.jl

### Examples:
- `SubatomicSpecies("neutron", 0, m_neutron, anom_mag_moment_neutron, 0.5)`
- `SubatomicSpecies("pion-", -1, m_pion_charged, 0.0, 0.0)`
"""
SubatomicSpecies

struct SubatomicSpecies
  species_name::String              # common species_name of the particle
  charge::Int                     # charge on the particle in units of e+
  mass::Float64                     # mass of the particle in [eV/c^2]
  mu::Float64         # anomalous magnetic moment 
  spin::Float64                     # spin magnetic moment in [ħ]
end;
export SubatomicSpecies

# -----------------------------------------------------------------------------------------------
#=
Below we have a dictionary, subatomic_particles :
this contatins key=>value pairs of  subatomic-name => SubatomicSpecies
=#




"""
    subatomic_particles 
a dictionary of all the available subatomic species; 
the key is the particle's species_name, 
and the value is the relevant SubatomicSpecies struct, _eg_ 

Subatomic_Particles["some-particle"] = SubatomicSpecies("some-particle", ...)
"""
subatomic_particles

subatomic_particles = Dict{String,SubatomicSpecies}(
  "pion0" => SubatomicSpecies("pion0", 0, __b_m_pion_0, 0.0, 0.0),
  "neutron" => SubatomicSpecies("neutron", 0, __b_m_neutron, __b_mu_neutron, 0.5 * __b_h_bar_planck),
  "deuteron" => SubatomicSpecies("deuteron", 1, __b_m_deuteron, __b_mu_deuteron, 1.0 * __b_h_bar_planck),
  "pion+" => SubatomicSpecies("pion+", 1, __b_m_pion_charged, 0.0, 0.0),
  "anti_muon" => SubatomicSpecies("anti-muon", 1, __b_m_muon, __b_mu_muon, 0.5 * __b_h_bar_planck),
  "proton" => SubatomicSpecies("proton", 1, __b_m_proton, __b_mu_proton, 0.5 * __b_h_bar_planck),
  "positron" => SubatomicSpecies("positron", 1, __b_m_electron, __b_mu_electron, 0.5 * __b_h_bar_planck),
  "photon" => SubatomicSpecies("photon", 0, 0.0, 0.0, 0.0),
  "electron" => SubatomicSpecies("electron", -1, __b_m_electron, __b_mu_electron, 0.5 * __b_h_bar_planck),
  "anti_proton" => SubatomicSpecies("anti-proton", -1, __b_m_proton, __b_mu_proton, 0.5 * __b_h_bar_planck),
  "muon" => SubatomicSpecies("muon", -1, __b_m_muon, __b_mu_muon, 0.5 * __b_h_bar_planck),
  "pion-" => SubatomicSpecies("pion-", -1, __b_m_pion_charged, 0.0, 0.0),
  "anti_deuteron" => SubatomicSpecies("anti-deuteron", -1, __b_m_deuteron, __b_mu_deuteron, 1.0 * __b_h_bar_planck),
  "anti_neutron" => SubatomicSpecies("anti-neutron", 0, __b_m_neutron, __b_mu_neutron, 0.5 * __b_h_bar_planck)
);
export subatomic_particles




