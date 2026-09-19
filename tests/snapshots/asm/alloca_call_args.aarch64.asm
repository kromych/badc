
alloca_call_args.aarch64:	file format elf64-littleaarch64

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

<sum10>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	add	x0, x0, x1
               	add	x0, x0, x2
               	add	x0, x0, x3
               	add	x0, x0, x4
               	add	x0, x0, x5
               	add	x0, x0, x6
               	add	x0, x0, x7
               	ldr	x1, [x29, #0x10]
               	add	x0, x0, x1
               	ldr	x1, [x29, #0x18]
               	add	x0, x0, x1
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0x100000           // =1048576
               	add	x17, x0, #0xf
               	and	x17, x17, #0xfffffffffffffff0
               	mov	x1, sp
               	sub	x1, x1, x17
               	lsr	x17, x17, #12
               	cbz	x17, <addr>
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	subs	x17, x17, #0x1
               	b.ne	<addr>
               	mov	sp, x1
               	mov	x6, #0x7                // =7
               	mov	x2, #0x100000           // =1048576
               	mov	x0, #0x0                // =0
               	strb	w6, [x1, x0]
               	add	x0, x0, #0x1, lsl #12   // =0x1000
               	cmp	w0, w2
               	b.lt	<addr>
               	mov	x17, #0xfffff           // =1048575
               	add	x0, x1, x17
               	mov	x7, #0x8                // =8
               	strb	w7, [x0]
               	ldrb	w0, [x1]
               	add	x20, x0, #0x8
               	mov	x0, #0x1                // =1
               	mov	x1, #0x2                // =2
               	mov	x2, #0x3                // =3
               	mov	x3, #0x4                // =4
               	mov	x4, #0x5                // =5
               	mov	x5, #0x6                // =6
               	mov	x8, #0x9                // =9
               	mov	x9, #0xa                // =10
               	adrp	x10, <page>
               	add	x10, x10, <lo12>
               	ldr	x10, [x10]
               	sub	sp, sp, #0x10
               	str	x8, [sp]
               	str	x9, [sp, #0x8]
               	blr	x10
               	add	sp, sp, #0x10
               	cmp	w20, #0xf
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	sub	sp, x29, #0x20
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	cmp	x0, #0x37
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	sub	sp, x29, #0x20
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
               	mov	x0, #0x2a               // =42
               	sub	sp, x29, #0x20
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x20, [sp], #0x30
               	ret
