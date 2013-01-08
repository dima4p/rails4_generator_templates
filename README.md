## Tamplates for Rails 3 Generator

This set of templates has the following changes:

1. Simple form for view _form partial

2. Scaffold controller that utilizes CanCan and WiceGrid

3. Rspecs for the scaffold controller and its views

### Installation

1. Either 

        git clone https://github.com/dima4p/rails3_generator_templates.git lib/templates

    ...or...

        git submodule add https://github.com/dima4p/rails3_generator_templates.git lib/templates
  
2. Create stuff with:

        rails generate scaffold FancyModel
