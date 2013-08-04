require 'spec_helper'

describe User do
  let(:user) { create(:user) }
  let(:company) { create(:company) }
  let(:project) { create(:project) }

  context "without a company" do
    it "returns a default string when the user has no company" do
      user.current_company_name.should_not be_nil
    end

    it "returns a personal project" do
      user.projects.first.should be_an_instance_of(Project)
    end

    it "returns an array of blank tasks" do
      user.personal_tasks.should be_blank
    end

    context "with tasks" do
      let(:task) { create(:task) }

      before(:each) do
        user.tasks << task
      end

      it "returns 1 task in the personal project" do
        user.projects.first.tasks.should include(task)
      end

      it "return 1 task in personal tasks" do
        user.personal_tasks.should include(task)
      end
    end
  end

  context "with a company" do
    before(:each) do
      user.company = company
    end

    it "returns the name of the current company" do
      user.current_company_name.should eq company.name
    end

    context "with a project" do
      let(:project) { create(:project, company: company) }

      it "returns the poject" do
        user.projects.should include(project)
      end

      context "with a task" do
        let(:task) { create(:task, project: project, user: user) }

        it "returns no personal tasks" do
          user.tasks.should be_empty
        end
      end
    end
  end
end
