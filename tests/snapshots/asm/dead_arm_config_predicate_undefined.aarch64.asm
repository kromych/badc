
dead_arm_config_predicate_undefined.aarch64:	file format elf64-littleaarch64

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

<dispatch>:
               	ldr	x0, [x0]
               	and	x1, x0, #0x1
               	add	x1, x1, #0xa
               	tbz	w0, #0x3, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x1, x0
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x2, #0x0                // =0
               	sub	x0, x29, #0x8
               	str	x2, [x0]
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	and	x3, x1, #0x1
               	add	x3, x3, #0xa
               	ldr	x4, [x0]
               	tbz	w4, #0x3, <addr>
               	mov	x4, x1
               	add	x3, x3, x4
               	add	x4, x3, #0xa
               	mov	x3, #0x2                // =2
               	str	x3, [x0]
               	and	x3, x3, #0x1
               	add	x3, x3, #0xa
               	ldr	x5, [x0]
               	tbz	w5, #0x3, <addr>
               	mov	x5, x1
               	add	x3, x3, x5
               	add	x4, x4, x3
               	mov	x3, #0x3                // =3
               	str	x3, [x0]
               	and	x3, x3, #0x1
               	add	x3, x3, #0xa
               	ldr	x5, [x0]
               	tbz	w5, #0x3, <addr>
               	mov	x5, x1
               	add	x3, x3, x5
               	add	x4, x4, x3
               	mov	x3, #0x4                // =4
               	str	x3, [x0]
               	and	x3, x3, #0x1
               	add	x3, x3, #0xa
               	ldr	x5, [x0]
               	tbz	w5, #0x3, <addr>
               	mov	x2, x1
               	add	x2, x3, x2
               	add	x3, x4, x2
               	mov	x2, #0x5                // =5
               	str	x2, [x0]
               	and	x2, x2, #0x1
               	add	x2, x2, #0xa
               	ldr	x0, [x0]
               	tbz	w0, #0x3, <addr>
               	add	x0, x2, x1
               	add	x2, x3, x0
               	mov	x1, #0x6                // =6
               	sub	x0, x29, #0x8
               	str	x1, [x0]
               	and	x1, x1, #0x1
               	add	x3, x1, #0xa
               	ldr	x1, [x0]
               	tbz	w1, #0x3, <addr>
               	mov	x1, #0x1                // =1
               	add	x1, x3, x1
               	add	x2, x2, x1
               	mov	x1, #0x7                // =7
               	str	x1, [x0]
               	and	x1, x1, #0x1
               	add	x3, x1, #0xa
               	ldr	x1, [x0]
               	tbz	w1, #0x3, <addr>
               	mov	x1, #0x1                // =1
               	add	x1, x3, x1
               	add	x2, x2, x1
               	mov	x1, #0x8                // =8
               	str	x1, [x0]
               	and	x1, x1, #0x1
               	add	x3, x1, #0xa
               	ldr	x1, [x0]
               	tbz	w1, #0x3, <addr>
               	mov	x1, #0x1                // =1
               	add	x1, x3, x1
               	add	x2, x2, x1
               	mov	x1, #0x9                // =9
               	str	x1, [x0]
               	and	x1, x1, #0x1
               	add	x3, x1, #0xa
               	ldr	x1, [x0]
               	tbz	w1, #0x3, <addr>
               	mov	x1, #0x1                // =1
               	add	x1, x3, x1
               	add	x2, x2, x1
               	mov	x1, #0xa                // =10
               	str	x1, [x0]
               	and	x1, x1, #0x1
               	add	x3, x1, #0xa
               	ldr	x1, [x0]
               	tbz	w1, #0x3, <addr>
               	mov	x1, #0x1                // =1
               	add	x1, x3, x1
               	add	x2, x2, x1
               	mov	x1, #0xb                // =11
               	str	x1, [x0]
               	and	x1, x1, #0x1
               	add	x3, x1, #0xa
               	ldr	x1, [x0]
               	tbz	w1, #0x3, <addr>
               	mov	x1, #0x1                // =1
               	add	x1, x3, x1
               	add	x2, x2, x1
               	mov	x1, #0xc                // =12
               	str	x1, [x0]
               	and	x1, x1, #0x1
               	add	x3, x1, #0xa
               	ldr	x1, [x0]
               	tbz	w1, #0x3, <addr>
               	mov	x1, #0x1                // =1
               	add	x1, x3, x1
               	add	x2, x2, x1
               	mov	x1, #0xd                // =13
               	str	x1, [x0]
               	and	x1, x1, #0x1
               	add	x3, x1, #0xa
               	ldr	x1, [x0]
               	tbz	w1, #0x3, <addr>
               	mov	x1, #0x1                // =1
               	add	x1, x3, x1
               	add	x2, x2, x1
               	mov	x1, #0xe                // =14
               	str	x1, [x0]
               	and	x1, x1, #0x1
               	add	x1, x1, #0xa
               	ldr	x0, [x0]
               	tbz	w0, #0x3, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x1, x0
               	add	x2, x2, x0
               	mov	x0, #0xf                // =15
               	sub	x1, x29, #0x8
               	str	x0, [x1]
               	and	x0, x0, #0x1
               	add	x3, x0, #0xa
               	ldr	x0, [x1]
               	tbz	w0, #0x3, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x3, x0
               	add	x0, x2, x0
               	cmp	w0, #0xb0
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	str	xzr, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x5, x2
               	b	<addr>
               	mov	x5, x2
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
