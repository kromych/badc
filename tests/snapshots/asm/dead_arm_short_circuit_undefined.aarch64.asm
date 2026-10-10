
dead_arm_short_circuit_undefined.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x10
               	stp	xzr, xzr, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldp	x16, x17, [x1]
               	stp	x16, x17, [x0]
               	stur	xzr, [x29, #-0x10]
               	stur	xzr, [x29, #-0x8]
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x10]
               	stur	x0, [x29, #-0x8]
               	ldur	x2, [x29, #-0x10]
               	tbnz	w2, #0x0, <addr>
               	stur	xzr, [x29, #-0x10]
               	mov	x2, #0x2                // =2
               	stur	x2, [x29, #-0x8]
               	stur	x0, [x29, #-0x10]
               	mov	x2, #0x3                // =3
               	stur	x2, [x29, #-0x8]
               	tbnz	w0, #0x0, <addr>
               	ldur	x2, [x29, #-0x10]
               	tbnz	w2, #0x0, <addr>
               	stur	xzr, [x29, #-0x10]
               	mov	x1, #0x4                // =4
               	stur	x1, [x29, #-0x8]
               	stur	x0, [x29, #-0x10]
               	mov	x1, #0x5                // =5
               	stur	x1, [x29, #-0x8]
               	tbnz	w0, #0x0, <addr>
               	ldur	x0, [x29, #-0x10]
               	tbnz	w0, #0x0, <addr>
               	mov	x0, #0x0                // =0
               	stur	x0, [x29, #-0x10]
               	mov	x1, #0x6                // =6
               	stur	x1, [x29, #-0x8]
               	mov	x1, #0x1                // =1
               	stur	x1, [x29, #-0x10]
               	mov	x2, #0x7                // =7
               	stur	x2, [x29, #-0x8]
               	tbnz	w1, #0x0, <addr>
               	ldur	x1, [x29, #-0x10]
               	tbnz	w1, #0x0, <addr>
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x1, [x29, #-0x8]
               	and	x1, x1, #0xff
               	cmp	w1, #0x1
               	b	<addr>
               	ldur	x1, [x29, #-0x8]
               	and	x1, x1, #0xff
               	cmp	w1, #0x1
               	b	<addr>
               	ldur	x0, [x29, #-0x8]
               	and	x0, x0, #0xff
               	cmp	w0, #0x1
               	b	<addr>
               	ldur	x0, [x29, #-0x8]
               	and	x0, x0, #0xff
               	cmp	w0, #0x1
               	b	<addr>
               	ldur	x2, [x29, #-0x8]
               	and	x2, x2, #0xff
               	cmp	w2, #0x1
               	b	<addr>
               	ldur	x2, [x29, #-0x8]
               	and	x2, x2, #0xff
               	cmp	w2, #0x1
               	b	<addr>
               	ldur	x2, [x29, #-0x8]
               	and	x2, x2, #0xff
               	cmp	w2, #0x1
               	b	<addr>
