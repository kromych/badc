
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
               	str	x20, [sp, #-0x50]!
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	sub	x0, x29, #0x28
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	str	x1, [x0, #0x10]
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	ldrsw	x2, [x20]
               	str	w2, [x0]
               	mov	x2, #0x68               // =104
               	strb	w2, [x0, #0x4]
               	mov	x2, #0x6f               // =111
               	strb	w2, [x0, #0x5]
               	mov	x2, #0x6c               // =108
               	strb	w2, [x0, #0x6]
               	mov	x2, #0x61               // =97
               	strb	w2, [x0, #0x7]
               	strb	w1, [x0, #0x8]
               	strb	w1, [x0, #0x9]
               	strb	w1, [x0, #0xa]
               	strb	w1, [x0, #0xb]
               	strb	w1, [x0, #0xc]
               	strb	w1, [x0, #0xd]
               	str	x20, [x0, #0x10]
               	bl	<addr>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	ldrb	w1, [x0, #0x4]
               	mov	x17, #0x68              // =104
               	eor	x1, x1, x17
               	mov	w1, w1
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0x5]
               	mov	x17, #0x6f              // =111
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	w1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0x6]
               	mov	x17, #0x6c              // =108
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	w1, #0x0
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0x7]
               	mov	x17, #0x61              // =97
               	eor	x1, x1, x17
               	mov	w1, w1
               	cmp	w1, #0x0
               	cset	x1, ne
               	cbz	x1, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	ldrb	w1, [x0, #0x8]
               	cbnz	x1, <addr>
               	ldrb	w1, [x0, #0xd]
               	cmp	w1, #0x0
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
               	ldrsw	x1, [x20]
               	str	w1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldrsw	x1, [x1]
               	str	w1, [x0, #0x4]
               	mov	x1, #0x5                // =5
               	str	w1, [x0, #0x8]
               	bl	<addr>
               	ldrsw	x1, [x0]
               	cmp	w1, #0x3
               	b.ne	<addr>
               	ldrsw	x1, [x0, #0x4]
               	cmp	w1, #0x7
               	cset	x1, ne
               	cbnz	x1, <addr>
               	ldrsw	x0, [x0, #0x8]
               	cmp	w0, #0x5
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x20, [sp], #0x50
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	ldrb	w1, [x0]
               	mov	x17, #0x6f              // =111
               	eor	x1, x1, x17
               	mov	w1, w1
               	cbnz	x1, <addr>
               	ldrb	w0, [x0, #0x1]
               	mov	x17, #0x6b              // =107
               	eor	x0, x0, x17
               	mov	w0, w0
               	cmp	w0, #0x0
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
