
local_aggregate_runtime_init.aarch64:	file format elf64-littleaarch64

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
               	stp	x20, x21, [sp, #-0x60]!
               	str	x22, [sp, #0x10]
               	stp	x29, x30, [sp, #0x50]
               	add	x29, sp, #0x50
               	sub	x0, x29, #0x28
               	mov	x20, #0x0               // =0
               	str	x20, [x0]
               	str	x20, [x0, #0x8]
               	str	x20, [x0, #0x10]
               	adrp	x22, <page>
               	add	x22, x22, <lo12>
               	ldrsw	x1, [x22]
               	str	w1, [x0]
               	mov	x1, #0x68               // =104
               	strb	w1, [x0, #0x4]
               	mov	x1, #0x6f               // =111
               	strb	w1, [x0, #0x5]
               	mov	x1, #0x6c               // =108
               	strb	w1, [x0, #0x6]
               	mov	x1, #0x61               // =97
               	strb	w1, [x0, #0x7]
               	strb	w20, [x0, #0x8]
               	strb	w20, [x0, #0x9]
               	strb	w20, [x0, #0xa]
               	strb	w20, [x0, #0xb]
               	strb	w20, [x0, #0xc]
               	strb	w20, [x0, #0xd]
               	str	x22, [x0, #0x10]
               	bl	<addr>
               	ldrsw	x1, [x0]
               	cmp	x1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	ldrb	w1, [x0, #0x4]
               	mov	x17, #0x68              // =104
               	eor	x1, x1, x17
               	mov	w1, w1
               	mov	x21, #0x1               // =1
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0x5]
               	mov	x17, #0x6f              // =111
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0x6]
               	mov	x17, #0x6c              // =108
               	eor	x1, x1, x17
               	mov	w1, w1
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
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	ldrb	w2, [x0, #0x8]
               	cmp	x2, #0x0
               	cset	x1, ne
               	cbnz	x2, <addr>
               	ldrb	w1, [x0, #0xd]
               	cmp	x1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	ldr	x0, [x0, #0x10]
               	cmp	x0, x22
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	sub	x0, x29, #0x10
               	str	x20, [x0]
               	str	w20, [x0, #0x8]
               	ldrsw	x1, [x22]
               	str	w1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	str	w1, [x0, #0x4]
               	mov	x20, #0x5               // =5
               	str	w20, [x0, #0x8]
               	bl	<addr>
               	ldrsw	x1, [x0]
               	cmp	x1, #0x3
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x4]
               	cmp	x1, #0x7
               	cset	x21, ne
               	cbnz	x21, <addr>
               	ldrsw	x0, [x0, #0x8]
               	cmp	x0, #0x5
               	cset	x21, ne
               	cbz	x21, <addr>
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w1, [x0]
               	mov	x17, #0x6f              // =111
               	eor	x1, x1, x17
               	mov	w2, w1
               	cmp	x2, #0x0
               	cset	x1, ne
               	cbnz	x2, <addr>
               	ldrb	w0, [x0, #0x1]
               	mov	x17, #0x6b              // =107
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	x0, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x50]
               	ldr	x22, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x60
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	mov	x1, x21
               	b	<addr>
               	mov	x1, x21
               	b	<addr>
