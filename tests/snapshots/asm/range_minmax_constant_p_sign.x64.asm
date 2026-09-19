
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
               	leaq	<rip>, %r8
               	movl	$0x2710, %eax           # imm = 0x2710
               	movl	%eax, (%r8)
               	movslq	(%r8), %rax
               	xorl	%ecx, %ecx
               	testl	%eax, %eax
               	jle	<addr>
               	movslq	%eax, %rdx
               	movl	$0x1000, %esi           # imm = 0x1000
               	cmpq	%rsi, %rdx
               	jb	<addr>
               	movq	%rsi, %rdx
               	movl	%edx, %edx
               	addq	%rdx, %rcx
               	subq	%rdx, %rax
               	testl	%eax, %eax
               	jg	<addr>
               	cmpq	$0x2710, %rcx           # imm = 0x2710
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x1, %eax
               	movl	%eax, (%r8)
               	movslq	(%r8), %rax
               	xorl	%ecx, %ecx
               	testl	%eax, %eax
               	jle	<addr>
               	movslq	%eax, %rdx
               	movl	$0x1000, %esi           # imm = 0x1000
               	cmpq	%rsi, %rdx
               	jb	<addr>
               	movq	%rsi, %rdx
               	movl	%edx, %edx
               	addq	%rdx, %rcx
               	subq	%rdx, %rax
               	testl	%eax, %eax
               	jg	<addr>
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorl	%ecx, %ecx
               	movl	%ecx, (%r8)
               	movslq	(%r8), %rax
               	testl	%eax, %eax
               	jle	<addr>
               	movslq	%eax, %rdx
               	movl	$0x1000, %esi           # imm = 0x1000
               	cmpq	%rsi, %rdx
               	jb	<addr>
               	movq	%rsi, %rdx
               	movl	%edx, %edx
               	addq	%rdx, %rcx
               	subq	%rdx, %rax
               	testl	%eax, %eax
               	jg	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorl	%eax, %eax
               	retq
