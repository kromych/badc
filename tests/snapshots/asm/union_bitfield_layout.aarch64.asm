
union_bitfield_layout.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	b	<addr>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
               	mov	x0, #0x15               // =21
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	mov	x1, #0x5                // =5
               	ldr	w2, [x0]
               	mov	x17, #0xfff0            // =65520
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	orr	x1, x2, x1
               	str	w1, [x0]
               	sub	x0, x29, #0x8
               	mov	x1, #0x3                // =3
               	ldr	w2, [x0, #0x4]
               	mov	x17, #0xfff0            // =65520
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	and	x2, x2, x17
               	orr	x1, x2, x1
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x8
               	ldr	w0, [x0]
               	mov	x17, #0xf               // =15
               	and	x0, x0, x17
               	lsl	x0, x0, #60
               	asr	x0, x0, #60
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x1f               // =31
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x8
               	ldr	w0, [x0, #0x4]
               	mov	x17, #0xf               // =15
               	and	x0, x0, x17
               	lsl	x0, x0, #60
               	asr	x0, x0, #60
               	cmp	x0, #0x3
               	b.eq	<addr>
               	mov	x0, #0x20               // =32
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
