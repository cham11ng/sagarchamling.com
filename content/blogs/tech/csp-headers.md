---
title: 'HTTP Security with Content-Security-Policy headers'
summary: 'Key notes of CSP response headers and troubleshooting guide'
description: 'Key notes of CSP response headers and troubleshooting guide'
slug: '/http-security-with-csp-headers'
date: '2022-03-02'
tags: ['csp', 'html', 'http security']
---

## Introduction

The Content-Security-Policy header adds the layer of security that facilitates web application administrators to control resources the user agent is allowed to load for a given page. This helps guard against cross-site scripting attacks (XSS), packet sniffing and data injection attacks.

### Syntax

```html
Content-Security-Policy: {policy-directive}; {policy-directive}
```

### Example

```html
Content-Security-Policy: default-src https: 'unsafe-eval' 'unsafe-inline';
object-src 'none'
```

## Directive Terms

### Fetch directive

Fetch directives control the locations from which certain resource types may be loaded. All fetch directives fall back to `default-src`.

### script-src

Directive specifies valid sources for JavaScript.

### Nonce

- Usage for script elements [Content Security Policy Level 2 ](https://www.w3.org/TR/CSP2/#script-src-nonce-usage)
- Ideally, developers would avoid inline scripts entirely and whitelist scripts by URL.
- However, in some cases, removing inline scripts can be difficult or impossible
- For those cases, developers can whitelist scripts using a randomly generated nonce.

```html
Content-Security-Policy: default-src 'self'; script-src 'self'
https://example.com 'nonce-EDNnf03nceIOfn39fn3e9h3sdfa'

<script nonce="EDNnf03nceIOfn39fn3e9h3sdfa">
  alert('Still blocked because nonce is wrong.');
</script>
```

### default-src

Directive serves as a fallback for the other CSP fetch directives.

### style-src

Directive specifies valid sources for stylesheets.

### frame-ancestors

Directive specifies valid parents that may embed a page using `<frame>`, `<iframe>`, `<object>`, `<embed>`, or `<applet>`.

### object-src

Directive specifies valid sources for the `<object>`, `<embed>`, and `<applet>` elements.

### report-to

Directive instructs the user agent to store reporting endpoints for an origin.

## Implementing in AWS Amplify

```yml
# customHTTP.yml
customHeaders:
  - pattern: '**/*'
    headers:
      - key: 'Strict-Transport-Security'
        value: 'max-age=31536000; includeSubDomains'
      - key: 'X-Frame-Options'
        value: 'SAMEORIGIN'
      - key: 'X-XSS-Protection'
        value: '1; mode=block'
      - key: 'X-Content-Type-Options'
        value: 'nosniff'
      - key: 'Content-Security-Policy'
        value: "default-src 'self'; style-src 'self'; img-src 'self' data:;"
```

## Troubleshooting

Mitigating with CSP policy directive for corresponding errors:

### Directive 1: img-src 'self' data:

```text
Refused to load the image 'data:image/png;base64,somerandomnumber' because it
violates the following Content Security Policy directive: "img-src 'self' data"
```

### Directive 2: connect-src https://\*.example1.com

```html
Refused to connect to 'https://hello.example1.com/' because it violates the
following Content Security Policy directive: "default-src 'self'". Note that
'connect-src' was not explicitly set, so 'default-src' is used as a fallback.
```

### Directive 3: connect-src wss://example.net

```html
Refused to connect to 'wss://example.net' because it violates the following
Content Security Policy directive.
```

### Directive 4: style-src-elem 'self' 'unsafe-inline' https://example.com

```html
Refused to load the stylesheet 'https://example.com/custom.css' because it
violates the following Content Security Policy directive: "style-src 'self'
'unsafe-inline'". Note that 'style-src-elem' was not explicitly set, so
'style-src' is used as a fallback.

<link rel="stylesheet" type="text/css" href="https://example.com/custom.css" />
```

### Directive 5: font-src 'self' data:;

```html
Refused specific: data:font/woff;base64,"someBase64encoded font",
```

## Validation Tools

- CSP Validator (https://csp-evaluator.withgoogle.com/)

- CSP Scanner (https://csper.io/evaluator)
