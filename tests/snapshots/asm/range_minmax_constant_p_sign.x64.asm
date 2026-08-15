
range_minmax_constant_p_sign.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	leaq	<rip>, %r8
               	movl	$0x2710, %eax           # imm = 0x2710
               	movl	%eax, (%r8)
               	movslq	(%r8), %rax
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	movl	$0x1000, %esi           # imm = 0x1000
               	movl	$0x1, %edi
               	cmpq	%rsi, %rcx
               	jae	<addr>
               	jmp	<addr>
               	movq	%rsi, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rdx
               	subq	%rcx, %rax
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
               	jg	<addr>
               	cmpq	$0x2710, %rdx           # imm = 0x2710
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movl	$0x1, %eax
               	movl	%eax, (%r8)
               	movslq	(%r8), %rax
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	movl	$0x1000, %esi           # imm = 0x1000
               	movl	$0x1, %edi
               	cmpq	%rsi, %rcx
               	jae	<addr>
               	jmp	<addr>
               	movq	%rsi, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rdx
               	subq	%rcx, %rax
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
               	jg	<addr>
               	cmpq	$0x1, %rdx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	xorq	%rax, %rax
               	movl	%eax, (%r8)
               	movslq	(%r8), %rax
               	xorq	%rdx, %rdx
               	jmp	<addr>
               	movl	$0x1000, %esi           # imm = 0x1000
               	movl	$0x1, %edi
               	cmpq	%rsi, %rcx
               	jae	<addr>
               	jmp	<addr>
               	movq	%rsi, %rcx
               	movl	%ecx, %ecx
               	addq	%rcx, %rdx
               	subq	%rcx, %rax
               	movslq	%eax, %rcx
               	testq	%rcx, %rcx
               	jg	<addr>
               	testq	%rdx, %rdx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	xorq	%rax, %rax
               	retq
