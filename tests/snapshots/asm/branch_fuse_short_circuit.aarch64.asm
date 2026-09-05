
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
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x3, [x2]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w4, [x2]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x1, x17
               	b.ne	<addr>
               	cmp	x0, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	cmp	x3, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	mov	w2, w4
               	cmp	w2, #0x0
               	cset	x2, eq
               	cbz	x2, <addr>
               	mov	x1, #0x1                // =1
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	w2, [x2]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x1, x17
               	b.ne	<addr>
               	mov	x2, #0x0                // =0
               	cmp	x1, #0x64
               	b.ls	<addr>
               	mov	x1, #0x2                // =2
               	cmp	x1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w1, [x1]
               	mov	x1, #0x3                // =3
               	mov	x2, x1
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	ldr	x2, [x2]
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	w3, [x3]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x2, x17
               	b.ne	<addr>
               	cmp	x0, #0x0
               	cset	x3, eq
               	cbz	x3, <addr>
               	mov	x3, #0x0                // =0
               	cmp	x2, #0x64
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
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	cmp	x3, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	mov	x0, #0x0                // =0
               	cmp	x2, #0x64
               	b.ls	<addr>
               	mov	x1, #0x2                // =2
               	cmp	x1, #0x2
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	mov	x0, #0x0                // =0
               	ret
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
               	mov	x1, #0x3                // =3
               	b	<addr>
               	cmp	x1, #0x64
               	b.ls	<addr>
               	mov	x1, #0x2                // =2
               	b	<addr>
               	mov	x1, #0x3                // =3
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
