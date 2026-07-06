
static_local_shadows_extern_fn.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<sum_first_two>:
               	movzbq	(%rdi), %rax
               	movzbq	0x1(%rdi), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq

<driver>:
               	movslq	%edi, %rdi
               	xorq	%rcx, %rcx
               	cmpq	$0x2, %rdi
               	jl	<addr>
               	cmpq	$0x2, %rdi
               	je	<addr>
               	movslq	%ecx, %rax
               	retq
               	movabsq	$-0x1, %rcx
               	jmp	<addr>
               	cmpq	$0x1, %rdi
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rcx
               	movzbq	0x1(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rcx
               	jmp	<addr>
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x1, %edi
               	popq	%rbp
               	jmp	<addr>
