
static_local_shadows_extern_fn.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	ldrb	w14, [x0]
               	add	x0, x0, #0x1
               	ldrb	w0, [x0]
               	add	x14, x14, x0
               	sxtw	x0, w14
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x19, [sp]
               	sxtw	x0, w0
               	mov	x14, #0x0               // =0
               	stur	w14, [x29, #-0x8]
               	b	<addr>
               	ldursw	x13, [x29, #-0x8]
               	mov	x0, x13
               	ldr	x19, [sp]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x19, <page>
               	add	x19, x19, #0xd0
               	mov	x14, x19
               	ldrb	w13, [x14]
               	add	x14, x14, #0x1
               	ldrb	w14, [x14]
               	add	x13, x13, x14
               	sxtw	x13, w13
               	stur	w13, [x29, #-0x8]
               	b	<addr>
               	mov	x13, #0xffff            // =65535
               	movk	x13, #0xffff, lsl #16
               	movk	x13, #0xffff, lsl #32
               	movk	x13, #0xffff, lsl #48
               	stur	w13, [x29, #-0x8]
               	b	<addr>
               	cmp	x0, #0x1
               	b.eq	<addr>
               	cmp	x0, #0x2
               	b.eq	<addr>
               	b	<addr>
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x1                // =1
               	bl	<addr>
               	mov	x14, x0
               	mov	x0, x14
               	ldp	x29, x30, [sp], #0x10
               	ret
