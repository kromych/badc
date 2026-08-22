
local_array_runtime_init.aarch64:	file format elf64-littleaarch64

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

<probe_char>:
               	mov	x0, #0x12c              // =300
               	ret

<main>:
               	stp	x29, x30, [sp, #-0x10]!
               	mov	x29, sp
               	adrp	x0, <page>
               	add	x0, x0, <lo12>
               	mov	x1, #0x1234             // =4660
               	strh	w1, [x0, #0xa]
               	adrp	x1, <page>
               	add	x1, x1, <lo12>
               	mov	x2, #0x5678             // =22136
               	strh	w2, [x1, #0xa]
               	ldrh	w0, [x0, #0xa]
               	ldrh	w1, [x1, #0xa]
               	mov	x17, #0xffff            // =65535
               	and	x0, x0, x17
               	mov	x17, #0x3e8             // =1000
               	mul	x0, x0, x17
               	mov	x17, #0xffff            // =65535
               	and	x1, x1, x17
               	add	x0, x0, x1
               	sxtw	x0, w0
               	mov	x17, #0x7198            // =29080
               	movk	x17, #0x47, lsl #16
               	cmp	x0, x17
               	b.eq	<addr>
               	mov	x0, #0x1                // =1
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x2                // =2
               	bl	<addr>
               	cmp	x0, #0x12c
               	b.eq	<addr>
               	mov	x0, #0x4                // =4
               	ldp	x29, x30, [sp], #0x10
               	ret
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	mov	x0, #0x0                // =0
               	ldp	x29, x30, [sp], #0x10
               	ret
