
# Constants pulled from the NIST table of
# the 2022 CODATA release


# Format is:
# const __b_const_name = value;
# Constant Name const_unit


const __b_m_electron = 510998.95069
# Electron Mass [eV]/c^2
const __b_m_proton = 9.382720894300001e8
# Proton Mass [eV]/c^2
const __b_m_neutron = 9.395654219399999e8
# Neutron Mass [eV]/c^2
const __b_m_muon = 1.056583755e8
# Muon Mass [eV]/c^2
const __b_m_helion = 2.80839161112e9
# Helion Mass He3 nucleus [eV]/c^2
const __b_m_deuteron = 1.875612945e9
# Deuteron Mass [eV]/c^2
const __b_c_light = 2.99792458e8
# speed of light [m/s]
const __b_h_planck = 4.135667696e-15
# Planck's constant [eV*s]
const __b_r_e = 2.8179403205e-15
# classical electron radius [m]
const __b_mu_0_vac = 1.25663706127e-6
# Vacuum permeability in [N/A^2] (newtons per ampere squared)




const __b_e_charge = 1.602176634e-19
# elementary charge [Coul]
const __b_fine_structure = 0.0072973525643
# fine structure constant
const __b_kg_per_amu = 1.66053906892e-27
# kg per standard atomic mass unit (dalton)
const __b_eV_per_amu = 9.3149410372e8
# eV per standard atomic mass unit (dalton)
const __b_J_per_eV = 1.602176634e-19
# Joules per eV
const __b_N_avogadro = 6.02214076e23
# Avogadro's constant: Number / mole (exact)




const __b_mu_deuteron = 4.330735087e-27
# deuteron magnetic moment in [eV/T]
const __b_mu_electron = -9.2847646917e-24
# electron magnetic moment in [eV/T]
const __b_mu_helion = -1.07461755198e-26
# helion magnetic moment in [eV/T]
const __b_mu_muon = -4.4904483e-26
# muon magnetic moment in [eV/T]
const __b_mu_neutron = -9.6623653e-27
# neutron magnetic moment in [eV/T]
const __b_mu_proton = 1.41060679545e-26
# proton magnetic moment in [eV/T]
const __b_mu_triton = 1.5046095178e-26
# triton magnetic moment in [eV/T]






# values calculated from other constants in this collection




const __b_classical_radius_factor = __b_r_e * __b_m_electron;
# e^2 / (4 pi eps_0) = classical_radius * mass * c^2.
# Is same for all particles of charge +/- 1.
const __b_r_p = __b_r_e * __b_m_electron / __b_m_proton;
# proton radius [m]
const __b_h_bar_planck =  __b_h_planck / 2pi;
# h_planck/twopi [eV*sec]
const __b_eps_0_vac = 8.8541878188e-12
# Permittivity of free space in [F/m]







# constants mysteriously missing from the release
# picked up from PDG
const __b_m_pion_0 = 1.349768277676847e8
# uncharged pion mass [eV]/c^2
const __b_m_pion_charged = 1.3957039098368132e8
# charged pion mass [eV]/c^2




#---------------------------------------------------------------------------------------------------