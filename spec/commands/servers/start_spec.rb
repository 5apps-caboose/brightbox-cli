require "spec_helper"

describe "brightbox servers" do

  describe "start" do
    let(:output) { FauxIO.new { Brightbox::run(argv) } }
    let(:stdout) { output.stdout }
    let(:stderr) { output.stderr }

    context "" do
      let(:argv) { ["servers", "start"] }

      it "does not error" do
        expect { output }.to_not raise_error
      end
    end
  end
end
