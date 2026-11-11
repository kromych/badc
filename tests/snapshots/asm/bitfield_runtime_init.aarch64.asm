
bitfield_runtime_init.aarch64:	file format elf64-littleaarch64

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

<build_packed>:
               	and	x3, x0, #0xf
               	and	x4, x1, #0xf
               	orr	x0, x3, x4, lsl #4
               	and	x1, x2, #0x1f
               	and	x0, x0, #0xffffffffffffe0ff
               	orr	x0, x0, x1, lsl #8
               	and	x1, x0, #0xf
               	cmp	w1, w3
               	mov	x1, #0x0                // =0
               	b.ne	<addr>
               	mov	w3, w0
               	ubfx	x3, x3, #4, #4
               	cmp	w3, w4
               	cset	x3, eq
               	cbz	x3, <addr>
               	mov	w0, w0
               	sbfx	x0, x0, #8, #5
               	cmp	w0, w2
               	cset	x0, eq
               	mov	x2, #0x1                // =1
               	cmp	x0, #0x0
               	csel	x0, x2, x1, ne
               	ret
               	mov	x0, x1
               	b	<addr>
               	mov	x3, x1
               	b	<addr>

<build_mixed>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	sub	sp, sp, #0x10
               	sub	x5, x29, #0x10
               	str	xzr, [x5]
               	str	wzr, [x5, #0x8]
               	sturh	w0, [x29, #-0x10]
               	and	x5, x1, #0x7
               	ldur	w1, [x29, #-0x10]
               	and	x1, x1, #0xfffffffffff8ffff
               	orr	x1, x1, x5, lsl #16
               	stur	w1, [x29, #-0x10]
               	and	x2, x2, #0x3ff
               	and	x1, x1, #0xffffffffe007ffff
               	orr	x1, x1, x2, lsl #19
               	stur	w1, [x29, #-0x10]
               	and	x3, x3, #0x7ffff
               	stur	w3, [x29, #-0xc]
               	stur	w4, [x29, #-0x8]
               	ldurh	w3, [x29, #-0x10]
               	and	x0, x0, #0xffff
               	cmp	w3, w0
               	mov	x0, #0x0                // =0
               	b.ne	<addr>
               	mov	w3, w1
               	ubfx	x3, x3, #16, #3
               	cmp	w3, w5
               	cset	x3, eq
               	cbz	x3, <addr>
               	mov	w1, w1
               	ubfx	x1, x1, #19, #10
               	cmp	w1, w2
               	cset	x1, eq
               	mov	x2, #0x1                // =1
               	cmp	x1, #0x0
               	csel	x1, x2, x0, ne
               	mov	x2, #0x1                // =1
               	cmp	x1, #0x0
               	csel	x0, x2, x0, ne
               	add	sp, sp, #0x10
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x1, x0
               	b	<addr>
               	mov	x3, x0
               	b	<addr>

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	mov	x0, #0x5                // =5
               	mov	x1, #0xa                // =10
               	mov	x2, #-0x3               // =-3
               	mov	x3, #0x2345             // =9029
               	movk	x3, #0x1, lsl #16
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xff               // =255
               	mov	x1, #0x1f               // =31
               	mov	x2, #0xf                // =15
               	mov	x3, #0xfffffff          // =268435455
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x2, #-0x10              // =-16
               	mov	x1, x0
               	mov	x3, x0
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x1234             // =4660
               	mov	x1, #0x6                // =6
               	mov	x2, #0x1f4              // =500
               	mov	x3, #0x86a0             // =34464
               	movk	x3, #0x1, lsl #16
               	mov	x4, #-0x4d              // =-77
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0xffff             // =65535
               	mov	x1, #0x7                // =7
               	mov	x2, #0x3ff              // =1023
               	mov	x3, #0x7ffff            // =524287
               	mov	x4, #0x7fffffff         // =2147483647
               	bl	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
