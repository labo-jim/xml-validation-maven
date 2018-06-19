<?xml version="1.0" encoding="UTF-8"?>
<schema xmlns="http://www.ascc.net/xml/schematron">
  
  <pattern name="test">
    <rule context="/*">
      <assert test="@toto">
        Root element mus have a toto attribute
      </assert>
    </rule>
  </pattern>
  
</schema>