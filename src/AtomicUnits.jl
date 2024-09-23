
module AtomicUnits
include("PhysicalConstants.jl")
using Unitful

# some units are defined in the package, should we define it again?

#@unit c "c" C_light (__b_c_light) * Unitful.m / Unitful.s false
#@unit eV "eV" Electric_volt (__b_e_charge) * Unitful.J false
@unit e "e" Elementary_charge (__b_e_charge) * Unitful.C false
@unit amu "amu" Amu (1 / (__b_N_avogadro)) * Unitful.g false

end