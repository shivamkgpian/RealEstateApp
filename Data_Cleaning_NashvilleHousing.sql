-- Checking the dataset
select *
FROM [Portfolio Project].dbo.NashvilleHousing

select SaleDateConverted
FROM [Portfolio Project].dbo.NashvilleHousing

-- Standardize Date format.

select CAST(SaleDate AS date)
FROM [Portfolio Project].dbo.NashvilleHousing

Update [Portfolio Project].dbo.NashvilleHousing
SET SaleDate = CAST(SaleDate AS date)

ALTER TABLE NashvilleHousing
Add SaleDateConverted date;

Update [Portfolio Project].dbo.NashvilleHousing
SET SaleDateConverted = CAST(SaleDate AS date)

--Checking Property Address Data 

select PropertyAddress
FROM [Portfolio Project].dbo.NashvilleHousing
WHERE PropertyAddress is null

select *
FROM [Portfolio Project].dbo.NashvilleHousing
Order by ParcelID


select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress
FROM [Portfolio Project].dbo.NashvilleHousing a
JOIN [Portfolio Project].dbo.NashvilleHousing b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress is null -- We can see that common parcelID has property address


select a.ParcelID, a.PropertyAddress, b.ParcelID, b.PropertyAddress, ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM [Portfolio Project].dbo.NashvilleHousing a
JOIN [Portfolio Project].dbo.NashvilleHousing b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress is null -- Populating Null Values by matching Property Address using ParcelID

Update a
SET PropertyAddress = ISNULL(a.PropertyAddress, b.PropertyAddress)
FROM [Portfolio Project].dbo.NashvilleHousing a
JOIN [Portfolio Project].dbo.NashvilleHousing b
ON a.ParcelID = b.ParcelID
AND a.[UniqueID ] <> b.[UniqueID ]
WHERE a.PropertyAddress is null -- Updating the table 


-- Separating Address into individual columns(address , city and state)


Select
SUBSTRING(PropertyAddress,1, CHARINDEX(',' , PropertyAddress)-1) as Address,
SUBSTRING(PropertyAddress ,CHARINDEX(',' , PropertyAddress) +1, LEN(PropertyAddress)) as City
FROM [Portfolio Project].dbo.NashvilleHousing


ALTER TABLE [Portfolio Project].dbo.NashvilleHousing
Add Address Nvarchar(255);

Update [Portfolio Project].dbo.NashvilleHousing
SET Address = SUBSTRING(PropertyAddress,1, CHARINDEX(',' , PropertyAddress)-1)


ALTER TABLE [Portfolio Project].dbo.NashvilleHousing
Add City Nvarchar(255);

Update [Portfolio Project].dbo.NashvilleHousing
SET City = SUBSTRING(PropertyAddress ,CHARINDEX(',' , PropertyAddress) +1, LEN(PropertyAddress)) 

select * 
FROM [Portfolio Project].dbo.NashvilleHousing

select
PARSENAME(REPLACE(OwnerAddress,',','.'),3),
PARSENAME(REPLACE(OwnerAddress,',','.'),2),
PARSENAME(REPLACE(OwnerAddress,',','.'),1)
FROM [Portfolio Project].dbo.NashvilleHousing -- PARSENAME and REPLACE functions are more easier to write than Substring functions.

ALTER TABLE [Portfolio Project].dbo.NashvilleHousing
Add Owner_Address Nvarchar(255);

Update [Portfolio Project].dbo.NashvilleHousing
SET Owner_Address = PARSENAME(REPLACE(OwnerAddress,',','.'),3)

ALTER TABLE [Portfolio Project].dbo.NashvilleHousing
Add Owner_City Nvarchar(255);

Update [Portfolio Project].dbo.NashvilleHousing
SET Owner_City = PARSENAME(REPLACE(OwnerAddress,',','.'),2)

ALTER TABLE [Portfolio Project].dbo.NashvilleHousing
Add Owner_State Nvarchar(255);

Update [Portfolio Project].dbo.NashvilleHousing
SET Owner_State = PARSENAME(REPLACE(OwnerAddress,',','.'),1)


--Changing Y and N to Yes and No in the "Sold as vacant" column.

select DISTINCT (SoldAsVacant) , count(SoldAsVacant)
From [Portfolio Project].dbo.NashvilleHousing
GROUP BY SoldAsVacant
ORDER BY 2

select SoldAsVacant,
CASE WHEN SoldAsVacant= 'Y' THEN 'Yes'
     WHEN SoldAsVacant= 'N' THEN 'No'
     ELSE SoldAsVacant
     END
FROM [Portfolio Project].dbo.NashvilleHousing

UPDATE [Portfolio Project].dbo.NashvilleHousing

SET SoldAsVacant= CASE WHEN SoldAsVacant= 'Y' THEN 'Yes'
                  WHEN SoldAsVacant= 'N' THEN 'No'
                  ELSE SoldAsVacant
                  END

-- Remove duplicates

With RowNumCTE AS (
select *,
ROW_NUMBER() OVER(
PARTITION BY ParcelID,
             PropertyAddress,
			 SalePrice,
			 SaleDate,
			 LegalReference
			 ORDER BY 
			 UniqueID
			 ) row_num

FROM [Portfolio Project].dbo.NashvilleHousing
)
DELETE
FROM RowNumCTE
where row_num >1


With RowNumCTE AS (
select *,
ROW_NUMBER() OVER(
PARTITION BY ParcelID,
             PropertyAddress,
			 SalePrice,
			 SaleDate,
			 LegalReference
			 ORDER BY 
			 UniqueID
			 ) row_num

FROM [Portfolio Project].dbo.NashvilleHousing
)
select *
FROM RowNumCTE
where row_num >1
ORDER BY PropertyAddress -- Checking if duplicates got deleted.

--Deleting Unused columns

ALTER TABLE [Portfolio Project].dbo.NashvilleHousing
DROP COLUMN OwnerAddress, PropertyAddress, TaxDistrict, SaleDate

select DISTINCT(LandUse),
COUNT(LandUse)
FROM [Portfolio Project].dbo.NashvilleHousing
GROUP BY LandUse
ORDER BY COUNT(LandUse) DESC

select * 
FROM [Portfolio Project].dbo.NashvilleHousing
WHERE Owner_State is null

































