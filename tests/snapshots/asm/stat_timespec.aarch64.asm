
stat_timespec.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x3b0              // =944
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0xb0]!
               	stp	x29, x30, [sp, #0xa0]
               	add	x29, sp, #0xa0
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	sub	x1, x29, #0x80
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp], #0xb0
               	ret
               	sub	x0, x29, #0x80
               	ldr	x1, [x0, #0x58]
               	sub	x0, x29, #0x80
               	ldr	x0, [x0, #0x58]
               	cmp	x1, x0
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp], #0xb0
               	ret
               	sub	x0, x29, #0x80
               	ldr	x0, [x0, #0x58]
               	mov	x17, #0xca00            // =51712
               	movk	x17, #0x3b9a, lsl #16
               	cmp	x0, x17
               	b.ge	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp], #0xb0
               	ret
               	sub	x0, x29, #0x80
               	ldrsw	x0, [x0, #0x10]
               	mov	x17, #0xf000            // =61440
               	and	x0, x0, x17
               	mov	x17, #0x4000            // =16384
               	cmp	x0, x17
               	cset	x0, eq
               	cmp	x0, #0x0
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp], #0xb0
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0xa0]
               	ldr	x19, [sp], #0xb0
               	ret
