

select Saledateconverted, convert (date,saledate)
from Nashvillehousing

update Nashvillehousing
set SaleDate = convert(date,saledate)
 
 alter table Nashvillehousing
 add saledateconverted date;
select *
from Nashvillehousing

 update Nashvillehousing
set saledateconverted = convert(date,saledate)

select *
from Nashvillehousing
--where PropertyAddress is null  
order by ParcelID


select a. ParcelID, a.PropertyAddress,b.ParcelID,b.PropertyAddress, isnull(a. propertyaddress, b.PropertyAddress)
from Nashvillehousing a
join Nashvillehousing b
	on a. ParcelID = b. ParcelID
	and a. [UniqueID ] <> b. [UniqueID ]
where a. PropertyAddress is null

update a
SET PropertyAddress = isnull(a. propertyaddress, b.PropertyAddress)
from Nashvillehousing a
join Nashvillehousing b
	on a. ParcelID = b. ParcelID
	and a. [UniqueID ] <> b. [UniqueID ]
where a. PropertyAddress is null


select PropertyAddress
from Nashvillehousing
--where PropertyAddress is null  
--order by ParcelID

select
SUBSTRING(PropertyAddress, 1, charindex(',', PropertyAddress) -1) as address
, SUBSTRING(PropertyAddress, charindex(',', PropertyAddress) +1 ,len (propertyaddress)) as address
from Nashvillehousing

alter table Nashvillehousing
add propertysplitaddress nvarchar (255);

update NashvilleHousing
set propertysplitaddress = SUBSTRING(PropertyAddress, 1, charindex(',', PropertyAddress) -1)


alter table Nashvillehousing
add propertysplitcity nvarchar (255);

update NashvilleHousing
set propertysplitcity = SUBSTRING(PropertyAddress, charindex(',', PropertyAddress) +1 ,len (propertyaddress)) 


select *
from NashvilleHousing


select OwnerAddress
from NashvilleHousing

select 
PARSENAME(replace(OwnerAddress, ',', '.'),3)
,PARSENAME(replace(OwnerAddress, ',', '.'),2)
,PARSENAME(replace(OwnerAddress, ',', '.'),1)
from NashvilleHousing






alter table Nashvillehousing
add ownersplitaddress nvarchar (255);

update NashvilleHousing
set ownersplitaddress =PARSENAME(replace(OwnerAddress, ',', '.'),3)


alter table Nashvillehousing
add ownersplitcity nvarchar (255);

update NashvilleHousing
set ownersplitcity = PARSENAME(replace(OwnerAddress, ',', '.'),2) 

alter table Nashvillehousing
add ownersplitstate nvarchar (255);

update NashvilleHousing
set ownersplitstate = PARSENAME(replace(OwnerAddress, ',', '.'),1)

select ownersplitaddress, ownersplitcity, ownersplitstate
from NashvilleHousing

select distinct (SoldAsVacant), count(SoldAsVacant)
from NashvilleHousing
group by SoldAsVacant
order by 2


select SoldAsVacant
,	case when SoldAsVacant = 'Y' then 'Yes'
		 when SoldAsVacant = 'N' then 'No'
		 ELSE SoldAsVacant
		 END
from NashvilleHousing 


update  NashvilleHousing 
set SoldAsVacant = case when SoldAsVacant = 'Y' then 'Yes'
		 when SoldAsVacant = 'N' then 'No'
		 ELSE SoldAsVacant
		 END


WITH RowNumCTE AS(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num
from NashvilleHousing
--order by ParcelID
)
select *
from RowNumCTE
where row_num > 1
--order by PropertyAddress


select *
from NashvilleHousing




--Select *
--From NashvilleHousing


--ALTER TABLE PortfolioProject.dbo.NashvilleHousing
--DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate



