# Species Functions

Species functions each take a `Species` as their parameter and return a specific property. Here are the available functions:

- `massof(::Species)`
- `chargeof(::Species)`
- `atomicnumber(::Species)`
- `fullname(::Species)`
- `g_spin(::Species)`
    - ``g = \frac{2m\mu }{Sq}``
    - ``g`` is gyromagnetic ratio
    - ``m`` is species mass
    - ``\mu`` is the species magnetic moment
    - ``S`` is the species spin
    - ``q`` is the species charge
- `gyromagnetic_anomaly(::Species)`
    - ``g_a = \frac{g-2}{2}``
    - ``g_a`` is the gyromagnetic anomaly for a lepton
    - ``g`` is the gyromagnetic ratio
- `g_nucleon(::Species)`
    - ``g_n = \frac{g Zm_p}{m}``
    - ``g_n`` is the gyromagnetic anomaly for a baryon
    - ``g`` is the gyromagnetic ratio
    - ``Z`` is the species charge
    - ``m_p`` is the mass of a proton
    - ``m`` is species mass

**Note**: You must call `@APCdef` before using `massof()` or `chargeof()`.
