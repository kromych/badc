
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
               	leaq	<rip>, %r9
               	movl	$0x2710, %eax           # imm = 0x2710
               	movl	%eax, (%r9)
               	movslq	(%r9), %rax
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%eax, %rdx
               	movl	$0x1000, %esi           # imm = 0x1000
               	movl	$0x1, %edi
               	cmpq	%rsi, %rdx
               	jae	<addr>
               	jmp	<addr>
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
               	movl	$0x1, %esi
               	movl	%esi, (%r9)
               	movslq	(%r9), %rax
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	%eax, %rdx
               	movl	$0x1000, %edi           # imm = 0x1000
               	movq	%rsi, %r8
               	cmpq	%rdi, %rdx
               	jae	<addr>
               	jmp	<addr>
               	movq	%rdi, %rdx
               	movl	%edx, %edx
               	addq	%rdx, %rcx
               	subq	%rdx, %rax
               	testl	%eax, %eax
               	jg	<addr>
               	cmpq	$0x1, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorq	%rcx, %rcx
               	movl	%ecx, (%r9)
               	movslq	(%r9), %rax
               	jmp	<addr>
               	movslq	%eax, %rdx
               	movl	$0x1000, %edi           # imm = 0x1000
               	movq	%rsi, %r8
               	cmpq	%rdi, %rdx
               	jae	<addr>
               	jmp	<addr>
               	movq	%rdi, %rdx
               	movl	%edx, %edx
               	addq	%rdx, %rcx
               	subq	%rdx, %rax
               	testl	%eax, %eax
               	jg	<addr>
               	testq	%rcx, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%rax, %rax
               	retq
