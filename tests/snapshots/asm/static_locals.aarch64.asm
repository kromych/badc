
static_locals.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	adrp	x15, <page>
               	add	x15, x15, #0xe0
               	ldrsw	x14, [x15]
               	add	x14, x14, #0x1
               	sxtw	x14, w14
               	str	w14, [x15]
               	ldrsw	x0, [x15]
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	sxtw	x15, w0
               	cbz	x15, <addr>
               	adrp	x14, <page>
               	add	x14, x14, #0xe8
               	mov	x15, #0x64              // =100
               	str	w15, [x14]
               	adrp	x13, <page>
               	add	x13, x13, #0xf0
               	mov	x15, #0x0               // =0
               	str	w15, [x13]
               	b	<addr>
               	adrp	x15, <page>
               	add	x15, x15, #0xe8
               	ldrsw	x14, [x15]
               	add	x14, x14, #0x1
               	sxtw	x14, w14
               	str	w14, [x15]
               	adrp	x13, <page>
               	add	x13, x13, #0xf0
               	ldrsw	x14, [x13]
               	ldrsw	x12, [x15]
               	add	x14, x14, x12
               	sxtw	x14, w14
               	str	w14, [x13]
               	ldrsw	x15, [x15]
               	ldrsw	x13, [x13]
               	add	x15, x15, x13
               	sxtw	x0, w15
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	adrp	x15, <page>
               	add	x15, x15, #0xf8
               	ldrsw	x14, [x15]
               	add	x14, x14, #0x1
               	sxtw	x14, w14
               	str	w14, [x15]
               	ldrsw	x0, [x15]
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	adrp	x15, <page>
               	add	x15, x15, #0x100
               	ldrsw	x14, [x15]
               	add	x14, x14, #0x1
               	sxtw	x14, w14
               	str	w14, [x15]
               	ldrsw	x0, [x15]
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x14, #0x1               // =1
               	mov	x0, x14
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x14, #0x3               // =3
               	mov	x0, x14
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x14, x0
               	cmp	x14, #0xca
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	bl	<addr>
               	cmp	x0, #0x131
               	b.eq	<addr>
               	mov	x14, #0x5               // =5
               	mov	x0, x14
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x14, x0
               	cmp	x14, #0xca
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	mov	x14, x0
               	cmp	x14, #0x1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	mov	x14, x0
               	cmp	x14, #0x2
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	mov	x14, x0
               	cmp	x14, #0x3e9
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	mov	x14, x0
               	cmp	x14, #0x3ea
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	mov	x14, x0
               	cmp	x14, #0x3
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x0               // =0
               	mov	x0, x14
               	ldp	x29, x30, [sp], #0x10
               	ret
