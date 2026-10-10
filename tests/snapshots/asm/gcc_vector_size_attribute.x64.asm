
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
               	movups	-0x10(%rbp), %xmm0
               	movups	%xmm0, -0x10(%rbp)
               	movzbq	-0x10(%rbp), %rax
               	xorq	$0x1, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	-0x9(%rbp), %rax
               	xorq	$0x8, %rax
               	testl	%eax, %eax
               	jne	<addr>
               	movzbq	-0x1(%rbp), %rax
               	xorq	$0x10, %rax
               	testl	%eax, %eax
               	je	<addr>
               	movl	$0x6, %eax
               	leave
               	retq
               	xorl	%eax, %eax
               	leave
               	retq
