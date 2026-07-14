
inline_multi_block_phi_caller.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<acc_add>:
               	leaq	<rip>, %rax
               	movl	%edi, %ecx
               	andq	$0x3, %rcx
               	movl	(%rax,%rcx,4), %edx
               	movl	%esi, %esi
               	addq	%rsi, %rdx
               	movl	%edx, (%rax,%rcx,4)
               	xorq	%rax, %rax
               	retq

<acc_xor>:
               	leaq	<rip>, %rax
               	movl	%edi, %ecx
               	andq	$0x3, %rcx
               	movl	(%rax,%rcx,4), %edx
               	movl	%esi, %esi
               	xorq	%rsi, %rdx
               	movl	%edx, (%rax,%rcx,4)
               	xorq	%rax, %rax
               	retq

<acc_def>:
               	leaq	<rip>, %rax
               	movl	%edi, %ecx
               	andq	$0x3, %rcx
               	movl	%esi, %edx
               	movl	%edx, (%rax,%rcx,4)
               	xorq	%rax, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	movq	%r13, 0x10(%rsp)
               	movl	$0x1, %r12d
               	leaq	<rip>, %rax
               	movl	(%rax), %r13d
               	xorq	%rbx, %rbx
               	jmp	<addr>
               	movl	%ebx, %eax
               	movl	$0x3, %ecx
               	pushq	%rax
               	xorq	%rdx, %rdx
               	divq	%rcx
               	popq	%rax
               	movl	%r12d, %ecx
               	movl	%edx, %edx
               	cmpq	$0x1, %rdx
               	jb	<addr>
               	cmpq	$0x1, %rdx
               	je	<addr>
               	movl	%eax, %edi
               	movl	%ecx, %esi
               	callq	<addr>
               	movl	%r12d, %eax
               	imulq	$0x41c64e6d, %rax, %rax # imm = 0x41C64E6D
               	movl	%eax, %eax
               	addq	$0x3039, %rax           # imm = 0x3039
               	movl	%eax, %r12d
               	jmp	<addr>
               	movl	%eax, %edi
               	movl	%ecx, %esi
               	callq	<addr>
               	jmp	<addr>
               	testq	%rdx, %rdx
               	jne	<addr>
               	movl	%eax, %edi
               	movl	%ecx, %esi
               	callq	<addr>
               	jmp	<addr>
               	movl	%ebx, %eax
               	leaq	0x1(%rax), %rbx
               	movl	%ebx, %eax
               	movl	%r13d, %ecx
               	cmpq	%rcx, %rax
               	jb	<addr>
               	leaq	<rip>, %rax
               	movl	(%rax), %ecx
               	movl	0x4(%rax), %edx
               	xorq	%rdx, %rcx
               	movl	0x8(%rax), %edx
               	xorq	%rdx, %rcx
               	movl	0xc(%rax), %eax
               	xorq	%rcx, %rax
               	movl	%eax, %eax
               	andq	$0x7f, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	movq	0x10(%rsp), %r13
               	addq	$0x20, %rsp
               	popq	%rbp
               	retq
