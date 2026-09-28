
fn_ptr_explicit_deref.x64:	file format elf64-x86-64

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

<real_fn>:
               	leaq	0x1(%rdi), %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, -0x8(%rbp)
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movl	$0x28, %edi
               	callq	*%rax
               	cmpl	$0x29, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	leave
               	retq
               	leaq	-0x8(%rbp), %rax
               	movq	(%rax), %rax
               	movl	$0x28, %edi
               	callq	*%rax
               	cmpl	$0x29, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	leave
               	retq
               	movl	$0x2a, %eax
               	leave
               	retq
