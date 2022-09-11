Class dc.samba.SambaService
{

/// List files from a folder
ClassMethod ListFiles(server, port, share, username, password, folder) As %Status [ Language = python ]
{
    import smbclient
    from smbclient import listdir
    
    username = "bob"
    password = "bobspasswd"
    server = "samba-iris-adapter-samba-1"
    port = 446
    share = "//samba-iris-adapter-samba-1/BobDrive/"
    folder = "//samba-iris-adapter-samba-1/BobDrive/test"

    smbclient.register_session(server, username=username, password=password)

    for filename in listdir(folder, port=port):
        print(filename)
}

/// Create a new folder
ClassMethod CreateFolder(server, port, share, username, password, folder) As %Status [ Language = python ]
{
    import smbclient
    from smbclient import mkdir
    try:
        smbclient.register_session(server, port=port, username=username, password=password)
        smbclient.mkdir('//' + server + '/' + share + '/' + folder, port=port)
        return 1
    except Exception as error:
        print(error)
        return 0
}

}
