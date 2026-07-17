
pointer_to_array_typedef_deref_decays.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x270              // =624
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x60
               	sub	x1, x29, #0x40
               	mov	x0, #0xffff             // =65535
               	movk	x0, #0xffff, lsl #16
               	movk	x0, #0xffff, lsl #32
               	movk	x0, #0xffff, lsl #48
               	str	x0, [x1]
               	sub	x1, x29, #0x40
               	str	x0, [x1, #0x38]
               	sub	x0, x29, #0x48
               	sub	x1, x29, #0x40
               	str	x1, [x0]
               	sub	x0, x29, #0x48
               	ldr	x0, [x0]
               	mov	x1, #0x4567             // =17767
               	movk	x1, #0x123, lsl #16
               	str	x1, [x0]
               	mov	x1, #0x4568             // =17768
               	movk	x1, #0x123, lsl #16
               	str	x1, [x0, #0x38]
               	sub	x0, x29, #0x40
               	ldr	x0, [x0]
               	mov	x17, #0x4567            // =17767
               	movk	x17, #0x123, lsl #16
               	cmp	x0, x17
               	cset	x0, ne
               	cbnz	x0, <addr>
               	sub	x0, x29, #0x40
               	ldr	x0, [x0, #0x38]
               	mov	x17, #0x4568            // =17768
               	movk	x17, #0x123, lsl #16
               	cmp	x0, x17
               	cset	x0, ne
               	cbz	x0, <addr>
               	mov	x0, #0x1                // =1
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x48
               	ldr	x0, [x0]
               	ldr	x0, [x0]
               	mov	x17, #0x4567            // =17767
               	movk	x17, #0x123, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	add	sp, sp, #0x60
               	ldp	x29, x30, [sp], #0x10
               	ret
               	sub	x0, x29, #0x48
               	ldr	x0, [x0]
               	ldr	x0, [x0, #0x38]
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
