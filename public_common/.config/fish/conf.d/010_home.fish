if test -d /opt/android-sdk
    set -gx ANDROID_HOME /opt/android-sdk
end 

if test -d /usr/lib/jvm
    set -gx JAVA_HOME /usr/lib/jvm/java-8-openjdk
end

if which go > /dev/null >&1
    set -gx GOPATH $HOME/go
end

if which ruby > /dev/null 2>&1
    set -gx GEM_HOME $HOME/.gem/ruby/2.6.0
    set -gx GEM_PATH $GEM_HOME $GEM_PATH
end
