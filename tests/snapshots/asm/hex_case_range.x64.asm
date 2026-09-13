
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
               	movabsq	$0x4028000000000000, %rdx # imm = 0x4028000000000000
               	movl	$0x1, %ecx
               	movq	%rcx, %rax
               	movq	%rcx, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rsi
               	movq	%rax, %rcx
               	movl	$0x2, %ecx
               	movq	%rcx, %rsi
               	xorq	%rax, %rax
               	xorq	%rax, %rax
               	movq	%rax, %rcx
               	movabsq	$0x4028000000000000, %rcx # imm = 0x4028000000000000
               	movq	%rdx, %xmm14
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm14
               	jp	<addr>
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	retq
