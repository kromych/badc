
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
               	movq	%fs:0x0, %rax
               	addq	$-0x8, %rax
               	movslq	(%rax), %rcx
               	incq	%rcx
               	addq	$0x3, %rcx
               	movl	%ecx, (%rax)
               	movq	%rcx, %rax
               	cmpl	$0xb, %eax
               	je	<addr>
               	callq	<addr>
               	ud2
               	xorl	%eax, %eax
               	popq	%rbp
               	retq
