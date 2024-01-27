#--- Author : Ali Hojaji ---#

#--*-----------------------------*--#
#---> Implement Stretch Cluster <---#
#--*-----------------------------*--#

#--> test storage replica topology (run directly on CL1-TEST)
Test-SRTopology -SourceComputerName CL1-TEST -SourceVolumeName D: -SourceLogVolumeName L: -DestinationComputerName CL3-TEST -DestinationVolumeName E: -DestinationLogVolume


#--> enter remote session on a cluster node
Enter-PSSession cL1-TEST

#--> create fault domains
New-ClusterFaultDomain -Name Site1 -FaultDomainType Site -Location "East Coast"
New-ClusterFaultDomain -Name Site2 -FaultDomainType Site -Location "West Coast"

#--> add nodes to sites
Set-ClusterFaultDomain -Name CL1-FKT,CL2-TEST -FaultDomain site1
Set-ClusterFaultDomain -Name CL3-FKT,CL4-TEST -FaultDomain site2

#--> view fault domains
Get-ClusterFaultDomain

#--> set primary site
(Get-Cluster -Name CL-TEST).PreferredSite = "Site1"

#--> configure vm resiliency
(Get-Cluster -Name CL-TEST).ResiliencyLevel = 2
(Get-Cluster -Name CL-TEST).ResiliencyDefaultPeriod = 5
(Get-Cluster -Name CL-TEST).QuarantineThreshold = 3
(Get-Cluster -Name CL-TEST).QuarantineDuration = 3600