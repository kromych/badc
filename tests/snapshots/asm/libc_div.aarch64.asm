
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
               	stp	x20, x21, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x11               // =17
               	bl	<addr>
               	mov	x21, x0
               	mov	x20, #0x5               // =5
               	mov	x0, x20
               	bl	<addr>
               	mov	x1, x0
               	sxtw	x0, w21
               	sxtw	x1, w1
               	sdiv	x2, x0, x1
               	sdiv	x17, x0, x1
               	msub	x1, x17, x1, x0
               	sxtw	x0, w2
               	cmp	x0, #0x3
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sxtw	x0, w1
               	cmp	x0, #0x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0xffef             // =65519
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, x20
               	bl	<addr>
               	mov	x1, x0
               	sxtw	x0, w21
               	sxtw	x2, w1
               	sdiv	x1, x0, x2
               	sdiv	x17, x0, x2
               	msub	x2, x17, x2, x0
               	sxtw	x0, w1
               	mov	x17, #0xfffd            // =65533
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sxtw	x0, w2
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x17, #0x5               // =5
               	mul	x0, x1, x17
               	add	x0, x0, x2
               	sxtw	x0, w0
               	mov	x17, #0xffef            // =65519
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x64               // =100
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0x7                // =7
               	bl	<addr>
               	sdiv	x1, x21, x0
               	sdiv	x17, x21, x0
               	msub	x2, x17, x0, x21
               	cmp	x1, #0xe
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	x2, #0x2
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x3e8              // =1000
               	bl	<addr>
               	mov	x21, x0
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	sdiv	x1, x21, x0
               	sdiv	x17, x21, x0
               	msub	x2, x17, x0, x21
               	cmp	x1, #0x14d
               	cset	x0, ne
               	cbnz	x0, <addr>
               	cmp	x2, #0x1
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, x20
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x20
               	ret
               	b	<addr>
               	b	<addr>
               	b	<addr>
               	b	<addr>
