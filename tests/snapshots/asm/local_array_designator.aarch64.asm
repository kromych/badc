
local_array_designator.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1

<use_auto>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x30
               	mov	x1, #0x5                // =5
               	sub	x0, x29, #0x28
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x2, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x2, #0x18]
               	str	x10, [x0, #0x18]
               	ldrb	w10, [x2, #0x20]
               	strb	w10, [x0, #0x20]
               	ldrb	w10, [x2, #0x21]
               	strb	w10, [x0, #0x21]
               	ldrb	w10, [x2, #0x22]
               	strb	w10, [x0, #0x22]
               	ldrb	w10, [x2, #0x23]
               	strb	w10, [x0, #0x23]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x28
               	str	w1, [x0, #0x18]
               	mov	x1, #0x6                // =6
               	sub	x0, x29, #0x28
               	str	w1, [x0, #0x1c]
               	mov	x1, #0x7                // =7
               	sub	x0, x29, #0x28
               	str	w1, [x0, #0x20]
               	mov	x0, #0xa                // =10
               	sub	x1, x29, #0x28
               	str	w0, [x1]
               	mov	x1, #0xb                // =11
               	sub	x0, x29, #0x28
               	str	w1, [x0, #0x4]
               	mov	x1, #0xc                // =12
               	sub	x0, x29, #0x28
               	str	w1, [x0, #0x8]
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	sub	x0, x29, #0x28
               	ldrsw	x0, [x0, #0xc]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x28
               	ldrsw	x0, [x0, #0x14]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>

<use_fixed>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	mov	x1, #0x7                // =7
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	sub	x0, x29, #0x30
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x2, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x2, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x2, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x2, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [sp], #0x10
               	sub	x0, x29, #0x30
               	str	w1, [x0, #0x24]
               	mov	x1, #0x8                // =8
               	sub	x0, x29, #0x30
               	str	w1, [x0, #0x28]
               	mov	x1, #0x0                // =0
               	sub	x0, x29, #0x30
               	str	w1, [x0, #0x2c]
               	mov	x1, #0x4                // =4
               	sub	x0, x29, #0x30
               	str	w1, [x0, #0xc]
               	mov	x1, #0x5                // =5
               	sub	x0, x29, #0x30
               	str	w1, [x0, #0x10]
               	mov	x1, #0x6                // =6
               	sub	x0, x29, #0x30
               	str	w1, [x0, #0x14]
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x30
               	ldrsw	x0, [x0, #0x18]
               	cmp	x0, #0x0
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x19               // =25
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	mov	x1, x0
               	sxtw	x0, w1
               	cbz	x0, <addr>
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp], #0x10
               	ret
