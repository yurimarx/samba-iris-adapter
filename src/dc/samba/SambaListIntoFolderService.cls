Class dc.samba.SambaListIntoFolderService Extends Ens.BusinessService
{

Parameter ADAPTER = "Ens.InboundAdapter";

Method OnProcessInput(pInput As dc.samba.ListIntoFolderMessage, Output pOutput As dc.samba.FolderListResponseMessage) As %Status
{
    Set tSC=$$$OK
    If pInput '= "" {
        Set tSC = ..SendRequestSync("SambaBusinessOperation", pInput, .pResp, 100)
    }
    Set pOutput = pResp
    Quit tSC
}

}
