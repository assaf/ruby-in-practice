require 'osx/cocoa'
dnc =  OSX::NSDistributedNotificationCenter.defaultCenter
dnc.postNotificationName_object_userInfo_deliverImmediately(
  :GrowlApplicationRegistrationNotification, nil,
  { :ApplicationName=>'TODO/FIXME', :AllNotifications=>['Completed'] },
  true)
dnc.postNotificationName_object_userInfo_deliverImmediately(
  :GrowlNotification, nil,
  { :ApplicationName=>'TODO/FIXME', :NotificationName=>'Completed',
    :NotificationTitle=>'TODO/FIXME comments added to iCal' }, true)

