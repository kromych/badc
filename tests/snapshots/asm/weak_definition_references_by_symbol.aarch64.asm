
weak_definition_references_by_symbol.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<wf>:
               	mov	x0, #0x7                // =7
               	ret

<get_f>:
               	adrp	x0, <addr>
		R_AARCH64_ADR_GOT_PAGE	wf
               	ldr	x0, [x0]
		R_AARCH64_LD64_GOT_LO12_NC	wf
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	adrp	x0, <addr>
		R_AARCH64_ADR_GOT_PAGE	wobj
               	ldr	x0, [x0]
		R_AARCH64_LD64_GOT_LO12_NC	wobj
               	ldr	x0, [x0]
               	adrp	x1, <addr>
		R_AARCH64_ADR_PREL_PG_HI21	.data+0x20
               	ldr	x1, [x1]
		R_AARCH64_LDST64_ABS_LO12_NC	.data+0x20
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <addr>
		R_AARCH64_ADR_GOT_PAGE	ws
               	ldr	x0, [x0]
		R_AARCH64_LD64_GOT_LO12_NC	ws
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <addr>
		R_AARCH64_ADR_PREL_PG_HI21	.data+0x28
               	ldr	x0, [x0]
		R_AARCH64_LDST64_ABS_LO12_NC	.data+0x28
               	blr	x0
               	str	x0, [sp, #0x8]
               	bl	<addr>
		R_AARCH64_CALL26	wf
               	ldr	x16, [sp, #0x8]
               	add	x0, x16, x0
               	cmp	x0, #0xe
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
