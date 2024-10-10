class Gor < Formula
  desc "Real-time HTTP traffic replay tool written in Go"
  homepage "https://goreplay.org"
  url "https://github.com/buger/goreplay.git",
      tag:      "1.3.3",
      revision: "f8ef77e8cf4aae59029daf6cbd2fc784af811cee"
  license "LGPL-3.0-only"
  head "https://github.com/buger/goreplay.git", branch: "master"

  livecheck do
    url :stable
    regex(/^v?(\d+(?:\.\d+)+)$/i)
  end

  bottle do
    sha256 cellar: :any_skip_relocation, arm64_sequoia:  "a8ed8382f86dda7151fc370d5dd57a6df574581dd1a8b6220ae588350d374715"
    sha256 cellar: :any_skip_relocation, arm64_sonoma:   "116b89358d585b7eece8d89c3c3d39c671c1036db379cdb775ed1f55c394174e"
    sha256 cellar: :any_skip_relocation, arm64_ventura:  "68be04c49961eaf2b9bfecd1711ee12670ca219541c9d7d0947207e6135264d7"
    sha256 cellar: :any_skip_relocation, arm64_monterey: "fe66f6fc334df036e4fe3f6cd579bc73ac6eacef6848e2c46a6e475a4874c9c2"
    sha256 cellar: :any_skip_relocation, arm64_big_sur:  "227fba89a0ef4516c6b25e9c865c60de19731213a96f6b471ea7780f7bb72485"
    sha256 cellar: :any_skip_relocation, sonoma:         "fafb32cdb0f4c995083b3a4e3e39288601b8f7f654455edf2e8d2541e3e68d6e"
    sha256 cellar: :any_skip_relocation, ventura:        "e8da9dd64c5e41f1ae20fc6b5650ccfdbbf923bb55fffdee6609b0748fa1b559"
    sha256 cellar: :any_skip_relocation, monterey:       "be4aae24b0d4f5c8e55631a5314eb0f1f08a77c404b432b7db71b7e2d5186d82"
    sha256 cellar: :any_skip_relocation, big_sur:        "6ff4869f7dcd7a5b830eb005940900360f31450d82538ff4208e6093e09840ce"
    sha256 cellar: :any_skip_relocation, catalina:       "822445285cbf26edb06857be8bdeb0c5a7f6df0c9a801316e1537fc1794becb2"
    sha256 cellar: :any_skip_relocation, mojave:         "25f3c17675fa60d8ce06a2a94c95ac5210f00e23d4dfcad6e6a98449080e2b33"
    sha256 cellar: :any_skip_relocation, x86_64_linux:   "1239ddcc67670144a35dbdf90712514bc56f52ccbc755285eef6e54ed909afb1"
  end

  depends_on "go" => :build

  uses_from_macos "netcat" => :test
  uses_from_macos "libpcap"

  def install
    system "go", "build", *std_go_args(ldflags: "-X main.VERSION=#{version}")
  end

  test do
    test_port = free_port
    fork do
      exec bin/"gor", "file-server", ":#{test_port}"
    end

    sleep 2
    system "nc", "-z", "localhost", test_port
  end
end
