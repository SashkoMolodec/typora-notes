## :symbols: Controlling Query Results

[:arrow_backward:](es_index)

[toc]

#### Specifying the result format

Return as YAML:

```json
GET /recipe/_search?format=yaml
{
    "query": {
      "match": { "title": "pasta" }
    }
}
```

Return pretty JSON:

```json
GET /recipe/_search?pretty
{
    "query": {
      "match": { "title": "pasta" }
    }
}
```



#### Source filtering

Include all of the `ingredients` object's keys, except the `name` key:

```json
GET /recipe/_search
{
  "_source": {
    "includes": "ingredients.*",
    "excludes": "ingredients.name"
  },
  "query": {
    "match": { "title": "pasta" }
  }
}
```



#### Specifying the result size

```json
GET /recipe/_search?size=2
{
  "_source": false,
  "query": {
    "match": {
      "title": "pasta"
    }
  }
}
```

We can also use it within the request body



#### Specifying an offset

```json
GET /recipe/_search
{
  "_source": false,
  "size": 2,
  "from": 2,
  "query": {
    "match": {
      "title": "pasta"
    }
  }
}
```

We can implement pagination using `from` key. 

```
from = (page_size * (page_number-1))
```



#### Sorting results

Simplest form:

```json
GET /recipe/_search
{
  "_source": false,
  "query": {
    "match_all": {}
  },
  "sort": [
    "preparation_time_minutes"
  ]
}
```

Sorting by multiple fields:

```json
GET /recipe/_search
{
  "_source": [ "preparation_time_minutes", "created" ],
  "query": {
    "match_all": {}
  },
  "sort": [
    { "preparation_time_minutes": "asc" },
    { "created": "desc" }
  ]
}
```



#### Sorting by multi-value fields

Sorting by the average rating (desc):

```json
GET /recipe/_search
{
  "_source": "ratings",
  "query": {
    "match_all": {}
  },
  "sort": [
    {
      "ratings": {
        "order": "desc",
        "mode": "avg"
      }
    }
  ]
}
```



#### Filters

```json
GET /recipe/_search
{
  "query": {
    "bool": {
      "must": [
        {
          "match": {
            "title": "pasta"
          }
        }
      ],
      "filter": [
        {
          "range": {
            "preparation_time_minutes": {
              "lte": 15
            } } } ] } }
}
```



#### Term vectors

```json
GET /markdown/_termvectors/<doc_id> 
{
  "fields": ["content"]
}
```

