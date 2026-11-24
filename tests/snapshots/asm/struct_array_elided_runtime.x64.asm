
struct_array_elided_runtime.x64:	file format elf64-x86-64

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

<run>:
               	xorl	%eax, %eax
               	retq

<main>:
               	subq	$0x10, %rsp
               	pushq	%rbx
               	xorl	%ebx, %ebx
               	movq	%rbx, %rdi
               	callq	<addr>
               	testl	%eax, %eax
               	jne	<addr>
               	incq	%rbx
               	cmpl	$0x14, %ebx
               	jl	<addr>
               	xorl	%eax, %eax
               	popq	%rbx
               	addq	$0x10, %rsp
               	retq
               	leaq	0x1(%rbx), %rax
               	popq	%rbx
               	addq	$0x10, %rsp
               	retq
