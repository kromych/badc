
large_int_literal_auto_promotes.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x30
               	mov	x15, #0xffff            // =65535
               	movk	x15, #0xffff, lsl #16
               	movk	x15, #0xffff, lsl #32
               	movk	x15, #0x7fff, lsl #48
               	mov	x14, #-0x8000000000000000 // =-9223372036854775808
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0x7fff, lsl #48
               	cmp	x15, x17
               	b.eq	0x400280 <.text+0x60>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x14, x17
               	b.eq	0x40029c <.text+0x7c>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0xfffe            // =65534
               	movk	x13, #0xffff, lsl #16
               	movk	x13, #0xffff, lsl #32
               	movk	x13, #0x7fff, lsl #48
               	mov	x17, #0xfffe            // =65534
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0x7fff, lsl #48
               	cmp	x13, x17
               	b.eq	0x4002d8 <.text+0xb8>
               	mov	x13, #0x3               // =3
               	mov	x0, x13
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #-0x8000000000000000 // =-9223372036854775808
               	mov	x17, #-0x8000000000000000 // =-9223372036854775808
               	cmp	x0, x17
               	b.eq	0x4002f8 <.text+0xd8>
               	mov	x0, #0x4                // =4
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x13, #0xf201            // =61953
               	movk	x13, #0x2a05, lsl #16
               	movk	x13, #0x1, lsl #32
               	mov	x17, #0xf201            // =61953
               	movk	x17, #0x2a05, lsl #16
               	movk	x17, #0x1, lsl #32
               	cmp	x13, x17
               	b.eq	0x40032c <.text+0x10c>
               	mov	x13, #0x5               // =5
               	mov	x0, x13
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x30
               	ldp	x29, x30, [sp], #0x10
               	ret
