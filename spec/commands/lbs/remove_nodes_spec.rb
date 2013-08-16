require "spec_helper"

describe "brightbox lbs" do

  describe "remove_nodes" do
    let(:output) { FauxIO.new { Brightbox::run(argv) } }
    let(:stdout) { output.stdout }
    let(:stderr) { output.stderr }

    context "" do
      let(:argv) { ["lbs", "remove_nodes"] }

      it "does not error" do
        expect { output }.to_not raise_error
      end
    end
  end
end