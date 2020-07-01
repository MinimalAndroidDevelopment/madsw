"------------- vim-quickui settings  ------------------"
function! FormatCurrentFile()
    silent execute "!clang-format -i ". " " . expand('%:p')
    :e
endfunction
au BufEnter,BufWrite *.java call FormatCurrentFile()

let s:update = "update | w |"
let s:Domain = "com.github.linarcx.mian"
let s:AppName = "mian"
let s:MainActivity = "MainActivity"

let s:sdkPATH = "/mnt/D/software/linux/IDE/android/sdk"
let s:sdkPathToolsBin = "/tools/bin"
let s:sdkPathTools = "/tools"

call quickui#menu#clear('P&roject')
" cbry--g--vts--euip
call quickui#menu#install('P&roject', [
            \ [ '&clean', s:update.'call HTerminal(0.4, 300.0, "./scripts/clean.sh \n")' ],
            \ [ '&build', s:update.'call HTerminal(0.4, 300.0, "./scripts/build.sh \n")' ],
            \ [ 'install and &run', s:update.'call HTerminal(0.4, 300.0, "./scripts/run.sh \n")' ],
            \ [ 'generate sign ke&y', s:update.'call HTerminal(0.4, 300.0, "./scripts/generateSignedKey.sh \n")' ],
            \ [ "--", '' ],
            \ [ 'adb(lo&gcat)', s:update.'call HTerminal(0.4, 300.0, "adb logcat \n")' ],
            \ [ "--", '' ],
            \ [ 'avdmanager(list a&vd)', s:update.'call ExecCommands("Lists existing Android Virtual Devices", "!'. s:sdkPATH . s:sdkPathToolsBin .'/avdmanager list avd")' ],
            \ [ 'avdmanager(list &target)', s:update.'call ExecCommands("Lists existing targets", "!'. s:sdkPATH . s:sdkPathToolsBin .'/avdmanager list target")' ],
            \ [ 'avdmanager(li&st device)', s:update.'call ExecCommands("Lists existing devices", "!'. s:sdkPATH . s:sdkPathToolsBin .'/avdmanager list device")' ],
            \ [ "--", '' ],
            \ [ '&emulator(list avds)', s:update.'call ExecCommands("emulator", "!'. s:sdkPATH . s:sdkPathTools .'/emulator -list-avds")' ],
            \ [ 'emulator(r&un 23)', ':silent exec "!' . s:sdkPATH . s:sdkPathTools . '/emulator -avd AVD23 &\n"' ],
            \ [ 'emulator(run 22)', ':silent exec "!' . s:sdkPATH . s:sdkPathTools . '/emulator -avd AVD22 &\n"' ],
            \ [ 'emulator(run 23 in terminal)', s:update.'call HTerminal(0.4, 300.0, "' . s:sdkPATH . s:sdkPathTools . '/emulator -avd AVD23 &\n ")' ],
            \ ], 5000)
