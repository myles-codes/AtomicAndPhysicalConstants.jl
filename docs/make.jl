using Documenter, AtomicAndPhysicalConstants

makedocs(
  sitename="AtomicAndPhysicalConstants.jl",
  authors="Alex Coxe et al.",
  format=Documenter.HTMLWriter.HTML(size_threshold=nothing),
  pages=
  [
    "Home" => "index.md",
    "Set Units" => "set_units.md"
  ]
)

deploydocs(;
  repo="github.com/bmad-sim/AtomicAndPhysicalConstants.jl.git",
)
