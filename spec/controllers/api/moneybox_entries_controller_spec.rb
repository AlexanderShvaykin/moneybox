describe Api::MoneyboxEntriesController do
  describe "POST #create" do
    specify  do
      expect(:post => "/api/moneyboxes")
          .to route_to(controller: "api/moneybox_entries", action: "create")
    end
  end
end
