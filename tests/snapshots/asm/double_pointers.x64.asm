
double_pointers.x64:	file format elf64-x86-64

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
               	subq	$0x18, %rsp
               	pushq	%rbx
               	movl	$0xa, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	%rax, -0x10(%rbp)
               	leaq	-0x10(%rbp), %rax
               	movq	(%rax), %rax
               	movl	$0x2a, (%rax)
               	movslq	-0x8(%rbp), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	-0x10(%rbp), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x2a, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	movl	$0x8, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rbx
               	movl	$0x4, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, (%rbx)
               	movl	$0x7b, (%rax)
               	movq	(%rbx), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x7b, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbx
               	leave
               	retq
               	movq	(%rbx), %rax
               	movslq	(%rax), %rax
               	cmpl	$0x7b, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
