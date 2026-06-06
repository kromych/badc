
ssa_call_result_spill.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	<addr>
               	adrp	x16, <page>
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	sxtw	x1, w1
               	lsr	x2, x0, x1
               	mov	x3, #0x40               // =64
               	sub	x1, x3, x1
               	sxtw	x1, w1
               	lsl	x0, x0, x1
               	orr	x0, x2, x0
               	ret
               	and	x1, x0, x1
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	eor	x0, x0, x17
               	and	x0, x0, x2
               	eor	x0, x1, x0
               	ret
               	ror	x1, x0, #0xe
               	ror	x2, x0, #0x12
               	eor	x1, x1, x2
               	ror	x0, x0, #0x29
               	eor	x0, x1, x0
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xd0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	str	x25, [sp, #0x28]
               	str	x26, [sp, #0x30]
               	str	x27, [sp, #0x38]
               	str	x28, [sp, #0x40]
               	mov	x28, #0x100             // =256
               	mov	x27, #0x200             // =512
               	mov	x26, #0x400             // =1024
               	mov	x25, #0x800             // =2048
               	mov	x24, #0x1000            // =4096
               	mov	x23, #0x2000            // =8192
               	mov	x22, #0x4000            // =16384
               	mov	x21, #0x8000            // =32768
               	mov	x20, #0x0               // =0
               	b	<addr>
               	sxtw	x0, w20
               	cmp	x0, #0x4
               	b.ge	<addr>
               	b	<addr>
               	sxtw	x0, w20
               	add	x20, x0, #0x1
               	mov	x21, x22
               	mov	x22, x23
               	mov	x23, x24
               	mov	x24, x1
               	mov	x25, x26
               	mov	x26, x27
               	mov	x27, x28
               	mov	x28, x2
               	b	<addr>
               	mov	x0, x24
               	bl	<addr>
               	str	x0, [sp, #0x58]
               	mov	x0, x24
               	mov	x2, x22
               	mov	x1, x23
               	bl	<addr>
               	ldr	x16, [sp, #0x58]
               	add	x0, x16, x0
               	add	x21, x0, x21
               	mov	x0, x28
               	bl	<addr>
               	add	x1, x25, x21
               	add	x2, x21, x0
               	b	<addr>
               	mov	x17, #0xbb19            // =47897
               	movk	x17, #0xde61, lsl #16
               	movk	x17, #0x5d88, lsl #32
               	movk	x17, #0x30a5, lsl #48
               	cmp	x28, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x28, [sp, #0x40]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x17, #0xc800            // =51200
               	movk	x17, #0x8, lsl #32
               	movk	x17, #0x4400, lsl #48
               	cmp	x21, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x28, [sp, #0x40]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	ldr	x25, [sp, #0x28]
               	ldr	x26, [sp, #0x30]
               	ldr	x27, [sp, #0x38]
               	ldr	x28, [sp, #0x40]
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
