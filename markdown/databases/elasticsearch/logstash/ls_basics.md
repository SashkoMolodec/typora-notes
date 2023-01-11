## Logstash Basics

Logstash is a open source event processing engine.

Pipeline = input + (filter) + output.

One of the advantages of using Logstash and not directly sending events to Elasticsearch is decoupled architecture.

##### Handling JSON with output to file and filter example

```json
input {
    stdin {
        codec => json
    }
}

filter {
	mutate {
		convert => { "quantity" => "integer" }
	}
}

output {
    stdout {
        codec => rubydebug
    }
    
    file {
    	path => "output.txt"
    }
}
```



