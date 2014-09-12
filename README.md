# Deprecated!

The long awaited event at least took place.

I've divided the code into separate parts and created the gems:
* https://rubygems.org/gems/active_record_model_and_rspec_enhanced_templates
* https://rubygems.org/gems/factory_girl_fixtures_template
* https://rubygems.org/gems/i18n_scaffold_controller_template
* https://rubygems.org/gems/rspec_rails_scaffold_templates

If you are interested in more automation of you work I suggest to look also at other my gems https://rubygems.org/profiles/koulikoff

So, this project is not supported any more. ;-)

## Templates for Rails 4 Generator

This set of templates has the following changes:

1. Simple form for view _form partial

2. Scaffold controller that utilizes CanCan and WiceGrid

3. Rspecs for the scaffold controller and its views

### Installation

1. Either 

        git clone https://github.com/dima4p/rails4_generator_templates.git lib/templates

    ...or...

        git submodule add https://github.com/dima4p/rails4_generator_templates.git lib/templates
  
2. Create stuff with:

        rails generate scaffold FancyModel
