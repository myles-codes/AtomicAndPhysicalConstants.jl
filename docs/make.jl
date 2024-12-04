using Documenter, AtomicAndPhysicalConstants

makedocs(
  sitename="AtomicAndPhysicalConstants.jl",
  authors="Alex Coxe et al.",
  format=Documenter.HTMLWriter.HTML(size_threshold=nothing),
  pages=
  [
    "Home" => "index.md",
    "APCdef" => "units.md",
    "Constants" => "constants.md",
    "Species" => "species.md"
  ]
)

deploydocs(;
  repo="github.com/bmad-sim/AtomicAndPhysicalConstants.jl.git",
)
