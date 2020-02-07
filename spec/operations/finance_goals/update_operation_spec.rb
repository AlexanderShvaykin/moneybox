# frozen_string_literal: true

describe FinanceGoals::UpdateOperation do
  describe "#call" do
    subject { described_class.new(id: id, **params).call(repo) }

    let(:started_at) { "2015-01-01" }
    let(:finished_at) { "2015-02-01" }
    let(:params) do
      {
          payment_amount: 100,
          income_amount: 100,
          started_at: started_at,
          finished_at: finished_at
      }
    end
    let(:id) { 10 }
    let(:repo) { class_double(FinanceGoal) }
    let(:goal) { instance_double(FinanceGoal, update!: true) }
    let(:form) { instance_double(FinanceGoalForm, save: true, goal: goal) }

    before do
      allow(repo).to receive(:find_by).with(id: id).and_return(goal)
      allow(FinanceGoalForm).to receive(:new).with(
        goal: goal, payment_amount: 100, income_amount: 100,
        started_at: Date.parse(started_at), finished_at: Date.parse(finished_at)
      ).and_return(form)
    end

    it_behaves_like "calls find_operation"

    it "calls form" do
      expect(form).to receive(:save)
      subject
    end

    context "with invalid params" do
      let(:params) do
        { finished_at: finished_at }
      end

      it "returns error and payload" do
        expect(subject.failure).to contain_exactly :bad_request, instance_of(Array)
      end
    end

    context "with invalid form" do
      let(:form) { instance_double(FinanceGoalForm, save: false, serialized_errors: []) }


      it "returns error and payload" do
        expect(subject.failure).to contain_exactly :unprocessable_entity, instance_of(Array)
      end
    end
  end
end
