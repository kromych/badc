
static_locals.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xd0]
               	blr	x16
               	adrp	x0, <page>
               	add	x0, x0, #0xe0
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	sxtw	x1, w1
               	str	w1, [x0]
               	ldrsw	x0, [x0]
               	ret
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, #0xe8
               	mov	x1, #0x64               // =100
               	str	w1, [x0]
               	adrp	x0, <page>
               	add	x0, x0, #0xf0
               	mov	x1, #0x0                // =0
               	str	w1, [x0]
               	b	<addr>
               	adrp	x0, <page>
               	add	x0, x0, #0xe8
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	sxtw	x1, w1
               	str	w1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, #0xf0
               	ldrsw	x2, [x1]
               	ldrsw	x3, [x0]
               	add	x2, x2, x3
               	sxtw	x2, w2
               	str	w2, [x1]
               	ldrsw	x0, [x0]
               	ldrsw	x1, [x1]
               	add	x0, x0, x1
               	sxtw	x0, w0
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0xf8
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	sxtw	x1, w1
               	str	w1, [x0]
               	ldrsw	x0, [x0]
               	ret
               	adrp	x0, <page>
               	add	x0, x0, #0x100
               	ldrsw	x1, [x0]
               	add	x1, x1, #0x1
               	sxtw	x1, w1
               	str	w1, [x0]
               	ldrsw	x0, [x0]
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0xca
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	x0, #0x131
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0xca
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x3e9
               	b.eq	<addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x3ea
               	b.eq	<addr>
               	mov	x0, #0xa                // =10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	bl	<addr>
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0xb                // =11
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
