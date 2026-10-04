
gcc_vector_size_attribute.x64:	file format elf64-x86-64

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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x10, %rsp
               	leaq	-0x10(%rbp), %rax
               	leaq	<rip>, %rcx
               	movups	(%rcx), %xmm14
               	movups	%xmm14, (%rax)
               	movups	(%rax), %xmm0
               	leaq	-0x10(%rbp), %rax
               	movups	%xmm0, (%rax)
               	movzbq	(%rax), %rcx
               	xorq	$0x1, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0x7(%rax), %rcx
               	xorq	$0x8, %rcx
               	testl	%ecx, %ecx
               	jne	<addr>
               	movzbq	0xf(%rax), %rax
               	xorq	$0x10, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
