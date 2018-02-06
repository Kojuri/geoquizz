<?php  
class Serie extends \Illuminate\Database\Eloquent\Model {  
  protected $table = 'serie';
  protected $primaryKey = 'id';
  public $timestamps = false;

  public function photos(){
    return $this->hasMany( 'Photo', 'serie_id');
  }
}