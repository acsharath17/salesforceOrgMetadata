public class Test_xml_request {
	public String getxmlRes() {

	Xmlstreamwriter xmlW = new Xmlstreamwriter();
	xmlW.writeStartDocument('utf-8','1.0');
		xmlW.writeStartElement(null,'SERVICE', null);
			xmlW.writeAttribute(null,null,'version','1.0');
			xmlW.writeStartElement(null,'CLIENT',null);
				xmlW.writeAttribute(null,null,'email','xx.xx@xx.xx');
				xmlW.writeStartElement(null,'BASIC_FIELDS',null);
					xmlW.writeAttribute(null,null,'id','1');

					xmlW.writeStartElement(null,'ADRESS_LINE_1',null);
					xmlW.writeAttribute(null,null,'id','2');
						xmlW.writeCharacters('4 rue de rocher');
					xmlW.writeEndElement(); //Close ADRESS_LINE_1

					xmlW.writeStartElement(null,'CITY',null);
						xmlW.writeAttribute(null,null,'id','3');
						xmlW.writeCharacters('Paris');
					xmlW.writeEndElement(); //Close CITY

				xmlW.writeEndElement(); //Close BASIC_FIELDS
			xmlW.writeEndElement(); //Close CLIENT
		xmlW.writeEndElement(); //Close SERVICE
	xmlW.writeEndDocument(); //Close XML document

	String xmlStringxmlRes = xmlW.getXmlString();
	System.debug('The XML :'+xmlW.getXmlString());     
	xmlW.close();

	return xmlStringxmlRes;
}
}