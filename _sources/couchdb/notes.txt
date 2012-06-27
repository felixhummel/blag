#####
Notes
#####
.. todo:: collect, review, sort

Adding Documents batch style
============================
Post some docs::
    
    DB="http://127.0.0.1:5984/ido"
    curl -X POST $DB/_bulk_docs -d '{ "docs": [
            {
              "von": [2009, 11, 11, 0, 0, 0],
              "bis": [2009, 11, 11, 1, 0, 0],
              "was": "wurstsuppe1"
            },
            {
              "von": [2009, 11, 11, 1, 0, 0],
              "bis": [2009, 11, 11, 2, 0, 0],
              "was": "wurstsuppe2"
            },
            {
              "von": [2009, 11, 11, 3, 0, 0],
              "bis": [2009, 11, 11, 4, 0, 0],
              "was": "wurstsuppe3"
            },
            {
              "von": [2009, 11, 11, 4, 0, 0],
              "bis": [2009, 11, 11, 5, 0, 0],
              "was": "wurstsuppe4"
            },
            {
              "von": [2009, 11, 11, 5, 0, 0],
              "bis": [2009, 11, 11, 6, 0, 0],
              "was": "wurstsuppe5"
            }
        ]
    }'

See http://wiki.apache.org/couchdb/HTTP_Bulk_Document_API
