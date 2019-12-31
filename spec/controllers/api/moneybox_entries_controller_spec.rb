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

    subject(:get_record) { get :show, params: Hash[id: moneybox.id] }

    let_it_be(:moneybox) { create :moneybox }

    it "returns record" do
      expect(subject.body).to include_json(id: moneybox.id)
    end
  end

  describe "PATCH #update" do
    specify  do
      expect(patch: "/api/moneyboxes/1")
          .to route_to(controller: "api/moneybox_entries", action: "update", id: "1")
    end

    subject { patch :update, params: Hash[id: moneybox.id, name: "Foo123"] }

    let_it_be(:moneybox) { create :moneybox }

    it "updates and returns record", :aggregate_failures do
      expect { subject }.to change { moneybox.reload.name }.to("Foo123")
      expect(response.body).to include_json(id: moneybox.id)
    end
  end

  describe "DELETE #destroy" do
    specify  do
      expect(delete: "/api/moneyboxes/1")
          .to route_to(controller: "api/moneybox_entries", action: "destroy", id: "1")
    end

    subject { delete :destroy, params: Hash[id: moneybox.id] }

    let_it_be(:moneybox) { create :moneybox }

    it 'deletes record' do
      expect { subject }.to change(MoneyboxEntry, :count).by(-1)
    end
  end
end
