
param_entry_conversion.aarch64:	file format elf64-littleaarch64

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

<pass>:
               	ret

<across>:
               	stp	x20, x21, [sp, #-0x50]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	str	x26, [sp, #0x30]
               	stp	x29, x30, [sp, #0x40]
               	add	x29, sp, #0x40
               	sxtb	x20, w0
               	mov	x25, x5
               	mov	x24, x4
               	mov	x23, x3
               	sxtw	x22, w2
               	sxth	x21, w1
               	mov	x0, x20
               	bl	<addr>
               	mov	x26, x0
               	mov	x0, x21
               	bl	<addr>
               	add	x26, x26, x0
               	mov	x0, x22
               	bl	<addr>
               	add	x0, x26, x0
               	lsl	x0, x0, #1
               	add	x0, x0, x20
               	add	x0, x0, x21
               	add	x0, x0, x22
               	and	x1, x23, #0xff
               	add	x0, x0, x1
               	add	x0, x0, x24
               	and	x1, x25, #0xffff
               	add	x0, x0, x1
               	ldp	x29, x30, [sp, #0x40]
               	ldr	x26, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x50
               	ret

<leaf>:
               	sxtb	x0, w0
               	sxtw	x3, w3
               	sxtw	x2, w2
               	sxth	x1, w1
               	mov	x17, #0x1000            // =4096
               	movk	x17, #0xd4a5, lsl #16
               	movk	x17, #0xe8, lsl #32
               	mul	x0, x0, x17
               	mov	x17, #0x4240            // =16960
               	movk	x17, #0xf, lsl #16
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	mov	x17, #0x3               // =3
               	mul	x1, x2, x17
               	add	x0, x0, x1
               	add	x0, x0, x3
               	ret

<order>:
               	mov	x17, #0x2710            // =10000
               	mul	x0, x0, x17
               	mov	x17, #0x64              // =100
               	mul	x1, x1, x17
               	add	x0, x0, x1
               	add	x0, x0, x2
               	ret

<permute>:
               	stp	x20, x21, [sp, #-0x30]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	sxtw	x20, w0
               	sxtb	x22, w2
               	sxth	x21, w1
               	mov	x0, x22
               	mov	x2, x21
               	mov	x1, x20
               	bl	<addr>
               	mov	x23, x0
               	mov	x0, x21
               	mov	x2, x20
               	mov	x1, x22
               	bl	<addr>
               	sub	x0, x23, x0
               	ldp	x29, x30, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x30
               	ret

<low>:
               	mul	x0, x0, x1
               	add	x0, x0, #0x1
               	sxtw	x0, w0
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x20]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x18]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x10]
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	stur	x0, [x29, #-0x8]
               	mov	x0, #0x5afb             // =23291
               	movk	x0, #0x5a5a, lsl #16
               	movk	x0, #0x5a5a, lsl #32
               	movk	x0, #0x5a5a, lsl #48
               	mov	x1, #0xfed4             // =65236
               	movk	x1, #0xa5a5, lsl #16
               	movk	x1, #0xa5a5, lsl #32
               	movk	x1, #0xa5a5, lsl #48
               	mov	x2, #-0x10              // =-16
               	movk	x2, #0x5a5a, lsl #32
               	movk	x2, #0x5a5a, lsl #48
               	mov	x3, #0xa5c8             // =42440
               	movk	x3, #0xa5a5, lsl #16
               	movk	x3, #0xa5a5, lsl #32
               	movk	x3, #0xa5a5, lsl #48
               	mov	x4, #-0x3e8             // =-1000
               	mov	x5, #0xff00             // =65280
               	movk	x5, #0x5a5a, lsl #16
               	movk	x5, #0x5a5a, lsl #32
               	movk	x5, #0x5a5a, lsl #48
               	ldur	x6, [x29, #-0x20]
               	blr	x6
               	mov	x17, #0xf81d            // =63517
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xa564             // =42340
               	movk	x0, #0xa5a5, lsl #16
               	movk	x0, #0xa5a5, lsl #32
               	movk	x0, #0xa5a5, lsl #48
               	mov	x1, #0xfffe             // =65534
               	movk	x1, #0x5a5a, lsl #16
               	movk	x1, #0x5a5a, lsl #32
               	movk	x1, #0x5a5a, lsl #48
               	mov	x2, #0xcd15             // =52501
               	movk	x2, #0x75b, lsl #16
               	movk	x2, #0xa5a5, lsl #32
               	movk	x2, #0xa5a5, lsl #48
               	mov	x3, #-0x7               // =-7
               	movk	x3, #0x5a5a, lsl #32
               	movk	x3, #0x5a5a, lsl #48
               	ldur	x4, [x29, #-0x18]
               	blr	x4
               	mov	x17, #0x22b8            // =8888
               	movk	x17, #0x266f, lsl #16
               	movk	x17, #0x5af3, lsl #32
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x9c40            // =-40000
               	movk	x0, #0xa5a5, lsl #32
               	movk	x0, #0xa5a5, lsl #48
               	mov	x1, #0x4d2              // =1234
               	movk	x1, #0x5a5a, lsl #16
               	movk	x1, #0x5a5a, lsl #32
               	movk	x1, #0x5a5a, lsl #48
               	mov	x2, #0xa580             // =42368
               	movk	x2, #0xa5a5, lsl #16
               	movk	x2, #0xa5a5, lsl #32
               	movk	x2, #0xa5a5, lsl #48
               	ldur	x3, [x29, #-0x10]
               	blr	x3
               	mov	x17, #-0x90e            // =-2318
               	movk	x17, #0xfef3, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	movk	x0, #0x5a5a, lsl #32
               	movk	x0, #0x5a5a, lsl #48
               	mov	x1, #-0x2               // =-2
               	movk	x1, #0xa5a5, lsl #32
               	movk	x1, #0xa5a5, lsl #48
               	ldur	x2, [x29, #-0x8]
               	blr	x2
               	mov	x17, #-0x5              // =-5
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
