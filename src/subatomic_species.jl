

# AtomicAndPhysicalConstants.jl/ParticleSpecies.jl


# -----------------------------------------------------------------------------------------------
#=
Below we have two dictionaries: Subatomic_Particles and Atomic_Particles:
these contatin key=>value pairs of (respectively) subatomic-name => SubatomicSpecies
and atomic-name => AtomicSpecies
=#




"""
    subatomic_particles 
a dictionary of all the available subatomic species; 
the key is the particle's species_name, 
and the value is the relevant SubatomicSpecies struct, _eg_ 

Subatomic_Particles["some-particle"] = SubatomicSpecies("some-particle", ...)
""" subatomic_particles

subatomic_particles = Dict{String, SubatomicSpecies}(
  "pion0"             => SubatomicSpecies("pion0", 0, __b_m_pion_0, 0.0, 0.0),
  # const ref_species       = SubatomicSpecies("Ref_Particle", "Garbage!", 0, 0.0, 0.0, NaN)
  "neutron"           => SubatomicSpecies("neutron", 0, __b_m_neutron, 0, 0.5*__b_h_bar_planck),
  "deuteron"          => SubatomicSpecies("deuteron", 1, __b_m_deuteron, 0, 1.0*__b_h_bar_planck),
  "pion+"             => SubatomicSpecies("pion+", 1, __b_m_pion_charged, 0.0, 0.0),
  "anti_muon"          => SubatomicSpecies("anti-muon", 1, __b_m_muon, 0, 0.5*__b_h_bar_planck),
  "proton"            => SubatomicSpecies("proton", 1, __b_m_proton, 0, 0.5*__b_h_bar_planck),
  "positron"          => SubatomicSpecies("positron", 1, __b_m_electron, 0, 0.5*__b_h_bar_planck),
  "photon"            => SubatomicSpecies("photon", 0, 0.0, 0.0, 0.0),
  "electron"          => SubatomicSpecies("electron", -1, __b_m_electron, 0, 0.5*__b_h_bar_planck),
  "anti_proton"        => SubatomicSpecies("anti-proton", -1, __b_m_proton, 0, 0.5*__b_h_bar_planck),
  "muon"              => SubatomicSpecies("muon", -1, __b_m_muon, 0, 0.5*__b_h_bar_planck),
  "pion-"             => SubatomicSpecies("pion-", -1, __b_m_pion_charged, 0.0, 0.0),
  "anti_deuteron"     => SubatomicSpecies("anti-deuteron", -1, __b_m_deuteron, 0, 1.0*__b_h_bar_planck),
  "anti_neutron"      => SubatomicSpecies("anti-neutron", 0, __b_m_neutron, 0, 0.5*__b_h_bar_planck)
  # const anti_ref_species  = SubatomicSpecies("Anti_Ref_Particle", "Garbage!", 0, 0.0, 0.0, NaN)
); export Subatomic_Particles




