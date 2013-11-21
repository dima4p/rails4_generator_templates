require 'spec_helper'

<% output_attributes = attributes.reject{|attribute| [:datetime, :timestamp, :time, :date].index(attribute.type) } -%>
describe "<%= ns_table_name %>/show" do
  before(:each) do
    controller.stub(:can?).and_return(true)
<% if Rails.application.config.generators.options[:rails][:fixture_replacement] == :factory_girl -%>
    @<%= ns_file_name %> = assign(:<%= ns_file_name %>, create(:<%= ns_file_name %>))
<% else -%>
    @<%= ns_file_name %> = assign(:<%= ns_file_name %>, stub_model(<%= class_name %><%= output_attributes.empty? ? '))' : ',' %>
<% output_attributes.each_with_index do |attribute, attribute_index| -%>
      :<%= attribute.name %> => <%= value_for(attribute) %><%= attribute_index == output_attributes.length - 1 ? '' : ','%>
<% end -%>
<% if !output_attributes.empty? -%>
    ))
<% end -%>
<% end -%>
  end

  it "renders attributes in <p>" do
    render
<% for attribute in output_attributes -%>
<% if webrat? -%>
    rendered.should contain(<%= value_for(attribute) %>.to_s)
<% elsif Rails.application.config.generators.options[:rails][:fixture_replacement] == :factory_girl -%>
    rendered.should match(Regexp.new @<%= ns_file_name %>.<%= attribute.name %>.to_s)
<% else -%>
    rendered.should match(/<%= eval(value_for(attribute)) %>/)
<% end -%>
<% end -%>
  end
end
