Class dc.samba.SambaService
{

/// List files from a folder
ClassMethod ListFiles(server, port, share, username, password, folder) As %Status [ Language = python ]
{
    import smbclient
    from smbclient import listdir
    
    smbclient.register_session(server, port=port, username=username, password=password)
    result = []

    for filename in smbclient.listdir('//' + server + '/' + share + '/' + folder, port=port):
        result.append(filename)
    return result
}

/// Create a new folder
ClassMethod CreateFolder(server, port, share, username, password, folder) As %Status [ Language = python ]
{
    import smbclient
    from smbclient import mkdir

    smbclient.register_session(server, port=port, username=username, password=password)
    smbclient.mkdir('//' + server + '/' + share + '/' + folder, port=port)
    return 1
}

/// Create a new folder
ClassMethod CreateFile(server, port, share, username, password, folder, filepath, filename) As %Status [ Language = python ]
{
    import smbclient
    from smbclient import open_file

    with open(filepath, mode='rb') as file: # b is important -> binary
        fileContent = file.read()

    smbclient.register_session(server, port=port, username=username, password=password)
    with smbclient.open_file('//' + server + '/' + share + '/' + folder + '/' + filename, port=port, mode="wb") as fd:
        fd.write(fileContent)
    return 1
}

/// Download a remote file
ClassMethod DownloadFile(server, port, share, username, password, folder, filename) As %String [ Language = python ]
{
    import smbclient
    from smbclient import open_file
        
    smbclient.register_session(server, port=port, username=username, password=password)
    with smbclient.open_file('//' + server + '/' + share + '/' + folder + '/' + filename, port=port, mode="rb") as fd:
        file_bytes = fd.read()
    
    with open('/tmp/' + filename, mode='wb') as file: # b is important -> binary
        file.write(file_bytes)
        file.close()

    return '/tmp/' + filename
}

/// Create a new folder
ClassMethod DeleteFolder(server, port, share, username, password, folder) As %Status [ Language = python ]
{
    import smbclient
    from smbclient import rmdir
    
    smbclient.register_session(server, port=port, username=username, password=password)
    smbclient.rmdir('//' + server + '/' + share + '/' + folder, port=port)
    return 1
}

}
