// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract CoffeeSupplyChain {
    // Información básica del lote
    struct Lot {
        string lotNumber;
        string producto;
        string farmerName;
        string farmLocation;
        string farmSize;
        string quantity;
        string variety;
        string altitud;
        string harvestingMethod;
        string harvestTimestamp;
        bool isActive; // Estado del lote
    }

    // Información de la cosecha
    struct Cosecha {
        string nombreCaficultor;
        string ubicacion;
        string tamanoFinca;
        string variedadesCultivadas;
        string altitudCultivo;
        string fechaCosecha;
        string metodoCosecha;
        string cantidadCosechada;
    }

    // Información de despulpado
    struct Despulpado {
        string metodoDespulpado;
        string fechaProceso;
        string cantidadPulpaRetirada;
        string destinoPulpa;
    }

    // Información de secado
    struct Secado {
        string metodoSecado;
        string humedadFinal;
        string fechaSecado;
    }

    // Información de trillado
    struct Trillado {
        string fechaTrillado;
        string cantidadTrillada;
    }

    // Información de impacto social y ambiental
    struct Impacto {
        string ayudaFamilias;
        string pagoSobrePromedio;
        string reduccionPesticidas;
        string usoComposta;
        string fechaImpacto;
    }

    // Información de fermentación
    struct Fermentacion {
        string duracionFermentacion;
        string temperaturaPromedio;
        string metodoFermentacion;
        string fechaFermentacion;
    }

    // Información de lavado
    struct Lavado {
        string volumenAguaUtilizada;
        string metodoReciclajeAgua;
        string cantidadAguaReutilizada;
        string fechaLavado;
    }

    // Información de clasificación del grano
    struct ClasificacionGrano {
        string metodoClasificacion;
        string criteriosSeleccion;
        string porcentajeImpurezas;
        string fechaClasificacion;
    }

    // Información de empaque
    struct Empaque {
        string tipoEmpaque;
        string pesoLote;
        string fechaEmpaque;
    }

    // Estructura para devolver todos los datos de un lote
    struct LotWithAllData {
        Lot lot;
        Cosecha cosecha;
        Despulpado despulpado;
        Secado secado;
        Trillado trillado;
        Impacto impacto;
        Fermentacion fermentacion;
        Lavado lavado;
        ClasificacionGrano clasificacionGrano;
        Empaque empaque;
    }

    // Mappings para almacenar los lotes y sus datos
    mapping(string => Lot) public lots;
    mapping(string => Cosecha) public cosechaData;
    mapping(string => Despulpado) public despulpadoData;
    mapping(string => Secado) public secadoData;
    mapping(string => Trillado) public trilladoData;
    mapping(string => Impacto) public impactoData;
    mapping(string => Fermentacion) public fermentacionData;
    mapping(string => Lavado) public lavadoData;
    mapping(string => ClasificacionGrano) public clasificacionGranoData;
    mapping(string => Empaque) public empaqueData;

    // Array para almacenar los IDs de los lotes
    string[] public lotIds;

    // Events
    event LotCreated(string indexed lotNumber, uint256 timestamp);
    event CosechaAdded(string indexed lotNumber, uint256 timestamp);
    event DespulpadoAdded(string indexed lotNumber, uint256 timestamp);
    event SecadoAdded(string indexed lotNumber, uint256 timestamp);
    event TrilladoAdded(string indexed lotNumber, uint256 timestamp);
    event ImpactoAdded(string indexed lotNumber, uint256 timestamp);
    event FermentacionAdded(string indexed lotNumber, uint256 timestamp);
    event LavadoAdded(string indexed lotNumber, uint256 timestamp);
    event ClasificacionGranoAdded(string indexed lotNumber, uint256 timestamp);
    event EmpaqueAdded(string indexed lotNumber, uint256 timestamp);

    // Modifiers
    modifier lotDoesNotExist(string memory lotNumber) {
        require(bytes(lots[lotNumber].lotNumber).length == 0, "Lote ya existe");
        _;
    }

    modifier lotExists(string memory lotNumber) {
        require(lots[lotNumber].isActive, "Lote no existe");
        _;
    }

    // Función para crear un nuevo lote (solo datos básicos)
    function createLot(
        string memory lotNumber,
        string memory producto,
        string memory farmerName,
        string memory farmLocation,
        string memory farmSize,
        string memory quantity,
        string memory variety,
        string memory altitud,
        string memory harvestingMethod,
        string memory harvestTimestamp
    ) public lotDoesNotExist(lotNumber) {
        // Almacenar datos básicos del lote
        lots[lotNumber] = Lot({
            lotNumber: lotNumber,
            producto: producto,
            farmerName: farmerName,
            farmLocation: farmLocation,
            farmSize: farmSize,
            quantity: quantity,
            variety: variety,
            altitud: altitud,
            harvestingMethod: harvestingMethod,
            harvestTimestamp: harvestTimestamp,
            isActive: true
        });
        // Agregar el ID del lote al array
        lotIds.push(lotNumber);
        // Emitir evento
        emit LotCreated(lotNumber, block.timestamp);
    }

    // Función para agregar datos de cosecha a un lote existente
    function addCosechaData(
        string memory lotNumber,
        string memory nombreCaficultor,
        string memory ubicacion,
        string memory tamanoFinca,
        string memory variedadesCultivadas,
        string memory altitudCultivo,
        string memory fechaCosecha,
        string memory metodoCosecha,
        string memory cantidadCosechada
    ) public lotExists(lotNumber) {
        // Almacenar datos de cosecha
        cosechaData[lotNumber] = Cosecha({
            nombreCaficultor: nombreCaficultor,
            ubicacion: ubicacion,
            tamanoFinca: tamanoFinca,
            variedadesCultivadas: variedadesCultivadas,
            altitudCultivo: altitudCultivo,
            fechaCosecha: fechaCosecha,
            metodoCosecha: metodoCosecha,
            cantidadCosechada: cantidadCosechada
        });
        // Emitir evento
        emit CosechaAdded(lotNumber, block.timestamp);
    }
    // Función para agregar datos de despulpado a un lote existente
    function addDespulpadoData(
        string memory lotNumber,
        string memory metodoDespulpado,
        string memory fechaProceso,
        string memory cantidadPulpaRetirada,
        string memory destinoPulpa
    ) public lotExists(lotNumber) {
        // Almacenar datos de despulpado
        despulpadoData[lotNumber] = Despulpado({
            metodoDespulpado: metodoDespulpado,
            fechaProceso: fechaProceso,
            cantidadPulpaRetirada: cantidadPulpaRetirada,
            destinoPulpa: destinoPulpa
        });

        // Emitir evento
        emit DespulpadoAdded(lotNumber, block.timestamp);
    }

    // Función para agregar datos de secado a un lote existente
    function addSecadoData(
        string memory lotNumber,
        string memory metodoSecado,
        string memory humedadFinal,
        string memory fechaSecado // Nuevo parámetro: fecha del secado
    ) public lotExists(lotNumber) {
        // Almacenar datos de secado
        secadoData[lotNumber] = Secado({
            metodoSecado: metodoSecado,
            humedadFinal: humedadFinal,
            fechaSecado: fechaSecado // Nuevo campo
        });

        // Emitir evento
        emit SecadoAdded(lotNumber, block.timestamp);
    }

    // Función para agregar datos de trillado a un lote existente
    function addTrilladoData(
        string memory lotNumber,
        string memory fechaTrillado,
        string memory cantidadTrillada
    ) public lotExists(lotNumber) {
        // Almacenar datos de trillado
        trilladoData[lotNumber] = Trillado({
            fechaTrillado: fechaTrillado,
            cantidadTrillada: cantidadTrillada
        });

        // Emitir evento
        emit TrilladoAdded(lotNumber, block.timestamp);
    }

    // Función para agregar datos de impacto social y ambiental a un lote existente
    function addImpactoData(
        string memory lotNumber,
        string memory ayudaFamilias,
        string memory pagoSobrePromedio,
        string memory reduccionPesticidas,
        string memory usoComposta,
        string memory fechaImpacto // Nuevo parámetro: fecha del impacto
    ) public lotExists(lotNumber) {
        // Almacenar datos de impacto
        impactoData[lotNumber] = Impacto({
            ayudaFamilias: ayudaFamilias,
            pagoSobrePromedio: pagoSobrePromedio,
            reduccionPesticidas: reduccionPesticidas,
            usoComposta: usoComposta,
            fechaImpacto: fechaImpacto // Nuevo campo
        });

        // Emitir evento
        emit ImpactoAdded(lotNumber, block.timestamp);
    }

    // Función para agregar datos de fermentación a un lote existente
    function addFermentacionData(
        string memory lotNumber,
        string memory duracionFermentacion,
        string memory temperaturaPromedio,
        string memory metodoFermentacion,
        string memory fechaFermentacion
    ) public lotExists(lotNumber) {
        // Almacenar datos de fermentación
        fermentacionData[lotNumber] = Fermentacion({
            duracionFermentacion: duracionFermentacion,
            temperaturaPromedio: temperaturaPromedio,
            metodoFermentacion: metodoFermentacion,
            fechaFermentacion: fechaFermentacion
        });
        // Emitir evento
        emit FermentacionAdded(lotNumber, block.timestamp);
    }

    // Función para agregar datos de lavado a un lote existente
    function addLavadoData(
        string memory lotNumber,
        string memory volumenAguaUtilizada,
        string memory metodoReciclajeAgua,
        string memory cantidadAguaReutilizada,
        string memory fechaLavado
    ) public lotExists(lotNumber) {
        // Almacenar datos de lavado
        lavadoData[lotNumber] = Lavado({
            volumenAguaUtilizada: volumenAguaUtilizada,
            metodoReciclajeAgua: metodoReciclajeAgua,
            cantidadAguaReutilizada: cantidadAguaReutilizada,
            fechaLavado: fechaLavado
        });
        // Emitir evento
        emit LavadoAdded(lotNumber, block.timestamp);
    }

    // Función para agregar datos de clasificación del grano a un lote existente
    function addClasificacionGranoData(
        string memory lotNumber,
        string memory metodoClasificacion,
        string memory criteriosSeleccion,
        string memory porcentajeImpurezas,
        string memory fechaClasificacion
    ) public lotExists(lotNumber) {
        // Almacenar datos de clasificación del grano
        clasificacionGranoData[lotNumber] = ClasificacionGrano({
            metodoClasificacion: metodoClasificacion,
            criteriosSeleccion: criteriosSeleccion,
            porcentajeImpurezas: porcentajeImpurezas,
            fechaClasificacion: fechaClasificacion
        });
        // Emitir evento
        emit ClasificacionGranoAdded(lotNumber, block.timestamp);
    }

    // Función para agregar datos de empaque a un lote existente
    function addEmpaqueData(
        string memory lotNumber,
        string memory tipoEmpaque,
        string memory pesoLote,
        string memory fechaEmpaque
    ) public lotExists(lotNumber) {
        // Almacenar datos de empaque
        empaqueData[lotNumber] = Empaque({
            tipoEmpaque: tipoEmpaque,
            pesoLote: pesoLote,
            fechaEmpaque: fechaEmpaque
        });
        // Emitir evento
        emit EmpaqueAdded(lotNumber, block.timestamp);
    }

    // Función para obtener todos los datos de un lote
    function getLotWithAllData(string memory lotNumber)
    public
    view
    lotExists(lotNumber)
    returns (LotWithAllData memory)
    {
        return LotWithAllData({
            lot: lots[lotNumber],
            cosecha: cosechaData[lotNumber],
            despulpado: despulpadoData[lotNumber],
            secado: secadoData[lotNumber],
            trillado: trilladoData[lotNumber],
            impacto: impactoData[lotNumber],
            fermentacion: fermentacionData[lotNumber],
            lavado: lavadoData[lotNumber],
            clasificacionGrano: clasificacionGranoData[lotNumber],
            empaque: empaqueData[lotNumber]
        });
    }

    // Obtener todos los lotes con sus datos
    function getAllLots()
    public
    view
    returns (
        Lot[] memory,
        Cosecha[] memory,
        Despulpado[] memory,
        Secado[] memory,
        Trillado[] memory,
        Impacto[] memory,
        Fermentacion[] memory,
        Lavado[] memory,
        ClasificacionGrano[] memory,
        Empaque[] memory
    )
    {
        uint256 length = lotIds.length;
        Lot[] memory allLots = new Lot[](length);
        Cosecha[] memory allCosechaData = new Cosecha[](length);
        Despulpado[] memory allDespulpadoData = new Despulpado[](length);
        Secado[] memory allSecadoData = new Secado[](length);
        Trillado[] memory allTrilladoData = new Trillado[](length);
        Impacto[] memory allImpactoData = new Impacto[](length);
        Fermentacion[] memory allFermentacionData = new Fermentacion[](length);
        Lavado[] memory allLavadoData = new Lavado[](length);
        ClasificacionGrano[] memory allClasificacionGranoData = new ClasificacionGrano[](length);
        Empaque[] memory allEmpaqueData = new Empaque[](length);

        for (uint256 i = 0; i < length; i++) {
            string memory currentLot = lotIds[i];
            allLots[i] = lots[currentLot];
            allCosechaData[i] = cosechaData[currentLot];
            allDespulpadoData[i] = despulpadoData[currentLot];
            allSecadoData[i] = secadoData[currentLot];
            allTrilladoData[i] = trilladoData[currentLot];
            allImpactoData[i] = impactoData[currentLot];
            allFermentacionData[i] = fermentacionData[currentLot];
            allLavadoData[i] = lavadoData[currentLot];
            allClasificacionGranoData[i] = clasificacionGranoData[currentLot];
            allEmpaqueData[i] = empaqueData[currentLot];
        }

        return (
            allLots,
            allCosechaData,
            allDespulpadoData,
            allSecadoData,
            allTrilladoData,
            allImpactoData,
            allFermentacionData,
            allLavadoData,
            allClasificacionGranoData,
            allEmpaqueData
        );
    }
}