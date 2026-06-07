
deferred_jit_thread_local.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	movslq	%edi, %rdi
               	leaq	<rip>, %rcx
               	movq	%rdi, %rax
               	shlq	$0x2, %rax
               	addq	%rcx, %rax
               	movl	%edi, (%rax)
               	movq	%rdi, %rax
               	shlq	$0x2, %rax
               	addq	%rax, %rcx
               	movslq	(%rcx), %rax
               	retq
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorq	%rdi, %rdi
               	callq	<addr>
               	movq	%fs:0x0, %rax
               	subq	$0x10, %rax
               	movslq	(%rax), %rcx
               	cmpq	$0x7, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rcx
               	subq	$0x8, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$-0x3, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movslq	(%rax), %rdx
               	movq	%fs:0x0, %rcx
               	subq	$0x8, %rcx
               	movslq	(%rcx), %rcx
               	addq	%rcx, %rdx
               	movslq	%edx, %rcx
               	movl	%ecx, (%rax)
               	movslq	(%rax), %rax
               	cmpq	$0x4, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
