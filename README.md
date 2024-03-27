# terragrunt quickie

```mermaid
flowchart TD
  bucket-2 -- depends --> bucket-1
  bucket-1-lifecycle-config -- depends --> bucket-1
  bucket-2-lifecycle-config -- depends --> bucket-2
```
