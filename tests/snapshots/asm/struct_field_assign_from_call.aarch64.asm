
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
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	ldr	x3, [x1, #0x8]
               	ldr	x4, [x1, #0x18]
               	mov	x0, #0x4                // =4
               	str	w0, [x1, #0x14]
               	mov	x2, #0xabcd             // =43981
               	movk	x2, #0x1234, lsl #16
               	str	x2, [x1, #0x8]
               	str	w0, [x1, #0x24]
               	str	x2, [x1, #0x18]
               	mov	x17, #0xabcd            // =43981
               	movk	x17, #0x1234, lsl #16
               	cmp	x3, x17
               	b.ne	<addr>
               	mov	x6, #0x1                // =1
               	cbz	w6, <addr>
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	ldr	x2, [x1, #0x8]
               	ldr	x3, [x1, #0x18]
               	ldrsw	x4, [x1, #0x14]
               	ldrsw	x5, [x1, #0x24]
               	mov	x1, x6
               	bl	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	bl	<addr>
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xabcd            // =43981
               	movk	x17, #0x1234, lsl #16
               	cmp	x4, x17
               	b.ne	<addr>
               	mov	x6, #0x2                // =2
               	b	<addr>
               	mov	x6, #0x0                // =0
               	b	<addr>
