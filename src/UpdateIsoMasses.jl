# AtomicAndPhysicalConstants/UpdateIsoMasses.jl

include("PhysicalConstants.jl")
include("ParticleTypes.jl")
using PyFormattedStrings
using Dates
kg_to_eV = 5.6095886e35; # eV/c^2 per kilogram
u_to_eV = 9.31494102e8;# eV/c^2 per unified AMU

"""download the current ascii table of isotopic data"""
function downloadIsos()
  url = "https://physics.nist.gov/cgi-bin/Compositions/stand_alone.pl?ele=&ascii=ascii2&isotype=all"
  path = download(url)
  return path
end;


"""Extract the masses, etc. from the ascii table of isotopic data located at path"""
function getIsos(path::AbstractString)
  f = open(path)
  everyline = readlines(f)
  isos = []
  i = 0
  for l in everyline
    line = split(l, " = ")
    if line[1] == "Atomic Number"
      i += 1
      push!(isos, Dict{AbstractString, Any}(line[1]=>tryparse(Int64, line[2])))
    elseif line[1] == "Atomic Symbol"
      isos[i][line[1]] = line[2]
    elseif line[1] == "Mass Number"
      isos[i][line[1]] = tryparse(Int64, line[2])
    elseif line[1] == "Relative Atomic Mass"
      ram = split(line[2], '(')[1]
      isos[i][line[1]] = tryparse(Float64, ram) # get mass in u
    elseif line[1] == "Isotopic Composition"
      num = split(line[2], '(')[1]
      isos[i][line[1]] = tryparse(Float64, num)
    end
  end
  return isos
end;



"""buildIsoDict takes the list of individual isotopes and 
builds a dictionary of the elements with each of their isotopes 
listed by mass, as well as the isotopic average mass:
specifically what is written out is a dictionary with 
nuclear charges as keys, and 'AtomicSpeciesData' structs as values""" buildIsoDict

function buildIsoDict(List::Vector{Dict{AbstractString, Any}})
	Atomic_Particles = Dict{Int64, AtomicSpeciesData}()

	for isotope in List
		# first check if the list has an entry for the appropriate element
		if haskey(Atomic_Particles, isotope["Atomic Number"]) == false
			# if not, create one
			(Atomic_Particles[isotope["Atomic Number"]] = 
			AtomicSpeciesData(
				isotope["Atomic Number"], 
				isotope["Atomic Symbol"], 
				Dict(-1 => 0, isotope["Mass Number"] => isotope["Relative Atomic Mass"])))
		
		else # if the element exists, update the list of isotopes
			(Atomic_Particles[isotope["Atomic Symbol"]].mass[isotope["Mass Number"]] = 
			isotope["Relative Atomic Mass"])
		end

		# update the average mass entry
		if typeof(isotope["Isotopic Composition"]) == Float64
			(Atomic_Particles[isotope["Atomic Symbol"]].mass[-1] += 
			isotope["Isotopic Composition"] * isotope["Relative Atomic Mass"])
		end
	end
	return Atomic_Particles
end;
	




# write a function to print the isotopes library to a julia file

