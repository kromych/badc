
hex_case_range.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
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

<classify>:
               	cmpl	$0x10, %edi
               	jge	<addr>
               	cmpl	$0x30, %edi
               	jge	<addr>
               	xorq	%rax, %rax
               	retq
               	cmpl	$0x40, %edi
               	jg	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpl	$0x20, %edi
               	jg	<addr>
               	movl	$0x1, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movabsq	$0x4028000000000000, %rax # imm = 0x4028000000000000
               	movq	%rax, %xmm14
               	movsd	%xmm14, -0x10(%rbp,%riz)
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rdx
               	movq	%rax, %rcx
               	movl	$0x2, %ecx
               	movq	%rcx, %rdx
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movsd	-0x10(%rbp,%riz), %xmm0
               	movabsq	$0x4028000000000000, %rcx # imm = 0x4028000000000000
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	leave
               	retq
