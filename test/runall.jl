## run files from ./src directory of same level as original notebook
## files 
files = readdir("../testFiles")
jlFileInds = [ismatch(r".jl$", thisFile) for thisFile in files]
files = files[jlFileInds]

currDir = pwd()
println(string("current working directory: ", currDir))

using Base.Test

macro no_error(ex)
    quote
        try
            $(esc(ex))
            true
        catch
            false
        end
    end
end


@testset "Summary over all individual notebook files" begin
	 for f in files
     	  println("")
        println("")
        println("")
        println("")
        println("")
   	  println("--------------------")
     	  println("Running $f tests")
   	  println("--------------------")
        @testset "$f testset:" begin
            @test @no_error include(string("../testFiles/", f))
        end
	end
end
