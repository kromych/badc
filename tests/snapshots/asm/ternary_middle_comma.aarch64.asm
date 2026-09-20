
ternary_middle_comma.aarch64:	file format elf64-littleaarch64

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

<rt>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x30]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x21, #0x0               // =0
               	mov	x0, #0x2a               // =42
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0x80
               	b.hs	<addr>
               	and	x21, x20, #0xff
               	mov	x1, #0x1                // =1
               	cmp	w1, #0x1
               	b.ne	<addr>
               	mov	x17, #0x2a              // =42
               	eor	x0, x21, x17
               	cbz	w0, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, x21
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	cmp	w20, #0x80
               	b.hs	<addr>
               	and	x2, x20, #0xff
               	mov	x1, #0x1                // =1
               	cmp	w1, #0x1
               	b.ne	<addr>
               	mov	x17, #0x2a              // =42
               	eor	x3, x2, x17
               	cbz	w3, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	cmp	w20, #0x80
               	b.hs	<addr>
               	and	x2, x20, #0xff
               	mov	x1, #0x1                // =1
               	cmp	w1, #0x1
               	b.ne	<addr>
               	mov	x17, #0x2a              // =42
               	eor	x3, x2, x17
               	cbz	w3, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	bl	<addr>
               	mov	x22, x0
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0x0                // =0
               	bl	<addr>
               	cmp	w20, #0x0
               	b.le	<addr>
               	mov	x22, #0x1               // =1
               	mov	x21, #0x2               // =2
               	mov	x0, #0x3                // =3
               	mov	x1, #0x6                // =6
               	cmp	w1, #0x6
               	b.ne	<addr>
               	cmp	w22, #0x1
               	b.ne	<addr>
               	cmp	w21, #0x2
               	b.ne	<addr>
               	cmp	w0, #0x3
               	b.eq	<addr>
               	adrp	x5, <page>
               	add	x5, x5, <lo12>
               	sxtw	x2, w22
               	sxtw	x3, w21
               	sxtw	x4, w0
               	mov	x0, x5
               	bl	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x20, #0x0               // =0
               	mov	x0, #0xc8               // =200
               	bl	<addr>
               	cmp	w0, #0x80
               	b.hs	<addr>
               	and	x20, x0, #0xff
               	mov	x1, #0x1                // =1
               	cmp	w1, #0x63
               	b.ne	<addr>
               	cbz	w20, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x2, x20
               	bl	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret
               	mov	x1, #0x63               // =99
               	b	<addr>
               	mov	x1, #-0x1               // =-1
               	b	<addr>
               	mov	x1, #0x63               // =99
               	mov	x2, x0
               	b	<addr>
               	mov	x1, #0x63               // =99
               	mov	x2, x0
               	b	<addr>
               	mov	x1, #0x63               // =99
               	b	<addr>
