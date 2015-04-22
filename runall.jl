## run files from ./src directory of same level as original notebook
## files 
files = readdir(".")

currDir = pwd()
println(string("current working directory: ", currDir))

for f in files
    println("--------------------")
    println("Running $f...")
    println("--------------------")
    include(string("test/", f))
    ## include(f)
end
