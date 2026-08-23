
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
               	ldr	x3, [x0, #0x8]
               	ldr	x4, [x0, #0x18]
               	mov	x1, #0x4                // =4
               	str	w1, [x0, #0x14]
               	mov	x2, #0xabcd             // =43981
               	movk	x2, #0x1234, lsl #16
               	str	x2, [x0, #0x8]
               	str	w1, [x0, #0x24]
               	str	x2, [x0, #0x18]
               	cmp	x3, x2
               	b.ne	<addr>
               	mov	x1, #0x1                // =1
               	sxtw	x2, w1
               	cbz	x2, <addr>
               	adrp	x3, <page>
               	add	x3, x3, <lo12>
               	ldr	x1, [x0, #0x8]
               	ldr	x4, [x0, #0x18]
               	ldrsw	x5, [x0, #0x14]
               	ldrsw	x0, [x0, #0x24]
               	mov	x16, x3
               	mov	x3, x4
               	mov	x4, x5
               	mov	x5, x0
               	mov	x0, x16
               	mov	x16, x1
               	mov	x1, x2
               	mov	x2, x16
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
               	ldr	x2, [x0, #0x18]
               	cmp	x4, x2
               	b.ne	<addr>
               	mov	x1, #0x2                // =2
               	b	<addr>
               	ldr	x2, [x0, #0x8]
               	mov	x17, #0xabcd            // =43981
               	movk	x17, #0x1234, lsl #16
               	cmp	x2, x17
               	b.eq	<addr>
               	mov	x1, #0x3                // =3
               	b	<addr>
               	ldr	x2, [x0, #0x18]
               	mov	x17, #0xabcd            // =43981
               	movk	x17, #0x1234, lsl #16
               	cmp	x2, x17
               	b.eq	<addr>
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
