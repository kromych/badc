
struct_field_assign_from_call.aarch64:	file format elf64-littleaarch64

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

<main>:
               	str	x19, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x0, #0x8]
               	ldr	x3, [x0, #0x18]
               	mov	x1, #0x4                // =4
               	str	w1, [x0, #0x14]
               	mov	x1, #0xabcd             // =43981
               	movk	x1, #0x1234, lsl #16
               	str	x1, [x0, #0x8]
               	mov	x4, #0x4                // =4
               	str	w4, [x0, #0x24]
               	mov	x4, #0xabcd             // =43981
               	movk	x4, #0x1234, lsl #16
               	str	x4, [x0, #0x18]
               	cmp	x2, x1
               	b.ne	<addr>
               	mov	x1, #0x1                // =1
               	sxtw	x2, w1
               	cbz	x2, <addr>
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	sxtw	x1, w1
               	ldr	x3, [x0, #0x8]
               	ldr	x4, [x0, #0x18]
               	ldrsw	x5, [x0, #0x14]
               	ldrsw	x0, [x0, #0x24]
               	mov	x16, x2
               	mov	x2, x3
               	mov	x3, x4
               	mov	x4, x5
               	mov	x5, x0
               	mov	x0, x16
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x19, [sp], #0x20
               	ret
               	ldr	x1, [x0, #0x18]
               	cmp	x3, x1
               	b.ne	<addr>
               	mov	x1, #0x2                // =2
               	b	<addr>
               	ldr	x1, [x0, #0x8]
               	mov	x17, #0xabcd            // =43981
               	movk	x17, #0x1234, lsl #16
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x1, #0x3                // =3
               	b	<addr>
               	ldr	x1, [x0, #0x18]
               	mov	x17, #0xabcd            // =43981
               	movk	x17, #0x1234, lsl #16
               	cmp	x1, x17
               	b.eq	<addr>
               	mov	x1, #0x4                // =4
               	b	<addr>
               	ldrsw	x1, [x0, #0x14]
               	cmp	x1, #0x4
               	b.eq	<addr>
               	mov	x1, #0x5                // =5
               	b	<addr>
               	ldrsw	x1, [x0, #0x24]
               	cmp	x1, #0x4
               	b.eq	<addr>
               	mov	x1, #0x6                // =6
               	b	<addr>
               	mov	x1, #0x0                // =0
               	b	<addr>
