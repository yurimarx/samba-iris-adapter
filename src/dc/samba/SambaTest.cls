Class dc.samba.SambaTest
{

/// Get array
ClassMethod GetArray() As %Status [ Language = python ]
{
    import smbclient
    from smbclient import listdir

    username = "bob"
    password = "bobspasswd"
    server = "samba-iris-adapter-samba-1"
    share = "BobDrive"
    folder = "directory"
    port = 445
    
    smbclient.register_session(server, port=port, username=username, password=password)

    result = []

    for filename in listdir('//' + server + '/' + share + '/' + folder, port=port):
        result.append(filename)
}

/// Description
ClassMethod TestCreateFolder() As %Status
{
    Set sc = $$$OK
    Set username = "bob"
    Set password = "bobspasswd"
    Set server = "samba-iris-adapter-samba-1"
    Set share = "BobDrive"
    Set folder = "directory44"
    Set port = 445
    
    Set tSC = ##class(dc.samba.SambaService).CreateFolder(server, port, share, username, password, folder)

    Write tSC.AsStatus()

    Return sc
}

}
