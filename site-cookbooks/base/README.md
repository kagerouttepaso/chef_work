base Cookbook
=============
this cookbook is base setting of my pc


Requirements
------------
requirements is notthing

Attributes
----------
cookbook attributes here.

#### base::default
key                              | type   | values            | default | description
:--                              |:--     |:--                |:--      |:--
`node['server_base']['mail_to']` | string | your mail address | root    | logwatch send mail address

Usage
-----
#### base::default
e.g1

```json
{
  "runlist" : [ "recipe[base]" ],
  "server_base" :{
    "mail_to" : "example@mail.com"
  }
}
```

Contributing
------------
TODO: (optional) If this is a public cookbook, detail the process for contributing. If this is a private cookbook, remove this section.

e.g.
1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

License and Authors
-------------------
Authors: TODO: List authors
