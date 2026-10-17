
inline_asm_leaf_sp_clobber.x64:	file format elf64-x86-64

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

<leaf_push>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	$0x77
               	leave
               	retq

<leaf_val>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	pushq	$0x77
               	pushq	$0x78
               	leaq	0x1(%rdi), %rax
               	leave
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
               	pushq	%rbx
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rax
               	leaq	(%rax,%rax,2), %rbx
               	callq	<addr>
               	leaq	<rip>, %rax      # <addr>
               	movq	(%rax), %rdi
               	callq	<addr>
               	cmpq	$0x2a, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbx
               	leave
               	retq
               	cmpq	$0x7b, %rbx
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbx
               	leave
               	retq
               	xorl	%eax, %eax
               	popq	%rbx
               	leave
               	retq
