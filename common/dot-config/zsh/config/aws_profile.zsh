# AWS profile selector
# This is a faster replacement for the ohmyzsh aws plugin
function asp() {
    if [[ -z "$1" ]]; then
        unset AWS_PROFILE AWS_DEFAULT_PROFILE AWS_EB_PROFILE
        echo "AWS profile unset"
    fi
    export AWS_PROFILE="$1"
    export AWS_DEFAULT_PROFILE="$1"
    export AWS_EB_PROFILE="$1"
    echo "AWS profile set to $1"
}

function asr() {
    if [[ -z "$1" ]]; then
        unset AWS_REGION AWS_DEFAULT_REGION
        echo "AWS region unset"
    fi
    export AWS_REGION="$1"
    export AWS_DEFAULT_REGION="$1"
    echo "AWS region set to $1"
}

function agp() {
    echo "AWS_PROFILE=$AWS_PROFILE"
    echo "AWS_DEFAULT_PROFILE=$AWS_DEFAULT_PROFILE"
    echo "AWS_EB_PROFILE=$AWS_EB_PROFILE"
    agr
}

function agr() {
    echo "AWS_REGION=$AWS_REGION"
    echo "AWS_DEFAULT_REGION=$AWS_DEFAULT_REGION"
}
