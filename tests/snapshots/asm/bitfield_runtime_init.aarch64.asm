
bitfield_runtime_init.aarch64:	file format elf64-littleaarch64

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

<build_packed>:
               	and	x0, x0, #0xf
               	and	x3, x1, #0xf
               	orr	x1, x0, x3, lsl #4
               	and	x4, x2, #0x1f
               	orr	x1, x1, x4, lsl #8
               	and	x4, x1, #0xf
               	cmp	w4, w0
               	mov	x0, #0x0                // =0
               	b.ne	<addr>
               	ubfx	x4, x1, #4, #4
               	cmp	w4, w3
               	cset	x3, eq
               	cbz	x3, <addr>
               	sbfx	x1, x1, #8, #5
               	cmp	w1, w2
               	cset	x1, eq
               	cmp	x1, #0x0
               	mov	x16, #0x1               // =1
               	csel	x0, x16, x0, ne
               	ret
               	mov	x1, x0
               	b	<addr>
               	mov	x3, x0
               	b	<addr>

<build_mixed>:
               	and	x0, x0, #0xffff
               	and	x3, x1, #0x7
               	orr	x1, x0, x3, lsl #16
               	and	x4, x2, #0x3ff
               	orr	x1, x1, x4, lsl #19
               	and	x2, x1, #0xffff
               	cmp	w2, w0
               	mov	x0, #0x0                // =0
               	b.ne	<addr>
               	ubfx	x2, x1, #16, #3
               	cmp	w2, w3
               	cset	x2, eq
               	cbz	x2, <addr>
               	eor	x1, x4, x1, asr #19
               	cmp	w1, #0x0
               	cset	x1, eq
               	cmp	x1, #0x0
               	mov	x16, #0x1               // =1
               	csel	x1, x16, x0, ne
               	cmp	x1, #0x0
               	mov	x16, #0x1               // =1
               	csel	x0, x16, x0, ne
               	ret
               	mov	x1, x0
               	b	<addr>
               	mov	x2, x0
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
               	mov	x1, #0x0                // =0
               	mov	x2, #-0x10              // =-16
               	mov	x3, #0x0                // =0
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
