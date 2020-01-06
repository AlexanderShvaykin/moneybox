# frozen_string_literal: true

describe Api::MoneyboxEntriesController, :with_auth_user do
  describe "GET #index" do
    specify  do
      expect(get: "/api/moneyboxes")
          .to route_to(controller: "api/moneybox_entries", action: "index")
    end

    subject { get :index, format: :as_json }

    let_it_be(:moneybox) { create :moneybox }

    it_behaves_like "auth require"

    it "returns relation" do
      expect(subject.body).to include_json(UnorderedArray(id: moneybox.id))
    end
  end

  describe "POST #create" do
    specify  do
      expect(post: "/api/moneyboxes")
          .to route_to(controller: "api/moneybox_entries", action: "create")
    end

    subject { post :create, params: params, format: :as_json }

    let(:params) { Hash[name: "Foo"] }

    it_behaves_like "auth require"

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

    it_behaves_like "auth require"

    it "returns record" do
      expect(subject.body).to include_json(id: moneybox.id)
    end
  end

  describe "PATCH #update" do
    specify  do
      expect(patch: "/api/moneyboxes/1")
          .to route_to(controller: "api/moneybox_entries", action: "update", id: "1")
    end

    subject { patch :update, params: params }

    let_it_be(:moneybox) { create :moneybox }
    let(:params) { Hash[id: moneybox.id, name: "Foo123"] }

    it_behaves_like "auth require"

    it "updates and returns record", :aggregate_failures do
      expect { subject }.to change { moneybox.reload.name }.to("Foo123")
      expect(response.body).to include_json(id: moneybox.id)
    end

    context "with empty name" do
      let(:params) { Hash[id: moneybox.id, name: ""] }

      it "return 400 bad request" do
        expect(subject.status).to eq(400)
      end
    end
  end

  describe "DELETE #destroy" do
    specify  do
      expect(delete: "/api/moneyboxes/1")
          .to route_to(controller: "api/moneybox_entries", action: "destroy", id: "1")
    end

    subject { delete :destroy, params: Hash[id: moneybox.id] }

    let_it_be(:moneybox) { create :moneybox }

    it_behaves_like "auth require"

    it "deletes record" do
      expect { subject }.to change(MoneyboxEntry, :count).by(-1)
    end
  end
end
