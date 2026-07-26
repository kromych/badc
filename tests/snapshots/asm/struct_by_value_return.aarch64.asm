
struct_by_value_return.aarch64:	file format elf64-littleaarch64

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
               	sub	sp, sp, #0x10
               	sub	x2, x29, #0x8
               	str	w0, [x2]
               	sub	x0, x29, #0x8
               	str	w1, [x0, #0x4]
               	sub	x0, x29, #0x8
               	mov	x16, x0
               	ldr	x0, [x16]
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<clobber>:
               	mov	x17, #0x1589            // =5513
               	movk	x17, #0x12, lsl #16
               	add	x0, x0, x17
               	sxtw	x1, w0
               	sxtw	x0, w1
               	ret

<sum_pair_pair>:
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x8
               	str	x0, [x16]
               	sub	x16, x29, #0x10
               	str	x1, [x16]
               	sub	x1, x29, #0x18
               	sub	x0, x29, #0x8
               	ldrsw	x0, [x0]
               	sub	x2, x29, #0x10
               	ldrsw	x2, [x2]
               	add	x0, x0, x2
               	str	w0, [x1]
               	sub	x1, x29, #0x18
               	sub	x0, x29, #0x8
               	ldrsw	x2, [x0, #0x4]
               	sub	x0, x29, #0x10
               	ldrsw	x0, [x0, #0x4]
               	add	x0, x2, x0
               	str	w0, [x1, #0x4]
               	sub	x0, x29, #0x18
               	mov	x16, x0
               	ldr	x0, [x16]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x20
               	ret

<main>:
               	mov	x0, #0x0                // =0
               	ret
