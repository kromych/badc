
branch_fuse_short_circuit.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<main>:
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x0, [x0]
               	cbz	x0, <addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x3, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x4, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w5, [x0]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x3, x17
               	mov	x0, #0x0                // =0
               	b.ne	<addr>
               	cmp	x1, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	cmp	x4, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	mov	w2, w5
               	cmp	x2, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	mov	x2, #0x1                // =1
               	cmp	x2, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	w3, [x3]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x2, x17
               	b.ne	<addr>
               	mov	x3, x0
               	cmp	x2, #0x64
               	b.ls	<addr>
               	mov	x0, #0x2                // =2
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	w0, [x0]
               	mov	x0, #0x0                // =0
               	mov	x2, x0
               	mov	x2, x0
               	mov	x2, #0x3                // =3
               	mov	x3, x2
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3]
               	adrp	x4, <page>
               	add	x4, x4, <lo12>
               	ldr	w4, [x4]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x3, x17
               	b.ne	<addr>
               	cmp	x1, #0x0
               	cset	x4, eq
               	cbz	x4, <addr>
               	mov	x4, x0
               	cmp	x3, #0x64
               	b.ls	<addr>
               	mov	x2, #0x2                // =2
               	cmp	x2, #0x2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x3, [x3]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x2, x17
               	b.ne	<addr>
               	cmp	x1, #0x0
               	cset	x0, eq
               	mov	x1, #0x0                // =0
               	cbz	x0, <addr>
               	cmp	x3, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, x1
               	cmp	x2, #0x64
               	b.ls	<addr>
               	mov	x0, #0x2                // =2
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	mov	x0, #0x3                // =3
               	b	<addr>
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x4, x0
               	b	<addr>
               	mov	x0, #0x3                // =3
               	b	<addr>
               	mov	x3, x0
               	b	<addr>
               	cmp	x3, #0x64
               	b.ls	<addr>
               	mov	x2, #0x2                // =2
               	b	<addr>
               	mov	x2, #0x3                // =3
               	b	<addr>
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x2, x0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
