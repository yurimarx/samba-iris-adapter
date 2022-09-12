Class dc.samba.SambaService
{

/// List files from a folder
ClassMethod ListFiles(server, port, share, username, password, folder) As %Status [ Language = python ]
{
    import smbclient
    from smbclient import listdir
    
    try:
        smbclient.register_session(server, port=port, username=username, password=password)
        result = []

        for filename in smbclient.listdir('//' + server + '/' + share + '/' + folder, port=port):
            result.append(filename)
    except Exception as error:
        print(error)
        result = []
    return result
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

/// Create a new folder
ClassMethod DeleteFolder(server, port, share, username, password, folder) As %Status [ Language = python ]
{
    import smbclient
    from smbclient import rmdir
    try:
        smbclient.register_session(server, port=port, username=username, password=password)
        smbclient.rmdir('//' + server + '/' + share + '/' + folder, port=port)
        return 1
    except Exception as error:
        print(error)
        return 0
}

}
