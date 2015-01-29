## run files from ./src directory of same level as original notebook
## files 
files = readdir("test")

for f in files
    println("--------------------")
    println("Running $f...")
    println("--------------------")
    include(string("test/", f))
end
