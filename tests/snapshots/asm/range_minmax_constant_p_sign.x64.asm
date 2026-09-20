
range_minmax_constant_p_sign.x64:	file format elf64-x86-64

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
               	leaq	<rip>, %rax
               	movl	$0x2710, (%rax)         # imm = 0x2710
               	movslq	(%rax), %rax
               	xorl	%edx, %edx
               	testl	%eax, %eax
               	jle	<addr>
               	movl	$0x1000, %ecx           # imm = 0x1000
               	cmpq	%rcx, %rax
               	jae	<addr>
               	movq	%rax, %rcx
               	addq	%rcx, %rdx
               	subq	%rcx, %rax
               	testl	%eax, %eax
               	jg	<addr>
               	cmpq	$0x2710, %rdx           # imm = 0x2710
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	leaq	<rip>, %rax
               	movl	$0x1, (%rax)
               	movslq	(%rax), %rax
               	xorl	%edx, %edx
               	testl	%eax, %eax
               	jle	<addr>
               	movl	$0x1000, %ecx           # imm = 0x1000
               	cmpq	%rcx, %rax
               	jae	<addr>
               	movq	%rax, %rcx
               	addq	%rcx, %rdx
               	subq	%rcx, %rax
               	testl	%eax, %eax
               	jg	<addr>
               	cmpq	$0x1, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	<rip>, %rax
               	xorl	%edx, %edx
               	movl	%edx, (%rax)
               	movslq	(%rax), %rax
               	testl	%eax, %eax
               	jle	<addr>
               	movl	$0x1000, %ecx           # imm = 0x1000
               	cmpq	%rcx, %rax
               	jae	<addr>
               	movq	%rax, %rcx
               	addq	%rcx, %rdx
               	subq	%rcx, %rax
               	testl	%eax, %eax
               	jg	<addr>
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorl	%eax, %eax
               	retq
