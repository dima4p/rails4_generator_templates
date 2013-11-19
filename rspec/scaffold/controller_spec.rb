require 'spec_helper'

<% module_namespacing do -%>
describe <%= controller_class_name %>Controller do

<% if options[:fixture_replacement] == :factory_girl -%>
  let(:valid_attributes) {FactoryGirl.build(:<%=file_name%>).attributes}
<% else -%>
  # This should return the minimal set of attributes required to create a valid
  # <%= class_name %>. As you add validations to <%= class_name %>, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) { <%= formatted_hash(example_valid_attributes) %> }
<% end -%>

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # <%= controller_class_name %>Controller. Be sure to keep this updated too.
  let(:valid_session) { {} }

  before :each do
    controller.stub!(:current_user).and_return(current_user)
  end

<% unless options[:singleton] -%>
  describe "GET index" do
    it "assigns all <%= table_name.pluralize %> as @<%= table_name.pluralize %>" do
      get :index, {}, valid_session
      assigns(:<%= table_name %>).should be_a_kind_of(ActiveRecord::Relation)
    end
  end

<% end -%>
  describe "GET show" do
    it "assigns the requested <%= ns_file_name %> as @<%= ns_file_name %>" do
      <%= file_name %> = <%= class_name %>.create! valid_attributes
      get :show, {:id => <%= file_name %>.to_param}, valid_session
      assigns(:<%= ns_file_name %>).should eq(<%= file_name %>)
    end
  end

  describe "GET new" do
    it "assigns a new <%= ns_file_name %> as @<%= ns_file_name %>" do
      get :new, {}, valid_session
      assigns(:<%= ns_file_name %>).should be_a_new(<%= class_name %>)
    end
  end

  describe "GET edit" do
    it "assigns the requested <%= ns_file_name %> as @<%= ns_file_name %>" do
      <%= file_name %> = <%= class_name %>.create! valid_attributes
      get :edit, {:id => <%= file_name %>.to_param}, valid_session
      assigns(:<%= ns_file_name %>).should eq(<%= file_name %>)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new <%= class_name %>" do
        expect {
          post :create, {:<%= ns_file_name %> => valid_attributes}, valid_session
        }.to change(<%= class_name %>, :count).by(1)
      end

      it "assigns a newly created <%= ns_file_name %> as @<%= ns_file_name %>" do
        post :create, {:<%= ns_file_name %> => valid_attributes}, valid_session
        assigns(:<%= ns_file_name %>).should be_a(<%= class_name %>)
        assigns(:<%= ns_file_name %>).should be_persisted
      end

      it "redirects to the created <%= ns_file_name %>" do
        post :create, {:<%= ns_file_name %> => valid_attributes}, valid_session
        response.should redirect_to(<%= class_name %>.last)
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved <%= ns_file_name %> as @<%= ns_file_name %>" do
        # Trigger the behavior that occurs when invalid params are submitted
        <%= class_name %>.any_instance.stub(:save).and_return(false)
        post :create, {:<%= ns_file_name %> => <%= formatted_hash(example_invalid_attributes) %>}, valid_session
        assigns(:<%= ns_file_name %>).should be_a_new(<%= class_name %>)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        <%= class_name %>.any_instance.stub(:save).and_return(false)
        post :create, {:<%= ns_file_name %> => <%= formatted_hash(example_invalid_attributes) %>}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested <%= ns_file_name %>" do
        <%= file_name %> = <%= class_name %>.create! valid_attributes
        # Assuming there are no other <%= table_name %> in the database, this
        # specifies that the <%= class_name %> created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        <%- if ::Rails::VERSION::STRING >= '4' -%>
        <%= class_name %>.any_instance.should_receive(:update).with(<%= formatted_hash(example_params_for_update) %>)
        <%- else -%>
        <%= class_name %>.any_instance.should_receive(:update_attributes).with(<%= formatted_hash(example_params_for_update) %>)
        <%- end -%>
        put :update, {:id => <%= file_name %>.to_param, :<%= ns_file_name %> => <%= formatted_hash(example_params_for_update) %>}, valid_session
      end

      it "assigns the requested <%= ns_file_name %> as @<%= ns_file_name %>" do
        <%= file_name %> = <%= class_name %>.create! valid_attributes
        put :update, {:id => <%= file_name %>.to_param, :<%= ns_file_name %> => valid_attributes}, valid_session
        assigns(:<%= ns_file_name %>).should eq(<%= file_name %>)
      end

      it "redirects to the <%= ns_file_name %>" do
        <%= file_name %> = <%= class_name %>.create! valid_attributes
        put :update, {:id => <%= file_name %>.to_param, :<%= ns_file_name %> => valid_attributes}, valid_session
        response.should redirect_to(<%= file_name %>)
      end
    end

    describe "with invalid params" do
      it "assigns the <%= ns_file_name %> as @<%= ns_file_name %>" do
        <%= file_name %> = <%= class_name %>.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        <%= class_name %>.any_instance.stub(:save).and_return(false)
        put :update, {:id => <%= file_name %>.to_param, :<%= ns_file_name %> => <%= formatted_hash(example_invalid_attributes) %>}, valid_session
        assigns(:<%= ns_file_name %>).should eq(<%= file_name %>)
      end

      it "re-renders the 'edit' template" do
        <%= file_name %> = <%= class_name %>.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        <%= class_name %>.any_instance.stub(:save).and_return(false)
        put :update, {:id => <%= file_name %>.to_param, :<%= ns_file_name %> => <%= formatted_hash(example_invalid_attributes) %>}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested <%= ns_file_name %>" do
      <%= file_name %> = <%= class_name %>.create! valid_attributes
      expect {
        delete :destroy, {:id => <%= file_name %>.to_param}, valid_session
      }.to change(<%= class_name %>, :count).by(-1)
    end

    it "redirects to the <%= table_name %> list" do
      <%= file_name %> = <%= class_name %>.create! valid_attributes
      delete :destroy, {:id => <%= file_name %>.to_param}, valid_session
      response.should redirect_to(<%= index_helper %>_url)
    end
  end

end
<% end -%>
