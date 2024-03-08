
# Including packages
using Pkg
Pkg.add("HTTP")
Pkg.add("JSON")
using HTTP
using JSON

# extracting informations from the S009 json file
url = "https://pdgapi.lbl.gov/summaries/S009"
response = HTTP.get(url)
info = JSON.parse(String(response.body))

# the dictionary that maps the name of the particle to the mass unit is MeV
Mass = Dict{String, Float64}()

# the information of the mass is only at 1, 2
for i in 1:2
    Mass[info["summaries"]["properties"][i]["description"]] = info["summaries"]["properties"][i]["pdg_values"][1]["value"]
end

# extracting informations from the S008 json file
url = "https://pdgapi.lbl.gov/summaries/S008"
response = HTTP.get(url)
info= JSON.parse(String(response.body))

# the information of the mass is only at 1, 3
for i in 1:2:3
    Mass[info["summaries"]["properties"][i]["description"]] = info["summaries"]["properties"][i]["pdg_values"][1]["value"]
end

#print the dictionary
println(Mass)


