
array_alias_param_outer_bracket.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x60
               	sub	x2, x29, #0x60
               	mov	x0, #0x1                // =1
               	str	x0, [x2]
               	mov	x0, #0x2                // =2
               	str	x0, [x2, #0x18]
               	mov	x0, #0xb                // =11
               	str	x0, [x2, #0x20]
               	add	x0, x2, #0x20
               	mov	x1, #0xc                // =12
               	str	x1, [x0, #0x18]
               	mov	x0, #0x15               // =21
               	str	x0, [x2, #0x40]
               	add	x0, x2, #0x40
               	mov	x1, #0x16               // =22
               	str	x1, [x0, #0x18]
               	mov	x0, #0x0                // =0
               	mov	x3, x0
               	cmp	w0, #0x3
               	b.hs	<addr>
               	lsl	x1, x0, #5
               	add	x1, x2, x1
               	ldr	x4, [x1]
               	ldr	x1, [x1, #0x18]
               	add	x1, x4, x1
               	add	x3, x3, x1
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lo	<addr>
               	cmp	x3, #0x45
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x3, x29, #0x60
               	add	x1, x3, #0x20
               	sub	x0, x1, x3
               	cmp	x0, #0x20
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	str	x0, [x1]
               	str	x0, [x1, #0x18]
               	ldr	x1, [x3]
               	cmp	x1, #0x1
               	b.ne	<addr>
               	ldr	x1, [x3, #0x58]
               	cmp	x1, #0x16
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x2, x0
               	cmp	w0, #0x3
               	b.hs	<addr>
               	lsl	x1, x0, #5
               	add	x1, x3, x1
               	ldr	x4, [x1]
               	ldr	x1, [x1, #0x18]
               	add	x1, x4, x1
               	add	x2, x2, x1
               	add	x0, x0, #0x1
               	cmp	w0, #0x3
               	b.lo	<addr>
               	cmp	x2, #0x2e
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
