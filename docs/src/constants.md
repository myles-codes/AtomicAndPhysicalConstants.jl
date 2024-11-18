
# Constants

Here is a list of constants provided in the package. They are accessed by a getter function. If a unit is provided, then the value with that unit is returned. If units is not provided, then the units will be in the units determined by `setunits()`. For Example:

```julia
c_light(u"km/s") #
```

Constants are pulled from the NIST table of the **2022 CODATA release**. Note that `m_pion_0` and `m_pion_charged` are pulled from **PDG**.

function c_light(unit::Unitful.FreeUnits)
  return __b_c_light |> unit
end

function h_planck(unit::Unitful.FreeUnits)
  return __b_h_planck |> unit
end


function h_bar_planck(unit::Unitful.FreeUnits)
  return __b_h_bar_planck |> unit
end


function r_e(unit::Unitful.FreeUnits)
  return __b_r_e |> unit
end

function r_p(unit::Unitful.FreeUnits)
  return __b_r_p |> unit
end

function e_charge(unit::Unitful.FreeUnits)
  return __b_e_charge |> unit
end


function mu_0_vac()
  return __b_mu_0_vac
end

function mu_0_vac(unit::Unitful.FreeUnits)
  return __b_mu_0_vac |> unit
end


function eps_0_vac()
  return __b_eps_0_vac
end

function eps_0_vac(unit::Unitful.FreeUnits)
  return __b_eps_0_vac |> unit
end

function classical_radius_factor()
  return __b_classical_radius_factor
end

function fine_structure()
  return __b_classical_radius_factor
end

function N_avogadro()
  return __b_N_avogadro
end