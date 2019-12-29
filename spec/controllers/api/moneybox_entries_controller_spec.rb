# frozen_string_literal: true

describe Api::MoneyboxEntriesController do
  describe "POST #create" do
    specify  do
      expect(post: "/api/moneyboxes")
          .to route_to(controller: "api/moneybox_entries", action: "create")
    end

    subject { post :create, params: params, format: :as_json }

    let(:params) { Hash[name: 'Foo'] }

    it "creates moneybox" do
      expect { subject }.to change(MoneyboxEntry, :count).by(1)
    end
  end

  describe "GET #show" do
    specify  do
      expect(get: "/api/moneyboxes/1")
          .to route_to(controller: "api/moneybox_entries", action: "show", id: "1")
    end
  end
end
