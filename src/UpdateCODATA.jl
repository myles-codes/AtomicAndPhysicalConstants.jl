# AtomicAndPhysicalConstants/UpdateConstants.jl


include("PhysicalConstants.jl")
include("ParticleTypes.jl")
using PyFormattedStrings
using Dates

"""This is a dictionary that associates \n\
named constants in any CODATA release to \n\
their stored values; it's used to store  \n\
fetched values so they can be written to \n\
file""" CODATA_Consts

CODATA_Consts = Dict{AbstractString, Dict{AbstractString, Float64}}(
	"electron mass energy equivalent in MeV" => Dict("m_electron" => m_electron), 
	"proton mass energy equivalent in MeV" => Dict("m_proton" => m_proton), 
	"neutron mass energy equivalent in MeV" => Dict("m_neutron" => m_neutron), 
	"muon mass energy equivalent in MeV" => Dict("m_muon" => m_muon), 
	"helion mass energy equivalent in MeV" => Dict("m_helion" => m_helion), 
	"deuteron mass energy equivalent in MeV" => Dict("m_deuteron" => m_deuteron), 
	"speed of light in vacuum" => Dict("c_light" => c_light), 
	"Planck constant in eV/Hz" => Dict("h_planck" => h_planck), 
	"classical electron radius" => Dict("r_e" => r_e), 
	"Avogadro constant" => Dict("N_avogadro" => N_avogadro), 
	"vacuum electric permittivity" => Dict("eps_0_vac" => eps_0_vac), 
	"vacuum mag. permeability" => Dict("mu_0_vac" => mu_0_vac), 
	"fine-structure constant" => Dict("fine_structure_ant" => fine_structure_ant), 
	"muon mag. mom. anomaly" => Dict("anom_mag_moment_muon" => anom_mag_moment_muon), 
	"electron mag. mom. anomaly" => Dict("anom_mag_moment_electron" => anom_mag_moment_electron), 
	"elementary charge" => Dict("e_charge" => e_charge),
	"atomic mass unit-kilogram relationship" => Dict("kg_per_amu" => kg_per_amu),
	"atomic mass unit-electron volt relationship" => Dict("eV_per_amu" => eV_per_amu)
);



"""downloadCODATA takes the desired year of the release as an argument,
then downloads the ascii table of fundamental physical constants and 
returns the path to the local copy""" downloadCODATA

function downloadCODATA(year::Int)
	myYear = year
	NIST_releases = [1969, 1973, 1986, 1998, 2002, 2006, 2010, 2014, 2018]
	ixyear = findmin(myYear .- NIST_releases)
	year = NIST_releases[ixyear[2]]
	if ixyear[1] != 0
		println(f"The year requested isn't available: downloading the {year} CODATA release instead.")
	end
	if year != 2018
			url = "https://physics.nist.gov/cuu/Constants/ArchiveASCII/allascii_"*string(year)*".txt"
	else 
			url = "https://physics.nist.gov/cuu/Constants/Table/allascii.txt"
	end
	path = download(url)
	return path
end;


"""getCODATA(path::AbstractString) accesses \n\
the file at "path" (which is expected to be \n\
the ascii table of CODATA constants) and \n\
tries to extract the constants named in the \n\
dictionary CODATA_Consts and write them to \n\
that same dictionary""" getCODATA

function getCODATA(path::AbstractString)
	f = open(path)
	everyline = readlines(f)
	for l in everyline
			line = split(l, "   ")
			sp = findall(x->x=="", line)
			line = deleteat!(line, sp)
			if length(line) != 0
					if haskey(CODATA_Consts, line[1]) == true
							if occursin(' ', line[2]) == true
									line[2] = replace(line[2], ' ' => "")
							end
							if occursin("...", line[2]) == true
									line[2] = replace(line[2], "..." => "")
							end
							if line[1] == "unified atomic mass unit"
									CODATA_Consts[line[1]]["atomic_mass_unit"] = kg_to_ev*parse(Float64, line[2])
							elseif last(line) == "MeV"
									CODATA_Consts[line[1]][first(keys(CODATA_Consts[line[1]]))] = 0.001*parse(Float64, line[2])
							else
									CODATA_Consts[line[1]][first(keys(CODATA_Consts[line[1]]))] = parse(Float64, line[2])
							end
					end
			end
	end
	close(f)
end;




"""writeCODATA writes a julia file called \n\
"yyyy-mm-dd_Constants.jl", where yyyy-mm-dd \n\
is the current date. The contents of this \n\
file are the fundamental constants extracted \n\
from the CODATA set of the year given in the \n\
argument""" writeCODATA

function writeCODATA(year::Int)
	date = today()
	f = open(pwd()*"/src/PhysicalConstants.jl", "r")
	everyline = readlines(f) 
	newf = open(pwd() * f"/src/{date}_Constants.jl", "a+")
	newlines = []
	for l in everyline
		line = split(l, "  ")   
		if line[1] != ""
			sp = findall(x->x=="", line)
			line = deleteat!(line, sp)
		end
									
		for (k, v) in CODATA_Consts
			eqspace = repeat(" ",28 - length(first(keys(v))))
			if line != "" && line[1] == first(keys(v)) 
				line[2] = eqspace*"= "*f"{v[first(keys(v))]}"
				break
			end
		end
		if line != "" && match(r"# .... CODATA", line[1]) == true
			line[1] = "# "*parse(AbstractString, year)*" CODATA"
		end			
		push!(newlines, line)
	end
	seekstart(newf)
	newlines[1] = f"# {date}_Constants.jl"
	for line in newlines
		if line[1] == "\n" 
			println(newf, "\n")
		elseif line[1] == '#'
			println(newf, line)
		else
			newl = join(line, "  ")
			println(newf, newl)
		end
	end
	close(f)
	close(newf)
end;





"""setCODATA combines the functions \n\
downloadCODATA, \n\
getCODATA, and \n\
writeCODATA \n\
to do a complete fetch of the updated \n\
CODATA constants and stores them in a \n\
Julia code file in the src directory""" setCODATA

function setCODATA(year::Int)
	table_path = downloadCODATA(year)
	getCODATA(table_path)
	writeCODATA(year)

end; export setCODATA


