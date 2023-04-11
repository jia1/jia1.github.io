---
title: "Spring Boot Interceptors"
date: 2021-02-11T20:57:00+08:00
draft: false
tags: ["spring"]
---
A neat trick to log HTTP requests and responses in a Spring Boot project is through interceptors. To log requests and responses between the client and the server, I use the `HandlerInterceptor` ([Introduction to Spring MVC HandlerInterceptor](https://www.baeldung.com/spring-mvc-handlerinterceptor)).

To create this interceptor, simply extend the `HandlerInterceptor` interface. By overriding the various methods available, you can intercept the request and/or response at different points of time. For example, `preHandle` is executed before the request is executed (i.e. no response yet). [This website](https://howtodoinjava.com/spring-mvc/spring-intercepting-requests-using-handlerinterceptor-with-example) explains when each of these methods are executed.

Given a `HttpServletRequest`, how do we extract the request body so that we can log it? There's no obvious getter for this, but `request.getReader().lines().collect(joining(...))`. In the [Stack Overflow thread](https://stackoverflow.com/questions/8100634/get-the-post-request-body-from-httpservletrequest), there's also a discussion about caching the request so that the request body can be read more than once (one for logging, one for the actual request). The caching can be done by wrapping the request with `new ContentCachingRequestWrapper(...)`.

Annoyingly, for `HttpServletResponse`, there's isn't `.getReader()...` and we need to do something else to access the content. This [Stack Overflow thread](https://stackoverflow.com/questions/63934694/how-to-get-response-body-from-servletresponse-in-spring-boot-filter) uses `.getContentAsByteArray()` after wrapping the response with the caching wrapper, `ContentCachingResponseWrapper`.

With that, we have our custom logging interceptor and what's left is to add this interceptor to `WebMvcConfig` by overriding the `addInterceptors` method.

```java
// WebMvcConfig
@Configuration
public class WebMvcConfig implements WebMvcConfigurer {
    private HttpHttpServletInterceptor httpHttpServletInterceptor;

    public WebMvcConfig() {
        this.httpHttpServletInterceptor = new HttpHttpServletInterceptor();
    }

    @Override
    public void addInterceptors(final InterceptorRegistry registry) {
        registry.addInterceptor(httpHttpServletInterceptor);
    }
}

// HttpServletInterceptor
@Slf4j
public class HttpServletInterceptor extends HandlerInterceptorAdapter {
    @Override
    public void postHandle(final HttpServletRequest request,
                           final HttpServletResponse response,
                           final Object handler,
                           final ModelAndView modelAndView) throws Exception {
        final ContentCachingRequestWrapper req = new ContentCachingRequestWrapper(request);
        log.info(String.format("%s %s", req.getMethod(), req.getRequestURI()));
        log.info(req.getReader().lines().collect(joining(System.lineSeparator())));
        final ContentCachingResponseWrapper res = new ContentCachingResponseWrapper(response);
        log.info(String.valueOf(res.getStatus()));
        log.info(new String(res.getContentAsByteArray(), res.getCharacterEncoding()));
    }
}
```
