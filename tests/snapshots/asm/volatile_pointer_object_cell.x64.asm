
volatile_pointer_object_cell.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<walk_reassigned>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rdi, 0x10(%rbp)
               	movq	0x10(%rbp), %rax
               	movq	(%rax), %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x10(%rbp)
               	movq	0x10(%rbp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	leaq	<rip>, %rcx
               	movq	%rcx, 0x10(%rbp)
               	movq	0x10(%rbp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<read_thrice>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rdi, 0x10(%rbp)
               	movq	0x10(%rbp), %rax
               	movq	(%rax), %rax
               	movq	0x10(%rbp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	movq	0x10(%rbp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<both_qualified>:
               	popq	%r10
               	subq	$0x10, %rsp
               	movq	%rdi, (%rsp)
               	pushq	%r10
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%rdi, 0x10(%rbp)
               	movq	0x10(%rbp), %rax
               	movq	(%rax), %rax
               	movq	0x10(%rbp), %rcx
               	movl	$0x5, %edx
               	movq	%rdx, (%rcx)
               	movq	0x10(%rbp), %rcx
               	movq	(%rcx), %rcx
               	addq	%rcx, %rax
               	popq	%rbp
               	popq	%r11
               	addq	$0x10, %rsp
               	pushq	%r11
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpq	$0x3c, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	callq	<addr>
               	cmpq	$0x3c, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	leaq	<rip>, %rdi
               	movl	$0x3, %eax
               	movq	%rax, (%rdi)
               	callq	<addr>
               	cmpq	$0x8, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
