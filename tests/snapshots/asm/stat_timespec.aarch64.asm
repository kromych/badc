
stat_timespec.aarch64:	file format elf64-littleaarch64

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
               	str	x20, [sp, #-0xc0]!
               	str	x19, [sp, #0x10]
               	stp	x29, x30, [sp, #0xb0]
               	add	x29, sp, #0xb0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x20, x29, #0x80
               	mov	x1, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xb0]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xc0
               	ret
               	ldr	x0, [x20, #0x58]
               	cmp	x0, x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xb0]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xc0
               	ret
               	ldr	x0, [x20, #0x58]
               	mov	x17, #0xca00            // =51712
               	movk	x17, #0x3b9a, lsl #16
               	cmp	x0, x17
               	b.ge	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xb0]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xc0
               	ret
               	ldrsw	x0, [x20, #0x10]
               	mov	x17, #0xf000            // =61440
               	and	x0, x0, x17
               	mov	x17, #0x4000            // =16384
               	cmp	w0, w17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0xb0]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xc0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xb0]
               	ldr	x19, [sp, #0x10]
               	ldr	x20, [sp], #0xc0
               	ret
