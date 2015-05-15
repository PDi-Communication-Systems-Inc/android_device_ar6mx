#
# Copyright (C) 2008 The Android Open Source Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#      http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
# BUILD_ID is usually used to specify the branch name
# (like "MAIN") or a branch name and a release candidate
# (like "CRB01").  It must be a single word, and is
# capitalized by convention.

buildnum := $(shell date +%Y%m%d.%H%M%S)
builddtonly := $(shell date +%Y%m%d)
export BUILD_NUMBER=${buildnum}
export BUILD_DATE_ONLY=${builddtonly}

ifeq (${PDI_SOLO},T)
   export CORE_TYPE=S
else
   export CORE_TYPE=Q
endif

ifeq (${ANDROID_BUILD_MODE},user)
   $(warning Generating user build)

   ifeq (${NIH_BUILD}, T)
      export BUILD_ID=NIH${CORE_TYPE}U8-${BUILD_DATE_ONLY}
   else
      ifeq (${TVRC_BUILD}, T)
         export BUILD_ID=TVRC${CORE_TYPE}U8-${BUILD_DATE_ONLY}
      else
         ifeq (${DAVITA_BUILD}, T)
            export BUILD_ID=DVT${CORE_TYPE}U8-${BUILD_DATE_ONLY}
         else
            ifeq (${TELEHEALTH_BUILD}, T)
               export BUILD_ID=TH${CORE_TYPE}U8-${BUILD_DATE_ONLY}
            else  
	       ifeq (${OPTIMAL_BUILD}, T)
                  export BUILD_ID=OS${CORE_TYPE}U8-${BUILD_DATE_ONLY}
               else
                  ifeq (${SIMONETTO_BUILD}, T)
                     export BUILD_ID=SIM${CORE_TYPE}U8-${BUILD_DATE_ONLY}
                  else
                     export BUILD_ID=${CORE_TYPE}U8-${BUILD_DATE_ONLY}
                  endif
               endif
	    endif
         endif
      endif
   endif
else
   $(warning Generating enginnering build)

   ifeq (${NIH_BUILD}, T) 
      export BUILD_ID=NIH${CORE_TYPE}E8-${BUILD_DATE_ONLY}
   else
      ifeq (${DAVITA_BUILD}, T)
         export BUILD_ID=DVT${CORE_TYPE}E8-${BUILD_DATE_ONLY}   
      else
         ifeq (${TVRC_BUILD}, T) 
            export BUILD_ID=TVRC${CORE_TYPE}E8-${BUILD_DATE_ONLY}
         else
            ifeq (${TELEHEALTH_BUILD}, T)
               export BUILD_ID=TH${CORE_TYPE}E8-${BUILD_DATE_ONLY}
            else
               ifeq (${DAVITA_BUILD}, T)
                  export BUILD_ID=DVT${CORE_TYPE}E8-${BUILD_DATE_ONLY}
               else 
                  ifeq (${OPTIMAL_BUILD}, T)
                     export BUILD_ID=OS${CORE_TYPE}E8-${BUILD_DATE_ONLY}
                  else
                     ifeq (${SIMONETTO_BUILD}, T)
                        export BUILD_ID=SIM${CORE_TYPE}E8-${BUILD_DATE_ONLY}
                     else
                        export BUILD_ID=${CORE_TYPE}E8-${BUILD_DATE_ONLY}
                     endif
                  endif
	       endif
	    endif
         endif
      endif
   endif 
endif
$(warning the finalized build id is defined to be ${BUILD_ID})
#export BUILD_ID=1.1.0-rc4
