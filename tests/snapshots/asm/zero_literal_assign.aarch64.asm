
zero_literal_assign.aarch64:	file format elf64-littleaarch64

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

<zero_pointer>:
               	stp	xzr, xzr, [x0]
               	mov	x0, #0x0                // =0
               	ret

<zero_designated>:
               	stp	xzr, xzr, [x0]
               	mov	x0, #0x0                // =0
               	ret

<zero_bytes>:
               	strh	wzr, [x0]
               	strb	wzr, [x0, #0x2]
               	mov	x0, #0x0                // =0
               	ret

<zero_mixed>:
               	str	xzr, [x0]
               	mov	x0, #0x0                // =0
               	ret

<zero_tail>:
               	str	xzr, [x0]
               	str	wzr, [x0, #0x8]
               	strb	wzr, [x0, #0xc]
               	mov	x0, #0x0                // =0
               	ret

<zero_union>:
               	stp	xzr, xzr, [x0]
               	mov	x0, #0x0                // =0
               	ret

<zero_chained>:
               	stp	xzr, xzr, [x0]
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	ret

<zero_above_bound>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x260
               	mov	x1, x0
               	sub	x0, x29, #0x258
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [x2, #0x10]
               	str	x10, [x0, #0x10]
               	ldr	x10, [x2, #0x18]
               	str	x10, [x0, #0x18]
               	ldr	x10, [x2, #0x20]
               	str	x10, [x0, #0x20]
               	ldr	x10, [x2, #0x28]
               	str	x10, [x0, #0x28]
               	ldr	x10, [x2, #0x30]
               	str	x10, [x0, #0x30]
               	ldr	x10, [x2, #0x38]
               	str	x10, [x0, #0x38]
               	ldr	x10, [x2, #0x40]
               	str	x10, [x0, #0x40]
               	ldr	x10, [x2, #0x48]
               	str	x10, [x0, #0x48]
               	ldr	x10, [x2, #0x50]
               	str	x10, [x0, #0x50]
               	ldr	x10, [x2, #0x58]
               	str	x10, [x0, #0x58]
               	ldr	x10, [x2, #0x60]
               	str	x10, [x0, #0x60]
               	ldr	x10, [x2, #0x68]
               	str	x10, [x0, #0x68]
               	ldr	x10, [x2, #0x70]
               	str	x10, [x0, #0x70]
               	ldr	x10, [x2, #0x78]
               	str	x10, [x0, #0x78]
               	ldr	x10, [x2, #0x80]
               	str	x10, [x0, #0x80]
               	ldr	x10, [x2, #0x88]
               	str	x10, [x0, #0x88]
               	ldr	x10, [x2, #0x90]
               	str	x10, [x0, #0x90]
               	ldr	x10, [x2, #0x98]
               	str	x10, [x0, #0x98]
               	ldr	x10, [x2, #0xa0]
               	str	x10, [x0, #0xa0]
               	ldr	x10, [x2, #0xa8]
               	str	x10, [x0, #0xa8]
               	ldr	x10, [x2, #0xb0]
               	str	x10, [x0, #0xb0]
               	ldr	x10, [x2, #0xb8]
               	str	x10, [x0, #0xb8]
               	ldr	x10, [x2, #0xc0]
               	str	x10, [x0, #0xc0]
               	ldr	x10, [x2, #0xc8]
               	str	x10, [x0, #0xc8]
               	ldr	x10, [x2, #0xd0]
               	str	x10, [x0, #0xd0]
               	ldr	x10, [x2, #0xd8]
               	str	x10, [x0, #0xd8]
               	ldr	x10, [x2, #0xe0]
               	str	x10, [x0, #0xe0]
               	ldr	x10, [x2, #0xe8]
               	str	x10, [x0, #0xe8]
               	ldr	x10, [x2, #0xf0]
               	str	x10, [x0, #0xf0]
               	ldr	x10, [x2, #0xf8]
               	str	x10, [x0, #0xf8]
               	ldr	x10, [x2, #0x100]
               	str	x10, [x0, #0x100]
               	ldr	x10, [x2, #0x108]
               	str	x10, [x0, #0x108]
               	ldr	x10, [x2, #0x110]
               	str	x10, [x0, #0x110]
               	ldr	x10, [x2, #0x118]
               	str	x10, [x0, #0x118]
               	ldr	x10, [x2, #0x120]
               	str	x10, [x0, #0x120]
               	ldr	x10, [x2, #0x128]
               	str	x10, [x0, #0x128]
               	ldr	x10, [x2, #0x130]
               	str	x10, [x0, #0x130]
               	ldr	x10, [x2, #0x138]
               	str	x10, [x0, #0x138]
               	ldr	x10, [x2, #0x140]
               	str	x10, [x0, #0x140]
               	ldr	x10, [x2, #0x148]
               	str	x10, [x0, #0x148]
               	ldr	x10, [x2, #0x150]
               	str	x10, [x0, #0x150]
               	ldr	x10, [x2, #0x158]
               	str	x10, [x0, #0x158]
               	ldr	x10, [x2, #0x160]
               	str	x10, [x0, #0x160]
               	ldr	x10, [x2, #0x168]
               	str	x10, [x0, #0x168]
               	ldr	x10, [x2, #0x170]
               	str	x10, [x0, #0x170]
               	ldr	x10, [x2, #0x178]
               	str	x10, [x0, #0x178]
               	ldr	x10, [x2, #0x180]
               	str	x10, [x0, #0x180]
               	ldr	x10, [x2, #0x188]
               	str	x10, [x0, #0x188]
               	ldr	x10, [x2, #0x190]
               	str	x10, [x0, #0x190]
               	ldr	x10, [x2, #0x198]
               	str	x10, [x0, #0x198]
               	ldr	x10, [x2, #0x1a0]
               	str	x10, [x0, #0x1a0]
               	ldr	x10, [x2, #0x1a8]
               	str	x10, [x0, #0x1a8]
               	ldr	x10, [x2, #0x1b0]
               	str	x10, [x0, #0x1b0]
               	ldr	x10, [x2, #0x1b8]
               	str	x10, [x0, #0x1b8]
               	ldr	x10, [x2, #0x1c0]
               	str	x10, [x0, #0x1c0]
               	ldr	x10, [x2, #0x1c8]
               	str	x10, [x0, #0x1c8]
               	ldr	x10, [x2, #0x1d0]
               	str	x10, [x0, #0x1d0]
               	ldr	x10, [x2, #0x1d8]
               	str	x10, [x0, #0x1d8]
               	ldr	x10, [x2, #0x1e0]
               	str	x10, [x0, #0x1e0]
               	ldr	x10, [x2, #0x1e8]
               	str	x10, [x0, #0x1e8]
               	ldr	x10, [x2, #0x1f0]
               	str	x10, [x0, #0x1f0]
               	ldr	x10, [x2, #0x1f8]
               	str	x10, [x0, #0x1f8]
               	ldr	x10, [x2, #0x200]
               	str	x10, [x0, #0x200]
               	ldr	x10, [x2, #0x208]
               	str	x10, [x0, #0x208]
               	ldr	x10, [x2, #0x210]
               	str	x10, [x0, #0x210]
               	ldr	x10, [x2, #0x218]
               	str	x10, [x0, #0x218]
               	ldr	x10, [x2, #0x220]
               	str	x10, [x0, #0x220]
               	ldr	x10, [x2, #0x228]
               	str	x10, [x0, #0x228]
               	ldr	x10, [x2, #0x230]
               	str	x10, [x0, #0x230]
               	ldr	x10, [x2, #0x238]
               	str	x10, [x0, #0x238]
               	ldr	x10, [x2, #0x240]
               	str	x10, [x0, #0x240]
               	ldr	x10, [x2, #0x248]
               	str	x10, [x0, #0x248]
               	ldr	x10, [x2, #0x250]
               	str	x10, [x0, #0x250]
               	ldr	x10, [sp], #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [x0, #0x10]
               	str	x10, [x1, #0x10]
               	ldr	x10, [x0, #0x18]
               	str	x10, [x1, #0x18]
               	ldr	x10, [x0, #0x20]
               	str	x10, [x1, #0x20]
               	ldr	x10, [x0, #0x28]
               	str	x10, [x1, #0x28]
               	ldr	x10, [x0, #0x30]
               	str	x10, [x1, #0x30]
               	ldr	x10, [x0, #0x38]
               	str	x10, [x1, #0x38]
               	ldr	x10, [x0, #0x40]
               	str	x10, [x1, #0x40]
               	ldr	x10, [x0, #0x48]
               	str	x10, [x1, #0x48]
               	ldr	x10, [x0, #0x50]
               	str	x10, [x1, #0x50]
               	ldr	x10, [x0, #0x58]
               	str	x10, [x1, #0x58]
               	ldr	x10, [x0, #0x60]
               	str	x10, [x1, #0x60]
               	ldr	x10, [x0, #0x68]
               	str	x10, [x1, #0x68]
               	ldr	x10, [x0, #0x70]
               	str	x10, [x1, #0x70]
               	ldr	x10, [x0, #0x78]
               	str	x10, [x1, #0x78]
               	ldr	x10, [x0, #0x80]
               	str	x10, [x1, #0x80]
               	ldr	x10, [x0, #0x88]
               	str	x10, [x1, #0x88]
               	ldr	x10, [x0, #0x90]
               	str	x10, [x1, #0x90]
               	ldr	x10, [x0, #0x98]
               	str	x10, [x1, #0x98]
               	ldr	x10, [x0, #0xa0]
               	str	x10, [x1, #0xa0]
               	ldr	x10, [x0, #0xa8]
               	str	x10, [x1, #0xa8]
               	ldr	x10, [x0, #0xb0]
               	str	x10, [x1, #0xb0]
               	ldr	x10, [x0, #0xb8]
               	str	x10, [x1, #0xb8]
               	ldr	x10, [x0, #0xc0]
               	str	x10, [x1, #0xc0]
               	ldr	x10, [x0, #0xc8]
               	str	x10, [x1, #0xc8]
               	ldr	x10, [x0, #0xd0]
               	str	x10, [x1, #0xd0]
               	ldr	x10, [x0, #0xd8]
               	str	x10, [x1, #0xd8]
               	ldr	x10, [x0, #0xe0]
               	str	x10, [x1, #0xe0]
               	ldr	x10, [x0, #0xe8]
               	str	x10, [x1, #0xe8]
               	ldr	x10, [x0, #0xf0]
               	str	x10, [x1, #0xf0]
               	ldr	x10, [x0, #0xf8]
               	str	x10, [x1, #0xf8]
               	ldr	x10, [x0, #0x100]
               	str	x10, [x1, #0x100]
               	ldr	x10, [x0, #0x108]
               	str	x10, [x1, #0x108]
               	ldr	x10, [x0, #0x110]
               	str	x10, [x1, #0x110]
               	ldr	x10, [x0, #0x118]
               	str	x10, [x1, #0x118]
               	ldr	x10, [x0, #0x120]
               	str	x10, [x1, #0x120]
               	ldr	x10, [x0, #0x128]
               	str	x10, [x1, #0x128]
               	ldr	x10, [x0, #0x130]
               	str	x10, [x1, #0x130]
               	ldr	x10, [x0, #0x138]
               	str	x10, [x1, #0x138]
               	ldr	x10, [x0, #0x140]
               	str	x10, [x1, #0x140]
               	ldr	x10, [x0, #0x148]
               	str	x10, [x1, #0x148]
               	ldr	x10, [x0, #0x150]
               	str	x10, [x1, #0x150]
               	ldr	x10, [x0, #0x158]
               	str	x10, [x1, #0x158]
               	ldr	x10, [x0, #0x160]
               	str	x10, [x1, #0x160]
               	ldr	x10, [x0, #0x168]
               	str	x10, [x1, #0x168]
               	ldr	x10, [x0, #0x170]
               	str	x10, [x1, #0x170]
               	ldr	x10, [x0, #0x178]
               	str	x10, [x1, #0x178]
               	ldr	x10, [x0, #0x180]
               	str	x10, [x1, #0x180]
               	ldr	x10, [x0, #0x188]
               	str	x10, [x1, #0x188]
               	ldr	x10, [x0, #0x190]
               	str	x10, [x1, #0x190]
               	ldr	x10, [x0, #0x198]
               	str	x10, [x1, #0x198]
               	ldr	x10, [x0, #0x1a0]
               	str	x10, [x1, #0x1a0]
               	ldr	x10, [x0, #0x1a8]
               	str	x10, [x1, #0x1a8]
               	ldr	x10, [x0, #0x1b0]
               	str	x10, [x1, #0x1b0]
               	ldr	x10, [x0, #0x1b8]
               	str	x10, [x1, #0x1b8]
               	ldr	x10, [x0, #0x1c0]
               	str	x10, [x1, #0x1c0]
               	ldr	x10, [x0, #0x1c8]
               	str	x10, [x1, #0x1c8]
               	ldr	x10, [x0, #0x1d0]
               	str	x10, [x1, #0x1d0]
               	ldr	x10, [x0, #0x1d8]
               	str	x10, [x1, #0x1d8]
               	ldr	x10, [x0, #0x1e0]
               	str	x10, [x1, #0x1e0]
               	ldr	x10, [x0, #0x1e8]
               	str	x10, [x1, #0x1e8]
               	ldr	x10, [x0, #0x1f0]
               	str	x10, [x1, #0x1f0]
               	ldr	x10, [x0, #0x1f8]
               	str	x10, [x1, #0x1f8]
               	ldr	x10, [x0, #0x200]
               	str	x10, [x1, #0x200]
               	ldr	x10, [x0, #0x208]
               	str	x10, [x1, #0x208]
               	ldr	x10, [x0, #0x210]
               	str	x10, [x1, #0x210]
               	ldr	x10, [x0, #0x218]
               	str	x10, [x1, #0x218]
               	ldr	x10, [x0, #0x220]
               	str	x10, [x1, #0x220]
               	ldr	x10, [x0, #0x228]
               	str	x10, [x1, #0x228]
               	ldr	x10, [x0, #0x230]
               	str	x10, [x1, #0x230]
               	ldr	x10, [x0, #0x238]
               	str	x10, [x1, #0x238]
               	ldr	x10, [x0, #0x240]
               	str	x10, [x1, #0x240]
               	ldr	x10, [x0, #0x248]
               	str	x10, [x1, #0x248]
               	ldr	x10, [x0, #0x250]
               	str	x10, [x1, #0x250]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret

<copy_nonzero>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	mov	x1, x0
               	sub	x0, x29, #0x10
               	adrp	x2, <page>
               	add	x2, x2, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x2]
               	str	x10, [x0]
               	ldr	x10, [x2, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x0]
               	str	x10, [x1]
               	ldr	x10, [x0, #0x8]
               	str	x10, [x1, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<zero_local>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x0, x29, #0x8
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [sp], #0x10
               	str	xzr, [x0]
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x260
               	sub	x0, x29, #0x10
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	str	x10, [sp, #-0x10]!
               	ldr	x10, [x1]
               	str	x10, [x0]
               	ldr	x10, [x1, #0x8]
               	str	x10, [x0, #0x8]
               	ldr	x10, [sp], #0x10
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x260
               	ldp	x29, x30, [sp], #0x10
               	ret
