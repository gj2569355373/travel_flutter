/*
 * create by gj
 * Created in 2020/12/9 5:43 下午
 * description: StateBase 核心状态类，具体各局部刷新子状态均为StateBase的子类
 * */
abstract class StateBase {
}

class HttpState extends StateBase{//扩展用于控制网络指示器开关的state
  final bool httpB;
  HttpState(this.httpB);
}
class CountDownState extends StateBase{//扩展用于控制验证码计时器
  final int time;
  CountDownState(this.time);
}

