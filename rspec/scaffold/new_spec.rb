<% if File.exist?(File.join %w[spec rails_helper.rb]) -%>
require 'rails_helper'
<% else -%>
require 'spec_helper'
<% end -%>

<% output_attributes = attributes.reject{|attribute| [:datetime, :timestamp, :time, :date].index(attribute.type) } -%>
describe "<%= ns_table_name %>/new", :type => :view do
  before(:each) do
    allow(controller).to receive(:can?).and_return(true)
<% if Rails.application.config.generators.options[:rails][:fixture_replacement] == :factory_girl -%>
    @<%= ns_file_name %> = assign(:<%= ns_file_name %>, build(:<%= ns_file_name %>))
  end
<% else -%>
    assign(:<%= ns_file_name %>, <%= class_name %>.new(<%= '))' if output_attributes.empty? %>
<% output_attributes.each_with_index do |attribute, attribute_index| -%>
      :<%= attribute.name %> => <%= attribute.default.inspect %><%= attribute_index == output_attributes.length - 1 ? '' : ','%>
<% end -%>
<%= !output_attributes.empty? ? "    ))\n  end" : "  end" %>
<% end -%>

  it "renders new <%= ns_file_name %> form" do
    render

    assert_select "form[action=?][method=?]", <%= index_helper %>_path, "post" do
<% for attribute in output_attributes -%>
      <% name = attribute.respond_to?(:column_name) ? attribute.column_name : attribute.name -%>
      <% input_type = attribute.reference? ? 'select' : attribute.input_type -%>
      assert_select '<%= input_type -%>#<%= ns_file_name %>_<%= name %>[name=?]', '<%= ns_file_name %>[<%= name %>]'
<% end -%>
    end
  end
end
