Class dc.samba.SambaProduction Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="dc.samba.SambaProduction" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="SambaCreateFolderService" Category="" ClassName="dc.samba.SambaCreateFolderService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="SambaDeleteFolderService" Category="" ClassName="dc.samba.SambaDeleteFolderService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="SambaListIntoFolderService" Category="" ClassName="dc.samba.SambaListIntoFolderService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="SambaBusinessOperation" Category="" ClassName="dc.samba.SambaBusinessOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Host" Name="Port">139</Setting>
    <Setting Target="Host" Name="Server">samba-iris-adapter-samba-1</Setting>
    <Setting Target="Host" Name="Share">BobDrive</Setting>
    <Setting Target="Host" Name="Credentials">SambaCredentials</Setting>
  </Item>
</Production>
}

}
