
struct_field_assign_from_call.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x0, #0x4                // =4
               	str	w0, [x1]
               	mov	x0, #0xabcd             // =43981
               	movk	x0, #0x1234, lsl #16
               	ret

<wrap>:
               	stp	x20, x21, [sp, #-0x40]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x29, x30, [sp, #0x30]
               	add	x29, sp, #0x30
               	mov	x20, x0
               	mov	x21, x1
               	ldr	x22, [x20, #0x8]
               	ldr	x25, [x20, #0x18]
               	add	x1, x20, #0x14
               	ldrsw	x0, [x20, #0x10]
               	add	x2, x0, #0x1
               	mov	x23, #0x10              // =16
               	mov	x24, #0x7fff            // =32767
               	mov	x0, x22
               	mov	x5, x21
               	mov	x4, x24
               	mov	x3, x23
               	bl	<addr>
               	str	x0, [x20, #0x8]
               	ldr	x0, [x20, #0x18]
               	add	x1, x20, #0x24
               	ldrsw	x2, [x20, #0x20]
               	add	x2, x2, #0x1
               	mov	x3, x23
               	mov	x5, x21
               	mov	x4, x24
               	bl	<addr>
               	str	x0, [x20, #0x18]
               	ldr	x0, [x20, #0x8]
               	cmp	x22, x0
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldr	x0, [x20, #0x18]
               	cmp	x25, x0
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldr	x0, [x20, #0x8]
               	mov	x17, #0xabcd            // =43981
               	movk	x17, #0x1234, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldr	x0, [x20, #0x18]
               	mov	x17, #0xabcd            // =43981
               	movk	x17, #0x1234, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldrsw	x0, [x20, #0x14]
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	ldrsw	x0, [x20, #0x24]
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x40
               	ret

<main>:
               	str	x20, [sp, #-0x30]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	adrp	x20, <page>
               	add	x20, x20, <lo12>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x1, w0
               	cmp	x1, #0x0
               	b.eq	<addr>
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	sxtw	x0, w0
               	ldr	x2, [x20, #0x8]
               	ldr	x3, [x20, #0x18]
               	ldrsw	x4, [x20, #0x14]
               	ldrsw	x5, [x20, #0x24]
               	mov	x16, x1
               	mov	x1, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0x30
               	ret
