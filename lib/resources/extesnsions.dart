extension xBool on bool?{
  int toInt (){
    if(this == null ) return 0 ;
    return this == true ? 1 :  0 ;

  }

}