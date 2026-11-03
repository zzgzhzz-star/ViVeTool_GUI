Imports System.IO
Imports System.Text.RegularExpressions

Public Module BuildListParser
    Public Function GetBuildName(repositoryPath As String) As String
        If String.IsNullOrWhiteSpace(repositoryPath) OrElse
           Not repositoryPath.StartsWith("features/", StringComparison.OrdinalIgnoreCase) Then Return Nothing
        Dim fileName = Path.GetFileName(repositoryPath)
        If Not Regex.IsMatch(fileName, "^\d+(?:\.\d+)*(?:_arm64)?\.txt$", RegexOptions.IgnoreCase) Then Return Nothing
        Return Path.GetFileNameWithoutExtension(fileName)
    End Function
End Module
