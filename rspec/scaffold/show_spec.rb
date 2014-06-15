<% if File.exist?(File.join %w[spec rails_helper.rb]) -%>
require 'rails_helper'
<% else -%>
require 'spec_helper'
<% end -%>

<% output_attributes = attributes.reject{|attribute| [:datetime, :timestamp, :time, :date].index(attribute.type) } -%>
describe "<%= ns_table_name %>/show", :type => :view do
  before(:each) do
    allow(controller).to receive(:can?).and_return(true)
<% if Rails.application.config.generators.options[:rails][:fixture_replacement] == :factory_girl -%>
    @<%= ns_file_name %> = assign(:<%= ns_file_name %>, create(:<%= ns_file_name %>))
<% else -%>
    @<%= ns_file_name %> = assign(:<%= ns_file_name %>, <%= class_name %>.create!(<%= '))' if output_attributes.empty? %>
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
<% if Rails.application.config.generators.options[:rails][:fixture_replacement] == :factory_girl -%>
<% if attribute.reference? -%>
    expect(rendered).to match(Regexp.new @<%= ns_file_name %>.<%= attribute.name %>.name)
<% else -%>
    expect(rendered).to match(Regexp.new @<%= ns_file_name %>.<%= attribute.name %>.to_s)
<% end -%>
<% else -%>
    expect(rendered).to match(/<%= raw_value_for(attribute) %>/)
<% end -%>
<% end -%>
  end
end
