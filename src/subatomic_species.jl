
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


# -----------------------------------------------------------------------------------------------
#=
Below we have a dictionary, SUBATOMIC_SPECIES :
this contatins key=>value pairs of  subatomic-name => SubatomicSpecies
=#



"""
    SUBATOMIC_SPECIES 
a dictionary of all the available subatomic species; 
the key is the particle's species_name, 
and the value is the relevant SubatomicSpecies struct, _eg_ 

Subatomic_Particles["some-particle"] = SubatomicSpecies("some-particle", ...)
"""

const SUBATOMIC_SPECIES = Dict{String,SubatomicSpecies}(
  "pion0" => SubatomicSpecies("pion0", 0, __b_m_pion_0.val, 0.0, 0.0),
  "neutron" => SubatomicSpecies("neutron", 0, __b_m_neutron.val, __b_mu_neutron.val, 0.5 * __b_h_bar_planck.val),
  "deuteron" => SubatomicSpecies("deuteron", 1, __b_m_deuteron.val, __b_mu_deuteron.val, 1.0 * __b_h_bar_planck.val),
  "pion+" => SubatomicSpecies("pion+", 1, __b_m_pion_charged.val, 0.0, 0.0),
  "anti_muon" => SubatomicSpecies("anti-muon", 1, __b_m_muon.val, __b_mu_muon.val, 0.5 * __b_h_bar_planck.val),
  "proton" => SubatomicSpecies("proton", 1, __b_m_proton.val, __b_mu_proton.val, 0.5 * __b_h_bar_planck.val),
  "positron" => SubatomicSpecies("positron", 1, __b_m_electron.val, __b_mu_electron.val, 0.5 * __b_h_bar_planck.val),
  "photon" => SubatomicSpecies("photon", 0, 0.0, 0.0, 0.0),
  "electron" => SubatomicSpecies("electron", -1, __b_m_electron.val, __b_mu_electron.val, 0.5 * __b_h_bar_planck.val),
  "anti_proton" => SubatomicSpecies("anti-proton", -1, __b_m_proton.val, __b_mu_proton.val, 0.5 * __b_h_bar_planck.val),
  "muon" => SubatomicSpecies("muon", -1, __b_m_muon.val, __b_mu_muon.val, 0.5 * __b_h_bar_planck.val),
  "pion-" => SubatomicSpecies("pion-", -1, __b_m_pion_charged.val, 0.0, 0.0),
  "anti_deuteron" => SubatomicSpecies("anti-deuteron", -1, __b_m_deuteron.val, __b_mu_deuteron.val, 1.0 * __b_h_bar_planck.val),
  "anti_neutron" => SubatomicSpecies("anti-neutron", 0, __b_m_neutron.val, __b_mu_neutron.val, 0.5 * __b_h_bar_planck.val)
)




