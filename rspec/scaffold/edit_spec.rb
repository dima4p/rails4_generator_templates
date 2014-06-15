<% if File.exist?(File.join %w[spec rails_helper.rb]) -%>
require 'rails_helper'
<% else -%>
require 'spec_helper'
<% end -%>

<% output_attributes = attributes.reject{|attribute| [:datetime, :timestamp, :time, :date].index(attribute.type) } -%>
describe "<%= ns_table_name %>/edit", :type => :view do
  before(:each) do
    allow(controller).to receive(:can?).and_return(true)
<% if Rails.application.config.generators.options[:rails][:fixture_replacement] == :factory_girl -%>
    @<%= ns_file_name %> = assign(:<%= ns_file_name %>, create(:<%= ns_file_name %>))
<% else -%>
    @<%= ns_file_name %> = assign(:<%= ns_file_name %>, <%= class_name %>.create!(<%= '))' if output_attributes.empty? %>
<% output_attributes.each_with_index do |attribute, attribute_index| -%>
      :<%= attribute.name %> => <%= attribute.default.inspect %><%= attribute_index == output_attributes.length - 1 ? '' : ','%>
<% end -%>
<%= output_attributes.empty? ? "" : "    ))\n" -%>
<% end -%>
  end

  it "renders the edit <%= ns_file_name %> form" do
    render

    assert_select "form[action=?][method=?]", <%= ns_file_name %>_path(@<%= ns_file_name %>), "post" do
<% for attribute in output_attributes -%>
      <% name = attribute.respond_to?(:column_name) ? attribute.column_name : attribute.name -%>
      <% input_type = attribute.reference? ? 'select' : attribute.input_type -%>
      assert_select '<%= input_type -%>#<%= ns_file_name %>_<%= name %>[name=?]', '<%= ns_file_name %>[<%= name %>]'
<% end -%>
    end
  end
end
