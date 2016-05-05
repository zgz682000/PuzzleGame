

local ZBS = "/Applications/ZeroBraneStudio.app/Contents/ZeroBraneStudio/";
package.path = package.path .. ";./?.lua;"..ZBS.."lualibs/?/?.lua;"..ZBS.."lualibs/?.lua;"
require("mobdebug").start();


