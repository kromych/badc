
struct_fn_ptr_field_deref_call.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<adder3>:
               	leaq	0x3(%rdi), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<adder7>:
               	leaq	0x7(%rdi), %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	leaq	<rip>, %rbx
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, (%rbx)
               	xorq	%rcx, %rcx
               	movl	%ecx, 0x8(%rbx)
               	movl	$0xa, %edi
               	callq	*%rax
               	movslq	%eax, %r12
               	movq	(%rbx), %rax
               	movl	$0x14, %edi
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0xd, %r12
               	je	<addr>
               	movl	$0x1, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	leaq	-<rip>, %rax       # <addr>
               	movq	%rax, (%rbx)
               	movl	$0x64, %edi
               	callq	*%rax
               	movslq	%eax, %r12
               	movq	(%rbx), %rax
               	movl	$0xc8, %edi
               	callq	*%rax
               	movslq	%eax, %rax
               	cmpq	$0x6b, %r12
               	je	<addr>
               	movl	$0x3, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	cmpq	$0xcf, %rax
               	je	<addr>
               	movl	$0x4, %eax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
