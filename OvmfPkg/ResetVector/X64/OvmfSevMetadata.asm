;-----------------------------------------------------------------------------
; @file
; OVMF metadata for the AMD SEV confidential computing guests
;
; Copyright (c) 2021, AMD Inc. All rights reserved.<BR>
;
; SPDX-License-Identifier: BSD-2-Clause-Patent
;-----------------------------------------------------------------------------

BITS  64

%define OVMF_SEV_METADATA_VERSION     1

; The section must be accepted or validated by the VMM before the boot
%define OVMF_SECTION_TYPE_SNP_SEC_MEM     0x1

; AMD SEV-SNP specific sections
%define OVMF_SECTION_TYPE_SNP_SECRETS     0x2

ALIGN 16

TIMES (15 - ((OvmfSevGuidedStructureEnd - OvmfSevGuidedStructureStart + 15) % 16)) DB 0

OvmfSevGuidedStructureStart:
;
; OvmfSev metadata descriptor
;
OvmfSevMetadataGuid:

_Descriptor:
  DB 'A','S','E','V'                                  ; Signature
  DD OvmfSevGuidedStructureEnd - _Descriptor          ; Length
  DD OVMF_SEV_METADATA_VERSION                        ; Version
  DD (OvmfSevGuidedStructureEnd - _Descriptor - 16) / 12 ; Number of sections

; SEV-SNP Secrets page
SevSnpSecrets:
  DD  SEV_SNP_SECRETS_BASE
  DD  SEV_SNP_SECRETS_SIZE
  DD  OVMF_SECTION_TYPE_SNP_SECRETS

OvmfSevGuidedStructureEnd:
  ALIGN   16