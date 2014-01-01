server_base Cookbook
====================
this cookbook is base setting of my vps


Requirements
------------
requirements is notthing


Attributes
----------
cookbook attributes here.


#### base::default
key                            | type   | values          | default | description
:--                            |:--     |:--              |:--      |:--
`node['base']['dotfilesrepo']` | string | master, sanritz | master  | repository of dotfiles


Usage
-----
#### base::default
e.g1

```json
{
  "runlist" : [ "recipe[server_base]" ],
  "base" :{
    "dotfilesrepo" : "sanritz"
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
