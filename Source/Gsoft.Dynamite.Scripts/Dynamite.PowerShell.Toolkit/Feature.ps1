#
# Module 'Dynamite.PowerShell.Toolkit'
# Generated by: GSoft, Team Dynamite.
# Generated on: 10/24/2013
# > GSoft & Dynamite : http://www.gsoft.com
# > Dynamite Github : https://github.com/GSoft-SharePoint/Dynamite-PowerShell-Toolkit
# > Documentation : https://github.com/GSoft-SharePoint/Dynamite-PowerShell-Toolkit/wiki
#

<#
	.SYNOPSIS
		Toggle the features on a Farm level. 

	.DESCRIPTION
		Toggle the features on a Farm level. 

    --------------------------------------------------------------------------------------
    Module 'Dynamite.PowerShell.Toolkit'
    by: GSoft, Team Dynamite.
    > GSoft & Dynamite : http://www.gsoft.com
    > Dynamite Github : https://github.com/GSoft-SharePoint/Dynamite-PowerShell-Toolkit
    > Documentation : https://github.com/GSoft-SharePoint/Dynamite-PowerShell-Toolkit/wiki
    --------------------------------------------------------------------------------------
    
	.PARAMETER  xmlinput
		The path of a XML file (schema defines in NOTES)

	.PARAMETER  state
		$true = enable feature
    $false = disable feature

	.EXAMPLE
		PS C:\> Initialize-DSPFarmFeatures "c:\features.xml" $true

	.INPUTS
		System.String,System.Boolean

	.NOTES
		Here is the XML schema
    
<Configuration>
	<Farm>
		<Feature GUID="12345678-350a-421b-bd8a-0b688956f183" Name="Farm level feature"/>
		<WebApplications>
			<WebApplication Url="http://myServer">
				<Feature GUID="12345678-350a-421b-bd8a-0b688956f183" Name="Web Application level feature"/>
				<Sites>
					<Site Url="http://myServer/mySiteCollection">
						<Feature GUID="12345678-350a-421b-bd8a-0b688956f183" Name="My first feature"/>
						<Feature GUID="12345678-a710-473a-af3c-08d49ad2e0b4" Name="My second feature"/>
						<Webs>
							<AllWebs>
								<Feature GUID="12345678-566b-4233-ad7b-722518a94170" Name="My third feature"/>
							</AllWebs>
						</Webs>
					</Site>
				</Sites>
			<WebApplication>
		</WebApplications>
	</Farm>
</Configuration>
    
  .LINK
    GSoft, Team Dynamite on Github
    > https://github.com/GSoft-SharePoint
    
    Dynamite PowerShell Toolkit on Github
    > https://github.com/GSoft-SharePoint/Dynamite-PowerShell-Toolkit
    
    Documentation
    > https://github.com/GSoft-SharePoint/Dynamite-PowerShell-Toolkit/wiki
    
#>
function Initialize-DSPFarmFeatures()
{
	Param(
		[Parameter(Mandatory=$true, ValueFromPipeline=$true)]
		[xml]$xmlinput,
		
		[Parameter(Mandatory=$true, ValueFromPipeline=$true)]
		$state
	)

	Write "Process farm features..."
	Switch-DSPFeatures $xmlinput.Configuration.Farm "" $state
}

<#
	.SYNOPSIS
		Toggle the features on a web application level. 

	.DESCRIPTION
		Toggle the features on a web application level. 

    --------------------------------------------------------------------------------------
    Module 'Dynamite.PowerShell.Toolkit'
    by: GSoft, Team Dynamite.
    > GSoft & Dynamite : http://www.gsoft.com
    > Dynamite Github : https://github.com/GSoft-SharePoint/Dynamite-PowerShell-Toolkit
    > Documentation : https://github.com/GSoft-SharePoint/Dynamite-PowerShell-Toolkit/wiki
    --------------------------------------------------------------------------------------
    
	.PARAMETER  xmlinput
		The path of a XML file (schema defines in NOTES)

	.PARAMETER  state
		$true = enable feature
    $false = disable feature

	.EXAMPLE
		PS C:\> Initialize-DSPSiteCollectionsFeatures "c:\features.xml" $true

	.INPUTS
		System.String,System.Boolean

	.NOTES
		Here is the XML schema
    
<Configuration>
  <Sites>
    <Site Url="http://myServer/mySiteCollection">
      <Feature GUID="12345678-350a-421b-bd8a-0b688956f183" Name="My first feature"/>
      <Feature GUID="12345678-a710-473a-af3c-08d49ad2e0b4" Name="My second feature"/>
      <Webs>
        <AllWebs>
          <Feature GUID="12345678-566b-4233-ad7b-722518a94170" Name="My third feature"/>
        </AllWebs>
      </Webs>
    </Site>
  </Sites>
</Configuration>
    
  .LINK
    GSoft, Team Dynamite on Github
    > https://github.com/GSoft-SharePoint
    
    Dynamite PowerShell Toolkit on Github
    > https://github.com/GSoft-SharePoint/Dynamite-PowerShell-Toolkit
    
    Documentation
    > https://github.com/GSoft-SharePoint/Dynamite-PowerShell-Toolkit/wiki
    
#>
function Initialize-DSPWebApplicationFeatures()
{
	Param(
		[Parameter(Mandatory=$true, ValueFromPipeline=$true)]
		[xml]$xmlinput,
		
		[Parameter(Mandatory=$true, ValueFromPipeline=$true)]
		$state
	)

	Write "Process web application features..."
	foreach ($webApp in $xmlinput.SelectNodes("//WebApplication"))
	{
		$webAppUrl = $webApp.Url
		$spWebApp = Get-SPWebApplication -Identity $webApp.Url
		if($spWebApp -ne $null)
		{
			Switch-DSPFeatures $webApp $webAppUrl $state
		}
		else
		{
		  Write-Warning "Web application $webAppUrl doesn't exist" 
		}
	}
}

<#
	.SYNOPSIS
		Toggle the features on a Site Collection level. 

	.DESCRIPTION
		Toggle the features on a Site Collection level. 

    --------------------------------------------------------------------------------------
    Module 'Dynamite.PowerShell.Toolkit'
    by: GSoft, Team Dynamite.
    > GSoft & Dynamite : http://www.gsoft.com
    > Dynamite Github : https://github.com/GSoft-SharePoint/Dynamite-PowerShell-Toolkit
    > Documentation : https://github.com/GSoft-SharePoint/Dynamite-PowerShell-Toolkit/wiki
    --------------------------------------------------------------------------------------
    
	.PARAMETER  xmlinput
		The path of a XML file (schema defines in NOTES)

	.PARAMETER  state
		$true = enable feature
    $false = disable feature

	.EXAMPLE
		PS C:\> Initialize-DSPSiteCollectionsFeatures "c:\features.xml" $true

	.INPUTS
		System.String,System.Boolean

	.NOTES
		Here is the XML schema
    
<Configuration>
  <Sites>
    <Site Url="http://myServer/mySiteCollection">
      <Feature GUID="12345678-350a-421b-bd8a-0b688956f183" Name="My first feature"/>
      <Feature GUID="12345678-a710-473a-af3c-08d49ad2e0b4" Name="My second feature"/>
      <Webs>
        <AllWebs>
          <Feature GUID="12345678-566b-4233-ad7b-722518a94170" Name="My third feature"/>
        </AllWebs>
      </Webs>
    </Site>
  </Sites>
</Configuration>
    
  .LINK
    GSoft, Team Dynamite on Github
    > https://github.com/GSoft-SharePoint
    
    Dynamite PowerShell Toolkit on Github
    > https://github.com/GSoft-SharePoint/Dynamite-PowerShell-Toolkit
    
    Documentation
    > https://github.com/GSoft-SharePoint/Dynamite-PowerShell-Toolkit/wiki
    
#>
function Initialize-DSPSiteCollectionsFeatures()
{
	Param(
		[Parameter(Mandatory=$true, ValueFromPipeline=$true)]
		[xml]$xmlinput,
		
		[Parameter(Mandatory=$true, ValueFromPipeline=$true)]
		$state
	)

	Write "Process site collection features..."
	foreach ($Site in $xmlinput.SelectNodes("//Site"))
	{
		$SiteUrl = $Site.Url
		$spSite = Get-SPSite -Identity $Site.Url
		if($spSite -ne $null)
		{
			Switch-DSPFeatures $Site $SiteUrl $state
		}
		else
		{
		  Write-Warning "Site collection $SiteUrl doesn't exist" 
		}
	}
}

<#
	.SYNOPSIS
		Toggle the features on a AllWebs (of a Site Collection) level. 

	.DESCRIPTION
		Toggle the features on a AllWebs (of a Site Collection) level. 

    --------------------------------------------------------------------------------------
    Module 'Dynamite.PowerShell.Toolkit'
    by: GSoft, Team Dynamite.
    > GSoft & Dynamite : http://www.gsoft.com
    > Dynamite Github : https://github.com/GSoft-SharePoint/Dynamite-PowerShell-Toolkit
    > Documentation : https://github.com/GSoft-SharePoint/Dynamite-PowerShell-Toolkit/wiki
    --------------------------------------------------------------------------------------
    
	.PARAMETER  xmlinput
		The path of a XML file (schema defines in NOTES)

	.PARAMETER  state
		$true = enable feature
    $false = disable feature

	.EXAMPLE
		PS C:\> Initialize-DSPSiteAllWebsFeatures "c:\features.xml" $true

	.INPUTS
		System.String,System.Boolean

	.NOTES
		Here is the XML schema
    
<Configuration>
  <Sites>
    <Site Url="http://myServer/mySiteCollection">
      <Feature GUID="12345678-350a-421b-bd8a-0b688956f183" Name="My first feature"/>
      <Feature GUID="12345678-a710-473a-af3c-08d49ad2e0b4" Name="My second feature"/>
      <Webs>
        <AllWebs>
          <Feature GUID="12345678-566b-4233-ad7b-722518a94170" Name="My third feature"/>
        </AllWebs>
      </Webs>
    </Site>
  </Sites>
</Configuration>
    
  .LINK
    GSoft, Team Dynamite on Github
    > https://github.com/GSoft-SharePoint
    
    Dynamite PowerShell Toolkit on Github
    > https://github.com/GSoft-SharePoint/Dynamite-PowerShell-Toolkit
    
    Documentation
    > https://github.com/GSoft-SharePoint/Dynamite-PowerShell-Toolkit/wiki
    
#>
Function Initialize-DSPSiteAllWebsFeatures()
{
	Param(
		[Parameter(Mandatory=$true, ValueFromPipeline=$true)]
		[xml]$xmlinput,
		
		[Parameter(Mandatory=$true, ValueFromPipeline=$true)]
		$state
	)

 	Write "Process webs features..." 
	
	foreach ($Site in $xmlinput.SelectNodes("//Site"))
	{
		$SiteUrl = $Site.Url
		$spSite = Get-SPSite -Identity $Site.Url
		if($spSite -ne $null)
		{
		  # AllWebs
			foreach ($Feature in .Feature)
			{
				if(!($Feature.GUID -eq $null))
				{
					$FeatureName = $Feature.Name
					$WebUrl = $Web.Url
				
					foreach($Web in $spSite.AllWebs)
					{
					  Switch-DSPFeatures $Site.Webs.AllWebs $Web.Url $state
					}
				}
			}     
		}
		else
		{
		  Write-Warning "Site collection $SiteUrl doesn't exist"
		}
	} 	
}

<#
	.SYNOPSIS
		Toggle the features on specific webs (of a Site Collection) level. 

	.DESCRIPTION
		Toggle the features on specific webs (of a Site Collection) level. 

    --------------------------------------------------------------------------------------
    Module 'Dynamite.PowerShell.Toolkit'
    by: GSoft, Team Dynamite.
    > GSoft & Dynamite : http://www.gsoft.com
    > Dynamite Github : https://github.com/GSoft-SharePoint/Dynamite-PowerShell-Toolkit
    > Documentation : https://github.com/GSoft-SharePoint/Dynamite-PowerShell-Toolkit/wiki
    --------------------------------------------------------------------------------------
    
	.PARAMETER  xmlinput
		The path of a XML file (schema defines in NOTES)

	.PARAMETER  state
		$true = enable feature
    $false = disable feature

	.EXAMPLE
		PS C:\> Initialize-DSPSiteAllWebsFeatures "c:\features.xml" $true

	.INPUTS
		System.String,System.Boolean

	.NOTES
		Here is the XML schema
    
<Configuration>
  <Sites>
    <Site Url="http://myServer/mySiteCollection">
      <Feature GUID="12345678-350a-421b-bd8a-0b688956f183" Name="My first feature"/>
      <Feature GUID="12345678-a710-473a-af3c-08d49ad2e0b4" Name="My second feature"/>
      <Webs>
        <AllWebs>
          <Feature GUID="12345678-566b-4233-ad7b-722518a94170" Name="My third feature"/>
        </AllWebs>
      </Webs>
    </Site>
  </Sites>
</Configuration>
    
  .LINK
    GSoft, Team Dynamite on Github
    > https://github.com/GSoft-SharePoint
    
    Dynamite PowerShell Toolkit on Github
    > https://github.com/GSoft-SharePoint/Dynamite-PowerShell-Toolkit
    
    Documentation
    > https://github.com/GSoft-SharePoint/Dynamite-PowerShell-Toolkit/wiki
    
#>
Function Initialize-DSPWebFeatures()
{

	Param(
		[Parameter(Mandatory=$true, ValueFromPipeline=$true)]
		[xml]$xmlinput,
		
		[Parameter(Mandatory=$true, ValueFromPipeline=$true)]
		$state
	)
	
	Write "Process specific webs features..." 
	foreach ($Site in $xmlinput.SelectNodes("//Site"))
	{
		$SiteUrl = $Site.Url
		$spSite = Get-SPSite -Identity $Site.Url
		if($spSite -ne $null)
		{
		  foreach ($web in $Site.Webs.Web)
		  {
			$spWeb = Get-SPWeb $web.Url -ErrorAction SilentlyContinue
			$exists = ($spWeb) -ne $null
			
			if($exists -eq $true)
			{
			  Switch-DSPFeatures $web $web.Url $state
			}
		  }     
		}
		else
		{
		  Write-Warning "Site collection $SiteUrl doesn't exist"
		}
	}
}

function Switch-DSPFeatures()
{
	[CmdletBinding()]
	param
	(
		[Parameter(Mandatory=$true, Position=0)]
		[System.Xml.XmlElement]$Features,

		[Parameter(Mandatory=$true, Position=1)]
		$Url,
		
		[Parameter(Mandatory=$false, Position=2)]
		$State=$true
	)
	
	foreach($Feature in $Features.Feature)
	{
		if(!($Feature.GUID -eq $null))
		{
			$FeatureName = $Feature.Name
		
			if($State -eq $true)
			{
				if (![string]::IsNullOrEmpty($Url))
				{
					Write-Verbose "`tActivating web feature $FeatureName on $Url" 
					Enable-SPFeature -Identity $Feature.GUID -Url $Url -Force:$true
				}
				else
				{
					Write-Verbose "`tActivating farm feature $FeatureName" 
					Enable-SPFeature -Identity $Feature.GUID -Force:$true
				}
			}
			else
			{
				$f = $spWeb.Features[$Feature.GUID]
				if($f -ne $null)
				{
					if (![string]::IsNullOrEmpty($Url))
					{
						Write-Verbose "`tDeactivating web feature $FeatureName on $Url" 
						Disable-SPFeature -Identity $Feature.GUID -Url $Url -Force:$true -Confirm:$false
					}
					else 
					{
						Write-Verbose "`tDeactivating farm feature $FeatureName" 
						Disable-SPFeature -Identity $Feature.GUID -Force:$true -Confirm:$false
					}
				}
				else
				{
					Write-Warning "`tFeature $FeatureName is already disabled on $Url"
				} 					
			}
		}
   }
}