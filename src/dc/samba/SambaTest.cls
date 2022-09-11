Class dc.samba.SambaTest
{

/// Description
ClassMethod TestCreateFolder() As %Status
{
    Set sc = $$$OK
    Set username = "bob"
    Set password = "bobspasswd"
    Set server = "samba-iris-adapter-samba-1"
    Set port = 139
    Set share = "BobDrive"
    Set folder = "yuri2"

    Set sc = ##class(dc.samba.SambaService).CreateFolder(server, port, share, username, password, folder)

    Return sc
}

}
