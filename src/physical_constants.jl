                             # AtomicAndPhysicalConstants/src/2022_constants.jl


                             # Constants pulled from the NIST table of
                             # the 2022 CODATA release


                             # Format is:
                             # __b_const_name = value;
                             # Constant Name const_unit






														 __b_m_electron               = 0.0005109989506900001
                             # Electron Mass [eV]/c^2
__b_m_proton                 = 938.27208943
                             # Proton Mass [eV]/c^2
__b_m_neutron                = 939.56542194
                             # Neutron Mass [eV]/c^2
__b_m_muon                   = 0.10565837550000001
                             # Muon Mass [eV]
__b_m_helion                 = 2808.39161112
                             # Helion Mass He3 nucleus [eV]/c^2
__b_m_deuteron               = 1875.612945
                             # Deuteron Mass [eV]/c^2
__b_c_light                  = 2.99792458e8
                             # speed of light [m/s]
__b_h_planck                 = 4.135667696e-15
                             # Planck's constant [eV*s]
__b_r_e                      = 2.8179403205e-15
                             # classical electron radius [m]
__b_mu_0_vac                 = 1.25663706127e-6
                             # Vacuum permeability in [N/A^2] (newtons per ampere squared)


__b_e_charge                 = 1.602176634e-19
                             # elementary charge [Coul]
__b_fine_structure           = 0.0072973525643
                             # fine structure constant
__b_kg_per_amu               = 1.66053906892e-27
                             # kg per standard atomic mass unit (dalton)
__b_eV_per_amu               = 9.3149410372e8
                             # eV per standard atomic mass unit (dalton)
__b_J_per_eV                 = 1.602176634e-19
                             # Joules per eV 
__b_N_avogadro               = 6.02214076e23
                             # Avogadro's constant: Number / mole (exact)






__b_mu_deuteron              = 2.703032234459612e-8
                             # deuteron magnetic moment in [eV/T]
__b_mu_electron              = -5.795094307747844e-5
                             # electron magnetic moment in [eV/T]
__b_mu_helion                = -6.707235202257981e-8
                             # helion magnetic moment in [eV/T]
__b_mu_muon                  = -2.802717381284691e-7
                             # muon magnetic moment in [eV/T]
__b_mu_neutron               = -6.03077407007048e-8
                             # neutron magnetic moment in [eV/T]
__b_mu_proton                = 8.804315114297193e-8
                             # proton magnetic moment in [eV/T]
__b_mu_triton                = 9.391033958868733e-8
                             # triton magnetic moment in [eV/T]






                             # values calculated from other constants in this collection


__b_classical_radius_factor = __b_r_e * __b_m_electron;
                             # e^2 / (4 pi eps_0) = classical_radius * mass * c^2.
                             # Is same for all particles of charge +/- 1.
__b_r_p = __b_r_e * __b_m_electron / __b_m_proton;
                             # proton radius [m]
__b_h_bar_planck = __b_h_planck / 2pi;
                             # h_planck/twopi [eV*sec]
__b_eps_0_vac                = 8.8541878188e-12
                             # Permittivity of free space in [F/m]








                             # constants mysteriously missing from the release
                             # picked up from PDG
__b_m_pion_0                 = 1.349768277676847e8
                             # uncharged pion mass [eV]/c^2
__b_m_pion_charged           = 1.3957039098368132e8
                             # charged pion mass [eV]/c^2


#---------------------------------------------------------------------------------------------------








