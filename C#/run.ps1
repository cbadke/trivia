Param([switch]$generate)

function Get-ScriptDirectory
{
      $Invocation = (Get-Variable MyInvocation -Scope 1).Value
        Split-Path $Invocation.MyCommand.Path
}
function GenerateDataFile
{
    Param([string]$fileName)
    rm -force $fileName -ErrorAction SilentlyContinue
    Get-Content input.txt | % { Trivia\Trivia\bin\Debug\Trivia.exe $_ } >> $fileName
}
$scriptPath = Get-ScriptDirectory

pushd $scriptPath
if($generate){
    GenerateDataFile "golden.txt"
}
else{
    GenerateDataFile "output.txt"
    $goldenTestCase = Get-Content golden.txt
    $output = Get-Content output.txt
    $comparison = Compare-Object $goldenTestCase $output
    if ($comparison){
        exit -1
    }
}
popd

exit 0
