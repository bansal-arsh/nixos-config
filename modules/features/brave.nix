{...}: {
  flake.modules.nixos.brave = {pkgs, ...}: {
    environment.systemPackages = [pkgs.brave];

    environment.etc."brave/policies/managed/config.json".text = builtins.toJSON {
      # Debloating
      BraveRewardsDisabled = true;
      BraveWalletDisabled = true;
      BraveVPNDisabled = true;
      BraveAIChatEnabled = false;
      BraveNewsDisabled = true;
      BraveTalkDisabled = true;
      SyncDisabled = true;

      # Telemetry
      BraveP3AEnabled = false;
      BraveStatsPingEnabled = false;
      BraveWebDiscoveryEnabled = false;
      MetricsReportingEnabled = false;

      DnsOverHttpsMode = "automatic";

      # Security
      PasswordManagerEnabled = false;
      AutofillAddressEnabled = false;
      AutofillCreditCardEnabled = false;

      # Configuration
      PromptForDownloadLocation = true;
    };
  };
}
