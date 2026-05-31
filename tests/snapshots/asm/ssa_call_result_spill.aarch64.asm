
ssa_call_result_spill.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	ldr	x0, [sp]
               	add	x1, sp, #0x8
               	bl	0x400308 <.text+0xe8>
               	adrp	x16, 0x410000
               	ldr	x16, [x16, #0xc0]
               	blr	x16
               	mov	x15, x0
               	sxtw	x14, w1
               	lsr	x13, x15, x14
               	mov	x12, #0x40              // =64
               	sub	x12, x12, x14
               	sxtw	x12, w12
               	lsl	x15, x15, x12
               	orr	x0, x13, x15
               	ret
               	mov	x15, x0
               	mov	x14, x1
               	mov	x13, x2
               	and	x12, x15, x14
               	mov	x17, #0xffff            // =65535
               	movk	x17, #0xffff, lsl #16
               	movk	x17, #0xffff, lsl #32
               	movk	x17, #0xffff, lsl #48
               	eor	x15, x15, x17
               	and	x15, x15, x13
               	eor	x0, x12, x15
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	mov	x20, x0
               	mov	x21, #0xe               // =14
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400238 <.text+0x18>
               	mov	x22, x0
               	mov	x23, #0x12              // =18
               	mov	x0, x20
               	mov	x1, x23
               	bl	0x400238 <.text+0x18>
               	eor	x22, x22, x0
               	mov	x21, #0x29              // =41
               	mov	x0, x20
               	mov	x1, x21
               	bl	0x400238 <.text+0x18>
               	eor	x22, x22, x0
               	mov	x0, x22
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	ret
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xa0
               	str	x20, [sp]
               	str	x21, [sp, #0x8]
               	str	x22, [sp, #0x10]
               	str	x23, [sp, #0x18]
               	str	x24, [sp, #0x20]
               	mov	x15, #0x100             // =256
               	stur	x15, [x29, #-0x8]
               	mov	x14, #0x200             // =512
               	stur	x14, [x29, #-0x10]
               	mov	x15, #0x400             // =1024
               	stur	x15, [x29, #-0x18]
               	mov	x14, #0x800             // =2048
               	stur	x14, [x29, #-0x20]
               	mov	x15, #0x1000            // =4096
               	stur	x15, [x29, #-0x28]
               	mov	x14, #0x2000            // =8192
               	stur	x14, [x29, #-0x30]
               	mov	x15, #0x4000            // =16384
               	stur	x15, [x29, #-0x38]
               	mov	x14, #0x8000            // =32768
               	stur	x14, [x29, #-0x40]
               	mov	x15, #0x0               // =0
               	stur	w15, [x29, #-0x48]
               	b	0x400374 <.text+0x154>
               	ldursw	x15, [x29, #-0x48]
               	cmp	x15, #0x4
               	b.ge	0x400434 <.text+0x214>
               	b	0x400398 <.text+0x178>
               	sub	x14, x29, #0x48
               	ldrsw	x15, [x14]
               	add	x15, x15, #0x1
               	str	w15, [x14]
               	b	0x400374 <.text+0x154>
               	ldur	x20, [x29, #-0x28]
               	mov	x0, x20
               	bl	0x40028c <.text+0x6c>
               	mov	x21, x0
               	ldur	x22, [x29, #-0x28]
               	ldur	x20, [x29, #-0x30]
               	ldur	x23, [x29, #-0x38]
               	mov	x0, x22
               	mov	x2, x23
               	mov	x1, x20
               	bl	0x40025c <.text+0x3c>
               	add	x21, x21, x0
               	ldur	x0, [x29, #-0x40]
               	add	x21, x21, x0
               	stur	x21, [x29, #-0x50]
               	ldur	x24, [x29, #-0x8]
               	mov	x0, x24
               	bl	0x40028c <.text+0x6c>
               	stur	x0, [x29, #-0x58]
               	ldur	x24, [x29, #-0x38]
               	stur	x24, [x29, #-0x40]
               	ldur	x0, [x29, #-0x30]
               	stur	x0, [x29, #-0x38]
               	ldur	x24, [x29, #-0x28]
               	stur	x24, [x29, #-0x30]
               	ldur	x0, [x29, #-0x20]
               	ldur	x24, [x29, #-0x50]
               	add	x0, x0, x24
               	stur	x0, [x29, #-0x28]
               	ldur	x23, [x29, #-0x18]
               	stur	x23, [x29, #-0x20]
               	ldur	x0, [x29, #-0x10]
               	stur	x0, [x29, #-0x18]
               	ldur	x23, [x29, #-0x8]
               	stur	x23, [x29, #-0x10]
               	ldur	x0, [x29, #-0x58]
               	add	x24, x24, x0
               	stur	x24, [x29, #-0x8]
               	b	0x400384 <.text+0x164>
               	ldur	x24, [x29, #-0x8]
               	mov	x17, #0xbb19            // =47897
               	movk	x17, #0xde61, lsl #16
               	movk	x17, #0x5d88, lsl #32
               	movk	x17, #0x30a5, lsl #48
               	cmp	x24, x17
               	b.eq	0x400474 <.text+0x254>
               	mov	x0, #0x1                // =1
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	ldur	x24, [x29, #-0x40]
               	mov	x17, #0xc800            // =51200
               	movk	x17, #0x8, lsl #32
               	movk	x17, #0x4400, lsl #48
               	cmp	x24, x17
               	b.eq	0x4004b0 <.text+0x290>
               	mov	x0, #0x2                // =2
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x24, #0x0               // =0
               	mov	x0, x24
               	ldr	x20, [sp]
               	ldr	x21, [sp, #0x8]
               	ldr	x22, [sp, #0x10]
               	ldr	x23, [sp, #0x18]
               	ldr	x24, [sp, #0x20]
               	add	sp, sp, #0xa0
               	ldp	x29, x30, [sp], #0x10
               	ret
