# AtomicAndPhysicalConstants/src/constants_struct.jl




# @doc"""
# CODATA is a type which contains all the relevant constants from our package;
# each release year is a different struct object with name "CODATAYYYY" where 
# YYYY is the year of the release.
# """ CODATA

Base.@kwdef struct CODATA
#####################################################################
# constants with dimension [mass]
#####################################################################

__b_m_electron#::typeof(1.0*u"MeV/c^2")
# Electron Mass [MeV]/c^2
__b_m_proton#::typeof(1.0*u"MeV/c^2")
# Proton Mass [MeV]/c^2
__b_m_neutron#::typeof(1.0*u"MeV/c^2")
# Neutron Mass [MeV]/c^2
__b_m_muon#::typeof(1.0*u"MeV/c^2")
# Muon Mass [MeV]/c^2
__b_m_helion #::typeof(1.0*u"MeV/c^2")
# Helion Mass He3 nucleus [MeV]/c^2
__b_m_deuteron#::typeof(1.0*u"MeV/c^2")
# Deuteron Mass [MeV]/c^2

# constants mysteriously missing from the release
# picked up from PDG
__b_m_pion_0#::typeof(1.0*u"MeV/c^2")
# uncharged pion mass [eV]/c^2
__b_m_pion_charged#::typeof(1.0*u"MeV/c^2")
# charged pion mass [eV]/c^2


#####################################################################
# constants with dimension [magnetic moment]
#####################################################################

__b_mu_deuteron#::typeof(1.0*u"J/T")
# deuteron magnetic moment in [J/T]
__b_mu_electron#::typeof(1.0*u"J/T")
# electron magnetic moment in [J/T]
__b_mu_helion#::typeof(1.0*u"J/T")
# helion magnetic moment in [J/T]
__b_mu_muon#::typeof(1.0*u"J/T")
# muon magnetic moment in [J/T]
__b_mu_neutron#::typeof(1.0*u"J/T")
# neutron magnetic moment in [J/T]
__b_mu_proton#::typeof(1.0*u"J/T")
# proton magnetic moment in [J/T]
__b_mu_triton#::typeof(1.0*u"J/T")
# triton magnetic moment in [J/T]


#####################################################################
# dimensionless constants
#####################################################################

__b_N_avogadro::Float64 
# Avogadro's constant: Number / mole (exact)
__b_fine_structure::Float64 
# fine structure constant

__b_gyro_anom_electron::Float64 
# electron magnetic moment anomaly
__b_gyro_anom_muon::Float64
# muon magnetic moment anomaly

__b_gspin_deuteron::Float64
# deuteron g factor 
__b_gspin_electron::Float64 
# electron g factor 
__b_gspin_helion::Float64 
# helion g factor 
__b_gspin_muon::Float64 
# muon g factor 
__b_gspin_neutron::Float64 
# neutron g factor 
__b_gspin_proton::Float64 
# proton g factor 
__b_gspin_triton::Float64 
# triton g factor


#####################################################################
# unit conversion constants
#####################################################################

__b_kg_per_amu#::typeof(1.0*u"kg/amu")
# kg per standard atomic mass unit (dalton)
__b_eV_per_amu#::typeof(1.0*u"(eV/c^2)/amu")
# eV per standard atomic mass unit (dalton)
__b_J_per_eV#::typeof(1.0*u"J/eV")
# Joules per eV
__b_e_coulomb#::typeof(1.0*u"C/e")
# elementary charge in coulombs per elementary charge


#####################################################################
# constants with miscelaneous dimension
#####################################################################

__b_e_charge#::typeof(1.0*u"C")
# elementary charge [C]
__b_r_e#::typeof(1.0*u"m")
# classical electron radius [m]
__b_r_p#::typeof(1.0*u"m/")
# classical proton radius [m]
__b_c_light#::typeof(u"m/s")
# speed of light [m/s]
__b_h_planck#::typeof(1.0*u"J*s")
# Planck's constant [J*s]
__b_h_bar_planck#::typeof(1.0*u"J*s")
# h_planck/twopi [J*s]
__b_classical_radius_factor#::typeof(1.0*u"m*MeV/c^2")
# e^2 / (4 pi eps_0) = classical_radius*mass*c^2.
# Is same for all particles of charge +/- 1.

__b_eps_0_vac#::typeof(1.0*u"F/m") 
# Permittivity of free space in [F/m]
__b_mu_0_vac#::typeof(1.0*u"N/A^2")
# Vacuum permeability in [N/A^2] (newtons per ampere squared)

__b_RELEASE_YEAR::Int32
# release year for posterity
end