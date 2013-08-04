require 'spec_helper'

describe Task do
  let(:task) { create(:task) }

  it "should not be complete" do
    task.complete?.should be_false
  end

  it "should be open" do
    task.open?.should be_true
  end

  it "should complete" do
    task.complete!
    task.complete?.should be_true
  end

  it "should uncomplete" do
    task.complete!
    task.uncomplete!
    task.complete?.should be_false
  end

  context "with prereq" do
    let(:pretask) { create(:task) }
    let(:prereq) { create(:prereq, task: task, req: pretask) }

    xit "should be closed" do
      task.closed?.should be_true
    end

    context "and prereq closes" do
      before(:each) do
        pretask.complete!
      end

      it "should be open" do
        task.status.should == :open
      end
    end
  end
end
