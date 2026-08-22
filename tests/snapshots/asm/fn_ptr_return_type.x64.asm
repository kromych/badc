
fn_ptr_return_type.x64:	file format elf64-x86-64

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

<anon>:
               	leaq	<rip>, %rax
               	retq

<vec>:
               	leaq	<rip>, %rax
               	retq

<go_s>:
               	leaq	-<rip>, %rax       # <addr>
               	retq

<go_i>:
               	leaq	-<rip>, %rax       # <addr>
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	callq	<addr>
               	movslq	(%rax), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	movslq	(%rax), %rax
               	cmpl	$0x7, %eax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	movslq	0x8(%rax), %rax
               	cmpl	$0x1e, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	callq	<addr>
               	movslq	(%rax), %rax
               	cmpl	$0xa, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
