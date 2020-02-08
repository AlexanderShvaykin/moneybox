# frozen_string_literal: true

describe FinanceGoals::PlanedExpenses::CreateOperation do
  describe "#call" do
    subject(:run_operation) { described_class.new(params).call(repo) }

    let(:repo) { class_double(FinanceGoal, find_by: nil) }
    let(:goal) do
      instance_double(
          FinanceGoal, planed_expenses: relation, id: 1, payment_amount: 10,
          'payment_amount=' => true, save!: true
      )
    end
    let(:relation) { class_double(PlanedExpense, new: expense) }
    let(:expense) { instance_double(PlanedExpense, save!: true, amount: 100) }
    let(:params) { Hash[name: "Milk", amount: 100, finance_goal_id: goal.id] }

    before do
      allow(repo).to receive(:find_by).with(id: goal.id).and_return(goal)
    end

    it "saves expense" do
      expect(expense).to receive(:save!)
      run_operation
    end

    it "builds with params" do
      expect(relation).to receive(:new).with(Hash[name: "Milk", amount: 100])
      run_operation
    end

    it "updates goal" do
      expect(goal).to receive(:save!)
      run_operation
    end

    it "returns ok code and user" do
      expect(subject.value!).to eq [:created, expense]
    end

    context "with invalid params" do
      context "without goal id" do
        let(:params) { Hash[name: "Milk", amount: 100] }

        it "returns error and payload" do
          expect(subject.failure).to contain_exactly :not_found, instance_of(Array)
        end
      end

      %i[name amount].each do |prop|
        context "without #{prop}" do
          let(:params) do
            super().merge(prop => nil)
          end

          it "returns error and payload" do
            expect(subject.failure).to contain_exactly :bad_request, instance_of(Array)
          end
        end
      end
    end

    describe "integrations tests" do
      let_it_be(:goal, reload: true) { create :finance_goal, payment_amount: 10 }
      let(:repo) { FinanceGoal }

      it "creates planed expense" do
        expect { subject }.to change(PlanedExpense, :count).by(1)
      end

      it "updates payment_amount to goal" do
        expect { subject }.to change { goal.reload.payment_amount }.by(100)
      end

      context "when goal not saves" do
        before do
          allow(FinanceGoal).to receive(:find_by).and_return(goal)
          allow(goal).to receive(:save!) do
            raise "Invalid Record"
          end
        end

        it "not changes count and goal amount" do
          expect { subject }.to not_change(PlanedExpense, :count)
            .and not_change { goal.reload.payment_amount }
            .and raise_error
        end
      end
    end
  end
end
