
static_init_logical_and.x64:	file format elf64-x86-64

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

<dispatch>:
               	leaq	<rip>, %rax # <addr>
               	andq	$0x1, %rdi
               	movq	(%rax,%rdi,8), %rcx
               	leaq	<rip>, %rax # <addr>
               	movq	(%rax,%rdi,8), %rax
               	cmpq	%rax, %rcx
               	je	<addr>
               	movq	$-0x1, %rax
               	retq
               	jmpq	*%rax
               	movl	$0xa, %eax
               	incq	%rax
               	incq	%rax
               	incq	%rax
               	retq
               	movl	$0x14, %eax
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%edi, %edi
               	callq	<addr>
               	cmpl	$0xd, %eax
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpl	$0x17, %eax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	popq	%rbp
               	retq
