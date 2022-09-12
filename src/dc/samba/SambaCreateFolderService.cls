Class dc.samba.SambaCreateFolderService Extends Ens.BusinessService
{

Parameter ADAPTER = "Ens.InboundAdapter";

Method OnProcessInput(pInput As dc.samba.CreateFolderMessage, pOutput As Ens.StringResponse) As %Status
{
    Set tSC=$$$OK
    If pInput '= "" {
        Set tSC = ..SendRequestSync("SambaBusinessOperation", pInput, .pResp, 100)
    }
    //Set pOutput = pResp
    Quit tSC
}

}
