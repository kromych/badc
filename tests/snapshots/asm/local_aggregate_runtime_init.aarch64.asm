
local_aggregate_runtime_init.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<opaque>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	sub	x1, x29, #0x28
               	mov	x0, #0x0                // =0
               	str	x0, [x1]
               	str	x0, [x1, #0x8]
               	str	x0, [x1, #0x10]
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrsw	x1, [x20]
               	sub	x2, x29, #0x28
               	str	w1, [x2]
               	mov	x2, #0x68               // =104
               	sub	x1, x29, #0x28
               	strb	w2, [x1, #0x4]
               	mov	x2, #0x6f               // =111
               	sub	x1, x29, #0x28
               	strb	w2, [x1, #0x5]
               	mov	x2, #0x6c               // =108
               	sub	x1, x29, #0x28
               	strb	w2, [x1, #0x6]
               	mov	x2, #0x61               // =97
               	sub	x1, x29, #0x28
               	strb	w2, [x1, #0x7]
               	sub	x1, x29, #0x28
               	strb	w0, [x1, #0x8]
               	sub	x1, x29, #0x28
               	strb	w0, [x1, #0x9]
               	sub	x1, x29, #0x28
               	strb	w0, [x1, #0xa]
               	sub	x1, x29, #0x28
               	strb	w0, [x1, #0xb]
               	sub	x1, x29, #0x28
               	strb	w0, [x1, #0xc]
               	sub	x1, x29, #0x28
               	strb	w0, [x1, #0xd]
               	sub	x0, x29, #0x28
               	str	x20, [x0, #0x10]
               	sub	x0, x29, #0x28
               	bl	<addr>
               	ldrsw	x1, [x0]
               	cmp	x1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	ldrb	w1, [x0, #0x4]
               	mov	x17, #0x68              // =104
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, ne
               	mov	x2, #0x1                // =1
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0x5]
               	mov	x17, #0x6f              // =111
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x2, ne
               	mov	x1, #0x1                // =1
               	cbnz	x2, <addr>
               	ldrb	w1, [x0, #0x6]
               	mov	x17, #0x6c              // =108
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, ne
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0x7]
               	mov	x17, #0x61              // =97
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	ldrb	w1, [x0, #0x8]
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0xd]
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	ldr	x0, [x0, #0x10]
               	cmp	x0, x20
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	sub	x0, x29, #0x10
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	w1, [x0, #0x8]
               	ldrsw	x0, [x20]
               	sub	x1, x29, #0x10
               	str	w0, [x1]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldrsw	x1, [x0]
               	sub	x0, x29, #0x10
               	str	w1, [x0, #0x4]
               	mov	x1, #0x5                // =5
               	sub	x0, x29, #0x10
               	str	w1, [x0, #0x8]
               	sub	x0, x29, #0x10
               	bl	<addr>
               	mov	x1, x0
               	ldrsw	x0, [x1]
               	cmp	x0, #0x3
               	cset	x2, ne
               	mov	x0, #0x1                // =1
               	cbnz	x2, <addr>
               	ldrsw	x0, [x1, #0x4]
               	cmp	x0, #0x7
               	cset	x0, ne
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrsw	x0, [x1, #0x8]
               	cmp	x0, #0x5
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x1, [x0]
               	ldrb	w0, [x1]
               	mov	x17, #0x6f              // =111
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	ldrb	w0, [x1, #0x1]
               	mov	x17, #0x6b              // =107
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
