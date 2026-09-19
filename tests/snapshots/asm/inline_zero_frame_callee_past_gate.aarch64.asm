
inline_zero_frame_callee_past_gate.aarch64:	file format elf64-littleaarch64

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

<consume>:
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x2c8]
               	add	x0, x3, x0
               	add	x0, x2, x0
               	str	x0, [x1]
               	ret

<submit>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xb40
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0xb40
               	lsl	x2, x0, #3
               	add	x1, x1, x2
               	add	x0, x0, #0x1
               	str	x0, [x1]
               	cmp	w0, #0x5a
               	b.lt	<addr>
               	sub	x0, x29, #0xb40
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x2c8]
               	add	x0, x3, x0
               	add	x0, x2, x0
               	str	x0, [x1]
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x870
               	lsl	x2, x0, #3
               	add	x1, x1, x2
               	add	x2, x0, #0x2
               	str	x2, [x1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x5a
               	b.lt	<addr>
               	sub	x0, x29, #0x870
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x2c8]
               	add	x0, x3, x0
               	add	x0, x2, x0
               	str	x0, [x1]
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x5a0
               	lsl	x2, x0, #3
               	add	x1, x1, x2
               	add	x2, x0, #0x3
               	str	x2, [x1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x5a
               	b.lt	<addr>
               	sub	x0, x29, #0x5a0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x2c8]
               	add	x0, x3, x0
               	add	x0, x2, x0
               	str	x0, [x1]
               	mov	x0, #0x0                // =0
               	sub	x1, x29, #0x2d0
               	lsl	x2, x0, #3
               	add	x1, x1, x2
               	add	x2, x0, #0x4
               	str	x2, [x1]
               	add	x0, x0, #0x1
               	cmp	w0, #0x5a
               	b.lt	<addr>
               	sub	x0, x29, #0x2d0
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x2, [x1]
               	ldr	x3, [x0]
               	ldr	x0, [x0, #0x2c8]
               	add	x0, x3, x0
               	add	x0, x2, x0
               	str	x0, [x1]
               	add	sp, sp, #0xb40
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	cmp	x0, #0x178
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
