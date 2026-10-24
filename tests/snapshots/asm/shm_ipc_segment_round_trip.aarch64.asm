
shm_ipc_segment_round_trip.aarch64:	file format elf64-littleaarch64

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

<main>:
               	stp	x20, x21, [sp, #-0x90]!
               	stp	x29, x30, [sp, #0x80]
               	add	x29, sp, #0x80
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x62               // =98
               	bl	<addr>
               	mov	x17, #-0x1              // =-1
               	cmp	w0, w17
               	b.eq	<addr>
               	cbnz	w0, <addr>
               	mov	x0, #0x2                // =2
               	ldp	x29, x30, [sp, #0x80]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	mov	x0, #0x0                // =0
               	mov	x1, #0x1000             // =4096
               	mov	x2, #0x380              // =896
               	bl	<addr>
               	mov	x20, x0
               	cmp	w20, #0x0
               	b.ge	<addr>
               	mov	x0, #0x3                // =3
               	ldp	x29, x30, [sp, #0x80]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	mov	x1, #0x0                // =0
               	mov	x0, x20
               	mov	x2, x1
               	bl	<addr>
               	mov	x21, x0
               	mov	x17, #-0x1              // =-1
               	cmp	x21, x17
               	b.ne	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp, #0x80]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x21
               	bl	<addr>
               	mov	x1, #0x2                // =2
               	sub	x2, x29, #0x70
               	mov	x0, x20
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x5                // =5
               	ldp	x29, x30, [sp, #0x80]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	ldur	x0, [x29, #-0x40]
               	mov	x17, #0x1000            // =4096
               	cmp	x0, x17
               	b.ne	<addr>
               	ldur	x0, [x29, #-0x18]
               	cmp	x0, #0x1
               	b.ne	<addr>
               	ldur	w0, [x29, #-0x5c]
               	and	x0, x0, #0x1ff
               	eor	x0, x0, #0x180
               	cbz	w0, <addr>
               	mov	x0, #0x6                // =6
               	ldp	x29, x30, [sp, #0x80]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbnz	x0, <addr>
               	mov	x0, x21
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x7                // =7
               	ldp	x29, x30, [sp, #0x80]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	mov	x1, #0x0                // =0
               	mov	x0, x20
               	mov	x2, x1
               	bl	<addr>
               	sxtw	x0, w0
               	cbz	x0, <addr>
               	mov	x0, #0x8                // =8
               	ldp	x29, x30, [sp, #0x80]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	bl	<addr>
               	sxtw	x0, w0
               	mov	x17, #0x1000            // =4096
               	cmp	x0, x17
               	b.lt	<addr>
               	bl	<addr>
               	sxtw	x0, w0
               	asr	x1, x0, #63
               	lsr	x1, x1, #52
               	add	x0, x0, x1
               	and	x0, x0, #0xfff
               	sub	x0, x0, x1
               	cbz	w0, <addr>
               	mov	x0, #0x9                // =9
               	ldp	x29, x30, [sp, #0x80]
               	ldp	x20, x21, [sp], #0x90
               	ret
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp, #0x80]
               	ldp	x20, x21, [sp], #0x90
               	ret
