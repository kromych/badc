
stack_probe_large_frames.aarch64:	file format elf64-littleaarch64

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

<touch>:
               	mov	x2, #0x1                // =1
               	strb	w2, [x0]
               	mov	x3, #0x2                // =2
               	lsr	x2, x1, #1
               	strb	w3, [x0, x2]
               	sub	x1, x1, #0x1
               	mov	x3, #0x3                // =3
               	strb	w3, [x0, x1]
               	ldrb	w3, [x0]
               	ldrb	w2, [x0, x2]
               	add	x2, x3, x2
               	ldrb	w0, [x0, x1]
               	add	x0, x2, x0
               	ret

<two_pages>:
               	mov	x0, #0x6                // =6
               	ret

<fifty_pages>:
               	mov	x0, #0x6                // =6
               	ret

<by_value>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x10]
               	ldur	x0, [x29, #-0x10]
               	ldr	x1, [x0]
               	ldrb	w2, [x0, #0x8]
               	add	x17, x0, #0x2, lsl #12  // =0x2000
               	ldrb	w3, [x17, #0x32f]
               	ldr	x0, [x0, #0x2330]
               	add	x0, x1, x0
               	add	x0, x0, x2
               	add	x0, x0, x3
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<recurse>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	sp, sp, #0x340
               	stp	x20, x21, [sp]
               	mov	x21, x0
               	add	x0, sp, #0x18
               	mov	x1, #0x2328             // =9000
               	bl	<addr>
               	mov	x20, x0
               	cmp	x21, #0x0
               	b.le	<addr>
               	sub	x0, x21, #0x1
               	bl	<addr>
               	add	x20, x20, x0
               	mov	x0, x20
               	ldp	x20, x21, [sp]
               	add	sp, sp, #0x2, lsl #12   // =0x2000
               	add	sp, sp, #0x340
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	sp, sp, #0x1, lsl #12   // =0x1000
               	str	xzr, [sp]
               	sub	sp, sp, #0x680
               	str	x20, [sp]
               	bl	<addr>
               	mov	x20, x0
               	bl	<addr>
               	add	x0, x20, x0
               	cmp	x0, #0xc
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	add	sp, sp, #0x4, lsl #12   // =0x4000
               	add	sp, sp, #0x680
               	ldp	x29, x30, [sp], #0x10
               	ret
               	add	x1, sp, #0x10
               	mov	x0, #0x4                // =4
               	str	x0, [x1]
               	mov	x0, #0x5                // =5
               	str	x0, [x1, #0x2330]
               	mov	x0, #0x6                // =6
               	strb	w0, [x1, #0x8]
               	mov	x17, #0x232f            // =9007
               	add	x0, x1, x17
               	mov	x2, #0x7                // =7
               	strb	w2, [x0]
               	sub	x0, x29, #0x2, lsl #12  // =0x2000
               	sub	x0, x0, #0x338
               	mov	x16, x0
               	mov	x17, #0x2330            // =9008
               	add	x17, x1, x17
               	ldp	x9, x10, [x1], #0x10
               	stp	x9, x10, [x16], #0x10
               	cmp	x1, x17
               	b.ne	<addr>
               	ldr	x9, [x1]
               	str	x9, [x16]
               	bl	<addr>
               	cmp	x0, #0x16
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	add	sp, sp, #0x4, lsl #12   // =0x4000
               	add	sp, sp, #0x680
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	cmp	x0, #0x30
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldr	x20, [sp]
               	add	sp, sp, #0x4, lsl #12   // =0x4000
               	add	sp, sp, #0x680
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2a               // =42
               	ldr	x20, [sp]
               	add	sp, sp, #0x4, lsl #12   // =0x4000
               	add	sp, sp, #0x680
               	ldp	x29, x30, [sp], #0x10
               	ret
