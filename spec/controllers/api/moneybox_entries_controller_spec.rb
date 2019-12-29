# frozen_string_literal: true

describe Api::MoneyboxEntriesController do
  describe "POST #create" do
    specify  do
      expect(post: "/api/moneyboxes")
          .to route_to(controller: "api/moneybox_entries", action: "create")
    end

    subject { post :create }

    it "creates moneybox" do
      expect { subject }.to change(MoneyboxEntry, :count).by(1)
    end
  end
end
