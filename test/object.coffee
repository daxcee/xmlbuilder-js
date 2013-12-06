vows = require 'vows'
assert = require 'assert'

xmlbuilder = require '../src/index.coffee'

vows
    .describe('Creating XML')
    .addBatch
        'From JS object':
            topic: () ->
                obj =
                    ele: "simple element"
                    person:
                        name: "John"
                        age: 35
                        address:
                            city: "Istanbul"
                            street: "End of long and winding road"
                        phone: [ "555-1234", "555-1235" ]
                        id: () -> return 42
    
                xmlbuilder.create('root', { headless: true })
                    .ele(obj)
                        .up()
                    .ele('added')

            'resulting XML': (topic) ->
                xml = '<root>' +
                          '<ele>simple element</ele>' +
                          '<person>' +
                              '<name>John</name>' +
                              '<age>35</age>' +
                              '<address>' +
                                  '<city>Istanbul</city>' +
                                  '<street>End of long and winding road</street>' +
                              '</address>' +
                              '<phone>555-1234</phone>' +
                              '<phone>555-1235</phone>' +
                              '<id>42</id>' +
                          '</person>' +
                          '<added/>' +
                      '</root>'

                assert.strictEqual topic.doc().toString(), xml

    .export(module)

