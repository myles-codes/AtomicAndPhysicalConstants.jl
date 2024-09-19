# AtomicAndPhysicalConstants/UpdateConstants.jl




"""This is a dictionary that associates \n\
named constants in any CODATA release to \n\
their stored values; it's used to store  \n\
fetched values so they can be written to \n\
file""" CODATA_Consts

CODATA_Consts = Dict{AbstractString, Dict{AbstractString, Float64}}(
	"electron mass energy equivalent in MeV" => Dict("__b_m_electron" => __b_m_electron), 
	"proton mass energy equivalent in MeV" => Dict("__b_m_proton" => __b_m_proton), 
	"neutron mass energy equivalent in MeV" => Dict("__b_m_neutron" => __b_m_neutron), 
	"muon mass energy equivalent in MeV" => Dict("__b_m_muon" => __b_m_muon), 
	"helion mass energy equivalent in MeV" => Dict("__b_m_helion" => __b_m_helion), 
	"deuteron mass energy equivalent in MeV" => Dict("__b_m_deuteron" => __b_m_deuteron), 
	"speed of light in vacuum" => Dict("__b_c_light" => __b_c_light), 
	"Planck constant in eV/Hz" => Dict("__b_h_planck" => __b_h_planck), 
	"classical electron radius" => Dict("__b_r_e" => __b_r_e), 
	"Avogadro constant" => Dict("__b_N_avogadro" => __b_N_avogadro), 
	"vacuum electric permittivity" => Dict("__b_eps_0_vac" => __b_eps_0_vac), 
	"vacuum mag. permeability" => Dict("__b_mu_0_vac" => __b_mu_0_vac), 
	"fine-structure constant" => Dict("__b_fine_structure" => __b_fine_structure), 
	"deuteron mag. mom." => Dict("__b_mu_deuteron" => __b_mu_deuteron),
	"electron mag. mom." => Dict("__b_mu_electron" => __b_mu_electron),
	"helion mag. mom." => Dict("__b_mu_helion" => __b_mu_helion),
	"muon mag. mom." => Dict("__b_mu_muon" => __b_mu_muon),
	"neutron mag. mom." => Dict("__b_mu_neutron" => __b_mu_neutron),
	"proton mag. mom." => Dict("__b_mu_proton" => __b_mu_proton),
	"triton mag. mom." => Dict("__b_mu_triton" => __b_mu_triton),
	"elementary charge" => Dict("__b_e_charge" => __b_e_charge),
	"atomic mass unit-kilogram relationship" => Dict("__b_kg_per_amu" => __b_kg_per_amu),
	"atomic mass unit-electron volt relationship" => Dict("__b_eV_per_amu" => __b_eV_per_amu),
	"electron volt-joule relationship" => Dict("__b_J_per_eV" => __b_J_per_eV)
);



"""downloadCODATA takes the desired year of the release as an argument,
then downloads the ascii table of fundamental physical constants and 
returns the path to the local copy""" downloadCODATA

function downloadCODATA(year::Int)
	myYear = year
	NIST_releases = [1969, 1973, 1986, 1998, 2002, 2006, 2010, 2014, 2018, 2022]
	ixyear = findmin(myYear .- NIST_releases)
	year = NIST_releases[ixyear[2]]
	if ixyear[1] != 0
		println(f"The year requested isn't available: downloading the {year} CODATA release instead.")
	end
	if year != 2022
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

function getCODATA(path::String, CODATA_Consts::Dict)
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
				elseif line[1][end-8:end] == "mag. mom."
					CODATA_Consts[line[1]][first(keys(CODATA_Consts[line[1]]))] = parse(Float64, line[2])/__b_J_per_eV
				else
					CODATA_Consts[line[1]][first(keys(CODATA_Consts[line[1]]))] = parse(Float64, line[2])
				end
			end
		end
	end
	close(f)
	return CODATA_Consts
end;



"""writeCODATA writes a julia file called \n\
"yyyy_constants.jl", where yyyy is the year \n\
of the release. The contents of this \n\
file are the fundamental constants extracted \n\
from the CODATA set of the year given in the \n\
argument""" writeCODATA

function writeCODATA(year::Int, new_consts)
	yearregex = r"[1-2][0-9][0-9][-0-9]"
	f = open(pwd()*"/src/physical_constants.jl", "r")
	everyline = readlines(f) 
	newf = open(pwd() * f"/src/{year}_constants.jl", "a+")
	newlines = []
	pion_masses = download_pdg_pion_masses()
	for l in everyline

		if match(r"CODATA", l) !== nothing
			line = ["#","the", f"{year}", "CODATA release"]
			push!(newlines, line)
			continue
		end
		if split(l) == SubString{String}[]
			line = "\n"
			push!(newlines, line)
			continue
		else
			line = split(l)
		end
		
									
		for (k, v) in new_consts
			eqspace = repeat(" ",28 - length(first(keys(v))))
			if size(line, 1) >= 1
				if line[1] == first(keys(v))
					line = [line[1]]
					push!(line, eqspace*"= "*f"{v[first(keys(v))]}")
					break
				
				elseif line[1] ==	"__b_m_pion_0"
					line = [line[1]]
					push!(line, eqspace*"= "*f"{pion_masses[1]}")
				elseif line[1] == "__b_m_pion_charged"
					line = [line[1]]
					push!(line, eqspace*"= "*f"{pion_masses[2]}")
				end
			end
		end
		push!(newlines, line)
	end
	seekstart(newf)
	newlines[1] = ["#", f"AtomicAndPhysicalConstants/src/{year}_constants.jl"]
	for line in newlines
		if length(line) >= 1
			if line == "\n"
				println(newf, "\n")
			elseif  line[1] == "#"
				line = join(pushfirst!(line, repeat(" ", 28)), " ")
				println(newf, line)
			else
				newl = join(line, " ")
				println(newf, newl)
			end
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
	new_consts = getCODATA(table_path, CODATA_Consts)
	writeCODATA(year, new_consts)

end; export setCODATA


