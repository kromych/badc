
libc_math_round.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3
               	int3

<main>:
               	pushq	%rax
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%r11
               	retq
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%r11
               	retq
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	ucomisd	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%r11
               	retq
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	cmpq	$0x3, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%r11
               	retq
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	cmpq	$-0x3, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%r11
               	retq
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	cmpq	$0x2, %rax
               	je	<addr>
               	movl	$0x6, %eax
               	popq	%r11
               	retq
               	movsd	<rip>, %xmm0
               	callq	<addr>
               	movabsq	$0xe8d4a51001, %r11     # imm = 0xE8D4A51001
               	cmpq	%r11, %rax
               	je	<addr>
               	movl	$0x7, %eax
               	popq	%r11
               	retq
               	movss	<rip>, %xmm0
               	callq	<addr>
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x8, %eax
               	popq	%r11
               	retq
               	movss	<rip>, %xmm0
               	callq	<addr>
               	ucomiss	<rip>, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x9, %eax
               	popq	%r11
               	retq
               	xorl	%eax, %eax
               	popq	%r11
               	retq
