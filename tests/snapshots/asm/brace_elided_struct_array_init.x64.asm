
brace_elided_struct_array_init.x64:	file format elf64-x86-64

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
               	movslq	(%rax), %rcx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movslq	0x8(%rax), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movq	0x10(%rax), %rcx
               	leaq	<rip>, %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	cmpq	$0x0, 0x18(%rax)
               	je	<addr>
               	cmpq	$0x0, 0x20(%rax)
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	movslq	0x28(%rax), %rcx
               	cmpl	$0x2, %ecx
               	jne	<addr>
               	movq	0x40(%rax), %rcx
               	leaq	<rip>, %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movslq	0x48(%rax), %rcx
               	cmpl	$0x3, %ecx
               	jne	<addr>
               	movq	0x50(%rax), %rcx
               	leaq	<rip>, %rdx
               	cmpq	%rdx, %rcx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	cmpl	$0x0, 0x68(%rax)
               	jne	<addr>
               	cmpq	$0x0, 0x70(%rax)
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	xorl	%eax, %eax
               	retq
