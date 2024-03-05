# eFactura
## Description:
- alternativa mai rapida a solutiei online: https://www.anaf.ro/uploadxml/;
- proceseaza fisierele `.zip` descarcate din contul eFactura: https://www.anaf.ro/anaf/internet/ANAF/despre_anaf/strategii_anaf/proiecte_digitalizare/e.factura;
- in urma procesarii rezulta un fisier XML, un fisier PDF si fisierul original .ZIP pentru fiecare factura (organizate in directoare);
## Instalation:
- `cd C:\ && git clone git@github.com:alexandru-mohora-rm/eFactura.git`

## Usage:
- se descarca facturile din contul ANAF eFactura: https://www.anaf.ro/anaf/internet/ANAF/despre_anaf/strategii_anaf/proiecte_digitalizare/e.factura in locatia `C:\eFactura\`;
- se executa shortcut-ul `proceseazaFacturi` pentru a porni procesarea;
- se verifica rezultatul in directorul `C:\eFactura-output`


ATENTIE!!! Acest script parseaza doar fisierele cu data modificare = ziua curenta.
