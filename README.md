# [AVsitterPlus](https://avsitterplus.github.io)™

Repository for [AVsitterPlus](https://avsitterplus.github.io)&trade; - a furniture pose system for [Second Life](https://www.secondlife.com)&reg; and [OpenSim](https://en.wikipedia.org/wiki/OpenSimulator), written in [LSL](https://wiki.secondlife.com/wiki/LSL_Portal).

**NOTE:** `AVsitterPlus` is an experimental fork of `AVsitter2` with feature enhancements and bug fixes not found in `AVsitter2` as development on `AVsitter2` ceased and the latest release of `AVsitter2` was in 2018. The `AVsitter2` code repository can be found at https://github.com/AVsitter/AVsitter and the `AVsitter2` documentation at https://avsitter.github.io/

## Getting the AVsitterPlus scripts in Second Life/Opensim

1. You can manually import the AVsitterPlus scripts into Second Life / Opensim by following our [AVsitterPlus Import Guide](AVsitterPlus/IMPORT_GUIDE.md).

    *or*

2. If you would prefer a pre-packaged version of the latest release, and to receive packaged [in-world updates](https://avsitterplus.github.io/updates.html) of future releases, then visit the [SL Marketplace](https://marketplace.secondlife.com/stores/44210). Proceeds from marketplace sales are shared with open-source contributors and will help support continued development of AVsitterPlus.

## User instructions

User instructions are found at [https://avsitterplus.github.io](https://avsitterplus.github.io).

## Support guide

Support guidelines are found at [https://avsitterplus.github.io/support.html](https://avsitterplus.github.io/support.html).

## Contributor guidelines

Contributor guidelines are found at [https://avsitterplus.github.io/contribute.html](https://avsitterplus.github.io/contribute.html).

## Editing the AVsitterPlus code

You can edit any scripts, as long as you stay in compliance with the license (see below); however, in order to benefit from the extra memory that the SL Marketplace version provides, you're advised to optimize the scripts following the same method used for packaging the releases. There's a guide on how to do it here: [Release Building Guide](AVsitterPlus/BUILD_GUIDE.md)

## License

AVsitterPlus LSL scripts are licensed under the [Mozilla Public License Version 2.0](https://www.mozilla.org/en-US/MPL/2.0/).

This basically means that: _you must make the source code for any of your changes available under MPL, but you can combine the MPL code with proprietary code, as long as you keep the MPL code in separate files._

For increased script memory, scripts can be run through [LSL-PyOptimizer online](http://lsl.blacktulip-virtual.com/lsl-pyoptimizer/online.php). If you do this, please keep the [license notification](/LICENSE_script_header) intact in the header of any scripts you distribute.

## Trademarks and branding

If you distribute the scripts in this repository or a derivation, you may only use our brand as permitted. See our [Trademark Guidelines](/TRADEMARK.mediawiki) for permitted use of the AVsitterPlus&trade; brand. We also suggest [http://fossmarks.org](http://fossmarks.org) for a practical guide to understanding trademarks in the context of Free and Open Source Software.

## Maintaining branches

To keep long-lived topic branches such as `work` while ensuring that `master` mirrors the latest upstream state, you can force-reset `master` against the upstream repository without deleting other branches:

```bash
git fetch upstream
git checkout master
git reset --hard upstream/master
```

This sequence rewinds the local `master` branch to match the canonical project history while leaving other branches untouched.

---

Second Life&reg; is a trademark of Linden Research, Inc. AVsitterPlus&trade; is not affiliated with or sponsored by Linden Research.

Scripts were formatted by [LSL-PyOptimizer](http://lsl.blacktulip-virtual.com/lsl-pyoptimizer/) and created using [LSLForge](https://github.com/raysilent/lslforge). A sincere thanks goes to the creators of those projects! Many thanks go also to Philip Rosedale and all Lindens (past and present).
