
netinet_addr_class_macros.aarch64:	file format elf64-littleaarch64

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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	sub	x1, x29, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x2, x29, #0x30
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x2]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x2, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x2
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, x1
               	sub	x0, x29, #0x20
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, x0
               	ldrb	w1, [x2]
               	mov	x17, #0xff              // =255
               	eor	x1, x1, x17
               	mov	w1, w1
               	cbz	x1, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldrb	w1, [x0]
               	mov	x17, #0xff              // =255
               	eor	x1, x1, x17
               	mov	w1, w1
               	cbnz	x1, <addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, #0x0                // =0
               	ldr	w3, [x0]
               	cbnz	x3, <addr>
               	ldr	w3, [x0, #0x4]
               	cmp	x3, #0x0
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldr	w3, [x0, #0x8]
               	cmp	x3, #0x0
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldrb	w3, [x0, #0xc]
               	cmp	x3, #0x0
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldrb	w3, [x0, #0xd]
               	cmp	x3, #0x0
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldrb	w3, [x0, #0xe]
               	cmp	x3, #0x0
               	cset	x3, eq
               	cbz	x3, <addr>
               	ldrb	w0, [x0, #0xf]
               	mov	x17, #0x1               // =1
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbnz	x0, <addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	w0, [x2]
               	cbnz	x0, <addr>
               	ldr	w0, [x2, #0x4]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	ldr	w0, [x2, #0x8]
               	cmp	x0, #0x0
               	cset	x0, eq
               	cbz	x0, <addr>
               	sub	x0, x29, #0x30
               	ldrb	w0, [x0, #0xc]
               	cmp	x0, #0x0
               	cset	x1, eq
               	mov	x0, #0x0                // =0
               	cbz	x1, <addr>
               	sub	x1, x29, #0x30
               	ldrb	w1, [x1, #0xd]
               	cmp	x1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	sub	x1, x29, #0x30
               	ldrb	w1, [x1, #0xe]
               	cmp	x1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	sub	x1, x29, #0x30
               	ldrb	w1, [x1, #0xf]
               	mov	x17, #0x1               // =1
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, eq
               	cbz	x1, <addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x30
               	ldrb	w2, [x1]
               	mov	x17, #0xff              // =255
               	eor	x2, x2, x17
               	mov	w2, w2
               	cbnz	x2, <addr>
               	ldrb	w1, [x1, #0x1]
               	mov	x17, #0xf               // =15
               	and	x1, x1, x17
               	cmp	x1, #0x2
               	cset	x1, eq
               	cbnz	x1, <addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x1, x29, #0x10
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	mov	x2, #0x1                // =1
               	mov	x3, x2
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	mov	x3, x2
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	mov	x1, x0
               	b	<addr>
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x0, x1
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
