#include <unistd.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdbool.h>
#include <fcntl.h>
#include "libNMD.h"

static inline bool is_mountpaths_detected();
static inline bool is_supath_detected();

static const char *TAG = "DetectMagiskNative";

static char *blacklistedMountPaths[] = {
        "/sbin/.magisk/",
        "/sbin/.core/mirror",
        "/sbin/.core/img",
        "/sbin/.core/db-0/magisk.db"
};

static const char *suPaths[] = {
        "/data/local/su",
        "/data/local/bin/su",
        "/data/local/xbin/su",
        "/sbin/su",
        "/su/bin/su",
        "/system/bin/su",
        "/system/bin/.ext/su",
        "/system/bin/failsafe/su",
        "/system/sd/xbin/su",
        "/system/usr/we-need-root/su",
        "/system/xbin/su",
        "/cache/su",
        "/data/su",
        "/dev/su"
};

__attribute__((visibility("default"))) __attribute__((used))
int isMagiskPresentNative() {
    bool bRet = false;
    do {
        bRet = is_supath_detected();
        if (bRet)
            break;
        bRet = is_mountpaths_detected();
        if (bRet)
            break;
    } while (false);

    if(bRet)
        return 1;
    else
        return 0;
}

__attribute__((always_inline))
static inline bool is_mountpaths_detected() {
    int len = sizeof(blacklistedMountPaths) / sizeof(blacklistedMountPaths[0]);

    bool bRet = false;

    FILE *fp = fopen("/proc/self/mounts", "r");
    if (fp == NULL)
        goto exit;

    fseek(fp, 0L, SEEK_END);
    long size = ftell(fp);
    /* For some reason size comes as zero */
    if (size == 0)
        size = 20000;  /*This will differ for different devices */
    char *buffer = malloc(size * sizeof(char));
    if (buffer == NULL)
        goto exit;

    size_t read = fread(buffer, 1, size, fp);
    int count = 0;
    for (int i = 0; i < len; i++) {
        char *rem = strstr(buffer, blacklistedMountPaths[i]);
        if (rem != NULL) {
            count++;
            break;
        }
    }
    if (count > 0)
        bRet = true;

    exit:

    if (buffer != NULL)
        free(buffer);
    if (fp != NULL)
        fclose(fp);

    return bRet;
}


__attribute__((always_inline))
static inline bool is_supath_detected() {
    int len = sizeof(suPaths) / sizeof(suPaths[0]);

    bool bRet = false;
    for (int i = 0; i < len; i++) {
        if (open(suPaths[i], O_RDONLY) >= 0) {
            bRet = true;
            break;
        }
        if (0 == access(suPaths[i], R_OK)) {
            bRet = true;
            break;
        }
    }

    return bRet;
}