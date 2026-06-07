
thread_local_basic.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	movq	(%rsp), %rdi
               	leaq	0x8(%rsp), %rsi
               	callq	<addr>
               	movq	%rax, %rdi
               	callq	*<rip>
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%fs:0x0, %rax
               	subq	$0x10, %rax
               	movslq	(%rax), %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rcx
               	subq	$0x8, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x0, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	movl	$0x7, %ecx
               	movl	%ecx, (%rax)
               	movq	%fs:0x0, %rcx
               	subq	$0x8, %rcx
               	movl	$0x2a, %edx
               	movl	%edx, (%rcx)
               	movslq	(%rax), %rcx
               	cmpq	$0x7, %rcx
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movq	%fs:0x0, %rcx
               	subq	$0x8, %rcx
               	movslq	(%rcx), %rcx
               	cmpq	$0x2a, %rcx
               	je	<addr>
               	movl	$0x4, %eax
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
               	cmpq	$0x31, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
