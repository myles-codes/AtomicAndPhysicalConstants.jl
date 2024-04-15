# AtomicAndPhysicalConstants/src/PhysicalConstants.jl

include("PhysicalConstants.jl")


# Global non-constants: type must be specified
# these are the dimensionful quantities which will change with change of units 

m_electron::Float64                  = __b_m_electron      # Electron Mass 
m_proton::Float64                    = __b_m_proton      # Proton Mass 
m_neutron::Float64                   = __b_m_neutron      # Neutron Mass 
m_muon::Float64                      = __b_m_muon      # Muon Mass 
m_helion::Float64                    = __b_m_helion      # Helion Mass He3 nucleus 
m_deuteron::Float64                  = __b_m_deuteron      # Deuteron Mass 
c_light::Float64                     = __b_c_light      # speed of light 
h_planck::Float64                    = __b_h_planck      # Planck's constant 
r_e::Float64                         = __b_r_e     # classical electron radius 
mu_0_vac::Float64                    = __b_mu_0_vac      # Vacuum permeability  
eps_0_vac::Float64                   = __b_eps_0_vac      # Permittivity of free space 

e_charge::Float64                    = __b_e_charge      # elementary charge 

anom_mag_moment_electron::Float64    = __b_anom_mag_moment_electron      # anomalous mag. mom. of the electron 
anom_mag_moment_muon::Float64        = __b_anom_mag_moment_muon      # 
anom_mag_moment_proton::Float64      = __b_anom_mag_moment_proton      # μ_p/μ_N - 1
anom_mag_moment_deuteron::Float64    = __b_anom_mag_moment_deuteron      # μ_{deuteron}/μ_N - 1
anom_mag_moment_neutron::Float64     = __b_anom_mag_moment_neutron      # μ_{neutron}/μ_N - 1
anom_mag_moment_He3::Float64         = __b_anom_mag_moment_He3      # μ_{He3}/μ_N - 2


# these are global constants: they're unitless and thus the values won't change.
kg_per_amu::Float64                  = __b_kg_per_amu             # kg per standard atomic mass unit (dalton)
eV_per_amu::Float64                  = __b_eV_per_amu                  # eV per standard atomic mass unit (dalton)
N_avogadro::Float64                  = __b_N_avogadro                  # Number / mole  (exact)
fine_structure::Float64              = __b_fine_structure                 # fine structure constant


# values calculated from other constants in this collection



classical_radius_factor = __b_classical_radius_factor                 # e^2 / (4 pi eps_0) [m*eV]
                                                #  = classical_radius * mass * c^2. 
                                                # Is same for all particles of charge +/- 1.
r_p                     = __b_r_p      # proton radius [m] 
h_bar_planck            = __b_h_bar_planck                   # h_planck/twopi [eV*sec]
kg_per_eV               = kg_per_amu / eV_per_amu



# constants mysteriously missing from the CODATA release

m_pion_0::Float64                = __b_m_pion_0                     # Mass [eV]/c^2
m_pion_charged::Float64          = __b_m_pion_charged                      # Mass [eV]/c^2

 #---------------------------------------------------------------------------------------------------

export m_electron, m_proton, m_neutron, m_muon, m_helion, m_pion_0, m_pion_charged, m_deuteron, atomic_mass_unit
export c_light, e_charge, h_planck, h_bar_planck, r_e, r_p, mu_0_vac, eps_0_vac, classical_radius_factor, N_avogadro
export fine_structure_constant, anom_mag_moment_electron, anom_mag_moment_proton, anom_mag_moment_muon
export anom_mag_moment_deuteron, anom_mag_moment_neutron, anom_mag_moment_He3
export kg_per_amu, eV_per_amu


