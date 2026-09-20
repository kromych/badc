
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
               	leaq	<rip>, %rdx
               	movq	%rdi, %rax
               	andq	$0x1, %rax
               	movq	%rax, %rcx
               	shlq	$0x3, %rcx
               	addq	%rcx, %rdx
               	movq	(%rdx), %rsi
               	leaq	<rip>, %rdx
               	addq	%rdx, %rcx
               	movq	(%rcx), %rcx
               	cmpq	%rcx, %rsi
               	je	<addr>
               	movq	$-0x1, %rax
               	retq
               	movq	(%rdx,%rax,8), %rax
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
