Powershell script for sorting EF Core schema XML content in increasing order
Execute by
powershell -ExecutionPolicy Bypass -File sort_xml_content.ps1 -xmlPath "Example.xml"

XML example:
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<schema class="PostgreQpDataContext" useLongUrls="true" replaceUrls="true" dbIndependent="true" isPartial="false" sendNotifications="false" siteName="main_site" dbType="postgres">
  <content id="537" name="AbstractItem" mapped_name="QPAbstractItem" plural_mapped_name="QPAbstractItems" use_default_filtration="true">
    <attribute name="Title" />
    <attribute name="Name" />
    <attribute name="OldName" mapped_name="Name1" />
    <attribute name="Parent" mapped_back_name="Children" />
    <attribute name="IsVisible" />
    <attribute name="IsPage" />
    <attribute name="Icon" />
    <attribute name="ZoneName" />
    <attribute name="AllowedUrlPatterns" />
    <attribute name="DeniedUrlPatterns" />
    <attribute name="Description" />
    <attribute name="Discriminator" mapped_back_name="Items" />
    <attribute name="VersionOf" mapped_back_name="Versions" />
    <attribute name="Culture" mapped_back_name="AbstractItems" />
    <attribute name="Tags" />
    <attribute name="IsInSiteMap" />
    <attribute name="IndexOrder" />
    <attribute name="ExtensionId" />
    <attribute name="ContentId" />
    <attribute name="TitleFormat" mapped_back_name="Item" />
    <attribute name="Regions" />
    <attribute name="Segments" />
    <attribute name="ProfileCards" />
  </content>
</schema>
