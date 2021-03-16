classdef hObj < handle
   properties
      o=[];
   end
   methods
      function obj=hObj(receivedObject)
         obj.o=receivedObject;
      end
   end
end