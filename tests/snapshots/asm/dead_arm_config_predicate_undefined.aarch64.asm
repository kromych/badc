
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
               	mov	x1, #0x0                // =0
               	stur	x1, [x29, #-0x8]
               	mov	x0, #0x1                // =1
               	stur	x0, [x29, #-0x8]
               	and	x2, x0, #0x1
               	add	x2, x2, #0xa
               	ldur	x3, [x29, #-0x8]
               	tbz	w3, #0x3, <addr>
               	mov	x3, x0
               	add	x2, x2, x3
               	add	x3, x2, #0xa
               	mov	x2, #0x2                // =2
               	stur	x2, [x29, #-0x8]
               	and	x2, x2, #0x1
               	add	x2, x2, #0xa
               	ldur	x4, [x29, #-0x8]
               	tbz	w4, #0x3, <addr>
               	mov	x4, x0
               	add	x2, x2, x4
               	add	x3, x3, x2
               	mov	x2, #0x3                // =3
               	stur	x2, [x29, #-0x8]
               	and	x2, x2, #0x1
               	add	x2, x2, #0xa
               	ldur	x4, [x29, #-0x8]
               	tbz	w4, #0x3, <addr>
               	mov	x4, x0
               	add	x2, x2, x4
               	add	x3, x3, x2
               	mov	x2, #0x4                // =4
               	stur	x2, [x29, #-0x8]
               	and	x2, x2, #0x1
               	add	x2, x2, #0xa
               	ldur	x4, [x29, #-0x8]
               	tbz	w4, #0x3, <addr>
               	mov	x1, x0
               	add	x1, x2, x1
               	add	x2, x3, x1
               	mov	x1, #0x5                // =5
               	stur	x1, [x29, #-0x8]
               	and	x1, x1, #0x1
               	add	x1, x1, #0xa
               	ldur	x3, [x29, #-0x8]
               	tbz	w3, #0x3, <addr>
               	add	x0, x1, x0
               	add	x1, x2, x0
               	mov	x0, #0x6                // =6
               	stur	x0, [x29, #-0x8]
               	and	x0, x0, #0x1
               	add	x2, x0, #0xa
               	ldur	x0, [x29, #-0x8]
               	tbz	w0, #0x3, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x2, x0
               	add	x1, x1, x0
               	mov	x0, #0x7                // =7
               	stur	x0, [x29, #-0x8]
               	and	x0, x0, #0x1
               	add	x2, x0, #0xa
               	ldur	x0, [x29, #-0x8]
               	tbz	w0, #0x3, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x2, x0
               	add	x1, x1, x0
               	mov	x0, #0x8                // =8
               	stur	x0, [x29, #-0x8]
               	and	x0, x0, #0x1
               	add	x2, x0, #0xa
               	ldur	x0, [x29, #-0x8]
               	tbz	w0, #0x3, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x2, x0
               	add	x1, x1, x0
               	mov	x0, #0x9                // =9
               	stur	x0, [x29, #-0x8]
               	and	x0, x0, #0x1
               	add	x2, x0, #0xa
               	ldur	x0, [x29, #-0x8]
               	tbz	w0, #0x3, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x2, x0
               	add	x1, x1, x0
               	mov	x0, #0xa                // =10
               	stur	x0, [x29, #-0x8]
               	and	x0, x0, #0x1
               	add	x2, x0, #0xa
               	ldur	x0, [x29, #-0x8]
               	tbz	w0, #0x3, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x2, x0
               	add	x1, x1, x0
               	mov	x0, #0xb                // =11
               	stur	x0, [x29, #-0x8]
               	and	x0, x0, #0x1
               	add	x2, x0, #0xa
               	ldur	x0, [x29, #-0x8]
               	tbz	w0, #0x3, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x2, x0
               	add	x1, x1, x0
               	mov	x0, #0xc                // =12
               	stur	x0, [x29, #-0x8]
               	and	x0, x0, #0x1
               	add	x2, x0, #0xa
               	ldur	x0, [x29, #-0x8]
               	tbz	w0, #0x3, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x2, x0
               	add	x1, x1, x0
               	mov	x0, #0xd                // =13
               	stur	x0, [x29, #-0x8]
               	and	x0, x0, #0x1
               	add	x2, x0, #0xa
               	ldur	x0, [x29, #-0x8]
               	tbz	w0, #0x3, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x2, x0
               	add	x1, x1, x0
               	mov	x0, #0xe                // =14
               	stur	x0, [x29, #-0x8]
               	and	x0, x0, #0x1
               	add	x2, x0, #0xa
               	ldur	x0, [x29, #-0x8]
               	tbz	w0, #0x3, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x2, x0
               	add	x1, x1, x0
               	mov	x0, #0xf                // =15
               	stur	x0, [x29, #-0x8]
               	and	x0, x0, #0x1
               	add	x2, x0, #0xa
               	ldur	x0, [x29, #-0x8]
               	tbz	w0, #0x3, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x2, x0
               	add	x0, x1, x0
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
               	ldr	x16, [x1]
               	str	x16, [x0]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x4, x1
               	b	<addr>
               	mov	x4, x1
               	b	<addr>
               	mov	x3, x1
               	b	<addr>
