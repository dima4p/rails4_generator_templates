require 'spec_helper'

describe "<%= class_name.pluralize %>" do
  describe "GET /<%= table_name %>" do
    it "works! (now write some real specs)" do
      get <%= index_helper %>_path
      # expect(response.status).to eq(200)
    end
  end
end
