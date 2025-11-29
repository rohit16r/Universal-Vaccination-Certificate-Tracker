
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract UniversalVaccinationCertificateTracker {

    struct Certificate {
        string citizenName;
        string vaccineName;
        uint256 doseNumber;
        uint256 dateOfVaccination;
        bool isValid;
    }

    mapping(address => Certificate[]) public certificates;
    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Only admin can perform this action");
        _;
    }

    // Add vaccination certificate
    function addCertificate(
        address citizen,
        string memory _citizenName,
        string memory _vaccineName,
        uint256 _doseNumber,
        uint256 _dateOfVaccination
    ) public onlyOwner {
        certificates[citizen].push(
            Certificate(
                _citizenName,
                _vaccineName,
                _doseNumber,
                _dateOfVaccination,
                true
            )
        );
    }

    // View certificates for any citizen
    function getCertificates(address citizen)
        public
        view
        returns (Certificate[] memory)
    {
        return certificates[citizen];
    }

    // Invalidate a certificate (fraud prevention)
    function invalidateCertificate(address citizen, uint index) public onlyOwner {
        require(index < certificates[citizen].length, "Invalid certificate index");
        certificates[citizen][index].isValid = false;
    }
}
