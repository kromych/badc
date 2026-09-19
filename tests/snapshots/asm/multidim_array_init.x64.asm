
multidim_array_init.x64:	file format elf64-x86-64

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
               	cmpl	$0x0, 0x10(%rax)
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movslq	0x14(%rax), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movslq	0x20(%rax), %rcx
               	cmpl	$0x6, %ecx
               	jne	<addr>
               	movslq	0x24(%rax), %rcx
               	cmpl	$0x7, %ecx
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	cmpl	$0x0, 0x28(%rax)
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	movslq	0x3c(%rax), %rcx
               	cmpl	$0x1, %ecx
               	jne	<addr>
               	movslq	0x40(%rax), %rcx
               	cmpl	$0x2, %ecx
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	movslq	0x60(%rax), %rcx
               	cmpl	$0x7, %ecx
               	jne	<addr>
               	cmpl	$0x0, 0x50(%rax)
               	je	<addr>
               	movl	$0x6, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	0x24(%rcx), %rcx
               	movslq	0x24(%rax), %rdx
               	cmpl	%edx, %ecx
               	je	<addr>
               	movl	$0x7, %eax
               	retq
               	leaq	<rip>, %rcx
               	movslq	0x60(%rcx), %rcx
               	movslq	0x60(%rax), %rax
               	cmpl	%eax, %ecx
               	je	<addr>
               	movl	$0x8, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	(%rax), %rax
               	cmpl	$0x1, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	movslq	0x4(%rax), %rax
               	cmpl	$0x2, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, 0xc(%rax)
               	je	<addr>
               	movl	$0x9, %eax
               	retq
               	leaq	<rip>, %rax
               	movslq	0x18(%rax), %rax
               	cmpl	$0x9, %eax
               	jne	<addr>
               	leaq	<rip>, %rax
               	cmpl	$0x0, 0x10(%rax)
               	je	<addr>
               	movl	$0xa, %eax
               	retq
               	leaq	<rip>, %rax
               	cmpl	$0x0, 0x20(%rax)
               	je	<addr>
               	movl	$0xb, %eax
               	retq
               	xorl	%eax, %eax
               	retq
