---
title: "Read Sheets in Java"
date: 2023-03-26T21:55:00+08:00
draft: false
tags: ["software","java"]
---
If you need to programmatically read a Google spreadsheet in Java, the [quickstart guide](https://developers.google.com/sheets/api/quickstart/java) describes a class that does configuration, scoping and reading all in one. However, if you use Spring Boot, you would want to split it into configuration and service layers:

```groovy
// build.gradle
...
dependencies {
    ...
    compile ('com.google.api-client:google-api-client')
    compile ('com.google.apis:google-api-services-sheets')
    ...
}
...
```

```java
// Spring Boot
// Your config layer should contain the Sheets bean:
// Copied from: https://stackoverflow.com/questions/53901194/use-google-sheets-java-api-with-api-key-not-oauth
import com.google.api.client.googleapis.javanet.GoogleNetHttpTransport;
import com.google.api.client.googleapis.services.CommonGoogleClientRequestInitializer;
import com.google.api.client.json.gson.GsonFactory;
import com.google.api.services.sheets.v4.Sheets;
...

    @Bean
    public Sheets sheets() throws IOException, GeneralSecurityException {
        return new Sheets.Builder(GoogleNetHttpTransport.newTrustedTransport(), GsonFactory.getDefaultInstance(), null)
                .setApplicationName("Your app name")
                .setGoogleClientRequestInitializer(CommonGoogleClientRequestInitializer.newBuilder()
                        .setKey(YOUR_API_KEY).build())
                .build();
    }
...

// Your service layer which makes sheets() do tasks:
// Adapted from: https://developers.google.com/sheets/api/quickstart/java
// Can add a range behind SHEET_NAME. See ^
import com.google.api.services.sheets.v4.Sheets;
import com.google.api.services.sheets.v4.model.ValueRange;
...

    public List<List<Object>> read() throws IOException {
        final Sheets.Spreadsheets.Values.Get g = sheets.spreadsheets().values().get(SHEET_ID, SHEET_NAME);
        final ValueRange r = g.execute();
        final List<List<Object>> v = r.getValues();
        return v;
    }
...
```
