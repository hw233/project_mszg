#include "cocos2d.h"
#include "CCEGLView.h"
#include "AppDelegate.h"
#include "CCLuaEngine.h"
#include "SimpleAudioEngine.h"
#include "Lua_extensions_CCB.h"
#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS || CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID || CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
#include "Lua_web_socket.h"
#endif
#include "ResDownload.h"

USING_NS_CC;
using namespace CocosDenshion;

#define RESOURCE_DIR			"resdir"
#define NATIVE_VERSION			"NativeVersion.txt"
#define NATIVE_FILE_LIST		"NativeFileList.txt"

AppDelegate::AppDelegate()
{
}

AppDelegate::~AppDelegate()
{
    SimpleAudioEngine::end();
}

bool AppDelegate::applicationDidFinishLaunching()
{
    // initialize director
    CCDirector *pDirector = CCDirector::sharedDirector();
    pDirector->setOpenGLView(CCEGLView::sharedOpenGLView());

    // turn on display FPS
    //pDirector->setDisplayStats(true);
	
    // set FPS. the default value is 1.0/60 if you don't call this
    pDirector->setAnimationInterval(1.0 / 60);

    // register lua engine
    CCLuaEngine* pEngine = CCLuaEngine::defaultEngine();
    CCScriptEngineManager::sharedManager()->setScriptEngine(pEngine);

    CCLuaStack *pStack = pEngine->getLuaStack();
    lua_State *tolua_s = pStack->getLuaState();

    tolua_extensions_ccb_open(tolua_s);

	lua_open_interface(tolua_s);
	lua_open_resdownload(tolua_s, RESOURCE_DIR);
	lua_open_resupdate(tolua_s, RESOURCE_DIR, NATIVE_VERSION, NATIVE_FILE_LIST);

#if (CC_TARGET_PLATFORM == CC_PLATFORM_IOS || CC_TARGET_PLATFORM == CC_PLATFORM_ANDROID || CC_TARGET_PLATFORM == CC_PLATFORM_WIN32)
    pStack = pEngine->getLuaStack();
    tolua_s = pStack->getLuaState();
    tolua_web_socket_open(tolua_s);
#endif
    
#if (CC_TARGET_PLATFORM == CC_PLATFORM_BLACKBERRY)
    CCFileUtils::sharedFileUtils()->addSearchPath("script");
#endif

	std::string path = CCFileUtils::sharedFileUtils()->fullPathForFilename("main.lua");
	pEngine->executeScriptFile(path.c_str());

    return true;
}

// This function will be called when the app is inactive. When comes a phone call,it's be invoked too
void AppDelegate::applicationDidEnterBackground()
{
    CCDirector::sharedDirector()->stopAnimation();
    //SimpleAudioEngine::sharedEngine()->pauseBackgroundMusic();
	lua_callGlobalFunc(CCLuaEngine::defaultEngine()->getLuaStack()->getLuaState(), "applicationDidEnterBackground", "");
}

// this function will be called when the app is active again
void AppDelegate::applicationWillEnterForeground()
{
    CCDirector::sharedDirector()->startAnimation();
    //SimpleAudioEngine::sharedEngine()->resumeBackgroundMusic();
	lua_callGlobalFunc(CCLuaEngine::defaultEngine()->getLuaStack()->getLuaState(), "applicationWillEnterForeground", "");
}