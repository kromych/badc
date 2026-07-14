
static_local_shadows_extern_fn.x64:	file format elf64-x86-64

Disassembly of section .text:

<.text>:
               	xorl	%ebp, %ebp
               	movq	%rsp, %rdi
               	movl	$<entry_off>, %esi
               	callq	<addr>
               	ud2

<driver>:
               	movslq	%edi, %rdi
               	xorq	%rax, %rax
               	cmpq	$0x2, %rdi
               	jl	<addr>
               	cmpq	$0x2, %rdi
               	je	<addr>
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	retq
               	movabsq	$-0x1, %rax
               	jmp	<addr>
               	cmpq	$0x1, %rdi
               	je	<addr>
               	jmp	<addr>
               	leaq	<rip>, %rax
               	movzbq	(%rax), %rcx
               	movzbq	0x1(%rax), %rax
               	addq	%rcx, %rax
               	movslq	%eax, %rcx
               	movslq	%ecx, %rax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x1, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq
