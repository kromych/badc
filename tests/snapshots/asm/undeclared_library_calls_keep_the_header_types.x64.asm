
undeclared_library_calls_keep_the_header_types.x64:	file format elf64-x86-64

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

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	<rip>, %rdi
               	xorl	%esi, %esi
               	callq	<addr>
               	leaq	<rip>, %rdi
               	movsd	%xmm0, 0x8(%rsp)
               	movb	$0x1, %al
               	callq	<addr>
               	movsd	0x8(%rsp), %xmm0
               	movabsq	$0x3ff8000000000000, %rcx # imm = 0x3FF8000000000000
               	xorl	%edx, %edx
               	movl	$0x1, %esi
               	movq	%rcx, %xmm15
               	ucomisd	%xmm15, %xmm0
               	cmovneq	%rsi, %rdx
               	cmovpq	%rsi, %rdx
               	xorl	%ecx, %ecx
               	movl	$0x2, %esi
               	cmpl	$0x5, %eax
               	cmovneq	%rsi, %rcx
               	orq	%rdx, %rcx
               	movq	%rcx, %rax
               	leave
               	retq
