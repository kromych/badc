
libc_div.aarch64:	file format elf64-littleaarch64

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

<rti>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	w0, [x29, #-0x8]
               	ldursw	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<rtl>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<rtll>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	stur	x0, [x29, #-0x8]
               	ldur	x0, [x29, #-0x8]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x11               // =17
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	sxtw	x2, w20
               	sxtw	x0, w0
               	sdiv	x1, x2, x0
               	msub	x0, x1, x0, x2
               	cmp	w1, #0x3
               	b.ne	<addr>
               	cmp	w0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #-0x11              // =-17
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x5                // =5
               	bl	<addr>
               	sxtw	x2, w20
               	sxtw	x1, w0
               	sdiv	x0, x2, x1
               	msub	x1, x0, x1, x2
               	mov	x17, #-0x3              // =-3
               	cmp	w0, w17
               	b.ne	<addr>
               	mov	x17, #-0x2              // =-2
               	cmp	w1, w17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x17, #0x5               // =5
               	mul	x0, x0, x17
               	add	x0, x0, x1
               	mov	x17, #-0x11             // =-17
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x64               // =100
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	sdiv	x1, x20, x0
               	msub	x0, x1, x0, x20
               	cmp	x1, #0xe
               	b.ne	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x3e8              // =1000
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	sdiv	x1, x20, x0
               	msub	x0, x1, x0, x20
               	cmp	x1, #0x14d
               	b.ne	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
