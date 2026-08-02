
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
               	movslq	%eax, %rax
               	retq
               	movabsq	$-0x1, %rax
               	jmp	<addr>
               	cmpq	$0x1, %rdi
               	je	<addr>
               	jmp	<addr>
               	movl	$0x2a, %eax
               	jmp	<addr>

<main>:
               	movl	$0x2a, %eax
               	movl	$0x2a, %eax
               	retq
