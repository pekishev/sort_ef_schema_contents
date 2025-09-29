This repository contains a small PowerShell script (sort_xml_content.ps1) that sorts parts of an EF Core-generated XML schema file into a consistent (deterministic) order. The goal is to make diffs between schema snapshots much easier to review by removing noise caused by ordering differences.

Powershell helper to sort EF Core schema XML contents into a deterministic order so diffs are smaller and easier to read.
Requirements
PowerShell 5.1+ on Windows, or PowerShell Core (pwsh) on macOS / Linux.

Execute by
powershell -ExecutionPolicy Bypass -File sort_xml_content.ps1 -xmlPath "Example.xml"

XML example:
```
<?xml version="1.0" encoding="utf-8" standalone="yes"?>
<schema class="PostgreQpDataContext"
        useLongUrls="true"
        replaceUrls="true"
        dbIndependent="true"
        isPartial="false"
        sendNotifications="false"
        siteName="main_site"
        dbType="postgres">

  <content id="537"
           name="AbstractItem"
           mapped_name="QPAbstractItem"
           plural_mapped_name="QPAbstractItems"
           use_default_filtration="true">

    <attribute name="Title"/>
    <attribute name="Name"/>
    <attribute name="OldName" mapped_name="Name1"/>
    <attribute name="Parent" mapped_back_name="Children"/>
    <attribute name="IsVisible"/>
    <attribute name="IsPage"/>
    <attribute name="Icon"/>
    <attribute name="ZoneName"/>
    <attribute name="AllowedUrlPatterns"/>
    <attribute name="DeniedUrlPatterns"/>
    <attribute name="Description"/>
    <attribute name="Discriminator" mapped_back_name="Items"/>
    <attribute name="VersionOf" mapped_back_name="Versions"/>
    <attribute name="Culture" mapped_back_name="AbstractItems"/>
    <attribute name="Tags"/>
    <attribute name="IsInSiteMap"/>
    <attribute name="IndexOrder"/>
    <attribute name="ExtensionId"/>
    <attribute name="ContentId"/>
    <attribute name="TitleFormat" mapped_back_name="Item"/>
    <attribute name="Regions"/>
    <attribute name="Segments"/>
    <attribute name="ProfileCards"/>
  </content>
</schema>
```
