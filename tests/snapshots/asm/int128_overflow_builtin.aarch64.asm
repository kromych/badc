
int128_overflow_builtin.aarch64:	file format elf64-littleaarch64

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

<chk>:
               	sub	sp, sp, #0x40
               	sub	sp, sp, #0x10
               	sub	sp, sp, #0x10
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x20
               	sub	x16, x29, #0x10
               	str	x1, [x16]
               	str	x2, [x16, #0x8]
               	mov	x2, x3
               	mov	x3, x4
               	mov	x4, x5
               	mov	x5, x6
               	sxtw	x0, w0
               	sxtw	x2, w2
               	cmp	x0, x2
               	b.eq	<addr>
               	sxtw	x0, w5
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x60
               	ret
               	sub	x0, x29, #0x10
               	ldr	x1, [x0]
               	cmp	x1, x4
               	b.eq	<addr>
               	add	x0, x5, #0x1
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x60
               	ret
               	ldr	x1, [x0, #0x8]
               	cmp	x1, x3
               	b.eq	<addr>
               	add	x0, x5, #0x2
               	sxtw	x0, w0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x60
               	ret
               	mov	x0, #0x0                // =0
               	add	sp, sp, #0x20
               	ldp	x29, x30, [sp], #0x10
               	add	sp, sp, #0x60
               	ret

<main>:
               	stp	x20, x21, [sp, #-0x130]!
               	stp	x22, x23, [sp, #0x10]
               	str	x24, [sp, #0x20]
               	stp	x29, x30, [sp, #0x120]
               	add	x29, sp, #0x120
               	mov	x22, #0x0               // =0
               	mov	x0, #0x1                // =1
               	sub	x20, x29, #0xc0
               	str	x22, [x20]
               	str	x22, [x20, #0x8]
               	mov	x1, x20
               	mov	x6, x0
               	mov	x5, x22
               	mov	x4, x22
               	mov	x3, x0
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	mov	x21, #0xffff            // =65535
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0xffff, lsl #48
               	str	x21, [x20]
               	str	x21, [x20, #0x8]
               	mov	x5, #0x4                // =4
               	mov	x0, x22
               	mov	x6, x5
               	mov	x5, x21
               	mov	x4, x21
               	mov	x3, x22
               	mov	x1, x20
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	mov	x22, #0x1               // =1
               	sub	x20, x29, #0xc0
               	str	x21, [x20]
               	str	x21, [x20, #0x8]
               	mov	x5, #0x7                // =7
               	mov	x0, x22
               	mov	x6, x5
               	mov	x5, x21
               	mov	x4, x21
               	mov	x3, x22
               	mov	x1, x20
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	mov	x21, #0x0               // =0
               	str	x21, [x20]
               	str	x21, [x20, #0x8]
               	mov	x5, #0xa                // =10
               	mov	x0, x22
               	mov	x6, x5
               	mov	x5, x21
               	mov	x4, x21
               	mov	x3, x22
               	mov	x1, x20
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	sub	x20, x29, #0xc0
               	mov	x22, #-0x8000000000000000 // =-9223372036854775808
               	str	x21, [x20]
               	str	x22, [x20, #0x8]
               	mov	x5, #0xd                // =13
               	mov	x0, x21
               	mov	x6, x5
               	mov	x5, x21
               	mov	x4, x22
               	mov	x3, x21
               	mov	x1, x20
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	mov	x21, #0x1               // =1
               	mov	x3, #0x2                // =2
               	movk	x3, #0x8000, lsl #48
               	str	x22, [x20]
               	str	x3, [x20, #0x8]
               	mov	x5, #0x10               // =16
               	mov	x0, x21
               	mov	x6, x5
               	mov	x5, x22
               	mov	x4, x3
               	mov	x3, x21
               	mov	x1, x20
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	mov	x4, #0x0                // =0
               	sub	x20, x29, #0xb0
               	mov	x3, #-0x8000000000000000 // =-9223372036854775808
               	str	x4, [x20]
               	str	x3, [x20, #0x8]
               	mov	x5, #0x13               // =19
               	mov	x0, x21
               	mov	x6, x5
               	mov	x5, x4
               	mov	x4, x3
               	mov	x3, x21
               	mov	x1, x20
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	mov	x4, #0xffff             // =65535
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	mov	x21, #0xffff            // =65535
               	movk	x21, #0xffff, lsl #16
               	movk	x21, #0xffff, lsl #32
               	movk	x21, #0x7fff, lsl #48
               	str	x4, [x20]
               	str	x21, [x20, #0x8]
               	mov	x22, #0x1               // =1
               	mov	x5, #0x16               // =22
               	mov	x0, x22
               	mov	x6, x5
               	mov	x5, x4
               	mov	x4, x21
               	mov	x3, x22
               	mov	x1, x20
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	mov	x4, #0xfffe             // =65534
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	str	x4, [x20]
               	str	x21, [x20, #0x8]
               	mov	x0, #0x0                // =0
               	sub	x20, x29, #0xb0
               	mov	x5, #0x19               // =25
               	mov	x1, x20
               	mov	x6, x5
               	mov	x5, x4
               	mov	x4, x21
               	mov	x3, x0
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	mov	x4, #0xffff             // =65535
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0x7fff, lsl #48
               	str	x4, [x20]
               	str	x3, [x20, #0x8]
               	mov	x23, #0x1               // =1
               	mov	x5, #0x1c               // =28
               	mov	x0, x23
               	mov	x6, x5
               	mov	x5, x4
               	mov	x4, x3
               	mov	x3, x22
               	mov	x1, x20
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	mov	x21, #0x0               // =0
               	mov	x22, #-0x8000000000000000 // =-9223372036854775808
               	str	x21, [x20]
               	str	x22, [x20, #0x8]
               	sub	x20, x29, #0xb0
               	mov	x5, #0x1f               // =31
               	mov	x0, x23
               	mov	x6, x5
               	mov	x5, x21
               	mov	x4, x22
               	mov	x3, x23
               	mov	x1, x20
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	mov	x23, #-0x8000000000000000 // =-9223372036854775808
               	str	x21, [x20]
               	str	x22, [x20, #0x8]
               	mov	x22, #0x0               // =0
               	sub	x20, x29, #0xb0
               	mov	x5, #0x22               // =34
               	mov	x0, x22
               	mov	x6, x5
               	mov	x5, x21
               	mov	x4, x23
               	mov	x3, x21
               	mov	x1, x20
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	mov	x1, #0x1                // =1
               	mov	x3, #-0x8000000000000000 // =-9223372036854775808
               	str	x22, [x20]
               	str	x23, [x20, #0x8]
               	sub	x21, x29, #0xb0
               	mov	x5, #0x25               // =37
               	mov	x0, x1
               	mov	x6, x5
               	mov	x5, x22
               	mov	x4, x3
               	mov	x3, x1
               	mov	x1, x21
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	mov	x20, #0x0               // =0
               	str	x20, [x21]
               	str	x20, [x21, #0x8]
               	mov	x5, #0x28               // =40
               	mov	x0, x20
               	mov	x6, x5
               	mov	x5, x20
               	mov	x4, x20
               	mov	x3, x20
               	mov	x1, x21
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	sub	x21, x29, #0xc0
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0x7fff, lsl #48
               	str	x22, [x21]
               	str	x3, [x21, #0x8]
               	mov	x5, #0x2b               // =43
               	mov	x0, x20
               	mov	x6, x5
               	mov	x5, x22
               	mov	x4, x3
               	mov	x3, x20
               	mov	x1, x21
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	mov	x3, #0x0                // =0
               	str	x3, [x21]
               	str	x3, [x21, #0x8]
               	mov	x20, #0x1               // =1
               	mov	x5, #0x2e               // =46
               	mov	x0, x20
               	mov	x6, x5
               	mov	x5, x3
               	mov	x4, x3
               	mov	x3, x20
               	mov	x1, x21
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	sub	x21, x29, #0xb0
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	str	x22, [x21]
               	str	x3, [x21, #0x8]
               	mov	x5, #0x31               // =49
               	mov	x0, x20
               	mov	x6, x5
               	mov	x5, x3
               	mov	x4, x3
               	mov	x3, x20
               	mov	x1, x21
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	mov	x20, #0x0               // =0
               	mov	x23, #0x1               // =1
               	str	x23, [x21]
               	str	x20, [x21, #0x8]
               	mov	x5, #0x34               // =52
               	mov	x0, x23
               	mov	x6, x5
               	mov	x5, x23
               	mov	x4, x20
               	mov	x3, x23
               	mov	x1, x21
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	sub	x24, x29, #0x88
               	mov	x4, #0x7b               // =123
               	str	w4, [x24]
               	ldur	w0, [x29, #-0x88]
               	sub	x21, x29, #0x90
               	str	x0, [x21]
               	str	x20, [x21, #0x8]
               	mov	x5, #0x37               // =55
               	mov	x0, x20
               	mov	x6, x5
               	mov	x5, x4
               	mov	x4, x20
               	mov	x3, x20
               	mov	x1, x21
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	mov	x22, #0x0               // =0
               	str	w22, [x24]
               	mov	x0, #0x1                // =1
               	str	x22, [x21]
               	str	x20, [x21, #0x8]
               	mov	x5, #0x3a               // =58
               	mov	x1, x21
               	mov	x6, x5
               	mov	x5, x20
               	mov	x4, x20
               	mov	x3, x23
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	sub	x23, x29, #0x88
               	mov	x4, #0xfffe             // =65534
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	str	w4, [x23]
               	ldursw	x0, [x29, #-0x88]
               	sub	x20, x29, #0x90
               	str	x0, [x20]
               	asr	x0, x0, #63
               	str	x0, [x20, #0x8]
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	mov	x5, #0x3d               // =61
               	mov	x0, x22
               	mov	x6, x5
               	mov	x5, x4
               	mov	x4, x3
               	mov	x3, x22
               	mov	x1, x20
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	mov	x21, #0x0               // =0
               	str	w21, [x23]
               	mov	x23, #0x1               // =1
               	str	x21, [x20]
               	str	x21, [x20, #0x8]
               	mov	x5, #0x40               // =64
               	mov	x0, x23
               	mov	x6, x5
               	mov	x5, x22
               	mov	x4, x22
               	mov	x3, x23
               	mov	x1, x20
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	sub	x0, x29, #0x88
               	mov	x22, #0xffff            // =65535
               	movk	x22, #0xffff, lsl #16
               	movk	x22, #0xffff, lsl #32
               	movk	x22, #0xffff, lsl #48
               	str	x22, [x0]
               	ldur	x0, [x29, #-0x88]
               	sub	x20, x29, #0x90
               	str	x0, [x20]
               	str	x21, [x20, #0x8]
               	mov	x5, #0x43               // =67
               	mov	x0, x23
               	mov	x6, x5
               	mov	x5, x22
               	mov	x4, x21
               	mov	x3, x23
               	mov	x1, x20
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	sub	x23, x29, #0x98
               	mov	x4, #0xfff1             // =65521
               	movk	x4, #0xffff, lsl #16
               	movk	x4, #0xffff, lsl #32
               	movk	x4, #0xffff, lsl #48
               	str	x4, [x23]
               	mov	x1, #0x0                // =0
               	ldur	x0, [x29, #-0x98]
               	str	x0, [x20]
               	asr	x0, x0, #63
               	str	x0, [x20, #0x8]
               	mov	x5, #0x46               // =70
               	mov	x0, x1
               	mov	x6, x5
               	mov	x5, x4
               	mov	x4, x22
               	mov	x3, x21
               	mov	x1, x20
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	mov	x1, #0x1                // =1
               	mov	x21, #-0x8000000000000000 // =-9223372036854775808
               	str	x21, [x23]
               	ldur	x0, [x29, #-0x98]
               	str	x0, [x20]
               	asr	x0, x0, #63
               	str	x0, [x20, #0x8]
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	mov	x5, #0x49               // =73
               	mov	x0, x1
               	mov	x6, x5
               	mov	x5, x21
               	mov	x4, x3
               	mov	x3, x1
               	mov	x1, x20
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	sub	x1, x29, #0xb0
               	mov	x20, #0x0               // =0
               	str	x21, [x1]
               	str	x20, [x1, #0x8]
               	mov	x5, #0x4c               // =76
               	mov	x0, x20
               	mov	x6, x5
               	mov	x5, x21
               	mov	x4, x20
               	mov	x3, x20
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	mov	x22, #0x1               // =1
               	sub	x21, x29, #0xc0
               	str	x20, [x21]
               	str	x22, [x21, #0x8]
               	mov	x5, #0x4f               // =79
               	mov	x0, x20
               	mov	x6, x5
               	mov	x5, x20
               	mov	x4, x22
               	mov	x3, x20
               	mov	x1, x21
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	mov	x3, #0xffff             // =65535
               	movk	x3, #0xffff, lsl #16
               	movk	x3, #0xffff, lsl #32
               	movk	x3, #0xffff, lsl #48
               	str	x3, [x21]
               	str	x3, [x21, #0x8]
               	mov	x5, #0x52               // =82
               	mov	x0, x22
               	mov	x6, x5
               	mov	x5, x3
               	mov	x4, x3
               	mov	x3, x22
               	mov	x1, x21
               	ldr	x2, [x1, #0x8]
               	ldr	x1, [x1]
               	bl	<addr>
               	cbz	x0, <addr>
               	sxtw	x0, w0
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x120]
               	ldr	x24, [sp, #0x20]
               	ldp	x22, x23, [sp, #0x10]
               	ldp	x20, x21, [sp], #0x130
               	ret
