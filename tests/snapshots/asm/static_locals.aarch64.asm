
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
               	adrp	x19, <page>
               	add	x19, x19, #0xe0
               	mov	x15, x19
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
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xe8
               	mov	x14, x19
               	mov	x0, #0x64               // =100
               	str	w0, [x14]
               	adrp	x19, <page>
               	add	x19, x19, #0xf0
               	mov	x13, x19
               	mov	x0, #0x0                // =0
               	str	w0, [x13]
               	b	<addr>
               	adrp	x19, <page>
               	add	x19, x19, #0xe8
               	mov	x0, x19
               	ldrsw	x14, [x0]
               	add	x14, x14, #0x1
               	sxtw	x14, w14
               	str	w14, [x0]
               	adrp	x19, <page>
               	add	x19, x19, #0xf0
               	mov	x13, x19
               	ldrsw	x14, [x13]
               	ldrsw	x12, [x0]
               	add	x14, x14, x12
               	sxtw	x14, w14
               	str	w14, [x13]
               	ldrsw	x0, [x0]
               	ldrsw	x13, [x13]
               	add	x0, x0, x13
               	sxtw	x13, w0
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	str	x19, [sp]
               	adrp	x19, <page>
               	add	x19, x19, #0xf8
               	mov	x15, x19
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
               	adrp	x19, <page>
               	add	x19, x19, #0x100
               	mov	x15, x19
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
