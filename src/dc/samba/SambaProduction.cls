Class dc.samba.SambaProduction Extends Ens.Production
{

XData ProductionDefinition
{
<Production Name="dc.samba.SambaProduction" LogGeneralTraceEvents="false">
  <Description></Description>
  <ActorPoolSize>2</ActorPoolSize>
  <Item Name="SambaBusinessService" Category="" ClassName="dc.samba.SambaBusinessService" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
  </Item>
  <Item Name="SambaBusinessOperation" Category="" ClassName="dc.samba.SambaBusinessOperation" PoolSize="1" Enabled="true" Foreground="false" Comment="" LogTraceEvents="false" Schedule="">
    <Setting Target="Adapter" Name="Port">139</Setting>
    <Setting Target="Adapter" Name="Server">samba</Setting>
    <Setting Target="Adapter" Name="Share">BobDrive</Setting> 
    <Setting Target="Adapter" Name="Credentials">SambaCredentials</Setting> 
  </Item>
</Production>
}

}
