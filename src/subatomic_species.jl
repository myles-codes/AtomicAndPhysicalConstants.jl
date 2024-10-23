


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
<<<<<<< HEAD
  "pion0" => SubatomicSpecies("pion0", 0*u"q", __b_m_pion_0, 0.0*u"J/T", 0.0*u"ħ"),
  "neutron" => SubatomicSpecies("neutron", 0*u"q", __b_m_neutron, __b_mu_neutron, 0.5*u"ħ"),
  "deuteron" => SubatomicSpecies("deuteron", 1*u"q", __b_m_deuteron, __b_mu_deuteron, 1.0*u"ħ"),
  "pion+" => SubatomicSpecies("pion+", 1*u"q", __b_m_pion_charged, 0.0*u"J/T", 0.0*u"ħ"),
  "anti-muon" => SubatomicSpecies("anti-muon", 1*u"q", __b_m_muon, __b_mu_muon, 0.5*u"ħ"),
  "proton" => SubatomicSpecies("proton", 1*u"q", __b_m_proton, __b_mu_proton, 0.5*u"ħ"),
  "positron" => SubatomicSpecies("positron", 1*u"q", __b_m_electron, __b_mu_electron, 0.5*u"ħ"),
  "photon" => SubatomicSpecies("photon", 0*u"q", 0.0*u"MeV/c^2", 0.0*u"J/T", 0.0*u"ħ"),
  "electron" => SubatomicSpecies("electron", -1*u"q", __b_m_electron, __b_mu_electron, 0.5*u"ħ"),
  "anti-proton" => SubatomicSpecies("anti-proton", -1*u"q", __b_m_proton, __b_mu_proton, 0.5*u"ħ"),
  "muon" => SubatomicSpecies("muon", -1*u"q", __b_m_muon, __b_mu_muon, 0.5*u"ħ"),
  "pion-" => SubatomicSpecies("pion-", -1*u"q", __b_m_pion_charged, 0.0*u"J/T", 0.0*u"ħ"),
  "anti-deuteron" => SubatomicSpecies("anti-deuteron", -1*u"q", __b_m_deuteron, __b_mu_deuteron, 1.0*u"ħ"),
  "anti-neutron" => SubatomicSpecies("anti-neutron", 0*u"q", __b_m_neutron, __b_mu_neutron, 0.5*u"ħ")
=======
  "pion0" => SubatomicSpecies("pion0", 0, __b_m_pion_0.val, 0.0, 0.0),
  "neutron" => SubatomicSpecies("neutron", 0, __b_m_neutron.val, __b_mu_neutron.val, 0.5),
  "deuteron" => SubatomicSpecies("deuteron", 1, __b_m_deuteron.val, __b_mu_deuteron.val, 1.0),
  "pion+" => SubatomicSpecies("pion+", 1, __b_m_pion_charged.val, 0.0, 0.0),
  "anti-muon" => SubatomicSpecies("anti-muon", 1, __b_m_muon.val, __b_mu_muon.val, 0.5),
  "proton" => SubatomicSpecies("proton", 1, __b_m_proton.val, __b_mu_proton.val, 0.5),
  "positron" => SubatomicSpecies("positron", 1, __b_m_electron.val, __b_mu_electron.val, 0.5),
  "photon" => SubatomicSpecies("photon", 0, 0.0, 0.0, 0.0),
  "electron" => SubatomicSpecies("electron", -1, __b_m_electron.val, __b_mu_electron.val, 0.5),
  "anti-proton" => SubatomicSpecies("anti-proton", -1, __b_m_proton.val, __b_mu_proton.val, 0.5),
  "muon" => SubatomicSpecies("muon", -1, __b_m_muon.val, __b_mu_muon.val, 0.5),
  "pion-" => SubatomicSpecies("pion-", -1, __b_m_pion_charged.val, 0.0, 0.0),
  "anti-deuteron" => SubatomicSpecies("anti-deuteron", -1, __b_m_deuteron.val, __b_mu_deuteron.val, 1.0),
  "anti-neutron" => SubatomicSpecies("anti-neutron", 0, __b_m_neutron.val, __b_mu_neutron.val, 0.5)
>>>>>>> 6d25f7d (changed some particle names for consistency with OpenPMD)
)




