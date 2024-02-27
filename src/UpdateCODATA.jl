# AtomicAndPhysicalConstants/UpdateConstants.jl


include("PhysicalConstants.jl")
include("ParticleTypes.jl")
using PyFormattedStrings
using Dates
kg_to_ev = 5.6095886e35;

"""This is a dictionary that associates the 
named constants in any CODATA release to 
their stored values; it's used to store the 
fetched values so they can be 
written to the file""" CODATA_Consts

CODATA_Consts = Dict{AbstractString, Dict{AbstractString, Float64}}(
    "electron mass energy equivalent in MeV" => Dict("m_electron" => m_electron), 
    "proton mass energy equivalent in MeV" => Dict("m_proton" => m_proton), 
    "neutron mass energy equivalent in MeV" => Dict("m_neutron" => m_neutron), 
    "muon mass energy equivalent in MeV" => Dict("m_muon" => m_muon), 
    "helion mass energy equivalent in MeV" => Dict("m_helion" => m_helion), 
    "deuteron mass energy equivalent in MeV" => Dict("m_deuteron" => m_deuteron), 
    "speed of light in vacuum" => Dict("c_light" => c_light), 
    "unified atomic mass unit" => Dict("atomic_mass_unit" => atomic_mass_unit), 
    "Planck constant in eV/Hz" => Dict("h_planck" => h_planck), 
    "classical electron radius" => Dict("r_e" => r_e), 
    "Avogadro constant" => Dict("N_avogadro" => N_avogadro), 
    "vacuum electric permittivity" => Dict("eps_0_vac" => eps_0_vac), 
    "vacuum mag. permeability" => Dict("mu_0_vac" => mu_0_vac), 
    "fine-structure constant" => Dict("fine_structure_ant" => fine_structure_ant), 
    "muon mag. mom. anomaly" => Dict("anom_mag_moment_muon" => anom_mag_moment_muon), 
    "electron mag. mom. anomaly" => Dict("anom_mag_moment_electron" => anom_mag_moment_electron), 
    "elementary charge" => Dict("e_charge" => e_charge)
    );


"""downloadCODATA takes the desired year of the release as an argument,
then downloads the ascii table of fundamental physical constants and 
returns the path to the local copy""" downloadCODATA

function downloadCODATA(year::Int)
    if year < 2018
        url = "https://physics.nist.gov/cuu/Constants/ArchiveASCII/allascii_"*string(year)*".txt"
    else 
        url = "https://physics.nist.gov/cuu/Constants/Table/allascii.txt"
    end
    path = download(url)
    return path
end;

"""getConstants accesses a file at 'path' 
(which is expected to be the ascii table of 
CODATA constants) and tries to extract 
the constants named in the dictionary 'CODATA_Consts'
and write them to that same dictionary""" getCODATA

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




"""writeCODATA writes a julia file called "yyyy-mm-dd_Constants.jl",
where yyyy-mm-dd is the current date. The contents of this file are the 
fundamental constants extracted from the CODATA set of the year given 
in the argument""" writeCODATA

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
			if line != "" && line[1] == first(keys(v)) 
				line[2] = "  = "*string(v[first(keys(v)) ])
				break
			end
		end
		if line != "" && match(r"# .... CODATA", line[1]) == true
			line[1] = "# "*parse(String, year)*" CODATA"
		end			
		push!(newlines, line)
	end
	seekstart(newf)
	newlines[1] = f"# AtomicAndPhysicalConstants.jl/{date}_Constants.jl"
	for line in newlines
		line = join(line, "  ")
		println(newf, line)
	end
	close(f)
	close(newf)
end;





"""setCODATA combines the functions 'downloadCODATA',
'getCODATA', and 'writeCODATA' to do a complete fetch 
of the updated CODATA constants and stores them in a 
Julia code file in the same directory""" setCODATA

function setCODATA(year::Int)
	table_path = downloadCODATA(year)
	getCODATA(table_path)
	writeCODATA(year)

end;


