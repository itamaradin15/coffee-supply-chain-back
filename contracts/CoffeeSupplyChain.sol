// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract CoffeeSupplyChain {
    // Información principal del lote
    struct MainLotData {
        string lotNumber;
        string farmerName;
        string farmLocation;
        string farmSize;
        string quantity;
        string variety;
        string altitud;
        string harvestingMethod;
        string harvestTimestamp;
        bytes32 processDataHash;   // Hash de ProcessingData
        bytes32 sustainabilityHash; // Hash de SustainabilityData
        bool isActive; // Estado del lote
    }

    struct ReturnLotData {
        string lotNumber;
        string farmerName;
        string farmLocation;
        string farmSize;
        string quantity;
        string variety;
        string altitud;
        string harvestingMethod;
        string harvestTimestamp;
        ProcessingData processingData;
        SustainabilityData sustainabilityData;
        bytes32 processDataHash;
        bytes32 sustainabilityHash;
        bool isActive;
    }

    // Información del procesamiento
    struct ProcessingData {
        string harvestMethod;
        string harvestedQuantity;
        ProcessingDetails processing;
        QualityControl quality;
    }

    // Detalles específicos del procesamiento
    struct ProcessingDetails {
        string pulpingMethod;
        string fermentationMethod;
        string dryingMethod;
        string millingMethod;
    }

    // Control de calidad
    struct QualityControl {
        string sortingMethod;
        string selectionCriteria;
        string defectsRemoved;
        string finalMoisture;
        string packagingType;
    }

    // Datos de sostenibilidad
    struct SustainabilityData {
        string familiesBenefited;
        string biodiversityConservation;
        string cultivationTechniques;
        string waterManagement;
    }

    // Mappings principales
    mapping(string => MainLotData) public mainLotRecords;
    mapping(string => ProcessingData) private processingRecords;
    mapping(string => SustainabilityData) private sustainabilityRecords;
    
    string[] public lotIds;
    
    // Events
    event LotCreated(string indexed lot, string farmerName, uint256 timestamp);
    event LotUpdated(string indexed lot, string farmerName, uint256 timestamp);
    event LotDataUpdated(string indexed lot, uint256 timestamp);

    // Modifiers
    modifier lotDoesNotExist(string memory lot) {
        require(bytes(mainLotRecords[lot].lotNumber).length == 0, "Lote ya existe");
        _;
    }

    modifier lotExists(string memory lot) {
        require(mainLotRecords[lot].isActive, "Lote no existe");
        _;
    }

    // Función para crear un nuevo lote
    function createLot(
        string memory lot,
        string memory farmerName,
        string memory farmLocation,
        string memory farmSize,
        string memory quantity,
        string memory variety,
        string memory altitud,
        string memory harvestingMethod,
        string memory harvestTimestamp,
        ProcessingData memory processingData,
        SustainabilityData memory sustainabilityData
    ) public lotDoesNotExist(lot) {
        // Almacenar datos principales
        mainLotRecords[lot] = MainLotData({
            lotNumber: lot,
            farmerName: farmerName,
            farmLocation: farmLocation,
            farmSize: farmSize,
            quantity: quantity,
            variety: variety,
            altitud: altitud,
            harvestingMethod: harvestingMethod,
            harvestTimestamp: harvestTimestamp,
            sustainabilityHash: keccak256(abi.encode(sustainabilityData)),
            processDataHash: keccak256(abi.encode(processingData)),
            isActive: true
        });

        // Almacenar datos secundarios
        processingRecords[lot] = processingData;
        sustainabilityRecords[lot] = sustainabilityData;
        
        lotIds.push(lot);
        
        emit LotCreated(lot, farmerName, block.timestamp);
    }

// Función para actualizar los datos de procesamiento y sostenibilidad de un lote
    function updateLotData(
        string memory lot,
        ProcessingData memory newProcessingData,
        SustainabilityData memory newSustainabilityData
    ) public lotExists(lot) {
        // Verificar que el lote esté activo
        require(mainLotRecords[lot].isActive, unicode"Lote no está activo");

        // Actualizar los datos de procesamiento
        processingRecords[lot] = newProcessingData;

        // Actualizar los datos de sostenibilidad
        sustainabilityRecords[lot] = newSustainabilityData;

        // Actualizar los hashes en MainLotData
        mainLotRecords[lot].processDataHash = keccak256(abi.encode(newProcessingData));
        mainLotRecords[lot].sustainabilityHash = keccak256(abi.encode(newSustainabilityData));

        // Emitir evento de actualización
        emit LotDataUpdated(lot, block.timestamp);
    }

    // Obtener información básica del lote
    function getMainLotData(string memory lot) 
        public 
        view 
        lotExists(lot) 
        returns (MainLotData memory) 
    {
        return mainLotRecords[lot];
    }

    // Obtener información de procesamiento
    function getProcessingData(string memory lot)
        public
        view
        lotExists(lot)
        returns (ProcessingData memory)
    {
        return processingRecords[lot];
    }

    // Obtener información de sostenibilidad
    function getSustainabilityData(string memory lot)
        public
        view
        lotExists(lot)
        returns (SustainabilityData memory)
    {
        return sustainabilityRecords[lot];
    }

    // Obtener resumen de todos los lotes
    function getAllLotsInfo() public view returns (ReturnLotData[] memory) {
    uint256 length = lotIds.length;
    ReturnLotData[] memory lots = new ReturnLotData[](length);

    for (uint256 i = 0; i < length; i++) {
        string memory currentLot = lotIds[i];

        lots[i] = ReturnLotData({
            lotNumber: lotData.lotNumber,
            farmerName: lotData.farmerName,
            farmLocation: lotData.farmLocation,
            farmSize: lotData.farmSize,
            quantity: lotData.quantity,
            variety: lotData.variety,
            altitud: lotData.altitud,
            harvestingMethod: lotData.harvestingMethod,
            harvestTimestamp: lotData.harvestTimestamp,    
            isActive: lotData.isActive,
            processDataHash: lotData.processDataHash,
            sustainabilityHash: lotData.sustainabilityHash,
            processingData: processingRecords[currentLot],
            sustainabilityData: sustainabilityRecords[currentLot]
        });
    }

    return lots;
    }

    // Verificar integridad de datos
    function verifyDataIntegrity(
        string memory lot,
        ProcessingData memory processingData,
        SustainabilityData memory sustainabilityData
    ) public view lotExists(lot) returns (bool) {
        MainLotData memory mainData = mainLotRecords[lot];
        
        return mainData.processDataHash == keccak256(abi.encode(processingData)) &&
               mainData.sustainabilityHash == keccak256(abi.encode(sustainabilityData));
    }
}