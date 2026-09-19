
break_continue.x64:	file format elf64-x86-64

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

<main>:
               	xorl	%eax, %eax
               	movq	%rax, %rcx
               	cmpl	$0x5, %ecx
               	je	<addr>
               	testb	$0x1, %cl
               	je	<addr>
               	addq	%rcx, %rax
               	incq	%rcx
               	cmpl	$0xa, %ecx
               	jl	<addr>
               	movslq	%eax, %rax
               	retq
