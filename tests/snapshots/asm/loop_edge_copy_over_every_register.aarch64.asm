
loop_edge_copy_over_every_register.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<_start>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, <entry_off>
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#0x1
               	brk	#0x1
               	brk	#0x1

<mix>:
               	stp	x20, x21, [sp, #-0x80]!
               	stp	x22, x23, [sp, #0x10]
               	stp	x24, x25, [sp, #0x20]
               	stp	x26, x27, [sp, #0x30]
               	str	x28, [sp, #0x40]
               	stp	x29, x30, [sp, #0x70]
               	add	x29, sp, #0x70
               	mov	x21, x0
               	str	x2, [sp, #0x68]
               	mov	x22, x1
               	ldr	x12, [x21]
               	ldr	x0, [x22]
               	eor	x5, x0, x12
               	ldr	x13, [x21, #0x8]
               	ldr	x0, [x22, #0x8]
               	eor	x6, x0, x13
               	ldr	x14, [x21, #0x10]
               	ldr	x0, [x22, #0x10]
               	eor	x7, x0, x14
               	ldr	x15, [x21, #0x18]
               	ldr	x0, [x22, #0x18]
               	eor	x8, x0, x15
               	ldr	x0, [x21, #0x20]
               	ldr	x1, [x22, #0x20]
               	eor	x9, x1, x0
               	ldr	x1, [x21, #0x28]
               	ldr	x2, [x22, #0x28]
               	eor	x10, x2, x1
               	ldr	x2, [x21, #0x30]
               	ldr	x3, [x22, #0x30]
               	eor	x11, x3, x2
               	ldr	x3, [x21, #0x38]
               	ldr	x4, [x22, #0x38]
               	eor	x4, x4, x3
               	mov	x20, #0x0               // =0
               	str	x22, [sp, #0x50]
               	adrp	x22, <addr>
               	add	x22, x22, <lo12>
               	lsr	x23, x12, #56
               	ldr	x22, [x22, x23, lsl #3]
               	adrp	x23, <addr>
               	add	x23, x23, <lo12>
               	add	x23, x23, #0x800
               	ubfx	x24, x3, #48, #8
               	ldr	x23, [x23, x24, lsl #3]
               	eor	x22, x22, x23
               	adrp	x23, <addr>
               	add	x23, x23, <lo12>
               	add	x23, x23, #0x1, lsl #12 // =0x1000
               	ubfx	x24, x2, #40, #8
               	ldr	x23, [x23, x24, lsl #3]
               	eor	x22, x22, x23
               	adrp	x23, <addr>
               	add	x23, x23, <lo12>
               	mov	x17, #0x1800            // =6144
               	add	x23, x23, x17
               	ubfx	x24, x1, #32, #8
               	ldr	x23, [x23, x24, lsl #3]
               	eor	x22, x22, x23
               	adrp	x23, <addr>
               	add	x23, x23, <lo12>
               	add	x23, x23, #0x2, lsl #12 // =0x2000
               	ubfx	x24, x0, #24, #8
               	ldr	x23, [x23, x24, lsl #3]
               	eor	x22, x22, x23
               	adrp	x23, <addr>
               	add	x23, x23, <lo12>
               	mov	x17, #0x2800            // =10240
               	add	x23, x23, x17
               	ubfx	x24, x15, #16, #8
               	ldr	x23, [x23, x24, lsl #3]
               	eor	x22, x22, x23
               	adrp	x23, <addr>
               	add	x23, x23, <lo12>
               	add	x23, x23, #0x3, lsl #12 // =0x3000
               	ubfx	x24, x14, #8, #8
               	ldr	x23, [x23, x24, lsl #3]
               	eor	x22, x22, x23
               	adrp	x23, <addr>
               	add	x23, x23, <lo12>
               	mov	x17, #0x3800            // =14336
               	add	x23, x23, x17
               	and	x24, x13, #0xff
               	ldr	x23, [x23, x24, lsl #3]
               	eor	x22, x22, x23
               	ldr	x16, [sp, #0x68]
               	ldr	x23, [x16, x20, lsl #3]
               	eor	x22, x22, x23
               	adrp	x23, <addr>
               	add	x23, x23, <lo12>
               	lsr	x24, x13, #56
               	ldr	x23, [x23, x24, lsl #3]
               	adrp	x24, <addr>
               	add	x24, x24, <lo12>
               	add	x24, x24, #0x800
               	ubfx	x25, x12, #48, #8
               	ldr	x24, [x24, x25, lsl #3]
               	eor	x23, x23, x24
               	adrp	x24, <addr>
               	add	x24, x24, <lo12>
               	add	x24, x24, #0x1, lsl #12 // =0x1000
               	ubfx	x25, x3, #40, #8
               	ldr	x24, [x24, x25, lsl #3]
               	eor	x23, x23, x24
               	adrp	x24, <addr>
               	add	x24, x24, <lo12>
               	mov	x17, #0x1800            // =6144
               	add	x24, x24, x17
               	ubfx	x25, x2, #32, #8
               	ldr	x24, [x24, x25, lsl #3]
               	eor	x23, x23, x24
               	adrp	x24, <addr>
               	add	x24, x24, <lo12>
               	add	x24, x24, #0x2, lsl #12 // =0x2000
               	ubfx	x25, x1, #24, #8
               	ldr	x24, [x24, x25, lsl #3]
               	eor	x23, x23, x24
               	adrp	x24, <addr>
               	add	x24, x24, <lo12>
               	mov	x17, #0x2800            // =10240
               	add	x24, x24, x17
               	ubfx	x25, x0, #16, #8
               	ldr	x24, [x24, x25, lsl #3]
               	eor	x23, x23, x24
               	adrp	x24, <addr>
               	add	x24, x24, <lo12>
               	add	x24, x24, #0x3, lsl #12 // =0x3000
               	ubfx	x25, x15, #8, #8
               	ldr	x24, [x24, x25, lsl #3]
               	eor	x23, x23, x24
               	adrp	x24, <addr>
               	add	x24, x24, <lo12>
               	mov	x17, #0x3800            // =14336
               	add	x24, x24, x17
               	and	x25, x14, #0xff
               	ldr	x24, [x24, x25, lsl #3]
               	eor	x23, x23, x24
               	adrp	x24, <addr>
               	add	x24, x24, <lo12>
               	lsr	x25, x14, #56
               	ldr	x24, [x24, x25, lsl #3]
               	adrp	x25, <addr>
               	add	x25, x25, <lo12>
               	add	x25, x25, #0x800
               	ubfx	x26, x13, #48, #8
               	ldr	x25, [x25, x26, lsl #3]
               	eor	x24, x24, x25
               	adrp	x25, <addr>
               	add	x25, x25, <lo12>
               	add	x25, x25, #0x1, lsl #12 // =0x1000
               	ubfx	x26, x12, #40, #8
               	ldr	x25, [x25, x26, lsl #3]
               	eor	x24, x24, x25
               	adrp	x25, <addr>
               	add	x25, x25, <lo12>
               	mov	x17, #0x1800            // =6144
               	add	x25, x25, x17
               	ubfx	x26, x3, #32, #8
               	ldr	x25, [x25, x26, lsl #3]
               	eor	x24, x24, x25
               	adrp	x25, <addr>
               	add	x25, x25, <lo12>
               	add	x25, x25, #0x2, lsl #12 // =0x2000
               	ubfx	x26, x2, #24, #8
               	ldr	x25, [x25, x26, lsl #3]
               	eor	x24, x24, x25
               	adrp	x25, <addr>
               	add	x25, x25, <lo12>
               	mov	x17, #0x2800            // =10240
               	add	x25, x25, x17
               	ubfx	x26, x1, #16, #8
               	ldr	x25, [x25, x26, lsl #3]
               	eor	x24, x24, x25
               	adrp	x25, <addr>
               	add	x25, x25, <lo12>
               	add	x25, x25, #0x3, lsl #12 // =0x3000
               	ubfx	x26, x0, #8, #8
               	ldr	x25, [x25, x26, lsl #3]
               	eor	x24, x24, x25
               	adrp	x25, <addr>
               	add	x25, x25, <lo12>
               	mov	x17, #0x3800            // =14336
               	add	x25, x25, x17
               	and	x26, x15, #0xff
               	ldr	x25, [x25, x26, lsl #3]
               	eor	x24, x24, x25
               	adrp	x25, <addr>
               	add	x25, x25, <lo12>
               	lsr	x26, x15, #56
               	ldr	x25, [x25, x26, lsl #3]
               	adrp	x26, <addr>
               	add	x26, x26, <lo12>
               	add	x26, x26, #0x800
               	ubfx	x27, x14, #48, #8
               	ldr	x26, [x26, x27, lsl #3]
               	eor	x25, x25, x26
               	adrp	x26, <addr>
               	add	x26, x26, <lo12>
               	add	x26, x26, #0x1, lsl #12 // =0x1000
               	ubfx	x27, x13, #40, #8
               	ldr	x26, [x26, x27, lsl #3]
               	eor	x25, x25, x26
               	adrp	x26, <addr>
               	add	x26, x26, <lo12>
               	mov	x17, #0x1800            // =6144
               	add	x26, x26, x17
               	ubfx	x27, x12, #32, #8
               	ldr	x26, [x26, x27, lsl #3]
               	eor	x25, x25, x26
               	adrp	x26, <addr>
               	add	x26, x26, <lo12>
               	add	x26, x26, #0x2, lsl #12 // =0x2000
               	ubfx	x27, x3, #24, #8
               	ldr	x26, [x26, x27, lsl #3]
               	eor	x25, x25, x26
               	adrp	x26, <addr>
               	add	x26, x26, <lo12>
               	mov	x17, #0x2800            // =10240
               	add	x26, x26, x17
               	ubfx	x27, x2, #16, #8
               	ldr	x26, [x26, x27, lsl #3]
               	eor	x25, x25, x26
               	adrp	x26, <addr>
               	add	x26, x26, <lo12>
               	add	x26, x26, #0x3, lsl #12 // =0x3000
               	ubfx	x27, x1, #8, #8
               	ldr	x26, [x26, x27, lsl #3]
               	eor	x25, x25, x26
               	adrp	x26, <addr>
               	add	x26, x26, <lo12>
               	mov	x17, #0x3800            // =14336
               	add	x26, x26, x17
               	and	x27, x0, #0xff
               	ldr	x26, [x26, x27, lsl #3]
               	eor	x25, x25, x26
               	adrp	x26, <addr>
               	add	x26, x26, <lo12>
               	lsr	x27, x0, #56
               	ldr	x26, [x26, x27, lsl #3]
               	adrp	x27, <addr>
               	add	x27, x27, <lo12>
               	add	x27, x27, #0x800
               	ubfx	x28, x15, #48, #8
               	ldr	x27, [x27, x28, lsl #3]
               	eor	x26, x26, x27
               	adrp	x27, <addr>
               	add	x27, x27, <lo12>
               	add	x27, x27, #0x1, lsl #12 // =0x1000
               	ubfx	x28, x14, #40, #8
               	ldr	x27, [x27, x28, lsl #3]
               	eor	x26, x26, x27
               	adrp	x27, <addr>
               	add	x27, x27, <lo12>
               	mov	x17, #0x1800            // =6144
               	add	x27, x27, x17
               	ubfx	x28, x13, #32, #8
               	ldr	x27, [x27, x28, lsl #3]
               	eor	x26, x26, x27
               	adrp	x27, <addr>
               	add	x27, x27, <lo12>
               	add	x27, x27, #0x2, lsl #12 // =0x2000
               	ubfx	x28, x12, #24, #8
               	ldr	x27, [x27, x28, lsl #3]
               	eor	x26, x26, x27
               	adrp	x27, <addr>
               	add	x27, x27, <lo12>
               	mov	x17, #0x2800            // =10240
               	add	x27, x27, x17
               	ubfx	x28, x3, #16, #8
               	ldr	x27, [x27, x28, lsl #3]
               	eor	x26, x26, x27
               	adrp	x27, <addr>
               	add	x27, x27, <lo12>
               	add	x27, x27, #0x3, lsl #12 // =0x3000
               	ubfx	x28, x2, #8, #8
               	ldr	x27, [x27, x28, lsl #3]
               	eor	x26, x26, x27
               	adrp	x27, <addr>
               	add	x27, x27, <lo12>
               	mov	x17, #0x3800            // =14336
               	add	x27, x27, x17
               	and	x28, x1, #0xff
               	ldr	x27, [x27, x28, lsl #3]
               	eor	x26, x26, x27
               	adrp	x27, <addr>
               	add	x27, x27, <lo12>
               	lsr	x28, x1, #56
               	ldr	x27, [x27, x28, lsl #3]
               	adrp	x28, <addr>
               	add	x28, x28, <lo12>
               	add	x28, x28, #0x800
               	ubfx	x16, x0, #48, #8
               	str	x16, [sp, #0x60]
               	mov	x17, x16
               	ldr	x28, [x28, x17, lsl #3]
               	eor	x27, x27, x28
               	adrp	x28, <addr>
               	add	x28, x28, <lo12>
               	add	x28, x28, #0x1, lsl #12 // =0x1000
               	ubfx	x16, x15, #40, #8
               	str	x16, [sp, #0x60]
               	mov	x17, x16
               	ldr	x28, [x28, x17, lsl #3]
               	eor	x27, x27, x28
               	adrp	x28, <addr>
               	add	x28, x28, <lo12>
               	mov	x17, #0x1800            // =6144
               	add	x28, x28, x17
               	ubfx	x16, x14, #32, #8
               	str	x16, [sp, #0x60]
               	mov	x17, x16
               	ldr	x28, [x28, x17, lsl #3]
               	eor	x27, x27, x28
               	adrp	x28, <addr>
               	add	x28, x28, <lo12>
               	add	x28, x28, #0x2, lsl #12 // =0x2000
               	ubfx	x16, x13, #24, #8
               	str	x16, [sp, #0x60]
               	mov	x17, x16
               	ldr	x28, [x28, x17, lsl #3]
               	eor	x27, x27, x28
               	adrp	x28, <addr>
               	add	x28, x28, <lo12>
               	mov	x17, #0x2800            // =10240
               	add	x28, x28, x17
               	ubfx	x16, x12, #16, #8
               	str	x16, [sp, #0x60]
               	mov	x17, x16
               	ldr	x28, [x28, x17, lsl #3]
               	eor	x27, x27, x28
               	adrp	x28, <addr>
               	add	x28, x28, <lo12>
               	add	x28, x28, #0x3, lsl #12 // =0x3000
               	ubfx	x16, x3, #8, #8
               	str	x16, [sp, #0x60]
               	mov	x17, x16
               	ldr	x28, [x28, x17, lsl #3]
               	eor	x27, x27, x28
               	adrp	x28, <addr>
               	add	x28, x28, <lo12>
               	mov	x17, #0x3800            // =14336
               	add	x28, x28, x17
               	and	x16, x2, #0xff
               	str	x16, [sp, #0x60]
               	mov	x17, x16
               	ldr	x28, [x28, x17, lsl #3]
               	eor	x27, x27, x28
               	adrp	x28, <addr>
               	add	x28, x28, <lo12>
               	lsr	x16, x2, #56
               	str	x16, [sp, #0x60]
               	mov	x17, x16
               	ldr	x28, [x28, x17, lsl #3]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	str	x16, [sp, #0x60]
               	add	x16, x16, #0x800
               	str	x16, [sp, #0x60]
               	ubfx	x16, x1, #48, #8
               	str	x16, [sp, #0x58]
               	ldr	x16, [sp, #0x60]
               	ldr	x17, [sp, #0x58]
               	ldr	x17, [x16, x17, lsl #3]
               	str	x17, [sp, #0x60]
               	eor	x28, x28, x17
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	str	x16, [sp, #0x60]
               	add	x16, x16, #0x1, lsl #12 // =0x1000
               	str	x16, [sp, #0x60]
               	ubfx	x16, x0, #40, #8
               	str	x16, [sp, #0x58]
               	ldr	x16, [sp, #0x60]
               	ldr	x17, [sp, #0x58]
               	ldr	x17, [x16, x17, lsl #3]
               	str	x17, [sp, #0x60]
               	eor	x28, x28, x17
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	str	x16, [sp, #0x60]
               	mov	x17, #0x1800            // =6144
               	add	x16, x16, x17
               	str	x16, [sp, #0x60]
               	ubfx	x16, x15, #32, #8
               	str	x16, [sp, #0x58]
               	ldr	x16, [sp, #0x60]
               	ldr	x17, [sp, #0x58]
               	ldr	x17, [x16, x17, lsl #3]
               	str	x17, [sp, #0x60]
               	eor	x28, x28, x17
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	str	x16, [sp, #0x60]
               	add	x16, x16, #0x2, lsl #12 // =0x2000
               	str	x16, [sp, #0x60]
               	ubfx	x16, x14, #24, #8
               	str	x16, [sp, #0x58]
               	ldr	x16, [sp, #0x60]
               	ldr	x17, [sp, #0x58]
               	ldr	x17, [x16, x17, lsl #3]
               	str	x17, [sp, #0x60]
               	eor	x28, x28, x17
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	str	x16, [sp, #0x60]
               	mov	x17, #0x2800            // =10240
               	add	x16, x16, x17
               	str	x16, [sp, #0x60]
               	ubfx	x16, x13, #16, #8
               	str	x16, [sp, #0x58]
               	ldr	x16, [sp, #0x60]
               	ldr	x17, [sp, #0x58]
               	ldr	x17, [x16, x17, lsl #3]
               	str	x17, [sp, #0x60]
               	eor	x28, x28, x17
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	str	x16, [sp, #0x60]
               	add	x16, x16, #0x3, lsl #12 // =0x3000
               	str	x16, [sp, #0x60]
               	ubfx	x16, x12, #8, #8
               	str	x16, [sp, #0x58]
               	ldr	x16, [sp, #0x60]
               	ldr	x17, [sp, #0x58]
               	ldr	x17, [x16, x17, lsl #3]
               	str	x17, [sp, #0x60]
               	eor	x28, x28, x17
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	str	x16, [sp, #0x60]
               	mov	x17, #0x3800            // =14336
               	add	x16, x16, x17
               	str	x16, [sp, #0x60]
               	and	x16, x3, #0xff
               	str	x16, [sp, #0x58]
               	ldr	x16, [sp, #0x60]
               	ldr	x17, [sp, #0x58]
               	ldr	x17, [x16, x17, lsl #3]
               	str	x17, [sp, #0x60]
               	eor	x28, x28, x17
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	str	x16, [sp, #0x60]
               	lsr	x3, x3, #56
               	ldr	x16, [sp, #0x60]
               	ldr	x3, [x16, x3, lsl #3]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	str	x16, [sp, #0x60]
               	add	x16, x16, #0x800
               	str	x16, [sp, #0x60]
               	ubfx	x2, x2, #48, #8
               	ldr	x16, [sp, #0x60]
               	ldr	x2, [x16, x2, lsl #3]
               	eor	x2, x3, x2
               	adrp	x3, <addr>
               	add	x3, x3, <lo12>
               	add	x3, x3, #0x1, lsl #12   // =0x1000
               	ubfx	x1, x1, #40, #8
               	ldr	x1, [x3, x1, lsl #3]
               	eor	x1, x2, x1
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	mov	x17, #0x1800            // =6144
               	add	x2, x2, x17
               	ubfx	x0, x0, #32, #8
               	ldr	x0, [x2, x0, lsl #3]
               	eor	x0, x1, x0
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x2, lsl #12   // =0x2000
               	ubfx	x2, x15, #24, #8
               	ldr	x1, [x1, x2, lsl #3]
               	eor	x0, x0, x1
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	mov	x17, #0x2800            // =10240
               	add	x1, x1, x17
               	ubfx	x2, x14, #16, #8
               	ldr	x1, [x1, x2, lsl #3]
               	eor	x0, x0, x1
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x3, lsl #12   // =0x3000
               	ubfx	x2, x13, #8, #8
               	ldr	x1, [x1, x2, lsl #3]
               	eor	x0, x0, x1
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	mov	x17, #0x3800            // =14336
               	add	x1, x1, x17
               	and	x2, x12, #0xff
               	ldr	x1, [x1, x2, lsl #3]
               	eor	x3, x0, x1
               	adrp	x0, <addr>
               	add	x0, x0, <lo12>
               	lsr	x1, x5, #56
               	ldr	x0, [x0, x1, lsl #3]
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x800
               	ubfx	x2, x4, #48, #8
               	ldr	x1, [x1, x2, lsl #3]
               	eor	x0, x0, x1
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x1, lsl #12   // =0x1000
               	ubfx	x2, x11, #40, #8
               	ldr	x1, [x1, x2, lsl #3]
               	eor	x0, x0, x1
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	mov	x17, #0x1800            // =6144
               	add	x1, x1, x17
               	ubfx	x2, x10, #32, #8
               	ldr	x1, [x1, x2, lsl #3]
               	eor	x0, x0, x1
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x2, lsl #12   // =0x2000
               	ubfx	x2, x9, #24, #8
               	ldr	x1, [x1, x2, lsl #3]
               	eor	x0, x0, x1
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	mov	x17, #0x2800            // =10240
               	add	x1, x1, x17
               	ubfx	x2, x8, #16, #8
               	ldr	x1, [x1, x2, lsl #3]
               	eor	x0, x0, x1
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	add	x1, x1, #0x3, lsl #12   // =0x3000
               	ubfx	x2, x7, #8, #8
               	ldr	x1, [x1, x2, lsl #3]
               	eor	x0, x0, x1
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	mov	x17, #0x3800            // =14336
               	add	x1, x1, x17
               	and	x2, x6, #0xff
               	ldr	x1, [x1, x2, lsl #3]
               	eor	x0, x0, x1
               	eor	x0, x0, x22
               	adrp	x1, <addr>
               	add	x1, x1, <lo12>
               	lsr	x2, x6, #56
               	ldr	x1, [x1, x2, lsl #3]
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	add	x2, x2, #0x800
               	ubfx	x12, x5, #48, #8
               	ldr	x2, [x2, x12, lsl #3]
               	eor	x1, x1, x2
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	add	x2, x2, #0x1, lsl #12   // =0x1000
               	ubfx	x12, x4, #40, #8
               	ldr	x2, [x2, x12, lsl #3]
               	eor	x1, x1, x2
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	mov	x17, #0x1800            // =6144
               	add	x2, x2, x17
               	ubfx	x12, x11, #32, #8
               	ldr	x2, [x2, x12, lsl #3]
               	eor	x1, x1, x2
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	add	x2, x2, #0x2, lsl #12   // =0x2000
               	ubfx	x12, x10, #24, #8
               	ldr	x2, [x2, x12, lsl #3]
               	eor	x1, x1, x2
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	mov	x17, #0x2800            // =10240
               	add	x2, x2, x17
               	ubfx	x12, x9, #16, #8
               	ldr	x2, [x2, x12, lsl #3]
               	eor	x1, x1, x2
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	add	x2, x2, #0x3, lsl #12   // =0x3000
               	ubfx	x12, x8, #8, #8
               	ldr	x2, [x2, x12, lsl #3]
               	eor	x1, x1, x2
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	mov	x17, #0x3800            // =14336
               	add	x2, x2, x17
               	and	x12, x7, #0xff
               	ldr	x2, [x2, x12, lsl #3]
               	eor	x1, x1, x2
               	eor	x1, x1, x23
               	adrp	x2, <addr>
               	add	x2, x2, <lo12>
               	lsr	x12, x7, #56
               	ldr	x2, [x2, x12, lsl #3]
               	adrp	x12, <addr>
               	add	x12, x12, <lo12>
               	add	x12, x12, #0x800
               	ubfx	x13, x6, #48, #8
               	ldr	x12, [x12, x13, lsl #3]
               	eor	x2, x2, x12
               	adrp	x12, <addr>
               	add	x12, x12, <lo12>
               	add	x12, x12, #0x1, lsl #12 // =0x1000
               	ubfx	x13, x5, #40, #8
               	ldr	x12, [x12, x13, lsl #3]
               	eor	x2, x2, x12
               	adrp	x12, <addr>
               	add	x12, x12, <lo12>
               	mov	x17, #0x1800            // =6144
               	add	x12, x12, x17
               	ubfx	x13, x4, #32, #8
               	ldr	x12, [x12, x13, lsl #3]
               	eor	x2, x2, x12
               	adrp	x12, <addr>
               	add	x12, x12, <lo12>
               	add	x12, x12, #0x2, lsl #12 // =0x2000
               	ubfx	x13, x11, #24, #8
               	ldr	x12, [x12, x13, lsl #3]
               	eor	x2, x2, x12
               	adrp	x12, <addr>
               	add	x12, x12, <lo12>
               	mov	x17, #0x2800            // =10240
               	add	x12, x12, x17
               	ubfx	x13, x10, #16, #8
               	ldr	x12, [x12, x13, lsl #3]
               	eor	x2, x2, x12
               	adrp	x12, <addr>
               	add	x12, x12, <lo12>
               	add	x12, x12, #0x3, lsl #12 // =0x3000
               	ubfx	x13, x9, #8, #8
               	ldr	x12, [x12, x13, lsl #3]
               	eor	x2, x2, x12
               	adrp	x12, <addr>
               	add	x12, x12, <lo12>
               	mov	x17, #0x3800            // =14336
               	add	x12, x12, x17
               	and	x13, x8, #0xff
               	ldr	x12, [x12, x13, lsl #3]
               	eor	x2, x2, x12
               	eor	x2, x2, x24
               	adrp	x12, <addr>
               	add	x12, x12, <lo12>
               	lsr	x13, x8, #56
               	ldr	x12, [x12, x13, lsl #3]
               	adrp	x13, <addr>
               	add	x13, x13, <lo12>
               	add	x13, x13, #0x800
               	ubfx	x14, x7, #48, #8
               	ldr	x13, [x13, x14, lsl #3]
               	eor	x12, x12, x13
               	adrp	x13, <addr>
               	add	x13, x13, <lo12>
               	add	x13, x13, #0x1, lsl #12 // =0x1000
               	ubfx	x14, x6, #40, #8
               	ldr	x13, [x13, x14, lsl #3]
               	eor	x12, x12, x13
               	adrp	x13, <addr>
               	add	x13, x13, <lo12>
               	mov	x17, #0x1800            // =6144
               	add	x13, x13, x17
               	ubfx	x14, x5, #32, #8
               	ldr	x13, [x13, x14, lsl #3]
               	eor	x12, x12, x13
               	adrp	x13, <addr>
               	add	x13, x13, <lo12>
               	add	x13, x13, #0x2, lsl #12 // =0x2000
               	ubfx	x14, x4, #24, #8
               	ldr	x13, [x13, x14, lsl #3]
               	eor	x12, x12, x13
               	adrp	x13, <addr>
               	add	x13, x13, <lo12>
               	mov	x17, #0x2800            // =10240
               	add	x13, x13, x17
               	ubfx	x14, x11, #16, #8
               	ldr	x13, [x13, x14, lsl #3]
               	eor	x12, x12, x13
               	adrp	x13, <addr>
               	add	x13, x13, <lo12>
               	add	x13, x13, #0x3, lsl #12 // =0x3000
               	ubfx	x14, x10, #8, #8
               	ldr	x13, [x13, x14, lsl #3]
               	eor	x12, x12, x13
               	adrp	x13, <addr>
               	add	x13, x13, <lo12>
               	mov	x17, #0x3800            // =14336
               	add	x13, x13, x17
               	and	x14, x9, #0xff
               	ldr	x13, [x13, x14, lsl #3]
               	eor	x12, x12, x13
               	eor	x12, x12, x25
               	adrp	x13, <addr>
               	add	x13, x13, <lo12>
               	lsr	x14, x9, #56
               	ldr	x13, [x13, x14, lsl #3]
               	adrp	x14, <addr>
               	add	x14, x14, <lo12>
               	add	x14, x14, #0x800
               	ubfx	x15, x8, #48, #8
               	ldr	x14, [x14, x15, lsl #3]
               	eor	x13, x13, x14
               	adrp	x14, <addr>
               	add	x14, x14, <lo12>
               	add	x14, x14, #0x1, lsl #12 // =0x1000
               	ubfx	x15, x7, #40, #8
               	ldr	x14, [x14, x15, lsl #3]
               	eor	x13, x13, x14
               	adrp	x14, <addr>
               	add	x14, x14, <lo12>
               	mov	x17, #0x1800            // =6144
               	add	x14, x14, x17
               	ubfx	x15, x6, #32, #8
               	ldr	x14, [x14, x15, lsl #3]
               	eor	x13, x13, x14
               	adrp	x14, <addr>
               	add	x14, x14, <lo12>
               	add	x14, x14, #0x2, lsl #12 // =0x2000
               	ubfx	x15, x5, #24, #8
               	ldr	x14, [x14, x15, lsl #3]
               	eor	x13, x13, x14
               	adrp	x14, <addr>
               	add	x14, x14, <lo12>
               	mov	x17, #0x2800            // =10240
               	add	x14, x14, x17
               	ubfx	x15, x4, #16, #8
               	ldr	x14, [x14, x15, lsl #3]
               	eor	x13, x13, x14
               	adrp	x14, <addr>
               	add	x14, x14, <lo12>
               	add	x14, x14, #0x3, lsl #12 // =0x3000
               	ubfx	x15, x11, #8, #8
               	ldr	x14, [x14, x15, lsl #3]
               	eor	x13, x13, x14
               	adrp	x14, <addr>
               	add	x14, x14, <lo12>
               	mov	x17, #0x3800            // =14336
               	add	x14, x14, x17
               	and	x15, x10, #0xff
               	ldr	x14, [x14, x15, lsl #3]
               	eor	x13, x13, x14
               	eor	x13, x13, x26
               	adrp	x14, <addr>
               	add	x14, x14, <lo12>
               	lsr	x15, x10, #56
               	ldr	x14, [x14, x15, lsl #3]
               	adrp	x15, <addr>
               	add	x15, x15, <lo12>
               	add	x15, x15, #0x800
               	ubfx	x16, x9, #48, #8
               	str	x16, [sp, #0x60]
               	mov	x17, x16
               	ldr	x15, [x15, x17, lsl #3]
               	eor	x14, x14, x15
               	adrp	x15, <addr>
               	add	x15, x15, <lo12>
               	add	x15, x15, #0x1, lsl #12 // =0x1000
               	ubfx	x16, x8, #40, #8
               	str	x16, [sp, #0x60]
               	mov	x17, x16
               	ldr	x15, [x15, x17, lsl #3]
               	eor	x14, x14, x15
               	adrp	x15, <addr>
               	add	x15, x15, <lo12>
               	mov	x17, #0x1800            // =6144
               	add	x15, x15, x17
               	ubfx	x16, x7, #32, #8
               	str	x16, [sp, #0x60]
               	mov	x17, x16
               	ldr	x15, [x15, x17, lsl #3]
               	eor	x14, x14, x15
               	adrp	x15, <addr>
               	add	x15, x15, <lo12>
               	add	x15, x15, #0x2, lsl #12 // =0x2000
               	ubfx	x16, x6, #24, #8
               	str	x16, [sp, #0x60]
               	mov	x17, x16
               	ldr	x15, [x15, x17, lsl #3]
               	eor	x14, x14, x15
               	adrp	x15, <addr>
               	add	x15, x15, <lo12>
               	mov	x17, #0x2800            // =10240
               	add	x15, x15, x17
               	ubfx	x16, x5, #16, #8
               	str	x16, [sp, #0x60]
               	mov	x17, x16
               	ldr	x15, [x15, x17, lsl #3]
               	eor	x14, x14, x15
               	adrp	x15, <addr>
               	add	x15, x15, <lo12>
               	add	x15, x15, #0x3, lsl #12 // =0x3000
               	ubfx	x16, x4, #8, #8
               	str	x16, [sp, #0x60]
               	mov	x17, x16
               	ldr	x15, [x15, x17, lsl #3]
               	eor	x14, x14, x15
               	adrp	x15, <addr>
               	add	x15, x15, <lo12>
               	mov	x17, #0x3800            // =14336
               	add	x15, x15, x17
               	and	x16, x11, #0xff
               	str	x16, [sp, #0x60]
               	mov	x17, x16
               	ldr	x15, [x15, x17, lsl #3]
               	eor	x14, x14, x15
               	eor	x14, x14, x27
               	adrp	x15, <addr>
               	add	x15, x15, <lo12>
               	lsr	x16, x11, #56
               	str	x16, [sp, #0x60]
               	mov	x17, x16
               	ldr	x15, [x15, x17, lsl #3]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	str	x16, [sp, #0x60]
               	add	x16, x16, #0x800
               	str	x16, [sp, #0x60]
               	ubfx	x16, x10, #48, #8
               	str	x16, [sp, #0x58]
               	ldr	x16, [sp, #0x60]
               	ldr	x17, [sp, #0x58]
               	ldr	x17, [x16, x17, lsl #3]
               	str	x17, [sp, #0x60]
               	eor	x15, x15, x17
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	str	x16, [sp, #0x60]
               	add	x16, x16, #0x1, lsl #12 // =0x1000
               	str	x16, [sp, #0x60]
               	ubfx	x16, x9, #40, #8
               	str	x16, [sp, #0x58]
               	ldr	x16, [sp, #0x60]
               	ldr	x17, [sp, #0x58]
               	ldr	x17, [x16, x17, lsl #3]
               	str	x17, [sp, #0x60]
               	eor	x15, x15, x17
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	str	x16, [sp, #0x60]
               	mov	x17, #0x1800            // =6144
               	add	x16, x16, x17
               	str	x16, [sp, #0x60]
               	ubfx	x16, x8, #32, #8
               	str	x16, [sp, #0x58]
               	ldr	x16, [sp, #0x60]
               	ldr	x17, [sp, #0x58]
               	ldr	x17, [x16, x17, lsl #3]
               	str	x17, [sp, #0x60]
               	eor	x15, x15, x17
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	str	x16, [sp, #0x60]
               	add	x16, x16, #0x2, lsl #12 // =0x2000
               	str	x16, [sp, #0x60]
               	ubfx	x16, x7, #24, #8
               	str	x16, [sp, #0x58]
               	ldr	x16, [sp, #0x60]
               	ldr	x17, [sp, #0x58]
               	ldr	x17, [x16, x17, lsl #3]
               	str	x17, [sp, #0x60]
               	eor	x15, x15, x17
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	str	x16, [sp, #0x60]
               	mov	x17, #0x2800            // =10240
               	add	x16, x16, x17
               	str	x16, [sp, #0x60]
               	ubfx	x16, x6, #16, #8
               	str	x16, [sp, #0x58]
               	ldr	x16, [sp, #0x60]
               	ldr	x17, [sp, #0x58]
               	ldr	x17, [x16, x17, lsl #3]
               	str	x17, [sp, #0x60]
               	eor	x15, x15, x17
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	str	x16, [sp, #0x60]
               	add	x16, x16, #0x3, lsl #12 // =0x3000
               	str	x16, [sp, #0x60]
               	ubfx	x16, x5, #8, #8
               	str	x16, [sp, #0x58]
               	ldr	x16, [sp, #0x60]
               	ldr	x17, [sp, #0x58]
               	ldr	x17, [x16, x17, lsl #3]
               	str	x17, [sp, #0x60]
               	eor	x15, x15, x17
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	str	x16, [sp, #0x60]
               	mov	x17, #0x3800            // =14336
               	add	x16, x16, x17
               	str	x16, [sp, #0x60]
               	and	x16, x4, #0xff
               	str	x16, [sp, #0x58]
               	ldr	x16, [sp, #0x60]
               	ldr	x17, [sp, #0x58]
               	ldr	x17, [x16, x17, lsl #3]
               	str	x17, [sp, #0x60]
               	eor	x15, x15, x17
               	eor	x15, x15, x28
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	str	x16, [sp, #0x60]
               	lsr	x4, x4, #56
               	ldr	x16, [sp, #0x60]
               	ldr	x4, [x16, x4, lsl #3]
               	adrp	x16, <addr>
               	add	x16, x16, <lo12>
               	str	x16, [sp, #0x60]
               	add	x16, x16, #0x800
               	str	x16, [sp, #0x60]
               	ubfx	x11, x11, #48, #8
               	ldr	x16, [sp, #0x60]
               	ldr	x11, [x16, x11, lsl #3]
               	eor	x4, x4, x11
               	adrp	x11, <addr>
               	add	x11, x11, <lo12>
               	add	x11, x11, #0x1, lsl #12 // =0x1000
               	ubfx	x10, x10, #40, #8
               	ldr	x10, [x11, x10, lsl #3]
               	eor	x4, x4, x10
               	adrp	x10, <addr>
               	add	x10, x10, <lo12>
               	mov	x17, #0x1800            // =6144
               	add	x10, x10, x17
               	ubfx	x9, x9, #32, #8
               	ldr	x9, [x10, x9, lsl #3]
               	eor	x4, x4, x9
               	adrp	x9, <addr>
               	add	x9, x9, <lo12>
               	add	x9, x9, #0x2, lsl #12   // =0x2000
               	ubfx	x8, x8, #24, #8
               	ldr	x8, [x9, x8, lsl #3]
               	eor	x4, x4, x8
               	adrp	x8, <addr>
               	add	x8, x8, <lo12>
               	mov	x17, #0x2800            // =10240
               	add	x8, x8, x17
               	ubfx	x7, x7, #16, #8
               	ldr	x7, [x8, x7, lsl #3]
               	eor	x4, x4, x7
               	adrp	x7, <addr>
               	add	x7, x7, <lo12>
               	add	x7, x7, #0x3, lsl #12   // =0x3000
               	ubfx	x6, x6, #8, #8
               	ldr	x6, [x7, x6, lsl #3]
               	eor	x4, x4, x6
               	adrp	x6, <addr>
               	add	x6, x6, <lo12>
               	mov	x17, #0x3800            // =14336
               	add	x6, x6, x17
               	and	x5, x5, #0xff
               	ldr	x5, [x6, x5, lsl #3]
               	eor	x4, x4, x5
               	eor	x4, x4, x3
               	add	x20, x20, #0x1
               	mov	x5, x0
               	mov	x6, x1
               	mov	x1, x27
               	mov	x0, x26
               	mov	x7, x2
               	mov	x8, x12
               	mov	x9, x13
               	mov	x12, x22
               	mov	x11, x15
               	mov	x10, x14
               	mov	x2, x28
               	mov	x13, x23
               	mov	x14, x24
               	mov	x15, x25
               	cmp	w20, #0xa
               	b.lt	<addr>
               	ldr	x1, [x21]
               	ldr	x0, [sp, #0x50]
               	ldr	x2, [x0]
               	eor	x2, x5, x2
               	eor	x1, x1, x2
               	str	x1, [x21]
               	ldr	x1, [x21, #0x8]
               	ldr	x2, [x0, #0x8]
               	eor	x2, x6, x2
               	eor	x1, x1, x2
               	str	x1, [x21, #0x8]
               	ldr	x1, [x21, #0x10]
               	ldr	x2, [x0, #0x10]
               	eor	x2, x7, x2
               	eor	x1, x1, x2
               	str	x1, [x21, #0x10]
               	ldr	x1, [x21, #0x18]
               	ldr	x2, [x0, #0x18]
               	eor	x2, x8, x2
               	eor	x1, x1, x2
               	str	x1, [x21, #0x18]
               	ldr	x1, [x21, #0x20]
               	ldr	x2, [x0, #0x20]
               	eor	x2, x9, x2
               	eor	x1, x1, x2
               	str	x1, [x21, #0x20]
               	ldr	x1, [x21, #0x28]
               	ldr	x2, [x0, #0x28]
               	eor	x2, x10, x2
               	eor	x1, x1, x2
               	str	x1, [x21, #0x28]
               	ldr	x1, [x21, #0x30]
               	ldr	x2, [x0, #0x30]
               	eor	x2, x11, x2
               	eor	x1, x1, x2
               	str	x1, [x21, #0x30]
               	ldr	x1, [x21, #0x38]
               	ldr	x0, [x0, #0x38]
               	eor	x0, x4, x0
               	eor	x0, x1, x0
               	str	x0, [x21, #0x38]
               	ldp	x29, x30, [sp, #0x70]
               	ldr	x28, [sp, #0x40]
               	ldp	x26, x27, [sp, #0x30]
               	ldp	x24, x25, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x80
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0xd0
               	mov	x0, #0x101010101010101  // =72340172838076673
               	stur	x0, [x29, #-0xd0]
               	mov	x0, #0x201              // =513
               	movk	x0, #0x403, lsl #16
               	movk	x0, #0x605, lsl #32
               	movk	x0, #0x807, lsl #48
               	stur	x0, [x29, #-0x90]
               	mov	x0, #0x202020202020202  // =144680345676153346
               	stur	x0, [x29, #-0xc8]
               	mov	x0, #0x402              // =1026
               	movk	x0, #0x806, lsl #16
               	movk	x0, #0xc0a, lsl #32
               	movk	x0, #0x100e, lsl #48
               	stur	x0, [x29, #-0x88]
               	mov	x0, #0x303030303030303  // =217020518514230019
               	stur	x0, [x29, #-0xc0]
               	mov	x0, #0x804              // =2052
               	movk	x0, #0x100c, lsl #16
               	movk	x0, #0x1814, lsl #32
               	movk	x0, #0x201c, lsl #48
               	stur	x0, [x29, #-0x80]
               	mov	x0, #0x404040404040404  // =289360691352306692
               	stur	x0, [x29, #-0xb8]
               	mov	x0, #0x1008             // =4104
               	movk	x0, #0x2018, lsl #16
               	movk	x0, #0x3028, lsl #32
               	movk	x0, #0x4038, lsl #48
               	stur	x0, [x29, #-0x78]
               	mov	x0, #0x505              // =1285
               	movk	x0, #0x505, lsl #16
               	movk	x0, #0x505, lsl #32
               	movk	x0, #0x505, lsl #48
               	stur	x0, [x29, #-0xb0]
               	mov	x0, #0x2010             // =8208
               	movk	x0, #0x4030, lsl #16
               	movk	x0, #0x6050, lsl #32
               	movk	x0, #0x8070, lsl #48
               	stur	x0, [x29, #-0x70]
               	mov	x0, #0x606060606060606  // =434041037028460038
               	stur	x0, [x29, #-0xa8]
               	mov	x0, #0x4020             // =16416
               	movk	x0, #0x8060, lsl #16
               	movk	x0, #0xc0a0, lsl #32
               	movk	x0, #0xe0, lsl #48
               	stur	x0, [x29, #-0x68]
               	mov	x0, #0x707070707070707  // =506381209866536711
               	stur	x0, [x29, #-0xa0]
               	mov	x0, #0x8040             // =32832
               	movk	x0, #0xc0, lsl #16
               	movk	x0, #0x8141, lsl #32
               	movk	x0, #0x1c1, lsl #48
               	stur	x0, [x29, #-0x60]
               	mov	x0, #0x808080808080808  // =578721382704613384
               	stur	x0, [x29, #-0x98]
               	mov	x0, #0x80               // =128
               	movk	x0, #0x181, lsl #16
               	movk	x0, #0x282, lsl #32
               	movk	x0, #0x383, lsl #48
               	stur	x0, [x29, #-0x58]
               	mov	x0, #0x5a5a             // =23130
               	movk	x0, #0x5a5a, lsl #16
               	movk	x0, #0x5a5a, lsl #32
               	movk	x0, #0x5a5a, lsl #48
               	stur	x0, [x29, #-0x50]
               	mov	x0, #0x2d2d             // =11565
               	movk	x0, #0x2d2d, lsl #16
               	movk	x0, #0x2d2d, lsl #32
               	movk	x0, #0x2d2d, lsl #48
               	stur	x0, [x29, #-0x48]
               	mov	x0, #0x9696             // =38550
               	movk	x0, #0x9696, lsl #16
               	movk	x0, #0x9696, lsl #32
               	movk	x0, #0x1696, lsl #48
               	stur	x0, [x29, #-0x40]
               	mov	x0, #0x4b4b             // =19275
               	movk	x0, #0x4b4b, lsl #16
               	movk	x0, #0x4b4b, lsl #32
               	movk	x0, #0xb4b, lsl #48
               	stur	x0, [x29, #-0x38]
               	mov	x0, #0xa5a5             // =42405
               	movk	x0, #0xa5a5, lsl #16
               	movk	x0, #0xa5a5, lsl #32
               	movk	x0, #0x5a5, lsl #48
               	stur	x0, [x29, #-0x30]
               	mov	x0, #0xd2d2             // =53970
               	movk	x0, #0xd2d2, lsl #16
               	movk	x0, #0xd2d2, lsl #32
               	movk	x0, #0x2d2, lsl #48
               	stur	x0, [x29, #-0x28]
               	mov	x0, #0x6969             // =26985
               	movk	x0, #0x6969, lsl #16
               	movk	x0, #0x6969, lsl #32
               	movk	x0, #0x169, lsl #48
               	stur	x0, [x29, #-0x20]
               	mov	x0, #0xb4b4             // =46260
               	movk	x0, #0xb4b4, lsl #16
               	movk	x0, #0xb4b4, lsl #32
               	movk	x0, #0xb4, lsl #48
               	stur	x0, [x29, #-0x18]
               	mov	x0, #0x5a5a             // =23130
               	movk	x0, #0x5a5a, lsl #16
               	movk	x0, #0x5a5a, lsl #32
               	movk	x0, #0x5a, lsl #48
               	stur	x0, [x29, #-0x10]
               	mov	x0, #0x2d2d             // =11565
               	movk	x0, #0x2d2d, lsl #16
               	movk	x0, #0x2d2d, lsl #32
               	movk	x0, #0x2d, lsl #48
               	stur	x0, [x29, #-0x8]
               	sub	x0, x29, #0xd0
               	sub	x1, x29, #0x90
               	sub	x2, x29, #0x50
               	bl	<addr>
               	sub	x0, x29, #0xd0
               	sub	x1, x29, #0x90
               	sub	x2, x29, #0x50
               	bl	<addr>
               	ldur	x0, [x29, #-0xd0]
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	ldur	x1, [x29, #-0xc8]
               	add	x0, x0, x1
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	ldur	x1, [x29, #-0xc0]
               	add	x0, x0, x1
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	ldur	x1, [x29, #-0xb8]
               	add	x0, x0, x1
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	ldur	x1, [x29, #-0xb0]
               	add	x0, x0, x1
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	ldur	x1, [x29, #-0xa8]
               	add	x0, x0, x1
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	ldur	x1, [x29, #-0xa0]
               	add	x0, x0, x1
               	mov	x17, #0x1f              // =31
               	mul	x0, x0, x17
               	ldur	x1, [x29, #-0x98]
               	add	x0, x0, x1
               	mov	x17, #0x6c84            // =27780
               	movk	x17, #0x4a73, lsl #16
               	movk	x17, #0x5151, lsl #32
               	movk	x17, #0x5151, lsl #48
               	cmp	x0, x17
               	mov	x17, #0x1               // =1
               	csel	x0, xzr, x17, eq
               	add	sp, sp, #0xd0
               	ldp	x29, x30, [sp], #0x10
               	ret
