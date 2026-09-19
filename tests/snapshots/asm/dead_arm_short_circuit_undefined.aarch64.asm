
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
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	str	x1, [x0, #0x8]
               	mov	x2, #0x1                // =1
               	str	x2, [x0]
               	str	x2, [x0, #0x8]
               	and	x3, x2, #0x1
               	cbnz	w3, <addr>
               	mov	x3, x1
               	cmp	w3, #0x1
               	ldr	x3, [x0]
               	and	x3, x3, #0x1
               	cbnz	w3, <addr>
               	mov	x3, x1
               	cmp	w3, #0x1
               	str	x1, [x0]
               	mov	x3, #0x2                // =2
               	str	x3, [x0, #0x8]
               	str	x2, [x0]
               	mov	x3, #0x3                // =3
               	str	x3, [x0, #0x8]
               	and	x3, x2, #0x1
               	cbnz	w3, <addr>
               	mov	x3, x1
               	cmp	w3, #0x1
               	ldr	x3, [x0]
               	and	x3, x3, #0x1
               	cbnz	w3, <addr>
               	mov	x3, x1
               	cmp	w3, #0x1
               	str	x1, [x0]
               	sub	x0, x29, #0x10
               	mov	x1, #0x4                // =4
               	str	x1, [x0, #0x8]
               	str	x2, [x0]
               	mov	x1, #0x5                // =5
               	str	x1, [x0, #0x8]
               	and	x1, x2, #0x1
               	cbnz	w1, <addr>
               	mov	x1, #0x0                // =0
               	cmp	w1, #0x1
               	ldr	x1, [x0]
               	and	x1, x1, #0x1
               	cbnz	w1, <addr>
               	mov	x1, #0x0                // =0
               	cmp	w1, #0x1
               	mov	x1, #0x0                // =0
               	str	x1, [x0]
               	mov	x2, #0x6                // =6
               	str	x2, [x0, #0x8]
               	mov	x2, #0x1                // =1
               	str	x2, [x0]
               	mov	x3, #0x7                // =7
               	str	x3, [x0, #0x8]
               	and	x2, x2, #0x1
               	cbnz	w2, <addr>
               	mov	x2, x1
               	cmp	w2, #0x1
               	ldr	x2, [x0]
               	and	x2, x2, #0x1
               	cbnz	w2, <addr>
               	mov	x0, x1
               	cmp	w0, #0x1
               	mov	x0, x1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x0, #0x8]
               	and	x0, x0, #0xff
               	b	<addr>
               	ldr	x2, [x0, #0x8]
               	and	x2, x2, #0xff
               	b	<addr>
               	ldr	x1, [x0, #0x8]
               	and	x1, x1, #0xff
               	b	<addr>
               	ldr	x1, [x0, #0x8]
               	and	x1, x1, #0xff
               	b	<addr>
               	ldr	x3, [x0, #0x8]
               	and	x3, x3, #0xff
               	b	<addr>
               	ldr	x3, [x0, #0x8]
               	and	x3, x3, #0xff
               	b	<addr>
               	ldr	x3, [x0, #0x8]
               	and	x3, x3, #0xff
               	b	<addr>
               	ldr	x3, [x0, #0x8]
               	and	x3, x3, #0xff
               	b	<addr>
