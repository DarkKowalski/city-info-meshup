export class XmlParser {
    public parse(xml: string) {
        const convert = require('xml-js');
        return convert.xml2json(xml, {compact: true, spaces: 2});
    }
}
