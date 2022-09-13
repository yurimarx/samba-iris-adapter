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
ClassMethod CreateFile(server, port, share, username, password, folder, filepath, filename) As %Status [ Language = python ]
{
    import smbclient
    from smbclient import open_file
    try:
        with open(filepath, mode='rb') as file: # b is important -> binary
            fileContent = file.read()

        smbclient.register_session(server, port=port, username=username, password=password)
        with smbclient.open_file('//' + server + '/' + share + '/' + folder + '/' + filename, port=port, mode="wb") as fd:
            fd.write(fileContent)
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
