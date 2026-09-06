
range_guard_field_reload.aarch64:	file format elf64-littleaarch64

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

<fill>:
               	mov	x1, #0x1                // =1
               	str	x1, [x0]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	str	x1, [x0, #0x8]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	w1, [x1]
               	str	w1, [x0, #0x10]
               	mov	x1, #0x0                // =0
               	str	w1, [x0, #0x14]
               	mov	x0, x1
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x80]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	mov	x0, #0x64               // =100
               	str	x0, [x20]
               	adrp	x21, <page>
               	add	x21, x21, <lo12>
               	mov	x0, #0x7                // =7
               	str	w0, [x21]
               	sub	x1, x29, #0x18
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x0, [x0]
               	mov	x9, x0
               	mov	x0, x1
               	blr	x9
               	sub	x0, x29, #0x18
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0x7fff, lsl #48
               	cmp	x1, x17
               	b.lo	<addr>
               	mov	x1, #0xffea             // =65514
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	cmp	x1, #0x7
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x1, #0xfffc             // =65532
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0x7fff, lsl #48
               	str	x1, [x20]
               	mov	x1, #0x9                // =9
               	str	w1, [x21]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	sub	x0, x29, #0x18
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0x7fff, lsl #48
               	cmp	x1, x17
               	b.lo	<addr>
               	mov	x1, #0xffea             // =65514
               	movk	x1, #0xffff, lsl #16
               	movk	x1, #0xffff, lsl #32
               	movk	x1, #0xffff, lsl #48
               	cmp	x1, #0x3
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x1, #0x4                // =4
               	movk	x1, #0x8000, lsl #48
               	str	x1, [x20]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x1, [x1]
               	mov	x9, x1
               	blr	x9
               	sub	x0, x29, #0x18
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0x7fff, lsl #48
               	cmp	x1, x17
               	b.lo	<addr>
               	mov	x0, #0xffea             // =65514
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	mov	x17, #0xffea            // =65514
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x19, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret
               	ldr	x2, [x0, #0x8]
               	ldr	w1, [x0, #0x10]
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0x7fff, lsl #48
               	sub	x2, x0, x2
               	mov	w0, w1
               	cmp	x0, x2
               	b.hs	<addr>
               	mov	w0, w0
               	sxtw	x0, w0
               	b	<addr>
               	mov	w0, w2
               	b	<addr>
               	ldr	x1, [x0, #0x8]
               	ldr	w2, [x0, #0x10]
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0x7fff, lsl #48
               	sub	x3, x3, x1
               	mov	w1, w2
               	cmp	x1, x3
               	b.hs	<addr>
               	mov	w1, w1
               	sxtw	x1, w1
               	b	<addr>
               	mov	w1, w3
               	b	<addr>
               	ldr	x1, [x0, #0x8]
               	ldr	w2, [x0, #0x10]
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0x7fff, lsl #48
               	sub	x3, x3, x1
               	mov	w1, w2
               	cmp	x1, x3
               	b.hs	<addr>
               	mov	w1, w1
               	sxtw	x1, w1
               	b	<addr>
               	mov	w1, w3
               	b	<addr>
