Imports System.IO
Imports System.Linq

Public Module Bootstrap
    <STAThread>
    Public Sub Main()
        Try
            My.Application.Run(Environment.GetCommandLineArgs().Skip(1).ToArray())
        Catch ex As Exception
            LogStartupException(ex)
            MessageBox.Show(ex.ToString(), "ViVeTool GUI 启动失败", MessageBoxButtons.OK, MessageBoxIcon.Error)
        End Try
    End Sub

    Public Sub LogStartupException(ex As Exception)
        Try
            File.AppendAllText(Path.Combine(AppDomain.CurrentDomain.BaseDirectory, "startup-error.log"),
                               DateTime.Now.ToString("s") & Environment.NewLine & ex.ToString() & Environment.NewLine)
        Catch
            ' A read-only installation folder must not cause a second startup failure.
        End Try
    End Sub
End Module
