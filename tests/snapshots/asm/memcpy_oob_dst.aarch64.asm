
memcpy_oob_dst.aarch64:	file format elf64-littleaarch64

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
               	str	x20, [sp, #-0x20]!
               	stp	x29, x30, [sp, #0x10]
               	add	x29, sp, #0x10
               	mov	x0, #0x64               // =100
               	bl	<addr>
               	mov	x20, x0
               	mov	x0, #0x8                // =8
               	bl	<addr>
               	ldp	x16, x17, [x20]
               	stp	x16, x17, [x0]
               	ldp	x16, x17, [x20, #0x10]
               	stp	x16, x17, [x0, #0x10]
               	ldp	x16, x17, [x20, #0x20]
               	stp	x16, x17, [x0, #0x20]
               	ldp	x16, x17, [x20, #0x30]
               	stp	x16, x17, [x0, #0x30]
               	ldp	x16, x17, [x20, #0x40]
               	stp	x16, x17, [x0, #0x40]
               	ldp	x16, x17, [x20, #0x50]
               	stp	x16, x17, [x0, #0x50]
               	ldr	w16, [x20, #0x60]
               	str	w16, [x0, #0x60]
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x10]
               	ldr	x20, [sp], #0x20
               	ret
