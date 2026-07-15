
struct_field_assign_from_call.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x2b0              // =688
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	mov	x2, x1
               	ldr	x3, [x0, #0x8]
               	ldr	x4, [x0, #0x18]
               	mov	x1, #0x4                // =4
               	str	w1, [x0, #0x14]
               	mov	x1, #0xabcd             // =43981
               	movk	x1, #0x1234, lsl #16
               	str	x1, [x0, #0x8]
               	mov	x1, #0x4                // =4
               	str	w1, [x0, #0x24]
               	mov	x1, #0xabcd             // =43981
               	movk	x1, #0x1234, lsl #16
               	str	x1, [x0, #0x18]
               	ldr	x1, [x0, #0x8]
               	cmp	x3, x1
               	b.ne	<addr>
               	mov	x0, #0x1                // =1
               	ret
               	ldr	x1, [x0, #0x18]
               	cmp	x4, x1
               	b.ne	<addr>
               	mov	x0, #0x2                // =2
               	ret
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xabcd            // =43981
               	movk	x17, #0x1234, lsl #16
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ret
               	ldr	x1, [x0, #0x18]
               	mov	x17, #0xabcd            // =43981
               	movk	x17, #0x1234, lsl #16
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ret
               	ldrsw	x1, [x0, #0x14]
               	cmp	x1, #0x4
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ret
               	ldrsw	x0, [x0, #0x24]
               	cmp	x0, #0x4
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ret
               	mov	x0, #0x0                // =0
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
