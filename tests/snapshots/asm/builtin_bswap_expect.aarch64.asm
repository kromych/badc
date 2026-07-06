
builtin_bswap_expect.aarch64:	file format elf64-littleaarch64

Disassembly of section .text:

<.text>:
               	mov	x29, #0x0               // =0
               	mov	x0, sp
               	mov	x1, #0x220              // =544
               	movk	x1, #0x0, lsl #16
               	b	<addr>
               	brk	#<addr>:
               	str	x19, [sp, #-0x30]!
               	stp	x29, x30, [sp, #0x20]
               	add	x29, sp, #0x20
               	mov	x0, #0x200              // =512
               	mov	x1, #0x1                // =1
               	orr	x0, x0, x1
               	cmp	x0, #0x201
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	mov	x0, #0x4000000          // =67108864
               	mov	x1, #0x30000            // =196608
               	orr	x0, x0, x1
               	mov	x1, #0x200              // =512
               	orr	x0, x0, x1
               	mov	x1, #0x1                // =1
               	orr	x0, x0, x1
               	mov	x17, #0x201             // =513
               	movk	x17, #0x403, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	mov	x0, #0x800000000000000  // =576460752303423488
               	mov	x1, #0x7000000000000    // =1970324836974592
               	orr	x0, x0, x1
               	mov	x1, #0x60000000000      // =6597069766656
               	orr	x0, x0, x1
               	mov	x1, #0x500000000        // =21474836480
               	orr	x0, x0, x1
               	mov	x1, #0x4000000          // =67108864
               	orr	x0, x0, x1
               	mov	x1, #0x30000            // =196608
               	orr	x0, x0, x1
               	mov	x1, #0x200              // =512
               	orr	x0, x0, x1
               	mov	x1, #0x1                // =1
               	orr	x0, x0, x1
               	mov	x17, #0x201             // =513
               	movk	x17, #0x403, lsl #16
               	movk	x17, #0x605, lsl #32
               	movk	x17, #0x807, lsl #48
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	mov	x0, #0xccdd             // =52445
               	movk	x0, #0xaabb, lsl #16
               	stur	w0, [x29, #-0x8]
               	ldur	w0, [x29, #-0x8]
               	mov	x17, #0xff              // =255
               	and	x1, x0, x17
               	lsl	x1, x1, #24
               	lsr	x2, x0, #8
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #16
               	orr	x1, x1, x2
               	lsr	x2, x0, #16
               	mov	x17, #0xff              // =255
               	and	x2, x2, x17
               	lsl	x2, x2, #8
               	orr	x1, x1, x2
               	lsr	x0, x0, #24
               	mov	x17, #0xff              // =255
               	and	x0, x0, x17
               	orr	x0, x1, x0
               	mov	x17, #0xbbaa            // =48042
               	movk	x17, #0xddcc, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	mov	x0, #0x5                // =5
               	cmp	x0, #0x5
               	cset	x1, eq
               	cmp	x1, #0x1
               	b.eq	<addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	cmp	x0, #0x5
               	b.eq	<addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
               	cmp	x0, #0x5
               	b.eq	<addr>
               	brk	#0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x20]
               	ldr	x19, [sp], #0x30
               	ret
