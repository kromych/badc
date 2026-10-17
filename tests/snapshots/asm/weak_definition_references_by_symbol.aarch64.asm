
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
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <addr>
		R_AARCH64_ADR_GOT_PAGE	wobj
               	ldr	x0, [x0]
		R_AARCH64_LD64_GOT_LO12_NC	wobj
               	ldr	x0, [x0]
               	adrp	x1, <addr>
		R_AARCH64_ADR_PREL_PG_HI21	.data+0x20
               	add	x1, x1, #0x0
		R_AARCH64_ADD_ABS_LO12_NC	.data+0x20
               	ldr	x1, [x1]
               	ldr	x1, [x1]
               	add	x0, x0, x1
               	cmp	x0, #0xa
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <addr>
		R_AARCH64_ADR_GOT_PAGE	ws
               	ldr	x0, [x0]
		R_AARCH64_LD64_GOT_LO12_NC	ws
               	add	x1, x0, #0x10
               	cmp	x1, x1
               	b.ne	<addr>
               	ldr	x0, [x0, #0x8]
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	adrp	x0, <addr>
		R_AARCH64_ADR_PREL_PG_HI21	.data+0x28
               	add	x0, x0, #0x0
		R_AARCH64_ADD_ABS_LO12_NC	.data+0x28
               	ldr	x0, [x0]
               	blr	x0
               	mov	x20, x0
               	bl	<addr>
		R_AARCH64_CALL26	wf
               	add	x0, x20, x0
               	cmp	x0, #0xe
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
