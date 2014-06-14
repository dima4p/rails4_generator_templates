require 'spec_helper'

<% output_attributes = attributes.reject{|attribute| [:datetime, :timestamp, :time, :date].index(attribute.type) } -%>
describe "<%= ns_table_name %>/index" do
  before(:each) do
    controller.stub(:can?).and_return(true)
<% if Rails.application.config.generators.options[:rails][:fixture_replacement] == :factory_girl -%>
    @<%= ns_file_name %> = create(:<%= ns_file_name %>)
<% if defined? Wice::WiceGrid -%>
    # assign(:<%= table_name %>, [
    result_set = [
      @<%= ns_file_name %>, @<%= ns_file_name %>] #)
<% else -%>
    assign(:<%= table_name %>, [@<%= ns_file_name %>, @<%= ns_file_name %>])
<% end -%>
<% else -%>
<% if defined? Wice::WiceGrid -%>
    # assign(:<%= table_name %>, [
    result_set = [
<% else -%>
    assign(:<%= table_name %>, [
<% end -%>
<% [1,2].each_with_index do |id, model_index| -%>
      stub_model(<%= class_name %><%= output_attributes.empty? ? (model_index == 1 ? ')' : '),') : ',' %>
<% output_attributes.each_with_index do |attribute, attribute_index| -%>
        :<%= attribute.name %> => <%= value_for(attribute) %><%= attribute_index == output_attributes.length - 1 ? '' : ','%>
<% end -%>
<% if !output_attributes.empty? -%>
      <%= model_index == 1 ? ')' : '),' %>
<% end -%>
<% end -%>
<% if defined? Wice::WiceGrid -%>
    ] #)
<% else -%>
    ])
<% end -%>
<% end -%>
<% if defined? Wice::WiceGrid -%>
    <%= class_name %>.should_receive(:page).and_return(result_set)
    result_set.should_receive(:per).and_return(result_set)
    result_set.should_receive(:includes).and_return(result_set)
    result_set.should_receive(:joins).and_return(result_set)
    result_set.should_receive(:order).and_return(result_set)
    result_set.should_receive(:where).and_return(result_set)
    result_set.should_receive(:total_count).twice.and_return(result_set.size)
    result_set.should_receive(:offset_value).and_return(0)
    result_set.should_receive(:last_page?).and_return(true)
    result_set.should_receive(:num_pages).and_return(1)
    result_set.should_receive(:current_page).and_return(1)
    result_set.should_receive(:total_pages).and_return(1)
    result_set.should_receive(:limit_value).and_return(1)
    assign(:grid, Wice::WiceGrid.new(<%= class_name %>, controller))
<% end -%>
  end

  it "renders a list of <%= table_name %>" do
    render

<% for attribute in output_attributes -%>
<% if Rails.application.config.generators.options[:rails][:fixture_replacement] == :factory_girl -%>
    assert_select "tr>td", :text => @<%= ns_file_name %>.<%= attribute.name %>.to_s, :count => 2
<% else -%>
    assert_select "tr>td", :text => <%= value_for(attribute) %>.to_s, :count => 2
<% end -%>
<% end -%>
  end
end
