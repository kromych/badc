
pointer_to_array_typedef_deref_decays.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x60
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	stur	x0, [x29, #-0x50]
               	sub	x0, x29, #0x40
               	stur	x0, [x29, #-0x48]
               	ldur	x1, [x29, #-0x50]
               	str	x1, [x0]
               	ldur	x1, [x29, #-0x50]
               	str	x1, [x0, #0x38]
               	ldur	x1, [x29, #-0x48]
               	ldur	x2, [x29, #-0x50]
               	mov	x17, #0x4568            // =17768
               	movk	x17, #0x123, lsl #16
               	add	x2, x2, x17
               	str	x2, [x1]
               	add	x2, x2, #0x1
               	str	x2, [x1, #0x38]
               	ldr	x2, [x0]
               	mov	x17, #0x4567            // =17767
               	movk	x17, #0x123, lsl #16
               	cmp	x2, x17
               	cset	x2, ne
               	cbnz	x2, <addr>
               	ldr	x0, [x0, #0x38]
               	mov	x17, #0x4568            // =17768
               	movk	x17, #0x123, lsl #16
               	cmp	x0, x17
               	cset	x2, ne
               	cbz	x2, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x1]
               	mov	x17, #0x4567            // =17767
               	movk	x17, #0x123, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldr	x0, [x1, #0x38]
               	mov	x17, #0x4568            // =17768
               	movk	x17, #0x123, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	b	<addr>
