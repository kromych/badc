
struct_linked_list.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	movq	%rbx, (%rsp)
               	movq	%r12, 0x8(%rsp)
               	xorq	%rbx, %rbx
               	movq	%rbx, %r12
               	jmp	<addr>
               	movl	$0x10, %edi
               	xorl	%eax, %eax
               	callq	<addr>
               	movq	%rax, %rcx
               	movl	%ebx, (%rcx)
               	movq	%r12, 0x8(%rcx)
               	movslq	%ebx, %rax
               	leaq	0x1(%rax), %rbx
               	movq	%rcx, %r12
               	movslq	%ebx, %rax
               	cmpq	$0x5, %rax
               	jl	<addr>
               	xorq	%rcx, %rcx
               	jmp	<addr>
               	movslq	(%r12), %rax
               	addq	%rax, %rcx
               	movq	0x8(%r12), %r12
               	testq	%r12, %r12
               	jne	<addr>
               	movslq	%ecx, %rax
               	movq	(%rsp), %rbx
               	movq	0x8(%rsp), %r12
               	addq	$0x10, %rsp
               	popq	%rbp
               	retq
               	addb	%al, (%rax)
