
wmem_functions.aarch64:	file format elf64-littleaarch64

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
               	str	x20, [sp, #-0x70]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x60]
               	add	x29, sp, #0x60
               	sub	x0, x29, #0x30
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldrb	w10, [x1, #0x10]
               	strb	w10, [x0, #0x10]
               	ldrb	w10, [x1, #0x11]
               	strb	w10, [x0, #0x11]
               	ldrb	w10, [x1, #0x12]
               	strb	w10, [x0, #0x12]
               	ldrb	w10, [x1, #0x13]
               	strb	w10, [x0, #0x13]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	mov	x1, #0x1e               // =30
               	mov	x2, #0x5                // =5
               	bl	<addr>
               	mov	x1, x0
               	sub	x0, x29, #0x30
               	add	x2, x0, #0x8
               	cmp	x1, x2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x70
               	ret
               	mov	x1, #0x63               // =99
               	mov	x2, #0x5                // =5
               	bl	<addr>
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x70
               	ret
               	sub	x0, x29, #0x18
               	sub	x1, x29, #0x30
               	mov	x20, #0x5               // =5
               	mov	x2, x20
               	bl	<addr>
               	sub	x0, x29, #0x18
               	sub	x1, x29, #0x30
               	mov	x2, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x70
               	ret
               	sub	x0, x29, #0x18
               	mov	x1, #0x7                // =7
               	mov	x2, #0x3                // =3
               	bl	<addr>
               	sub	x0, x29, #0x18
               	ldr	w1, [x0]
               	mov	x17, #0x7               // =7
               	eor	x1, x1, x17
               	mov	w2, w1
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	ldr	w2, [x0, #0x4]
               	mov	x17, #0x7               // =7
               	eor	x2, x2, x17
               	mov	w2, w2
               	cmp	w2, #0x0
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldr	w1, [x0, #0x8]
               	mov	x17, #0x7               // =7
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	w1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldr	w1, [x0, #0xc]
               	mov	x17, #0x28              // =40
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	w1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x70
               	ret
               	add	x1, x0, #0x4
               	mov	x2, #0x3                // =3
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sub	x1, x29, #0x18
               	ldr	w0, [x1, #0x4]
               	mov	x17, #0x7               // =7
               	eor	x0, x0, x17
               	mov	w2, w0
               	mov	x0, #0x1                // =1
               	cbnz	x2, <addr>
               	ldr	w0, [x1, #0x8]
               	mov	x17, #0x7               // =7
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldr	w0, [x1, #0xc]
               	mov	x17, #0x7               // =7
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x70
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x60]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x70
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x2, x1
               	b	<addr>
