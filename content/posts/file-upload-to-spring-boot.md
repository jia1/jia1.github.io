---
title: "File Upload to Spring Boot"
date: 2021-12-10T13:30:00+08:00
draft: false
tags: ["software","java","spring"]
---
Implementing file uploads through GraphQL was something I never managed to succeed in. Got embroiled in type incompatibilities. And eventually, I gave up and implemented a separate but simple API endpoint just for file uploads.

So here's the design: The user clicks "Submit". The files get uploaded first. Upon upload, the server returns IDs. And the rest of the form data plus the returned IDs are sent to the GraphQL endpoint.

This is how the backend controller looks like:

```java
@RestController
@RequestMapping("/")
public class MyFileController {
    ...

    @PostMapping("/upload")
    public MyResponse upload(@RequestParam("files") final MultipartFile[] files) {
        // TODO: Create an empty list to house file IDs.
        for (final MultipartFile file : files) {
            try {
                // Get file content with file.getBytes(). This may throw an exception.
                // Get filename with file.getOriginalFilename().
                // TODO: Add file data to db.
            } catch (final IOException e) {
                // TODO: Log the error
            }
        }
        return MyResponse.builder().build(); // TODO: Populate this with file IDs
    }
}
```

And this is how you send files over from the frontend:

```typescript
const upload = async (files: File[]) => {
    const formData = new FormData();
    for (let i = 0; i < files.length; i++) {
        formData.append('files', files[i]);
    }
    return await axios.post<MyResponseDefinedInTS>('/upload', formData);
};
```

`File` is defined by TypeScript and it is equivalent to [File](https://developer.mozilla.org/en-US/docs/Web/API/File) in JavaScript ([StackOverflow](https://stackoverflow.com/questions/51722363/create-file-object-type-in-typescript)).
