
struct_value_basics.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x15, x29, #0x8
               	mov	x14, #0x3               // =3
               	str	w14, [x15]
               	sub	x13, x29, #0x8
               	add	x13, x13, #0x4
               	mov	x14, #0x4               // =4
               	str	w14, [x13]
               	sub	x15, x29, #0x8
               	ldrsw	x15, [x15]
               	cmp	x15, #0x3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x8
               	add	x15, x15, #0x4
               	ldrsw	x15, [x15]
               	cmp	x15, #0x4
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x15, x29, #0x8
               	ldrsw	x0, [x15]
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x13, #0x3               // =3
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x0, x15, #0x4
               	ldrsw	x0, [x0]
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x13, #0x4               // =4
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1e               // =30
               	str	w0, [x15]
               	add	x15, x15, #0x4
               	mov	x13, #0x28              // =40
               	str	w13, [x15]
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1e
               	b.eq	<addr>
               	mov	x13, #0x5               // =5
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	add	x0, x0, #0x4
               	ldrsw	x0, [x0]
               	cmp	x0, #0x28
               	b.eq	<addr>
               	mov	x13, #0x6               // =6
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	mov	x13, #0x64              // =100
               	str	w13, [x0]
               	sub	x15, x29, #0x10
               	add	x15, x15, #0x4
               	mov	x13, #0xc8              // =200
               	str	w13, [x15]
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0]
               	cmp	x0, #0x1e
               	b.eq	<addr>
               	mov	x13, #0x7               // =7
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0]
               	cmp	x0, #0x64
               	b.eq	<addr>
               	mov	x13, #0x8               // =8
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0]
               	sub	x13, x29, #0x8
               	add	x13, x13, #0x4
               	ldrsw	x13, [x13]
               	add	x0, x0, x13
               	sxtw	x0, w0
               	sub	x13, x29, #0x10
               	ldrsw	x13, [x13]
               	add	x0, x0, x13
               	sxtw	x0, w0
               	sub	x13, x29, #0x10
               	add	x13, x13, #0x4
               	ldrsw	x13, [x13]
               	add	x0, x0, x13
               	sxtw	x0, w0
               	sxtw	x0, w0
               	cmp	x0, #0x172
               	b.eq	<addr>
               	mov	x13, #0x9               // =9
               	mov	x0, x13
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
