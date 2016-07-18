function answer = plus(arg1,arg2)
% PLUS		(system) is overloaded method for the 'simrobot' class.

	
if (~isa(arg1,'simrobot') | ~isa(arg2,'simrobot'))
   error('All input variables of "simrobot" class needed')
end

answer = [arg1 arg2];


