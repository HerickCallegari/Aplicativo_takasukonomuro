abstract class Iservices<e> {
  void Add(e objeto);
  void Update(e object);
  List<e> FindAll();
  e FindBy(e object);
}
