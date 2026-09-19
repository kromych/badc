
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
               	pushq	%rbp
               	movq	%rsp, %rbp
               	subq	$0x20, %rsp
               	movl	%edi, -0x20(%rbp)
               	leaq	<rip>, %rcx
               	movq	%rdi, %rax
               	andq	$0x1, %rax
               	shlq	$0x3, %rax
               	addq	%rax, %rcx
               	movq	(%rcx), %rdx
               	leaq	<rip>, %rcx
               	addq	%rcx, %rax
               	movq	(%rax), %rax
               	cmpq	%rax, %rdx
               	je	<addr>
               	movq	$-0x1, %rax
               	leave
               	retq
               	movslq	-0x20(%rbp), %rax
               	andq	$0x1, %rax
               	movq	(%rcx,%rax,8), %rax
               	jmpq	*%rax
               	movl	$0xa, -0x8(%rbp)
               	movslq	-0x8(%rbp), %rax
               	incq	%rax
               	incq	%rax
               	incq	%rax
               	movslq	%eax, %rax
               	leave
               	retq
               	movl	$0x14, -0x8(%rbp)
               	jmp	<addr>

<main>:
               	pushq	%rbp
               	movq	%rsp, %rbp
               	xorl	%edi, %edi
               	callq	<addr>
               	cmpq	$0xd, %rax
               	jne	<addr>
               	movl	$0x1, %edi
               	callq	<addr>
               	cmpq	$0x17, %rax
               	je	<addr>
               	movl	$0x3, %eax
               	popq	%rbp
               	retq
               	movl	$0x2a, %eax
               	popq	%rbp
               	retq
