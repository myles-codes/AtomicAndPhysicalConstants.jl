using AtomicAndPhysicalConstants
using Test



@testset "AtomicAndPhysicalConstants.jl" begin
    # Write your tests here.
end

@testset "set_units.jl" begin

    # constants should be undefined when setunits() in not called
    @test !@isdefined c_light
    @test !@isdefined m_electron
    @test !@isdefined m_electron
    @test !@isdefined m_proton
    @test !@isdefined m_neutron
    @test !@isdefined m_muon
    @test !@isdefined m_helion
    @test !@isdefined m_deuteron
    @test !@isdefined m_pion_0
    @test !@isdefined m_pion_charged
    @test !@isdefined r_e
    @test !@isdefined e_charge
    @test !@isdefined h_planck
    @test !@isdefined mu_0_vac
    @test !@isdefined eps_0_vac
    @test !@isdefined kg_per_amu
    @test !@isdefined eV_per_amu
    @test !@isdefined N_avogadro
    @test !@isdefined fine_structure
    @test !@isdefined classical_radius_factor
    @test !@isdefined r_p
    @test !@isdefined h_bar_planck
    @test !@isdefined kg_per_eV

    #setunits to default units
    setunits()

    #users should not have access to base values and helper variables

    @test !@isdefined current_units

    @test !@isdefined __b_m_electron
    @test !@isdefined __b_m_electron
    @test !@isdefined __b_m_proton
    @test !@isdefined __b_m_neutron
    @test !@isdefined __b_m_muon
    @test !@isdefined __b_m_helion
    @test !@isdefined __b_m_deuteron
    @test !@isdefined __b_c_light
    @test !@isdefined __b_h_planck
    @test !@isdefined __b_r_e
    @test !@isdefined __b_mu_0_vac
    @test !@isdefined __b_eps_0_vac

    @test !@isdefined __b_e_charge
    @test !@isdefined __b_fine_structure

    @test !@isdefined __b_kg_per_amu
    @test !@isdefined __b_eV_per_amu
    @test !@isdefined __b_N_avogadro

    @test !@isdefined __b_classical_radius_factor
    @test !@isdefined __b_r_p
    @test !@isdefined __b_h_bar_planck

    @test !@isdefined __b_m_pion_0
    @test !@isdefined __b_m_pion_charged

    #when setunits is runned all constants should be initialized to default units

    @test m_electron ≈ 0.51099895000e6
    @test m_proton ≈ 0.93827208816e9
    @test m_neutron ≈ 0.93956542052e9
    @test m_muon ≈ 105.6583755e6
    @test m_helion ≈ 2.808391607035771e9
    @test m_deuteron ≈ 1.87561294257e9

    @test c_light ≈ 2.99792458e8
    @test e_charge ≈ 1
    @test r_e ≈ 2.8179403262e-15
    @test h_planck ≈ 4.135667696e-15
    @test mu_0_vac ≈ 1.25663706212e-6
    @test eps_0_vac ≈ 8.854187812800385e-12


    @test kg_per_amu ≈ 1.66053906660e-27
    @test eV_per_amu ≈ 9.3149410242e8
    @test N_avogadro ≈ 6.02214076e23
    @test fine_structure ≈ 7.2973525693e-3

    @test classical_radius_factor ≈ 1.4399645478508574e-9
    @test r_p ≈ 1.5346982671888946e-18
    @test h_bar_planck ≈ 6.582119568038699e-16
    @test kg_per_eV ≈ 1.7826619216224324e-36

    #set units to MKS
    setunits(MKS)

    #mass should have unit in kg instead of eV/c^2
    @test m_electron ≈ 9.109383701540453e-31
    @test m_proton ≈ 1.6726219236839978e-27
    @test m_neutron ≈ 1.674927498034172e-27
    @test m_muon ≈ 1.8835316270433453e-28
    @test m_helion ≈ 5.006412778866699e-27
    @test m_deuteron ≈ 3.3435837724217406e-27

    #c_light shouldn't change
    @test c_light ≈ 2.99792458e8

    #e_charge should be in Coulomb 
    @test e_charge ≈ 1.602176634e-19

    #unitless constants shouldn't change


    @test kg_per_amu ≈ 1.66053906660e-27
    @test eV_per_amu ≈ 9.3149410242e8
    @test N_avogadro ≈ 6.02214076e23
    @test fine_structure ≈ 7.2973525693e-3

    #set units to MKS and mass to MeV, and mass should have unit in MeV/c^2
    setunits(MKS, mass_unit="MeV/c^2")

    @test m_electron ≈ 0.51099895000e6 / 10^6
    @test m_proton ≈ 0.93827208816e9 / 10^6
    @test m_neutron ≈ 0.93956542052e9 / 10^6
    @test m_muon ≈ 105.6583755e6 / 10^6
    @test m_helion ≈ 2.808391607035771e9 / 10^6
    @test m_deuteron ≈ 1.87561294257e9 / 10^6

    #set the unit of time to hour, the unit of speed should be m/hour
    setunits(time_unit="hr")

    @test c_light ≈ 2.99792458e8 * 3600

    # set units to CGS, the speed should be in cm/s, and mass should be in gram
    setunits(CGS)

    @test c_light ≈ 2.99792458e10

    @test m_electron ≈ 9.109383701540453e-28
    @test m_proton ≈ 1.6726219236839978e-24
    @test m_neutron ≈ 1.674927498034172e-24
    @test m_muon ≈ 1.8835316270433453e-25
    @test m_helion ≈ 5.006412778866699e-24
    @test m_deuteron ≈ 3.3435837724217406e-24

    #if unit has the wrong dimension exist a MethodError will be thrown
    @test_throws ErrorException setunits(mass_unit="km")
    @test_throws ErrorException setunits(charge_unit="eV/c^2")
    @test_throws ErrorException setunits(time_unit="J/km")



    #test massof and chargeof

    #create some particles

    H = Species("H", 1, 1, 0, 0, 0)

    #mass should be in amu and charge in elementary charge
    setunits(mass_unit="amu")

    @test massof(H) ≈ 1.00782503223
    @test chargeof(H) ≈ 1
    @test massof(H, "kg") ≈ 1.6735328383153192e-27
    @test chargeof(H, "C") ≈ 1.602176634e-19


end