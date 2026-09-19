
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
               	mov	x1, x0
               	ldr	x2, [x1]
               	and	x0, x2, #0x1
               	add	x0, x0, #0xa
               	and	x1, x2, #0x8
               	cbz	x1, <addr>
               	mov	x1, #0x1                // =1
               	add	x0, x0, x1
               	ret
               	mov	x1, #0x0                // =0
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
               	and	x4, x1, #0x8
               	cbz	x4, <addr>
               	mov	x4, x1
               	add	x3, x3, x4
               	add	x5, x3, #0xa
               	mov	x4, #0x2                // =2
               	str	x4, [x0]
               	and	x3, x4, #0x1
               	add	x3, x3, #0xa
               	and	x4, x4, #0x8
               	cbz	x4, <addr>
               	mov	x4, x1
               	add	x3, x3, x4
               	add	x5, x5, x3
               	mov	x4, #0x3                // =3
               	str	x4, [x0]
               	and	x3, x4, #0x1
               	add	x3, x3, #0xa
               	and	x4, x4, #0x8
               	cbz	x4, <addr>
               	mov	x4, x1
               	add	x3, x3, x4
               	add	x5, x5, x3
               	mov	x4, #0x4                // =4
               	str	x4, [x0]
               	and	x3, x4, #0x1
               	add	x3, x3, #0xa
               	and	x4, x4, #0x8
               	cbz	x4, <addr>
               	mov	x2, x1
               	add	x2, x3, x2
               	add	x4, x5, x2
               	mov	x3, #0x5                // =5
               	str	x3, [x0]
               	and	x2, x3, #0x1
               	add	x2, x2, #0xa
               	and	x0, x3, #0x8
               	cbz	x0, <addr>
               	add	x0, x2, x1
               	add	x3, x4, x0
               	mov	x2, #0x6                // =6
               	sub	x0, x29, #0x8
               	str	x2, [x0]
               	and	x1, x2, #0x1
               	add	x1, x1, #0xa
               	and	x2, x2, #0x8
               	cbz	x2, <addr>
               	mov	x2, #0x1                // =1
               	add	x1, x1, x2
               	add	x3, x3, x1
               	mov	x2, #0x7                // =7
               	str	x2, [x0]
               	and	x1, x2, #0x1
               	add	x1, x1, #0xa
               	and	x2, x2, #0x8
               	cbz	x2, <addr>
               	mov	x2, #0x1                // =1
               	add	x1, x1, x2
               	add	x3, x3, x1
               	mov	x2, #0x8                // =8
               	str	x2, [x0]
               	and	x1, x2, #0x1
               	add	x1, x1, #0xa
               	and	x2, x2, #0x8
               	cbz	x2, <addr>
               	mov	x2, #0x1                // =1
               	add	x1, x1, x2
               	add	x3, x3, x1
               	mov	x2, #0x9                // =9
               	str	x2, [x0]
               	and	x1, x2, #0x1
               	add	x1, x1, #0xa
               	and	x2, x2, #0x8
               	cbz	x2, <addr>
               	mov	x2, #0x1                // =1
               	add	x1, x1, x2
               	add	x3, x3, x1
               	mov	x2, #0xa                // =10
               	str	x2, [x0]
               	and	x1, x2, #0x1
               	add	x1, x1, #0xa
               	and	x2, x2, #0x8
               	cbz	x2, <addr>
               	mov	x2, #0x1                // =1
               	add	x1, x1, x2
               	add	x3, x3, x1
               	mov	x2, #0xb                // =11
               	str	x2, [x0]
               	and	x1, x2, #0x1
               	add	x1, x1, #0xa
               	and	x2, x2, #0x8
               	cbz	x2, <addr>
               	mov	x2, #0x1                // =1
               	add	x1, x1, x2
               	add	x3, x3, x1
               	mov	x2, #0xc                // =12
               	str	x2, [x0]
               	and	x1, x2, #0x1
               	add	x1, x1, #0xa
               	and	x2, x2, #0x8
               	cbz	x2, <addr>
               	mov	x2, #0x1                // =1
               	add	x1, x1, x2
               	add	x3, x3, x1
               	mov	x2, #0xd                // =13
               	str	x2, [x0]
               	and	x1, x2, #0x1
               	add	x1, x1, #0xa
               	and	x2, x2, #0x8
               	cbz	x2, <addr>
               	mov	x2, #0x1                // =1
               	add	x1, x1, x2
               	add	x3, x3, x1
               	mov	x2, #0xe                // =14
               	str	x2, [x0]
               	and	x1, x2, #0x1
               	add	x1, x1, #0xa
               	and	x0, x2, #0x8
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	x0, x1, x0
               	add	x3, x3, x0
               	mov	x1, #0xf                // =15
               	sub	x2, x29, #0x8
               	str	x1, [x2]
               	and	x0, x1, #0x1
               	add	x0, x0, #0xa
               	and	x1, x1, #0x8
               	cbz	x1, <addr>
               	mov	x1, #0x1                // =1
               	add	x0, x0, x1
               	add	x0, x3, x0
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
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x0, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x2, #0x0                // =0
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
               	mov	x4, x2
               	b	<addr>
