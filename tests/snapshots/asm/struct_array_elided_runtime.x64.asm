
struct_array_elided_runtime.x64:	file format elf64-x86-64

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

<run>:
               	leaq	0x1(%rdi), %rax
               	leaq	0x2(%rdi), %rcx
               	leaq	0x3(%rdi), %rdx
               	cmpl	%edi, %edi
               	jne	<addr>
               	cmpl	%eax, %eax
               	je	<addr>
               	movl	$0x1, %eax
               	retq
               	cmpl	%ecx, %ecx
               	jne	<addr>
               	cmpl	%edx, %edx
               	je	<addr>
               	movl	$0x2, %eax
               	retq
               	leaq	0x4(%rdi), %rax
               	cmpl	%eax, %eax
               	je	<addr>
               	movl	$0x4, %eax
               	retq
               	xorl	%eax, %eax
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x8, %rsp
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
               	leave
               	retq
               	leaq	0x1(%rbx), %rax
               	popq	%rbx
               	leave
               	retq
