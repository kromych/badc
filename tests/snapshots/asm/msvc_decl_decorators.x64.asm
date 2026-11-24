
msvc_decl_decorators.x64:	file format elf64-x86-64

Disassembly of section .text:

<_start>:
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
               	pushq	%rax
               	movq	%fs:0x0, %rax
               	addq	$-0x8, %rax
               	movl	(%rax), %ecx
               	incq	%rcx
               	addq	$0x3, %rcx
               	movl	%ecx, (%rax)
               	movq	%rcx, %rax
               	cmpl	$0xb, %eax
               	jne	<addr>
               	xorl	%eax, %eax
               	popq	%r11
               	retq
               	callq	<addr>
               	ud2
