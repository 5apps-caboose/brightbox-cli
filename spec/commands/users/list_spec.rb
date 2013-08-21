require "spec_helper"

describe "brightbox users" do

  describe "list" do
    let(:output) { FauxIO.new { Brightbox::run(argv) } }
    let(:stdout) { output.stdout }
    let(:stderr) { output.stderr }

    context "" do
      let(:argv) { ["users", "list"] }

      it "does not error" do
        expect { output }.to_not raise_error
      end
    end
  end
end
