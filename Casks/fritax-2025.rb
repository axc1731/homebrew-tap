cask "fritax-2025" do
  # NOTE: "2025" is not a version number, but an intrinsic part of the product name
  version "25.3.26"
  sha256 "6daa1f2d1446b5d8872f8754d567e9d7d2e52146add291806023ec35a6a29929"

  # NOTE: the URL is unversioned: Ringler's dispatcher always serves the latest
  # build of FriTax 2025 (y=2026 = fiscal year + 1). Each new build changes sha256.
  url "https://webupdate.ringler.ch/VBUpdateDispatcher/KVGetInstaller?k=FR&y=2026&t=N&o=mac",
      verified: "webupdate.ringler.ch/VBUpdateDispatcher/"
  name "FriTax 2025"
  desc "Tax declaration for the canton of Fribourg for the fiscal year 2025"
  homepage "https://www.fr.ch/impots/personnes-physiques/fritax/telecharger-fritax"

  livecheck do
    url "https://mirror9.ringler.ch/VBUpdateManager/KVUpdateInfo?k=FR&y=2026&t=N&o=mac&j=true"
    strategy :xml do |xml|
      xml.get_elements("//entry[@year='2026']").map { |item| item.attributes["version"] }
    end
  end

  auto_updates true

  # install4j 10 installer. Default (vendor) installation directory is
  # "~/FriTax 2025"; tax data ("dataroot") is stored INSIDE that directory.
  installer script: {
    executable: "#{staged_path}/Installateur FriTax 2025.app/Contents/MacOS/JavaApplicationStub",
    args:       ["-q", "-dir", "#{Dir.home}/FriTax 2025"],
  }

  # The install4j uninstaller only removes the files it installed, so the
  # user's tax files in "~/FriTax 2025/dataroot" are kept.
  uninstall quit:   [
              "com.install4j.NP-FR-2025.557",
              "com.install4j.NP-FR-2025.81",
            ],
            script: {
              executable: "#{Dir.home}/FriTax 2025/FriTax 2025 désinstallateur.app/Contents/MacOS/JavaApplicationStub",
              args:       ["-q"],
            }

  # WARNING: zap deletes the user's tax declarations stored in "~/FriTax 2025/dataroot".
  zap trash: [
    "~/Desktop/FriTax 2025 de",
    "~/Desktop/FriTax 2025 fr",
    "~/FriTax 2025",
    "~/Library/Preferences/com.install4j.NP-FR-2025.*.plist",
    "~/Library/Saved Application State/com.install4j.NP-FR-2025.*.savedState",
  ]

  caveats do
    requires_rosetta
  end
end
