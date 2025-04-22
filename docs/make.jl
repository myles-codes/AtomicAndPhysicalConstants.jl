using Documenter, AtomicAndPhysicalConstants

makedocs(
  sitename="AtomicAndPhysicalConstants.jl",
  authors="Alex Coxe, Lixing Li, Matt Signorelli, David Sagan et al.",
  format=Documenter.HTMLWriter.HTML(size_threshold=nothing, mathengine=Documenter.MathJax()),
  pages=
  [
    "Home" => "index.md",
    "Setting Units: APCdef" => "units.md",
    "Constants" => "constants.md",
    "Species" => "species.md",
    "Helper Functions" => "helper_functions.md"
  ]
)

deploydocs(;
  repo="github.com/bmad-sim/AtomicAndPhysicalConstants.jl.git",
)
