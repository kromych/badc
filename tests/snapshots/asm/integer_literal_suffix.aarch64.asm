
integer_literal_suffix.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400238 <.text+0x18>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x40
               	mov	x15, #0x1000000000      // =68719476736
               	sub	x14, x15, #0x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	cmp	x14, x17
               	b.eq	0x400270 <.text+0x50>
               	mov	x0, #0xb                // =11
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x24              // =36
               	mov	x0, #0x1                // =1
               	sxtw	x13, w15
               	lsl	x15, x0, x13
               	sub	x13, x15, #0x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xf, lsl #32
               	cmp	x13, x17
               	b.eq	0x4002a8 <.text+0x88>
               	mov	x0, #0xc                // =12
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0x6789            // =26505
               	movk	x15, #0x2345, lsl #16
               	movk	x15, #0x1, lsl #32
               	add	x0, x15, #0x1
               	mov	x17, #0x678a            // =26506
               	movk	x17, #0x2345, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x0, x17
               	b.eq	0x4002dc <.text+0xbc>
               	mov	x0, #0xd                // =13
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x15, #0xffff            // =65535
               	movk	x15, #0xffff, lsl #16
               	movk	x15, #0xffff, lsl #32
               	movk	x15, #0xffff, lsl #48
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x15, x17
               	cset	x0, eq
               	stur	x0, [x29, #-0x40]
               	cbz	x0, 0x400324 <.text+0x104>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	cmp	x15, x17
               	cset	x13, eq
               	stur	x13, [x29, #-0x40]
               	b	0x400324 <.text+0x104>
               	ldur	x13, [x29, #-0x40]
               	cbz	x13, 0x40033c <.text+0x11c>
               	mov	x0, #0xe                // =14
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x15, x17
               	b.eq	0x400364 <.text+0x144>
               	mov	x0, #0xf                // =15
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0xffff            // =65535
               	movk	x13, #0xffff, lsl #16
               	movk	x13, #0xffff, lsl #32
               	movk	x13, #0xffff, lsl #48
               	add	x0, x13, #0x1
               	cmp	x0, #0x0
               	b.eq	0x400390 <.text+0x170>
               	mov	x0, #0x10               // =16
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0x0               // =0
               	mov	x0, x13
               	add	sp, sp, #0x40
               	ldp	x29, x30, [sp], #0x10
               	ret
