
const_addr_multidim_array_elem.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	leaq	<rip>, %rcx
               	leaq	<rip>, %rax
               	movq	(%rax), %rdx
               	subq	%rcx, %rdx
               	cmpq	$0x300, %rdx            # imm = 0x300
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	movq	0x8(%rax), %rdx
               	subq	%rcx, %rdx
               	cmpq	$0x190, %rdx            # imm = 0x190
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	movq	0x10(%rax), %rax
               	subq	%rcx, %rax
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	retq
               	leaq	<rip>, %rax
               	leaq	<rip>, %rcx
               	movq	(%rcx), %rcx
               	subq	%rax, %rcx
               	cmpq	$0x80, %rcx
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	leaq	<rip>, %rcx
               	movq	0x8(%rcx), %rcx
               	movq	%rax, %r10
               	movq	%rcx, %rax
               	subq	%r10, %rax
               	cmpq	$0x48, %rax
               	je	<addr>
               	movl	$0x5, %eax
               	retq
               	xorq	%rax, %rax
               	retq
