POWERLEVEL9K_SHORTEN_DIR_LENGTH=1
## POWERLEVEL9K SETTINGS ##
POWERLEVEL9K_STATUS_VERBOSE=false
POWERLEVEL9K_STATUS_OK_IN_NON_VERBOSE=true
#POWERLEVEL9K_PROMPT_ON_NEWLINE=true
POWERLEVEL9K_SHORTEN_DIR_LENGTH=2
POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(os_icon user dir vcs newline time)
POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(status history ip disk_usage background_jobs load battery)

# coloring powerlevel9k

# os_icon color
POWERLEVEL9K_OS_ICON_BACKGROUND='000'
POWERLEVEL9K_OS_ICON_FOREGROUND='015'

# user color
POWERLEVEL9K_USER_DEFAULT_BACKGROUND='045'
POWERLEVEL9K_USER_DEFAULT_FOREGROUND='000'

# dir color
POWERLEVEL9K_DIR_HOME_BACKGROUND='117'
POWERLEVEL9K_DIR_HOME_FOREGROUND='000'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_BACKGROUND='123'
POWERLEVEL9K_DIR_HOME_SUBFOLDER_FOREGROUND='000'
POWERLEVEL9K_DIR_HOME_DEFAULT_BACKGROUND='063'
POWERLEVEL9K_DIR_HOME_DEFAULT_FOREGROUND='000'
POWERLEVEL9K_DIR_HOME_ETC_BACKGROUND='063'
POWERLEVEL9K_DIR_HOME_ETC_FOREGROUND='000'

# Advanced `vcs` color customization
# POWERLEVEL9K_VCS_CLEAN_FOREGROUND='blue'
# POWERLEVEL9K_VCS_CLEAN_BACKGROUND='black'
# POWERLEVEL9K_VCS_UNTRACKED_FOREGROUND='yellow'
# POWERLEVEL9K_VCS_UNTRACKED_BACKGROUND='black'
# POWERLEVEL9K_VCS_MODIFIED_FOREGROUND='red'
# POWERLEVEL9K_VCS_MODIFIED_BACKGROUND='black'

# time color
POWERLEVEL9K_TIME_BACKGROUND='010'
POWERLEVEL9K_TIME_FOREGROUND='000'

# status color
# POWERLEVEL9K_STATUS_ERROR_BACKGROUND='000'
# POWERLEVEL9K_STATUS_ERROR_FOREGROUND='247'
# POWERLEVEL9K_STATUS_OK_BACKGROUND='000'
# POWERLEVEL9K_STATUS_OK_FOREGROUND='247'

# # ip color
# POWERLEVEL9K_IP_BACKGROUND='000'
# POWERLEVEL9K_IP_FOREGROUND='247'

# # disk_usage color
# POWERLEVEL9K_DISK_USAGE_NORMAL_BACKGROUND='000'
# POWERLEVEL9K_DISK_USAGE_NORMAL_FOREGROUND='247'
# POWERLEVEL9K_DISK_USAGE_WARNING_BACKGROUND='000'
# POWERLEVEL9K_DISK_USAGE_WARNING_FOREGROUND='247'
# POWERLEVEL9K_DISK_USAGE_CRITICAL_BACKGROUND='000'
# POWERLEVEL9K_DISK_USAGE_CRITICAL_FOREGROUND='247'

# # background_jobs color
# POWERLEVEL9K_HISTORY_BACKGROUND='000'
# POWERLEVEL9K_HISTORY_FOREGROUND='247'

# # load color
# POWERLEVEL9K_LOAD_NORMAL_BACKGROUND='000'
# POWERLEVEL9K_LOAD_NORMAL_FOREGROUND='247'
# POWERLEVEL9K_LOAD_WARNING_BACKGROUND='000'
# POWERLEVEL9K_LOAD_WARNING_FOREGROUND='247'
# POWERLEVEL9K_LOAD_CRITICAL_BACKGROUND='000'
# POWERLEVEL9K_LOAD_CRITICAL_FOREGROUND='247'

# battery color
POWERLEVEL9K_BATTERY_DISCONNECTED_FOREGROUND='black'
POWERLEVEL9K_BATTERY_STAGES=($'\uf244 ' $'\uf243 ' $'\uf242 ' $'\uf241 ' $'\uf240 ')
POWERLEVEL9K_BATTERY_LEVEL_BACKGROUND=(red1 orangered1 darkorange orange1 gold1 yellow1 yellow2 greenyellow chartreuse1 chartreuse2 green1)

