
switch_label_after_terminator.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sxtw	x15, w0
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x8]
               	b	<addr>
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x14, #0x1               // =1
               	stur	w14, [x29, #-0x8]
               	b	<addr>
               	mov	x14, #0x2               // =2
               	stur	w14, [x29, #-0x8]
               	b	<addr>
               	mov	x14, #0x3               // =3
               	stur	w14, [x29, #-0x8]
               	b	<addr>
               	mov	x14, #0xffff            // =65535
               	movk	x14, #0xffff, lsl #16
               	movk	x14, #0xffff, lsl #32
               	movk	x14, #0xffff, lsl #48
               	mov	x0, x14
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	cmp	x15, #0x1
               	b.eq	<addr>
               	cmp	x15, #0x2
               	b.eq	<addr>
               	cmp	x15, #0x3
               	b.eq	<addr>
               	b	<addr>
               	ldursw	x14, [x29, #-0x8]
               	add	x14, x14, #0x64
               	sxtw	x0, w14
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	cmp	x0, #0x65
               	b.eq	<addr>
               	mov	x14, #0x1               // =1
               	mov	x0, x14
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	cmp	x0, #0x66
               	b.eq	<addr>
               	mov	x14, #0x2               // =2
               	mov	x0, x14
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x3                // =3
               	bl	<addr>
               	cmp	x0, #0x67
               	b.eq	<addr>
               	mov	x14, #0x3               // =3
               	mov	x0, x14
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x63               // =99
               	bl	<addr>
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x14, #0x4               // =4
               	mov	x0, x14
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
