# AtomicAndPhysicalConstants/UpdateIsoMasses.jl

include("PhysicalConstants.jl")
include("ParticleTypes.jl")
using PyFormattedStrings
using Dates
kg_to_ev = 5.6095886e35;


"""download the current ascii table of isotopic data"""
function download_isotopes()
    url = "https://physics.nist.gov/cgi-bin/Compositions/stand_alone.pl?ele=&ascii=ascii2&isotype=all"
    path = download(url)
    return path
end;


"""Extract the masses, etc. from the ascii table of isotopic data located at path"""
function get_isos(path::AbstractString)
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
        elseif line[1] == "Isotopic Composition"
            num = split(line[2], '(')[1]
            isos[i][line[1]] = tryparse(Float64, num)
        end
    end
    return isos
end;

# write a function to concatenate the elements of the iso list belonging to the same element

# write a function to print the isotopes library