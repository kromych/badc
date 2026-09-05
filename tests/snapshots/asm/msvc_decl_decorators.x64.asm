
msvc_decl_decorators.x64:	file format elf64-x86-64

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

<exported>:
               	movl	$0x3, %eax
               	retq

<halt>:
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movq	%fs:0x0, %rcx
               	addq	$-0x8, %rcx
               	movslq	(%rcx), %rax
               	incq	%rax
               	addq	$0x3, %rax
               	movl	%eax, (%rcx)
               	cmpl	$0xb, %eax
               	je	<addr>
               	callq	<addr>
               	ud2
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
