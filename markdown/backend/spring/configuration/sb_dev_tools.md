## Spring Boot DevTools

[:arrow_backward:](../spring_index)

DevTools provides handy development-time tools:

- Automatic application restart when code changes
- Automatic browser refresh when browser-destined resources (templates, scripts, styles) change
- Automatic disabling of template caches
- Built in H2 console, if using H2

##### Automatic application restart

The application is loaded into two separate class loaders in the JVM:

- one with your Java code, property files, everything from `src/main/` that are likely to change frequently
- other with dependency libraries, which aren't likely to change as often

When a change is detected, DevTools reloads only project code class loader and restarts the Spring context but leaves the other class loader and the JVM intact. 

##### Template cache disable

By default, Thymeleaf and FreeMarker are configured to cache the results of template parsing, which is great for production because better performance. But that's bad for development. Until we restart the application we won't see the changes. 

> DevTools automatically disables all template caching. 

For disabling we can also set caching property to `false`.