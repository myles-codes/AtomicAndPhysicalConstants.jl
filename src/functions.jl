# ------------------------------------------------------------------------------------------------------------


"""
		atomicnumber(particle::Species)

Get the atomic number (positive nuclear charge) of a tracked particle.
"""
atomicnumber

function atomicnumber(particle::Species)
  if haskey(ATOMIC_SPECIES, getfield(particle, :name))
    return ATOMIC_SPECIES[getfield(particle, :name)].Z
  else
    print("$(getfield(particle, :name)) is not an atom, and thus no atomic number.")
    return
  end
end;




# ------------------------------------------------------------------------------------------------------------
"""
		g_spin(species::Species)

Compute and return the value of g_s for a particle in [1/(T*s)] == [C/kg]
For atomic particles, will currently return 0. Will be updated in a future patch
"""
g_spin

function g_spin(species::Species)
  if isdefined(Main, :UNITS)

    vtypes = [Kind.LEPTON, Kind.HADRON]
    if getfield(species, :kind) ∉ vtypes
      error("Only massive subatomic particles have available gyromagnetic factors in this package.")
    end
    m_s = uconvert(u"MeV/c^2", getfield(species, :mass))
    mu_s = uconvert(u"m^2 * C / s", getfield(species, :moment))
    spin_s = getfield(species, :spin).val # since we store spin in units [ħ], we just want the half/integer
    charge_s = abs(uconvert(u"C", getfield(species, :charge)))

    gs = uconvert(u"h_bar", 2 * m_s * mu_s / (spin_s * charge_s)).val
    return gs
  else
    error("Please run @APCdef before you make a call to g_spin")
  end
end;



"""
		gyromagnetic_anomaly(species::Species)

Compute and deliver the gyromagnetic anomaly for a lepton given its g factor

# Arguments:
1. `gs::Float64': the g_factor for the particle
"""
gyromagnetic_anomaly

function gyromagnetic_anomaly(species::Species)

  if isdefined(Main, :APCconsts)
    vtypes = [Kind.LEPTON, Kind.HADRON]
    if getfield(species, :name) == "electron"
      return getfield(Main, Symbol(Main.APCconsts)).ELECTRON_GYRO_ANOM
    elseif getfield(species, :name) == "muon"
      return getfield(Main, Symbol(Main.APCconsts)).MUON_GYRO_ANOM
    elseif getfield(species, :kind) ∉ vtypes
      error("Only subatomic particles have computable gyromagnetic anomalies in this package.")
    else
      gs = abs(g_spin(species))
      return (gs - 2) / 2
    end
  else
    error("Please run @APCdef before you make a call to gyromagnetic_anomaly")
  end
end;



"""
		g_nucleon(gs::Float64, Z::Int, mass::Float64)

Compute and deliver the gyromagnetic anomaly for a baryon given its g factor


"""
g_nucleon

function g_nucleon(species::Species)

  Z = getfield(species, :charge).val
  m = getfield(species, :mass).val
  gs = g_spin(species)
  m_p = getfield(Species("proton"), :mass).val

  return gs * Z * m_p / m
end;









"""
    SUPERSCRIPT_MAP
    A dictionary mapping superscript characters to their corresponding integer values.
    This is used to convert superscript numbers in species names to their integer values.
"""
const SUPERSCRIPT_MAP = Dict{Char,Int64}(
  '⁰' => 0,
  '¹' => 1,
  '²' => 2,
  '³' => 3,
  '⁴' => 4,
  '⁵' => 5,
  '⁶' => 6,
  '⁷' => 7,
  '⁸' => 8,
  '⁹' => 9,
)

"""
    find_superscript(num::Int64)

## Description:
Convert an integer to its superscript representation.
This function takes an integer and returns a string containing the corresponding
superscript characters for each digit in the integer.
"""
function find_superscript(num::Int64)
  digs = reverse(digits(num))
  sup::String = ""
  for n ∈ digs
    for (k, v) in SUPERSCRIPT_MAP
      if n == v
        sup = sup * k
      end
    end
  end
  return sup
end

"""
    to_openPMD(val::Unitful.Quantity)
## Description:
Convert a Unitful.Quantity to a format suitable for openPMD.
Returns a tuple where the first element is the value in SI units
and the second element is a 7-tuple of  powers of the 7 base measures
characterizing the record's unit in SI 
(length L, mass M, time T, electric current I, thermodynamic temperature theta, amount of substance N, luminous intensity J)
"""
function to_openPMD(val::Unitful.Quantity)
  # convert the type to DynamicQuantities, which automatically converts to SI units
  # multiplying by 1.0 ensures that the value is converted to a float
  v = convert(DynamicQuantities.Quantity, val * 1.0)
  return (
    DynamicQuantities.ustrip(v),
    (
      DynamicQuantities.ulength(v),
      DynamicQuantities.umass(v),
      DynamicQuantities.utime(v),
      DynamicQuantities.ucurrent(v),
      DynamicQuantities.utemperature(v),
      DynamicQuantities.uamount(v),
      DynamicQuantities.uluminosity(v)
    )
  )
end
