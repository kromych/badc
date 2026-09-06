
inline_section_mandatory.x64:	file format elf64-x86-64

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

<run_boot>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x5, %edi
               	callq	<addr>
               	movslq	%eax, %rax
               	popq	%rbp
               	retq

<run_text>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x4, %edi
               	callq	<addr>
               	addq	$0xd, %rax
               	movslq	%eax, %rax
               	popq	%rbp
               	retq

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	movl	$0x5, %edi
               	callq	<addr>
               	cmpq	$0x1c, %rax
               	je	<addr>
               	movl	$0x1, %eax
               	popq	%rbp
               	retq
               	movl	$0x4, %edi
               	callq	<addr>
               	cmpq	$0x18, %rax
               	je	<addr>
               	movl	$0x2, %eax
               	popq	%rbp
               	retq
               	xorq	%rax, %rax
               	popq	%rbp
               	retq
		...
               	addb	%al, (%rax)
               	addb	%cl, -0x73(%rax)

<boot_offset>:
               	leaq	0x7(%rdi), %rax
               	movslq	%eax, %rax
               	retq

<boot_step>:
               	leaq	(%rdi,%rdi,2), %rax
               	incq	%rax
               	leaq	0x7(%rdi), %rcx
               	addq	%rcx, %rax
               	movslq	%eax, %rax
               	retq
